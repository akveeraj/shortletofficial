<!--#include virtual="/includes.inc"-->


<%
// --------------------------------------------------------------------------------------------------------------------------

  o_Query      = Request.Form
  o_Query      = UrlDecode( o_Query )
  o_Query      = Replace( o_Query, ";", vbcrlf )
  SubID        = ParseCircuit( "subid", o_Query )
  TxId         = ParseCircuit( "txid", o_Query )
  Email        = ParseCircuit( "email", o_Query )
  DoSendSMS    = 1
  DoSendEmail  = 1
  DoDelete     = 1
  
  Data    = "subid:" & SubId & ";txid:" & TxId & ";email:" & Email
  
  If Data > "" Then Data = StringToHex( Data ) End If
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Validate
// --------------------------------------------------------------------------------------------------------------------------

  SubSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "' AND email='" & Email & "'"
             Call FetchData( SubSQL, SubRs, ConnTemp )
		   
  SubCount = SubRs("NumberOfRecords")
  Call CloseRecord( SubRs, ConnTemp )
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Get Details
// --------------------------------------------------------------------------------------------------------------------------
  
  If SubCount > "0" Then
  
    SubSQL = "SELECT * FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "' AND email='" & Email & "'"
	         Call FetchData( SubSQL, SubRs, ConnTemp )
			   
			   SubEmail         = SubRs("email")
			   SubMethod        = SubRs("alertmethod")
			   SubMobile        = SubRs("mobile")
			   SubCode          = SubRs("countrycode")
			   SubMobileNumber  = SubCode & SubMobile
			   SubId            = SubRs("subid")
			   SubDesc          = SubRs("subdesc")
			   SubReq           = SubRs("requirement")
			   SubCity          = SubRs("city")
			   
			   If SubDesc > "" Then SubDesc = HexToString( SubDesc ) End If

			 Call CloseRecord( SubRs, ConnTemp )
  
  End If
  
// --------------------------------------------------------------------------------------------------------------------------

  If SubCount = "0" Then
    Proceed = 0
	RText   = "The subscription could not be found<br/>It may have already been cancelled or does not exist."
	RCode   = 1
  Else
    Proceed = 1
	RText   = "OK"
	RCode   = 2
  End If
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Send Confirmation by Email
// --------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND DoSendEmail = "1" Then
  
    EmailBody     = "Your subscription `<b>" & SubReq & " in " & SubCity & "</b>` has been cancelled."
    EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Subscription Cancelled (" & SubId & ")</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
				   
	MxSubject   = "Your Property Alerts Subscription has been cancelled"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = SubEmail
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Subscriptions Team"
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooterNoRegister(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
  
  End If
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Send Confirmation by Text
// --------------------------------------------------------------------------------------------------------------------------

  SMSBody      = "Your Property Alerts Subscription `" & SubReq & " in " & SubCity & "` [" & SubId & "] has been cancelled."
  SMSNumber    = SubMobileNumber
  SMSAPIToken  = "d6a1-7abc-a363-0cfc"
  SMSEndPoint  = "http://my.fastsms.co.uk/api"
  SMSUser      = "FS2821"
  SMSPass      = "elysium08512"
  
  If SubMethod = "2" AND Proceed = "1" AND DoSendSMS = "1" Then
  
    Set ParametersDict = CreateObject("Scripting.Dictionary")
	  ParametersDict.Add "Action", "Send"
	  ParametersDict.Add "DestinationAddress", SMSNumber
	  ParametersDict.Add "SourceAddress", "TGSHORTLETS"
	  ParametersDict.Add "Body", SMSBody
	  ParametersDict.Add "ValidityPeriod", "86400"
	  ResultCode = SendSMS(SMSNumber, SMSBody, SMSUser, SMSPass, ParametersDict, SMSEndPoint )
	Set ParametersDict = Nothing
  
  End If
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Delete Subscription
// --------------------------------------------------------------------------------------------------------------------------

  If Proceed = 1 AND DoDelete = 1 Then
    
	DelSQL = "DELETE FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "' AND email='" & Email & "'"
	         Call SaveRecord( DelSQL, DelRs, ConnTemp )
			 Call CloseRecord( DelRs, ConnTemp )

  End If
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Write JSON
// --------------------------------------------------------------------------------------------------------------------------
  
  JSON = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'subid':'" & SubId & "', 'txid':'" & TxId & "', 'data':'" & Data & "'}"
         Response.Write JSON

// --------------------------------------------------------------------------------------------------------------------------
%>
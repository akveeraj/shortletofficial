<!--#include virtual="/includes.inc"-->


<%
// -----------------------------------------------------------------------------------------------------

  o_Query        = fw_Query
  o_Query        = UrlDecode( o_Query )
  Data           = ParseCircuit( "data", o_Query )
  Data           = HexToString( Data )
  nData          = Replace( Data, ";", vbcrlf )
  Req            = ParseCircuit( "req", nData )
  City           = ParseCircuit( "city", nData )
  Email          = ParseCircuit( "email", nData )
  Method         = ParseCircuit( "method", nData )
  Duration       = ParseCircuit( "duration", nData )
  Total          = ParseCircuit( "total", nData )
  Desc           = ParseCircuit( "desc", nData )
  
  If Desc > "" Then nDesc = StringToHex( Desc ) End If
  
  Mobile         = ParseCircuit( "mobile", nData )
  CountryCode    = ParseCircuit( "countrycode", nData )
  TxId           = ParseCircuit( "txid", nData )
  TxId           = UCase( TxId )
  NewTxId        = ParseCircuit( "newtxid", nData )
  NewTxId        = UCase( NewTxId )
  SubId          = ParseCircuit( "subid", nData )
  SubId          = UCase( SubId )
  ExpiryDate     = ParseCircuit( "expirydate", nData )
  ExpiryDateTime = ParseCircuit( "expirydatetime", nData )
  Referrer       = ParseCircuit( "referrer", nData )
  DoSendEmail    = 1
  DoSendSMS      = 1
  DoSaveSub      = 1
  SMSNumber      = CountryCode&Mobile
  
  If SubId = "" Then SubId = "N/A" End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ----------------------------------------------------------------------------------------------------------------------------------

  SubSQL     = "SELECT COUNT(uIndex) As NumberOfRecords FROM PropertyAlerts WHERE subid='" & SubId & "' AND txid='" & TxId & "' AND Paid='1'"
               Call FetchData( SubSQL, SubRs, ConnTemp )
  
  AlertCount = SubRs("NumberOfRecords")
  
  Call CloseRecord( SubRs, ConnTemp )
  
  If Referrer = "" OR Instr( Referrer, "paypal.com" ) = 0 Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `ReferrerURL` is invalid."
	RCode   = 1
	Paid    = 0
  
  ElseIf Req = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `requirement` value was expected and was not returned."
	RCode   = 2
	Paid    = 0
  
  ElseIf City = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `City` value was expected and was not returned."
	RCode   = 3
	Paid    = 0
  
  ElseIf Email = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `Email` value was expected and was not returned."
	RCode   = 4
	Paid    = 0
  
  ElseIf Method = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `Method` value was expected and was not returned."
	RCode   = 5
	Paid    = 0
  
  ElseIf Duration = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `Duration` value was expected and was not returned."
	RCode   = 6
	Paid    = 0
  
  ElseIf Total = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `Total` value was expected and was not returned."
	RCode   = 7
	Paid    = 0
  
  ElseIf Desc = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `Description` value was expected and was not returned."
	RCode   = 8
	Paid    = 0
  
  ElseIf Method = "2" AND Mobile = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `Mobile` value was expected and was not returned."
	RCode   = 9
	Paid    = 0
  
  ElseIf Method = "2" AND CountryCode = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `CountryCode` value was expected and was not returned."
	RCode   = 10
	Paid    = 0
	
  ElseIf Txid = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `TXID` value was expected and was not returned."
	RCode   = 11
	Paid    = 0
	
  ElseIf SubId = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `SUBID` value was expected and was not returned."
	RCode   = 12
	Paid    = 0
	
  ElseIf ExpiryDate = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `ExpiryDate` value was expected and was not returned."
	RCode   = 13
	Paid    = 0
	
  ElseIf ExpiryDateTime = "" Then
    Proceed = 0
	RText   = "<b>Sorry, something went wrong</b><br/>The `ExpiryDateTime` value was expected and was not returned."
	RCode   = 14
	Paid    = 0
	
  Else
    Proceed = 1
	RText   = "OK"
	RCode   = 15
	Paid    = 1
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Update Subscription
// ----------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND DoSaveSub = "1" Then
  
    UpdSQL = "UPDATE propertyalerts SET " & _
	         "expirydate='" & ExpiryDate & "', expirydatetime='" & ExpiryDateTime & "', adddate='" & Var_DateNoTimeStamp & "', adddatetime='" & Var_DateStamp & "' " & _
			 "WHERE subid='" & SubID & "' AND txid='" & TxId & "' AND email='" & Email & "'"
			 Call SaveRecord( UpdSQL, UpdRs, ConnTemp )
			 Call CloseRecord( UpdSQL, ConnTemp )
  
  
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Send Email Notification
// ----------------------------------------------------------------------------------------------------------------------------------
  
  If Method = "2" Then
    SubDesc = Desc & "<br/><br/>Email: " & Email & "<br/>Mobile Number: +" & CountryCode & Mobile & "<br/>Expires: " & FormatDateTime(ExpiryDate,2)
  Else
    SubDesc = Desc & "<br/><br/>Email: " & Email & "<br/>Expires:" & FormatDateTime(ExpiryDate,2)
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" AND DoSendEmail = "1" Then
  
    EmailBody = "Your subscription was renewed successfully. See details below." & _
                "<h2 style=""color:#7a6a51; font-weight:bold;"">Subscription Details</h2>" & _
				"<table width='700px;' border='0' bgcolor='#ffffff' cellpadding='10' style='font-size:10pt; font-family:courier, arial, helvetica, geneva, sans-serif; cursor:default;'>" & vbcrlf & _
				
				"<tr>" & _
				"<td width='190px' align='top' style='vertical-align: top;'><b>Subscription</b></td><td>" & SubDesc & "</td>" & _
				"</tr>" & _
				
				"<tr>" & _
				"<td width='190px'><b>Requirement/Location</b></td><td>" & Req & " in " & City & "</td>" & _
				"</tr>" & _
				
				"<tr>" & _
				"<td width='190px'><b>Payment Method</b></td><td>&pound;" & FormatNumber( Total, 2 ) & " GBP via PayPal Payments</td>" & _
				"</tr>" & _
				
				"<tr>" & _
				"<td width='190px'><b>Subscription ID</b></td><td>" & SubId & "</td>" & _
				"</tr>" & _
				
				"<tr>" & _
				"<td width='190px'><b>Payment Date</b></td><td>" & FormatDateTime(Var_DateStamp,2 ) & " " & Var_TimeStamp & "</td>" & _
				"</tr>" & _
				
				"<tr>" & _
				"<td width='190px'><b>Website</b></td><td>townandgownshortlets.uk</td>" & _
				"</tr>" & _
				
				"</table>" & _
				"<br/><br/>" & _
				"Please keep this confirmation safe, this is your proof of purchase."
				
				
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Your Property Alerts Subscription has been renewed.</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Your Property Alerts Subscription has been renewed"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = Email
	MxAppend    = False
	MxTLS       = 0
	Salutation  = ""
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooterNoRegister(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
	
  End If

// ----------------------------------------------------------------------------------------------------------------------------------
// ' Send SMS Notification
// ----------------------------------------------------------------------------------------------------------------------------------

  SMSBody      = "Your Property Alert Subscription has been renewed. Ref: " & SubId & " - EXPIRES: " & FormatDateTime(ExpiryDate,2)
  SMSNumber    = SMSNumber
  SMSAPIToken  = "d6a1-7abc-a363-0cfc"
  SMSEndPoint  = "http://my.fastsms.co.uk/api"
  SMSUser      = "FS2821"
  SMSPass      = "elysium08512"
  
  If Method = "2" AND Proceed = "1" AND DoSendSMS = "1" Then
  
    Set ParametersDict = CreateObject("Scripting.Dictionary")
	  ParametersDict.Add "Action", "Send"
	  ParametersDict.Add "DestinationAddress", SMSNumber
	  ParametersDict.Add "SourceAddress", "TGSHORTLETS"
	  ParametersDict.Add "Body", SMSBody
	  ParametersDict.Add "ValidityPeriod", "86400"
	  ResultCode = SendSMS(SMSNumber, SMSBody, SMSUser, SMSPass, ParametersDict, SMSEndPoint )
	Set ParametersDict = Nothing
	
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
  
  Data = "subid:" & SubId & ";rtext:" & RText & ";rcode:" & RCode & ";email:" & Email
  Data = StringToHex( Data )

  Response.Redirect "/alertsubconfirm/subscriptions/?data:" & Data

// ----------------------------------------------------------------------------------------------------------------------------------
%>
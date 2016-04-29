<!--#include virtual="/includes.inc"-->

<%
// ----------------------------------------------------------------------------------------------------------------

  o_Query   = Request.Form
  o_Query   = UrlDecode( o_Query )
  o_Query   = Replace( o_Query, ";", vbcrlf  )
  Req       = ParseCircuit( "req", o_Query )
  City      = ParseCircuit( "city", o_Query )
  Email     = ParseCircuit( "email", o_Query )
  CCode     = ParseCircuit( "ccode", o_Query )
  Mobile    = ParseCircuit( "mobile", o_Query )
  SubId     = ParseCircuit( "subid", o_Query )
  TxId      = ParseCircuit( "txid", o_Query )
  Method    = ParseCircuit( "method", o_Query )
  
  If CCode  = "undefined" Then CCode  = "" End If
  If Mobile = "undefined" Then Mobile = "" End If 

// ----------------------------------------------------------------------------------------------------------------
// ' Validate
// ----------------------------------------------------------------------------------------------------------------

  SubSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM propertyalerts WHERE txid='" & TxId & "' AND subid='" & SubId & "'"
  Call FetchData( SubSQL, SubRs, ConnTemp )
  
  SubCount = SubRs("NumberOfRecords")
  Call CloseRecord( SubRs, ConnTemp )

// ----------------------------------------------------------------------------------------------------------------

  If SubCount = "0" Then
    Proceed = 0
	RText   = "The subscription could not be found."
	RCode   = 1
	
  ElseIf Req = "" Then
    Proceed = 0
	RText   = "Please select what you are looking for."
    RCode   = 2	
	
  ElseIf City = "-" Then
    Proceed = 0
	RText   = "Please select a City."
	RCode   = 3
	
  ElseIf Email = "" OR Instr( Email, "@" ) = 0 OR Instr( Email, "." ) = 0 Then
    Proceed = 0
	RText   = "Please enter a valid Email Address."
	RCode   = 4
  
  ElseIf Method = "2" AND CCode = "" Then
    Proceed = 0
	RText   = "Please enter your Mobile Phone Country Code."
	RCode   = 5
  
  ElseIf Method = "2" AND Mobile = "" AND IsNumeric( Mobile ) = 0 Then
    Proceed = 0
	RText   = "Please enter your Mobile Phone number, dropping the leading zero if in the UK"
	RCode   = 6
  
  Else
    Proceed = 1
	RText   = "OK"
	RCode   = 7
  
  End If
  
// ----------------------------------------------------------------------------------------------------------------
// ' Update Subscription
// ----------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    UpdSQL = "UPDATE propertyalerts SET " & _
	         "requirement='" & Req & "', city='" & City & "', email='" & Email & "', mobile='" & Mobile & "', countrycode='" & CCode & "' " & _
			 "WHERE subid='" & SubID & "' AND txid='" & TxId & "'"
             Call SaveRecord( UpdSQL, UpdRs, ConnTemp )
             Call CloseRecord( UpdRs, ConnTemp )			 
  
  
  End If
  
// ----------------------------------------------------------------------------------------------------------------
// ' Get Subscription Details
// ----------------------------------------------------------------------------------------------------------------

  If Proceed = 1 Then
  
    SubSQL = "SELECT * FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "'"
	         Call FetchData( SubSQL, SubRs, ConnTemp )
			 
			 SubId        = SubRs("subid")
			 SubReq       = SubRs("requirement")
			 SubCity      = SubRs("city")
			 SubEmail     = SubRs("email")
			 SubDuration  = SubRs("duration")
			 SubDateTime  = subRs("adddatetime")
			 SubDate      = SubRs("adddate")
			 SubExpires   = SubRs("expirydatetime")
			 SubExpires   = FormatDateTime( SubExpires, 1 )
			 SubDesc      = SubRs("subdesc")
			 SubPayTotal  = SubRs("paytotal")
			 PayDesc      = "&pound;" & FormatNumber(SubPayTotal, 2) & " GBP via PayPal Payments"
			 PayDate      = FormatDateTime(SubDateTime, 2 ) & " " & FormatDateTime(SubDateTime, 4 )
			 If SubDesc > "" Then SubDesc = HexToString( SubDesc ) End If
			 
  End If
  
// ----------------------------------------------------------------------------------------------------------------
// ' Send Update Notification
// ----------------------------------------------------------------------------------------------------------------

  If Proceed = 1 Then

  EmailBody = "Your subscription was updated successfully. See below for details.<br/><br/>" & _
              "<h2 style=""color:#7a6a51; font-weight:bold;"">Subscription Details</h2>" & vbcrlf & _
			  "<table width='700' border='0' bgcolor='#ffffff' cellpadding='10' style='font-size:10pt; font-family:courier, arial, helvetica, geneva, sans-serif; cursor:default;'>" & vbcrlf & _
			  
			  "<tr>" & vbcrlf & _
			  "<td width='190px' align='top' style='vertical-align:top;'><b>Subscription</b></td><td>" & SubDesc & "<br/>Email: " & Email & "<br/>Expires: " & SubExpires & "</td>" & _
			  "</tr>" & vbcrlf & _
			  
			  "<tr>" & vbcrlf & _
			  "<td width='190px;'><b>Requirement/Location</b></td><td>" & Req & " in " & City & "</td>" & vbcrlf & _
			  "</tr>" & vbcrlf & _
			  
			  "<tr>" & vbcrlf & _
			  "<td width='190px;'><b>Payment Method</b></td><td>" & PayDesc & "</td>" & vbcrlf & _
			  "</tr>" & vbcrlf & _
			  
			  "<tr>" & vbcrlf & _
			  "<td width='190px;'><b>Subscription ID</b></td><td>" & SubId & "</td>" & vbcrlf & _
			  "</tr>" & vbcrlf & _
			  
			  "<tr>" & vbcrlf & _
			  "<td width='190px;'><b>Payment Date</b></td><td>" & PayDate & "</td>" & vbcrlf & _
			  "</tr>" & vbcrlf & _
			  
			  "<tr>" & vbcrlf & _
			  "<td width='190px;'><b>Website</b></td><td>townandgownshortlets.uk</td>" & vbcrlf & _
			  "</tr>" & vbcrlf & _
			  
			  "</table><br/><br/>"
			  
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Your Property Alert Subscription was updated</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Your Property Alert Subscription was updated"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = Email
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Subscriptions Team"
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooterNoRegister(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
	
  End If
  
  Data = "subid:" & SubID & ";txid:" & TxId & ";email:" & Email
  Data = StringToHex(Data)
 
// ----------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// ----------------------------------------------------------------------------------------------------------------

  JSON = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'subid':'" & SubId & "', 'txid':'" & TxId & "', 'data':'" & Data & "'}"
         Response.Write JSON

// ----------------------------------------------------------------------------------------------------------------
%>
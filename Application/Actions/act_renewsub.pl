<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  Data       = ParseCircuit( "data", o_Query )
  Data       = DecodeText( Data )
  Data       = Replace( Data, ";", vbcrlf )
  Cid        = ParseCircuit( "cid", Data )
  ReqTime    = ParseCircuit( "requesttime", Data )
  Duration   = ParseCircuit( "duration", Data )
  SubDesc    = ParseCircuit( "desc", Data )
  SubDesc    = UrlEncode(SubDesc)
  ReqId      = ParseCircuit( "requestid", o_Query )
  Amount     = ParseCircuit( "amount", o_Query )
  
  If Duration > "" Then
    PaidUntil   = DateAdd( "d", Duration, Var_DateNoTimeStamp )
	nPaidUntil  = Split( PaidUntil, "/" )
	PaidDay     = nPaidUntil(0)
	PaidMonth   = nPaidUntil(1)
	PaidYear    = nPaidUntil(2)
	PaidYear    = Left( PaidYear, 4 )
	PaidUntil   = PaidYear & "-" & PaidMonth & "-" & PaidDay & " " & Time
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Account
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  UgSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & CId & "'"
            Call FetchData( UgSQL, UgRs, ConnTemp )
		  
  UgCount = UgRs("NumberOfRecords")
  
  If UGCount > "0" Then
  
    UgSQL = "SELECT * FROM members WHERE customerid='" & CId & "'"
	        Call FetchData( UgSQL, UgRs, ConnTemp )
			
			Firstname = UgRs("firstname")
			Email     = UgRs("emailaddress")
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If UgCount > "0" Then
    Proceed = "1"
	RCode   = 1
  Else
    Proceed = "0"
	RCode   = 0
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Subscription
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
  NewDateStamp = Left( PaidUntil, 10 )

    USQL = "UPDATE members SET " & _
           "paiduntil='" & PaidUntil & "', paiduntilnostamp='" & NewDateStamp & "', paidmember='1', sublength='" & Duration & "', subdescription='" & SubDesc & "'" & _
		   "WHERE customerid='" & CId & "'"
		   Call SaveRecord( USQL, URs, ConnTemp )
		 
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete request if it exists
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    USQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM renewalrequests WHERE requestid='" & ReqId & "'"
           Call FetchData( USQL, URs, ConnTemp )
		 
    UCount = URs("NumberOfRecords")
  
    If UCount > "0" Then
  
      USQL = "DELETE FROM renewalrequests WHERE requestid='" & ReqId & "'"
	         Call SaveRecord( USQL, URs, ConnTemp )
		   
    End If
  
  
  End If
		
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Send message to customer
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ReceiptTable = "<table width='600' style='margin-left:auto; margin-right:auto; font-family:arial, helvetica, geneva, sans-serif; font-size:13px;' border='1' bgcolor='#ffffff'>" & vbcrlf & _
                 "<tr><td width='500' style='padding:5px;'><b>Description</b></td>" & vbcrlf & _
                 "<td width='200' style='text-align:center;'><b>Amount</b></td></tr>" & vbcrlf & _
                 "<tr><td width='500' style='padding:5px;'>" & UrlDecode(SubDesc) & " - Renewed until: " & FormatDateTime( PaidUntil, 1 ) & "<br/>Paid via PayPal</td>" & vbcrlf & _
                 "<td width='200' style='text-align:center;'>&pound;" & Amount & "</td></tr>" & vbcrlf & _
                 "<tr><td width='500' style='padding:5px; text-align:right;'><b>Total</b></td>" & vbcrlf & _
                 "<td width='200' style='text-align:center;'>&pound;" & Amount & "</td></tr></table>" & vbcrlf

  If Proceed = "1" Then
  
    EmailBody = "Hello, " & Firstname & "<br/>" & vbcrlf & _
	            "Your subscription was renewed successfully," & _
				" a receipt has been attached to the bottom of this message.<br/><br/><br/>" & vbcrlf & _
				"<h2>Your Receipt</h2><br/>" & vbcrlf & _
				ReceiptTable & "<br/><br/>"
				
	EmailContent = "<h2 style=""color:#7a6a51; font-weight:bold;"">Your subscription has been renewed</h2>" & vbcrlf & _
	               EmailBody & vbcrlf 
				   
	MxSubject   = "Your Subscription was renewed successfully"
	MxReplyTo   = "support@townandgownshortlets.co.uk"
	MxFrom      = "support@townandgownshortlets.co.uk"
	MxFromName  = "Town and Gown Shortlets"
	MxQueue     = True
	MxIsHtml    = True
	MxRecipient = Email
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Subscriptions Team"	
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
  
  End If
  
  Response.Redirect "/subresponse/account/?responsecode:" & RCode


// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
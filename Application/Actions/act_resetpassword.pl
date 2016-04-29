<!--#include virtual="/includes.inc"-->

<%
// ------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = Request.Form
  o_Query      = Replace( o_Query, ";", vbcrlf  )
  Email        = ParseCircuit( "username", o_Query )
  RPath        = ParseCircuit( "rpath", o_Query )
  
// ------------------------------------------------------------------------------------------------------------------------------------
// ' Check account and Email
// ------------------------------------------------------------------------------------------------------------------------------------

  ESQL       = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE emailaddress='" & Email & "'"
               Call FetchData( ESQL, ERs, ConnTemp )
		 
  EmailCount = ERs("NumberOfRecords")
  
// ------------------------------------------------------------------------------------------------------------------------------------
  
  If EmailCount > "0" Then
  
    ESQL = "SELECT * FROM members WHERE emailaddress='" & Email & "'"
	       Call FetchData( ESQL, ERs, ConnTemp )
		   
		   Email      = ERs("emailaddress")
		   Firstname  = ERs("firstname")
		   Password   = ERs("password")
		   nPassword  = DecodeText( Password )
  
  
  End If
  
// ------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ------------------------------------------------------------------------------------------------------------------------------------
  
  If EmailCount = "0" Then
    Proceed = 0
	RCode   = 1
    RText   = "We were unable to find an account with the entered email address. Please contact us should this continue."
	
  Else
    Proceed = 1
	RCode   = 2
	RText   = "OK"
  End If

// ------------------------------------------------------------------------------------------------------------------------------------
// ' Send Reminder
// ------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
  EmailBody    = "Hello, " & Firstname & "<br/>" & vbcrlf & _
                 "You password is below, you or someone requested it on " & Now() & ".<br/>" & _
				 "If you did not request this, please log in and change your password.<br/><br/>" & _
				 "<b>Password</b> : <h2 style='font-weight:bold;'>" & nPassword & "</h2>" & _
				 "Please keep these details in a safe place, as you will need them to log into your account."
				 
				 
				 
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Your Password Reminder</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "IMPORTANT - Your password reminder"
	MxReplyTo   = "support@townandgownshortlets.co.uk"
	MxFrom      = "support@townandgownshortlets.co.uk"
	MxFromName  = "Town and Gown Shortlets"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = Email
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Accounts Team"
					
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'rpath':'" & RPath & "'}"
  Response.Write JSOn
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
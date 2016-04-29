<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
  o_Query       = UrlDecode( o_Query )
  Data          = ParseCircuit( "data", o_Query )
  Data          = HexToString( Data )
  Data          = Replace( Data, ";", vbcrlf )
  EndPoint      = ParseCircuit( "endpoint", Data )
  FromRegister  = ParseCircuit( "fromregister", Data )
  Key           = ParseCircuit( "key", Data )
  CustomerId    = ParseCircuit( "customerid", Data )
  ShortCode     = ParseCircuit( "shortcode", Data )
  TrialMode     = ParseCircuit( "trial", Data )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check ShortCode
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  CodeSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shorturl WHERE shortcode='" & ShortCode & "'"
               Call FetchData( CodeSQL, CodeRs, ConnTemp )
			
  CodeCount = CodeRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check CustomerId
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  CustSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & CustomerId & "'"
            Call FetchData( CustSQL, CustRs, ConnTemp )
			
  CustCount = CustRs("NumberOfRecords") 
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If CustCount > "0" Then
  
    CustSQL = "SELECT * FROM members WHERE customerid='" & CustomerId & "'"
	          Call FetchData( CustSQL, CustRs, ConnTemp )
			  
			  Firstname = CustRs("firstname")
			  Surname   = CustRs("surname")
			  Email     = CustRs("emailaddress")
			  PayRef    = CustRs("payreference")
			  Password  = CustRs("password")
			  nPassword = DecodeText( Password )
			  TrialDate = CustRs("paiduntil")
			  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If CustomerId = "" Then
    Proceed = 0
	RCode   = 1
	RText   = "<h2>We could not find the customer.</h2>The account may have been deleted."
  Else
    Proceed = 1
	RCode   = 0
	RText   = "<h2>OK</h2>"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Activate Account
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
  
    SaveSQL = "UPDATE members SET " & _
	          "status='1'" & _
	          " WHERE customerid='" & CustomerId & "'"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If CodeCount > "0" Then
  
    DelSQL = "DELETE FROM shorturl WHERE shortcode='" & ShortCode & "'"
	         Call SaveRecord( DelSQL, DelRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Send Activation Confirmation
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If TrialMode = "1" Then

  EmailBody    = "Hello, " & Firstname & "<br/>" & vbcrlf & _
                 "Your registration at Town and Gown Shortlets is now complete and your account is now active and ready to use." & _
				 " As a thank you for registering, you now have a " & Var_TrialLength & " Day Free Trial to try out our shortlets introductory platform. Your free trial will expire on " & _
				 "<b>" & FormatDateTime(TrialDate, 1 ) & "</b>. Once your trial has expired, you will need to renew any adverts you want to keep as they will expire" & _
				 " when your trial ends. (This excludes featured adverts).<br/><br/><br/>" & _
				 "We have included your log in details to access your account. Please keep this information in a safe place as you will" & _
				 " need this to create and edit your adverts.<br/><br/>" & _
				 "<b>Email Address</b> : <h2 style='font-weight:bold;'>" & Email & "</h2>" & _
				 "<b>Password</b> : <h2 style='font-weight:bold;'>" & nPassword & "</h2>"
				 
				 
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Thank you for registering</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Your Account Details"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = Email
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Registration Team"
					
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
	
	Else
	
  EmailBody    = "Hello, " & Firstname & "<br/>" & vbcrlf & _
                 "Your registration at Town and Gown Shortlets is now complete and your account is now active and ready to use.<br/><br/>" & _
				 "We have included your log in details to access your account. Please keep this information in a safe place as you will" & _
				 " need this to create and edit your adverts.<br/><br/>" & _
				 "<b>Email Address</b> : <h2 style='font-weight:bold;'>" & Email & "</h2>" & _
				 "<b>Password</b> : <h2 style='font-weight:bold;'>" & nPassword & "</h2>"
				 
				 
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Thank you for registering</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Your Account Details"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = Email
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Registration Team"
					
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
	
	End If


// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    Response.Cookies("tandgshortlets")("token")      = CustomerId
	Response.Cookies("tandgshortlets")("userid")     = CustomerId
	Response.Cookies("tandgshortlets")("firstname")  = Firstname
	Response.Cookies("tandgshortlets")("surname")    = Surname
	Response.Cookies("tandgshortlets")("email")      = Email
	Response.Cookies("tandgshortlets")("loggedin")   = 1
	Response.Cookies("tandgshortlets")("payref")     = PayRef
	Response.Redirect EndPoint

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  Else
  
  Response.Write RText & "<br/><a href='/'>Click here</a> to return to the home page."
  
  
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
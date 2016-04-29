<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
  
  Title        = ParseCircuit( "title", o_Query )
  Firstname    = ParseCircuit( "firstname", o_Query )
  Surname      = ParseCircuit( "surname", o_Query )
  Email        = ParseCircuit( "email", o_Query )
  Telephone    = ParseCircuit( "telephone", o_Query )
  Password     = ParseCircuit( "password", o_Query )
  Password2    = ParseCircuit( "password2", o_Query )
  CustomerId   = Var_UserId
  
  If Password > "" Then
    UpdatePass = 1
	nPassword  = EncodeText( Password )
  Else
    UpdatePass = 0
	nPassword  = ""
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Email
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ESQL       = "SELECT COUNT(uIndex) AS NumberOfRecords FROM members WHERE emailaddress='" & Email & "'"
               Call FetchData( ESQL, ERs, ConnTemp )
		 
  EmailCount = ERs("NumberOfRecords")
  
  If EmailCount > "0" Then
  
    ESQL = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
	       Call FetchData( ESQL, ERs, ConnTemp )
		  
		   MemEmail     = ERs( "emailaddress" )
		   MemFirstname = ERs("firstname")
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that, <a href=""javascript://"" onclick=""document.location.reload();"">click here</a> to log in."
	RText   = UrlEncode( RText )
  
  ElseIf Title = "" OR Title = "-" Then
    Proceed = 0
	RCode   = 2
	RText   = "Please select your Title."
  
  ElseIf Firstname = "" Then
    Proceed = 0
	RCode   = 3
	RText   = "Please enter your First Name."
	
  ElseIf Surname = "" Then
    Proceed = 0
	RCode   = 4
	RText   = "Please enter your Surname."
	
  ElseIf Email = "" OR Instr( Email, "." ) = "0" OR Instr(Email, "@" ) = "0" Then
    Proceed = 0
	RCode   = 5
	RText   = "Please enter a valid email address."
	
  ElseIf EmailCount > "0" AND Email <> MemEmail Then
    Proceed = 0
	RCode   = 6
	RText   = "The Email Address you entered is in use by another member. Please enter another Email Address."
  
  ElseIf Telephone = "" OR IsNumeric(Telephone) = "False" Then
    Proceed = 0
	RCode   = 7
	RText   = "Please enter your Telephone Number."
	
  ElseIf Password > "" AND Len(Password) < 5 Then
    Proceed = 0
	RCode   = 8
	RText   = "Please enter a Password, This will be used to access your account. 5 alpha/numeric characters minimum."
	
  ElseIf Password > "" AND Password2 <> Password Then
    Proceed = 0
	RCode   = 9
	RText   = "Your password combinations do not match. Please try again."
	
  Else
  
    Proceed = 1
	RCode   = 10
	RText   = "OK"
	
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Member
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND UpdatePass = "0" Then
    UdSQL = "UPDATE members SET " & _
	        "salutation='" & Title & "', firstname='" & Firstname & "', surname='" & Surname & "', emailaddress='" & Email & "', " & _
			"telephone='" & Telephone & "' " & _
	        "WHERE customerid='" & Var_UserId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
  End If
  
  
  If Proceed = "1" AND UpdatePass = "1" Then
    UdSQL = "UPDATE members SET " & _
	        "salutation='" & Title & "', firstname='" & Firstname & "', surname='" & Surname & "', emailaddress='" & Email & "', " & _
			"telephone='" & Telephone & "', password='" & nPassword & "' " & _
	        "WHERE customerid='" & Var_UserId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Notify of password change
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" AND UpdatePass = "1" Then
  
  EmailBody    = "Hello, " & MemFirstname & "<br/>" & vbcrlf & _
                 "Your new password detail are below, you or someone changed it @ " & Now() & " via your account.<br/>" & _
				 "If you did not change your password, contact us at tgshortlets@aol.co.uk or login and change your password.<br/><br/>" & _
				 "<b>Email Address</b> : <h2 style='font-weight:bold;'>" & MemEmail & "</h2>" & _
				 "<b>Password</b> : <h2 style='font-weight:bold;'>" & Password & "</h2>" & _
				 "Please keep these details in a safe place, as you will need them to log into your account."
				 
				 
				 
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Password Updated</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Your password has been updated"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = MemEmail
	MxAppend    = False
	MxTLS       = 0
	Salutation  = "Accounts Team"	
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
  
  End If


// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSON = "{'rcode':'" & RCode & "', 'rtext':'" & UrlEncode(RText) & "', 'proceed':'" & Proceed & "', 'rpath':'" & nPage & "'}"
         Response.Write JSON
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
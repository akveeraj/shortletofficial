<!--#include virtual="/includes.inc"-->

<%
// ------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
  
  Username     = ParseCircuit("username", o_Query )
  Username     = UrlDecode( Username )
  Username     = FixSingleQuotes( Username )
  Password     = ParseCircuit("password", o_Query )
  Password     = UrlDecode( Password )
  Password     = FixSingleQuotes( Password )
  nPassword    = EncodeText( Password )
  Page         = ParseCircuit( "page", o_Query )
  Page         = DecodeText( Page )
  Page         = "/" & Page
  CookieSet    = Var_TestCookie
  
  If Page = "" OR Page = "/" Then
    Page = "\/dashboard\/account\/"
  Else
    Page = Page
  End If
  
  If Username = "" Then
    Username = "NULL"
  End If

// ------------------------------------------------------------------------------------------------------------------------------------
// ' Check Username or Screen Name
// ------------------------------------------------------------------------------------------------------------------------------------

  UserSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE emailaddress='" & Username & "'"
              Call FetchData( UserSQL, UserRs, ConnTemp )
			
  UserCount = UserRs("NumberOfRecords")

// ------------------------------------------------------------------------------------------------------------------------------------

  If UserCount > "0" Then
  
    UserSQL = "SELECT * FROM members WHERE emailaddress='" & Username & "'"
	          Call FetchData( UserSQL, UserRs, ConnTemp )
			  
	CustomerId    = UserRs("customerid")
	Firstname     = UserRs("firstname")
	Surname       = UserRs("surname")
	OrigPassword  = UserRs("password")
	EmailAddress  = UserRs("emailaddress")
	Status        = UserRs("status")
	PayRef        = UserRs("payreference")
			  
  End If

// ------------------------------------------------------------------------------------------------------------------------------------
// ' Do Validation
// ------------------------------------------------------------------------------------------------------------------------------------

 
  If CookieSet = "" Then
    Proceed = 0
	RText   = "Cookies are not enabled on your browser. Please enable cookies in your browser preferences to log in."
	RCode   = 1
	
  ElseIf UserCount = "0" Then
    Proceed = 0
	RText   = "The Email Address you entered was not found on our system.<br/>If you are not yet created an account, <a href='/register/doc/'>click here.</a>"
	RCode   = 2
	
  ElseIf UserCount > "0" AND Status = "2" Then
    Proceed = 0
	RText   = "This account has not yet been activated. Please refer to the activation email we sent to your registered email address."
	RCode   = 3
  
  ElseIf nPassword <> OrigPassword Then
    Proceed = 0
	RText   = "The password you entered is invalid.<br/>Please try again."
    RCode   = 4
  Else
    Proceed = 1
	RText   = "OK"
	RCode   = 5
  End If
  
  If UserCount > "0" AND nPassword = OrigPassword AND Proceed = "1" Then
    AuthPassed = 1
  Else
    AuthPassed = 0
  End If
  
// ------------------------------------------------------------------------------------------------------------------------------------
// ' Log login actions
// ------------------------------------------------------------------------------------------------------------------------------------
  
  If AuthPassed = "1" Then
    Action = "Frontend Login Attempt/Successful"
  Else
    Action = "Frontend Login Attempt Failed"
  End If
  
  LineId  = Sha1( Timer() & Rnd() )
  Account = EmailAddress
  IPAddy  = Request.ServerVariables("REMOTE_HOST")
  
  AuthSQL = "INSERT INTO entrylogs " & _
            "( lineid, action, datetimestamp, user, ipaddress )" & _
			" VALUES (" & _
			" '" & LineId          & "', " & _
			" '" & Action          & "', " & _
			" '" & Var_DateStamp   & "', " & _
			" '" & Account         & "', " & _
			" '" & IpAddy          & "'  " & _
			" )"
			Call SaveRecord( AuthSQL, AuthRs, ConnTemp )
			Call CloseRecord( AuthRs, ConnTemp )

// ------------------------------------------------------------------------------------------------------------------------------------
// ' Set up login session
// ------------------------------------------------------------------------------------------------------------------------------------

  If AuthPassed = "1" Then
  
    Response.Cookies("tandgshortlets")("token")      = CustomerId
	Response.Cookies("tandgshortlets")("userid")     = CustomerId
	Response.Cookies("tandgshortlets")("firstname")  = Firstname
	Response.Cookies("tandgshortlets")("surname")    = Surname
	Response.Cookies("tandgshortlets")("email")      = EmailAddress
	Response.Cookies("tandgshortlets")("loggedin")   = 1
	Response.Cookies("tandgshortlets")("payref")     = PayRef
	
  Else
  
    Response.Cookies("tandgshortlets")("token")      = ""
	Response.Cookies("tandgshortlets")("userid")     = ""
	Response.Cookies("tandgshortlets")("firstname")  = ""
	Response.Cookies("tandgshortlets")("surname")    = ""
	Response.Cookies("tandgshortlets")("email")      = ""
	Response.Cookies("tandgshortlets")("loggedin")   = ""
	Response.Cookies("tandgshortlets")("payref")     = ""
	
  End If

// ------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSON
// ------------------------------------------------------------------------------------------------------------------------------------

  JSON = "{'rcode':'" & RCode & "', 'rtext':'" & UrlEncode(RText) & "', 'proceed':'" & Proceed & "', 'rpath':'" & Page & "', 'action':'" & Action & "'}"
         Response.Write JSON

// ------------------------------------------------------------------------------------------------------------------------------------
%>
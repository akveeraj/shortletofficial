<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query        = fw_Query
  o_Query        = UrlDecode( o_Query )
  
  Title          = ParseCircuit( "title", o_Query )
  Firstname      = ParseCircuit( "firstname", o_Query )
  Surname        = ParseCircuit( "surname", o_Query )
  Email          = ParseCircuit( "email", o_Query )
  Telephone      = ParseCircuit( "telephone", o_Query )
  Password       = ParseCircuit( "password", o_Query )
  Password2      = ParseCircuit( "password2", o_Query )
  TrialMode      = ParseCircuit( "trial", o_Query )
  CustomerId     = Sha1( Timer() & Rnd() )
  nPassword      = EncodeText( Password )
  Page           = ParseCircuit( "page", o_Query )
  TrialDate      = DateAdd("d", Var_TrialLength, Var_DateStamp )
  TDate          = Split( TrialDate, "/" )
  TrialDay       = TDate(0)
  TrialMonth     = TDate(1)
  TrialYear      = TDate(2)
  TrialYear      = Left( TrialYear, 4 )
  TrialDate      = TrialYear & "-" & TrialMonth & "-" & TrialDay & " " & Time
  ActivateToken  = Sha1(Timer()&Rnd())
  ActivateToken  = Left( ActivateToken, 8 )
  ActivateToken  = UCase( ActivateToken )
  ShortCode      = Sha1(Timer()&Rnd())
  ShortCode      = Left( ShortCode, 8 )
  ShortCode      = UCase( ShortCode )
  HostName       = Request.ServerVariables("HTTP_HOST")
  nShortUrl       = "http://" & HostName & "/" & ShortCode & "/shorturl/"
  
  If Page > "" AND Var_RegConfirm = "1" Then
  
    Page        = DecodeText( Page )
	PageVars    = "endpoint:" & Page & ";key:" & ActivateToken & ";customerid:" & CustomerId & ";shortcode:" & ShortCode
	PageVars    = StringToHex( PageVars )
	nPage       = "/activate/actions/?output:1;data:" & PageVars
    Page        = nPage
	RegEmail    = Email
	RegName     = Firstname
	RegVars     = "email:" & RegEmail & ";name:" & RegName
	RegVars     = StringToHex( RegVars )
	RegEndPoint = "/regcomplete/doc/?data:" & RegVars
  
  ElseIf Page > "" AND Var_RegConfirm = "0" Then
    
	Page        = "/createadvert/account/?fromregister:1"
    RegEndPoint = Page
  
  ElseIf Page = "" AND Var_RegConfirm = "1" Then
  
    Page = "/createadvert/account?fromregister:1"
	PageVars    = "endpoint:" & Page & ";key:" & ActivateToken & ";customerid:" & CustomerId & ";shortcode:" & ShortCode & ";trial:" & TrialMode
	PageVars    = StringToHex( PageVars )
	nPage       = "/activate/actions/?output:1;data:" & PageVars
	Page        = nPage
	RegEmail    = Email
	RegName     = Firstname
	RegVars     = "email:" & RegEmail & ";name:" & RegName
	RegVars     = StringToHex( RegVars )
	RegEndPoint = "/regcomplete/doc/?data:" & RegVars
  
  ElseIf Page = "" AND Var_RegConfirm = "0" Then
    
	Page        = "/createadvert/account/?fromregister:1"
	RegEndPoint = Page
  
  Else
    
	Page        = "/createadvert/account/?fromregister:1"
	RegEndPoint = Page
	
  End If
  
  If Var_RegConfirm = "1" Then
    NewStatus = "2"
  Else
    NewStatus = "1"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Email
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ESQL       = "SELECT COUNT(uIndex) AS NumberOfRecords FROM members WHERE emailaddress='" & Email & "'"
               Call FetchData( ESQL, ERs, ConnTemp )
		 
  EmailCount = ERs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Member Count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  MSQL       = "SELECT COUNT(uIndex) As NumberOfRecords FROM members"
               Call FetchData( MSQL, MRs, ConnTemp )
			   
  MemCount   = MRs("NumberOfRecords")

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Generate Payment Reference
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  MemCount     = CDBL(MemCount) + 1
  PayRef       = MemCount & Left(Firstname,2)&Left(Surname,2)&Left(CustomerId,2)
  PayRef       = "REG" & UCase( PayRef )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Title = "" OR Title = "-" Then
    Proceed = 0
	RCode   = 1
	RText   = "Please select your Title."
  
  ElseIf Firstname = "" Then
    Proceed = 0
	RCode   = 2
	RText   = "Please enter your First Name."
	
  ElseIf Surname = "" Then
    Proceed = 0
	RCode   = 3
	RText   = "Please enter your Surname."
	
  ElseIf Email = "" OR Instr( Email, "." ) = "0" OR Instr(Email, "@" ) = "0" Then
    Proceed = 0
	RCode   = 4
	RText   = "Please enter a valid email address."
	
  'ElseIf EmailCount > "0" Then
    'Proceed = 0
	'RCode   = 5
	'RText   = "The Email Address you entered is in use by another member. Please enter another Email Address."
  
  ElseIf Telephone = "" OR IsNumeric(Telephone) = "False" Then
    Proceed = 0
	RCode   = 6
	RText   = "Please enter your Telephone Number."

  ElseIf Password = "" OR Len(Password) < 5 Then
    Proceed = 0
	RCode   = 7
	RText   = "Please enter a Password, This will be used to access your account. 5 alpha/numeric characters minimum."
	
  ElseIf Password2 <> Password Then
    Proceed = 0
	RCode   = 8
	RText   = "Your Password combinations do not match. Please try again."
	
  Else
  
    Proceed = 1
	RCode   = 9
	RText   = "OK"
	
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Member
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND TrialMode = "1" Then
  
    NewDateStamp = Left( TrialDate, 10 )
  
    SaveSQL = "INSERT INTO members " & _
	          "( "       & _
			  "customerid, salutation, firstname, surname, password, " & _
			  "emailaddress, telephone, status, datetimestamp, datestamp, paidmember, paymentmethod, " & _
			  "payreference, paiduntil, subdescription, paiduntilnostamp, lastexpirycheck, lastexpirychecktime" & _
			  " )"       & _
			  " VALUES( " & _
			  "'" & CustomerId           & "', "  & _
			  "'" & Title                & "', "  & _
			  "'" & Firstname            & "', "  & _
			  "'" & Surname              & "', "  & _
			  "'" & nPassword            & "', "  & _
			  "'" & Email                & "', "  & _
			  "'" & Telephone            & "', "  & _
			  "'" & NewStatus            & "', "  & _
			  "'" & Var_DateStamp        & "', "  & _
			  "'" & Var_DateNoTimeStamp  & "', "  & _
			  "'0', "                    & _
			  "'2', "                    & _
			  "'" & PayRef               & "', " & _
			  "'" & TrialDate            & "', " & _
			  "'" & Var_TrialLabel       & "', " & _
			  "'" & NewDateStamp         & "', " & _
			  "'" & Var_DateStamp        & "', " & _
			  "'" & Var_DateNoTimeStamp  & "'  " & _
			  ")"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" AND TrialMode = "" Then
  
	nDStamp      = Left(Var_DateNoTimeStamp, 10 )
	nDTime       = Var_TimeStamp
	nDStamp      = DateAdd( "yyyy", -1, nDStamp )
	DateSplit    = Split( nDStamp, "/" )
	DayStamp     = DateSplit(0)
	MonthStamp   = DateSplit(1)
	YearStamp    = DateSplit(2)
	nDStamp      = YearStamp & "-" & MonthStamp & "-" & DayStamp
	nDStampTime  = YearStamp & "-" & MonthStamp & "-" & DayStamp & " " & nDTime 
  
    SaveSQL = "INSERT INTO members " & _
	          "( "       & _
			  "customerid, salutation, firstname, surname, password, " & _
			  "emailaddress, telephone, status, datetimestamp, datestamp, paiduntil, paiduntilnostamp, paidmember, paymentmethod, " & _
			  "payreference, lastexpirycheck, lastexpirychecktime" & _
			  " )"       & _
			  " VALUES( " & _
			  "'" & CustomerId              & "', "  & _
			  "'" & Title                   & "', "  & _
			  "'" & Firstname               & "', "  & _
			  "'" & Surname                 & "', "  & _
			  "'" & nPassword               & "', "  & _
			  "'" & Email                   & "', "  & _
			  "'" & Telephone               & "', "  & _
			  "'" & NewStatus               & "', "  & _
			  "'" & Var_DateStamp           & "', "  & _
			  "'" & Var_DateNoTimeStamp     & "', "  & _
			  "'" & nDStampTime             & "', " & _
			  "'" & nDStamp                 & "', " & _
			  "'0', "                       & _
			  "'2', "                       & _
			  "'" & PayRef                  & "', " & _
			  "'" & Var_DateStamp           & "', " & _
			  "'" & Var_DateNoTimeStamp     & "'  " & _
			  ")"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Auto Log In
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND Var_RegConfirm = "0" Then
    Response.Cookies("tandgshortlets")("token")      = CustomerId
	Response.Cookies("tandgshortlets")("userid")     = CustomerId
	Response.Cookies("tandgshortlets")("firstname")  = Firstname
	Response.Cookies("tandgshortlets")("surname")    = Surname
	Response.Cookies("tandgshortlets")("email")      = Email
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
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Short Url
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND Var_RegConfirm = "1" Then

  SaveSQL = "INSERT INTO shorturl " & _
            "( " & _
			"url, shortcode, requestdate" & _
			" )" & _
			" VALUES( " & _
			"'http://" & HostName & Page & "', " & _
			"'" & ShortCode     & "', " & _
			"'" & Var_DateStamp & "' " & _
			")"
			Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
			
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Send Email Notification
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    EmailBody = "New registration alert<br/><br/>This is an automated message from T&G Shortlets notification system,<br/>" & _
	            " A new member has joined the site on <b>" & Var_DateStamp & "</b>, " & _
				"<br/><br/>" & _
				"Please follow the link below to review new registrations.<br/><br/>" & _
				"http://admin.townandgownshortlets.uk/memberlist/do/<br/><br/>"
				
				   
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">New Registration Notification</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "** Notification ** New Registration"
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Notification System TG Shortlets"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = "tgshortlets@aol.co.uk"
	MxAppend    = False
	MxTLS       = 0
	Salutation  = ""	
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
				   
				   
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Send confirmation email
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND Var_RegConfirm = "0" AND TrialMode = "1" Then

  EmailBody    = "Hello, " & Firstname & "<br/>" & vbcrlf & _
                 "Your registration at Town and Gown Shortlets is now complete and your account is now active and ready to use." & _
				 " As a thank you for registering, you now have a free " & Var_TrialLength & " day trial to try out our shortlets introductory platform. Your free trial will expire on " & _
				 "<b>" & FormatDateTime(TrialDate, 1 ) & "</b>. Once your trial has expired, you will need to renew any adverts you want to keep as they will expire" & _
				 " when your trial ends. (This excludes featured adverts).<br/><br/><br/>" & _
				 "We have included your log in details to access your account. Please keep this information in a safe place as you will" & _
				 " need this to create and edit your adverts.<br/><br/>" & _
				 "<b>Email Address</b> : <h2 style='font-weight:bold;'>" & Email & "</h2>" & _
				 "<b>Password</b> : <h2 style='font-weight:bold;'>" & Password & "</h2>"
				 
				 
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Thank you for registering</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Your Town and Gown Shortlet account details"
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
  
  If Proceed = "1" And Var_RegConfirm = "0" AND TrialMode = "" Then
  
  EmailBody    = "Hello, " & Firstname & "<br/>" & vbcrlf & _
                 "Your registration at Town and Gown Shortlets is now complete and your account is now active and ready to use.<br/><br/>" & _
				 "We have included your log in details to access your account. Please keep this information in a safe place as you will" & _
				 " need this to create and edit your adverts.<br/><br/>" & _
				 "<b>Email Address</b> : <h2 style='font-weight:bold;'>" & Email & "</h2>" & _
				 "<b>Password</b> : <h2 style='font-weight:bold;'>" & Password & "</h2>"
				 
				 
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
  
  If Proceed = "1" AND Var_RegConfirm = "1" Then
  
  EmailBody    = "Hello, " & Firstname & "<br/>" & vbcrlf & _
                 "We have received your new registration request.<br/>" & _
				 "Your account is almost ready to use.<br/><br/>" & _
				 "Please click on the link below to activate your account<br/><br/>" & _
				 "<a href='" & nShortUrl & "' style='width:100px;'>" & nShortUrl & "</a><br/><br/>"
				 
				 
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Confirm your Registration</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "IMPORTANT - Confirm your Registration"
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
// ' Write JSON Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSON = "{'rcode':'" & RCode & "', 'rtext':'" & UrlEncode(RText) & "', 'proceed':'" & Proceed & "', 'rpath':'" & RegEndPoint & "'}"
         Response.Write JSON
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
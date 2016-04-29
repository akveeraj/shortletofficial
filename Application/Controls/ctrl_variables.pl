<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Global Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

   o_Query = fw_Query 
   o_Query = UrlDecode( o_Query )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Project Cookies
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    Global_Token         = Request.Cookies("tandgshortlets")("token")
	Global_UserId        = Request.Cookies("tandgshortlets")("userid")
	Global_FirstName     = Request.Cookies("tandgshortlets")("firstname")
	Global_Surname       = Request.Cookies("tandgshortlets")("surname")
	Global_Email         = Request.Cookies("tandgshortlets")("email")
	Global_Fee           = 50.00
	Global_AcceptCookies = Request.Cookies("tandgshortlets")("acceptcookies")
	Global_Telephone     = "07585 703 177"
	Global_LoginCheck    = Request.Cookies("tandgshortlets")("loggedin")
	Global_PayRef        = Request.Cookies("tandgshortlets")("payref")
	Global_Location      = Request.Cookies("tandgshortlets")("location")
	Global_ProType       = Request.Cookies("tandgshortlets")("protype")
	Global_NoRooms       = Request.Cookies("tandgshortlets")("norooms")
	Global_RentFrequency = Request.Cookies("tandgshortlets")("rentfrequency")
	Global_TestCookie    = Request.Cookies("tandgshortlets")("testcookie")
	
	If Global_TestCookie = "" Then
	  Response.Cookies("tandgshortlets")("testcookie") = "1"
	End If
	
	Var_Token           = Global_Token
	Var_UserId          = Global_UserId
	Var_Firstname       = Global_Firstname
	Var_Surname         = Global_Surname
	Var_Email           = Global_Email
	Var_Fee             = Global_Fee
	Var_LoggedIn        = Global_LoginCheck
	Var_TrialLabel      = "1 Month Trial"
	Var_PayRef          = Global_PayRef 
	Var_ReviewAds       = 0
	Var_Location        = Global_Location
	Var_ProType         = Global_ProType
	Var_NoRooms         = Global_NoRooms
	Var_RentFrequency   = Global_RentFrequency
	Var_TestCookie      = Global_TestCookie
	Var_ExpNoAdvert     = 1
	Var_ExpNoContact    = 1
	Var_ExpNoEdit       = 1
	Var_RegConfirm      = 1
	Var_TrialLength     = 14
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Custom Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
  Var_DateStamp         = Year(now) & "-" & FixSingleDigits(Month(Now)) & "-" & FixSingleDigits(Day(Now))
  Var_TimeSeconds       = FixSingleDigits(Second(Now))
  Var_ShortTime         = Time
  Var_24Time            = FormatDateTime(Now(), 4) & ":" & Var_TimeSeconds
  Var_TimeStamp         = Var_24Time
  Var_DateStamp         = Var_DateStamp & " " & Var_TimeStamp 
  Var_DateNoTimeStamp   = Var_DateStamp
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Set location from cities permalink
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PermaFolder = fw_Folder
  PermaFile   = fw_File
  
  If PermaFolder = "permalink" AND CheckSourceFile = "1" Then
    If PermaFile > "" Then
      Response.Cookies("tandgshortlets")("location") = PermaFile
	End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	If Global_Token = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_UserId = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_FirstName = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_Surname = "" Then
	  Session_LoggedIn = 0
	ElseIf Global_LoginCheck = "" OR Global_LoginChek = "0" Then
	  Session_LoggedIn = 0
	Else
	  Session_LoggedIn = 1
	End If
	
	Global_LoggedIn = Session_LoggedIn
	Var_LoggedIn    = Global_LoggedIn
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
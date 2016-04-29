<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = Request.Form
  o_Query      = Replace( o_Query, ";", vbcrlf )
  AdTitle      = ParseCircuit( "title", o_Query )
  AdTitle      = UrlDecode( AdTitle )
  NextDay      = ParseCircuit( "nextday", o_Query )
  NextDay      = UrlDecode( NextDay )
  NextMonth    = ParseCircuit( "nextmonth", o_Query )
  NextMonth    = UrlDecode(NextMonth)
  NextYear     = ParseCircuit( "nextyear", o_Query )
  NextYear     = UrlDecode(NextYear)
  Rent         = ParseCircuit( "rent", o_Query )
  Rent         = UrlDecode(Rent)
  Period       = ParseCircuit( "period", o_Query )
  Period       = UrlDecode(Period)
  IncBills     = ParseCircuit( "incbills", o_Query )
  IncBills     = UrlDecode(IncBills)
  PostCode     = ParseCircuit( "postcode", o_Query )
  PostCode     = UrlDecode(PostCode)
  Location     = ParseCircuit( "location", o_Query )
  Location     = UrlDecode(Location)
  ProType      = ParseCircuit( "protype", o_Query )
  ProType      = UrlDecode(ProType)
  RoomAmount   = ParseCircuit( "roomamount", o_Query )
  RoomAmount   = UrlDecode(RoomAmount)
  Desc         = ParseCircuit( "desc", o_Query )
  ByEmail      = ParseCircuit( "byemail", o_Query )
  ByEmail      = UrlDecode(ByEmail)
  Email        = ParseCircuit( "email", o_Query )
  Email        = UrlDecode( Email )
  ByPhone      = ParseCircuit( "byphone", o_Query )
  ByPhone      = UrlDecode( ByPhone )
  Phone        = ParseCircuit( "phone", o_Query )
  Phone        = UrlDecode( Phone )
  Contact      = ParseCircuit( "contact", o_Query )
  Contact      = UrlDecode( Contact )
  ListingId    = Sha1( Timer() & Rnd() )
  AdvertId     = Sha1( Timer() & Rnd() )
  AdvertId     = Left( AdvertId, 8 )
  AdvertId     = UCase( AdvertId )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate Form
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "0" OR Var_LoggedIn = "" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that, <a href=""javascript:\/\/"" onclick=""document.location.reload();"">click here</a> to log in."
	
  ElseIf AdTitle = "" Then
    Proceed = 0
	RCode   = 2
	RText   = "Please enter your advert title"
	
  ElseIf NextDay = "-" OR NextMonth = "-" Or NextYear = "-" Then
    Proceed = 0
	RCode   = 3
	RText   = "Please select a valid Available Date."
	
  ElseIf Rent = "" Then
    Proceed = 0
	RCode   = 4
	RText   = "Please enter the rent amount in whole pounds only"

  ElseIf Period = "-" Then
    Proceed = 0
	RCode   = 5
	RText   = "Please select the rental period"
	
  ElseIf Location = "" OR Location = "-" Then
    Proceed = 0
	RCode   = 6
	RText   = "Please select the location of your shortlet"
	
  ElseIf ProType = "-" Then
    Proceed = 0
	RCode   = 7
	RText   = "Please select the property type"
	
  ElseIf RoomAmount = "-" Then
    Proceed = 0
	RCode   = 8
	RText   = "Please select the amount of rooms available"
	
  ElseIf Desc = "" Then
    Proceed = 0
	RCode   = 9
	RText   = "Please enter a description for your advert"
	
  ElseIf ByEmail = "0" AND ByPhone = "0" Then
    Proceed = 0
	RCode   = 10
	RText   = "Please select at least one contact method by the checkboxes provided"
	
  ElseIf ByPhone = "0" AND ByEmail = "0" Then
    Proceed = 0
	RCode   = 11
	RText   = "Please select at least one contact method by the checkboxes provided"
	
  ElseIf ByEmail = "1" And Email = "" Then
    Proceed = 0
	RCode   = 12
	RText   = "Please enter a valid contact email address"
	
  ElseIf ByEmail = "1" AND Instr( Email, "@" ) = "0" Then
    Proceed = 0
	RCode   = 13
	RText   = "Please enter a valid contact email address"

  ElseIf ByEmail = "1" AND Instr( Email, "." ) = "0" Then
    Proceed = 0
	RCode   = 14
	RText   = "Please enter a valid contact email address"
	
  ElseIf ByPhone = "1" AND Phone = "" OR ByPhone = "1" AND IsNumeric(Phone) = False Then
    Proceed = 0
	RCode   = 15
	RText   = "Please enter a valid contact telephone number. No spaces or special characters."
	
  Else
    Proceed = 1
	RCode   = 16
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Customer Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    CustSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
                Call FetchData( CustSQL, CustRs, ConnTemp )
			
    CustCount = CustRs("NumberOfRecords")
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
    If CustCount > "0" Then
  
      CustSQL = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
                Call FetchData( CustSQL, CustRs, ConnTemp )
      Firstname   = CustRs("firstname")
      Surname     = CustRs("surname")
      Title       = CustRs("salutation")
      Telephone   = CustRs("telephone")
      Email       = CustRs("emailaddress")
      CustRef     = CustRs("payreference")
      CustomerId  = CustRs("customerid")
	  IsAdmin     = CustRs("administrator")
	  PaidUntilNoStamp = CustRs("paiduntilnostamp")
	  PaidUntil        = CustRs("paiduntil")
	  NumDays     = CalcDaysPassed( PaidUntil )
	  NumDays     = Replace( NumDays, "-", "" )
    End If 
  End If  
  
  DateNoTime = Left( Var_DateStamp, 10 )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if in trial 
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  IsTrialExpired = IsAccountExpired( CustomerId, ConnTemp ) 
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Var_ReviewAds = "1" Then
    NewStatus = 2
  Else
    NewStatus = 1
  End If
  
  DateNoTime = Left( Var_DateStamp, 10 )
  
  If Proceed = "1" Then
    AdTitle = StringToHex( AdTitle )
	Desc    = StringToHex( Desc )
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Record
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND IsTrialExpired = "0" Then
  
  	  PaidUntilNoStamp  = CustRs("paiduntilnostamp")
	  PaidUntil         = CustRs("paiduntil")
	  AdResponseText    = "<b>Your advert was saved successfully.</b><br/>Your advert is free during your 30 day trial period.<br/>"
	  AdResponseText    = UrlEncode( AdResponseText )
	  AdRPath           = "/editadvert/account/?saved:1;listingid:" & ListingId 
	  
	  PaidDate      = Split( PaidUntil, "/" )
	  NewAdDay      = PaidDate(0)
	  NewAdMonth    = PaidDate(1)
	  NewAdYear     = PaidDate(2)
	  NewAdYear     = Left( NewAdYear,4 )
	  NewAdYear     = Replace( NewAdYear, " ", "" )
	  
	  NewAdStamp    = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay & " " & Time
	  NewAdNoStamp  = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay
  
    SaveSQL = "INSERT INTO shortlets " & _
	          "( " & _
	          "customerid, advertid, listingid, photo, isvertical, title, nextday, nextmonth, nextyear, rent, " & _
	          "period, incbills, postcode, location, propertytype, roomamount, description, byemail, " & _
	          "email, byphone, phone, contactname, datetimestamp, datestamp, status, pageviews, adexpires, adexpiry, adduration, advertpaid" & _
			  " ) " & _
			  "VALUES (" & _
			  "'" & Var_UserId        & "', " & _
			  "'" & AdvertId          & "', " & _
			  "'" & ListingId         & "', " & _
			  "'NULL', "                      & _
			  "'0', "                         & _
			  "'" & AdTitle           & "', " & _
			  "'" & NextDay           & "', " & _
			  "'" & NextMonth         & "', " & _
			  "'" & NextYear          & "', " & _
			  "'" & Rent              & "', " & _
			  "'" & Period            & "', " & _
			  "'" & IncBills          & "', " & _
			  "'" & PostCode          & "', " & _
			  "'" & Location          & "', " & _
			  "'" & ProType           & "', " & _
			  "'" & RoomAmount        & "', " & _
			  "'" & Desc              & "', " & _
			  "'" & ByEmail           & "', " & _
			  "'" & Email             & "', " & _
			  "'" & ByPhone           & "', " & _
			  "'" & Phone             & "', " & _
			  "'" & Contact           & "', " & _
			  "'" & Var_DateStamp     & "', " & _
			  "'" & DateNoTime        & "', " & _
			  "'" & NewStatus         & "', " & _
			  "'0', " & _
			  "'" & NewAdStamp        & "', " & _
			  "'" & NewAdNoStamp      & "', " & _
			  "'" & NumDays           & "', " & _
			  "'1' " & _
			  " )"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp ) 
  
  ElseIf Proceed = "1" AND IsTrialExpired = "1" Then 
  
    AdResponseText = "<b>Your advert was saved successfully.</b><br/>You will now be taken to our payment page to pay for your advert."
	AdResponseText = UrlEncode( AdResponseText )
	AdRPath        = "/makepayment/account/?saved:1;listingid:" & ListingId & ";advertid:" & AdvertId
  
    SaveSQL = "INSERT INTO shortlets " & _
	          "( " & _
	          "customerid, advertid, listingid, photo, isvertical, title, nextday, nextmonth, nextyear, rent, " & _
	          "period, incbills, postcode, location, propertytype, roomamount, description, byemail, " & _
	          "email, byphone, phone, contactname, datetimestamp, datestamp, status, adduration, pageviews, advertpaid" & _
			  " ) " & _
			  "VALUES (" & _
			  "'" & Var_UserId     & "', " & _
			  "'" & AdvertId       & "', " & _
			  "'" & ListingId      & "', " & _
			  "'NULL', "                   & _
			  "'0', "                      & _
			  "'" & AdTitle        & "', " & _
			  "'" & NextDay        & "', " & _
			  "'" & NextMonth      & "', " & _
			  "'" & NextYear       & "', " & _
			  "'" & Rent           & "', " & _
			  "'" & Period         & "', " & _
			  "'" & IncBills       & "', " & _
			  "'" & PostCode       & "', " & _
			  "'" & Location       & "', " & _
			  "'" & ProType        & "', " & _
			  "'" & RoomAmount     & "', " & _
			  "'" & Desc           & "', " & _
			  "'" & ByEmail        & "', " & _
			  "'" & Email          & "', " & _
			  "'" & ByPhone        & "', " & _
			  "'" & Phone          & "', " & _
			  "'" & Contact        & "', " & _
			  "'" & Var_DateStamp  & "', " & _
			  "'" & DateNoTime     & "', " & _
			  "'" & NewStatus      & "', " & _
			  "'0', " & _
			  "'0', " & _
			  "'0'  " & _
			  " )"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp ) 
  
  End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  JSON = "{'rtext':'" & RText & "', 'adresponse':'" & AdResponseText & "', 'rcode':'" & RCode & "', 'proceed':'" & Proceed & "', 'rpath':'" & AdRPath & "'}"
         Response.Write JSON
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
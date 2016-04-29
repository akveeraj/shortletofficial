<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query         = Request.Form
  o_Query         = Replace( o_Query, "&", ";" )
  o_Query         = Replace( o_Query, ";", vbcrlf )

  RPath           = ParseCircuit( "rpath", o_Query )
  Title           = ParseCircuit( "title", o_Query )
  Title           = Replace( Title, "%C2%A3", "&pound;" )
  Title           = UrlDecode(Title)
  Desc            = ParseCircuit( "desc", o_Query )
  Desc            = Replace( Desc, "%C2%A3", "&pound;" )
  References      = ParseCircuit( "references", o_Query )
  References      = Replace( References, "%C2%A3", "&pound;" )
  NextDay         = ParseCircuit( "nextday", o_Query )
  NextDay         = UrlDecode(NextDay)
  NextMonth       = ParseCircuit( "nextmonth", o_Query )
  NextMonth       = UrlDecode(NextMonth)
  NextYear        = ParseCircuit( "nextyear", o_Query )
  NextYear        = UrlDecode(NextYear)
  Rent            = ParseCircuit( "rent", o_Query )
  Rent            = UrlDecode(Rent)
  Period          = ParseCircuit( "period", o_Query )
  Period          = UrlDecode(Period)
  IncBills        = ParseCircuit( "incbills", o_Query )
  IncBills        = UrlDecode(IncBills)
  PostCode        = ParseCircuit( "postcode", o_Query )
  PostCode        = UrlDecode(PostCode)
  Location        = ParseCircuit( "location", o_Query )
  Location        = UrlDecode(Location)
  ProType         = ParseCircuit( "protype", o_Query )
  ProType         = UrlDecode(ProType)
  RoomAmount      = ParseCircuit( "roomamount", o_Query )
  RoomAmount      = UrlDecode(RoomAmount)
  ByEmail         = ParseCircuit( "byemail", o_Query )
  ByEmail         = UrlDecode(ByEmail)
  Email           = ParseCircuit( "email", o_Query )
  Email           = UrlDecode( Email )
  ByPhone         = ParseCircuit( "byphone", o_Query )
  ByPhone         = UrlDecode(ByPhone)
  Phone           = ParseCircuit( "phone", o_Query )
  Phone           = UrlDecode( Phone )
  Contact         = ParseCircuit( "contact", o_Query )
  Contact         = UrlDecode(Contact)
  
  Photo1Value     = ParseCircuit( "photo1value", o_Query )
  Photo2Value     = ParseCircuit( "photo2value", o_Query )
  Photo3Value     = ParseCircuit( "photo3value", o_Query )
  Photo4Value     = ParseCircuit( "photo4value", o_Query )
  Photo5Value     = ParseCircuit( "photo5value", o_Query )
  Photo6Value     = ParseCircuit( "photo6value", o_Query )
  
  Photo1IsVert    = ParseCircuit( "photo1isvert", o_Query )
  Photo1IsVert    = Replace( Photo1IsVert, " ", "" )
  Photo2IsVert    = ParseCircuit( "photo2isvert", o_Query )
  Photo2IsVert    = Replace( Photo2IsVert, " ", "" )
  Photo3IsVert    = ParseCircuit( "photo3isvert", o_Query )
  Photo3IsVert    = Replace( Photo3IsVert, " ", "" )
  Photo4IsVert    = ParseCircuit( "photo4isvert", o_Query )
  Photo4IsVert    = Replace( Photo4IsVert, " ", "" )
  Photo5IsVert    = ParseCircuit( "photo5isvert", o_Query )
  Photo5IsVert    = Replace( Photo5IsVert, " ", "" )
  Photo6IsVert    = ParseCircuit( "photo6isvert", o_Query )
  Photo6IsVert    = Replace( Photo6IsVert, " ", "" )
  
  Photo1Width     = ParseCircuit( "photo1width", o_Query )
  Photo1Width     = UrlDecode(Photo1Width)
  Photo2Width     = ParseCircuit( "photo2width", o_Query )
  Photo2Width     = UrlDecode(Photo2Width)
  Photo3Width     = ParseCircuit( "photo3width", o_Query )
  Photo3Width     = UrlDecode(Photo3Width)
  Photo4Width     = ParseCircuit( "photo4width", o_Query )
  Photo4Width     = UrlDecode(Photo4Width)
  Photo5Width     = ParseCircuit( "photo5width", o_Query )
  Photo5Width     = UrlDecode(Photo5Width)
  Photo6Width     = ParseCircuit( "photo6width", o_Query )
  Photo6Width     = UrlDecode(Photo6Width)
  
  SaveAction      = ParseCircuit( "saveaction", o_Query )
  SaveAction      = UrlDecode(SaveAction)
  ListingId       = ParseCircuit( "listingid", o_Query )
  ListingId       = UrlDecode(ListingId)
  AdvertId        = ParseCircuit( "advertid", o_Query )
  AdvertId        = UrlDecode( AdvertId )
  
  FromLive        = ParseCircuit( "fromlive", o_Query )
  FromSaved       = ParseCircuit( "fromsaved", o_Query )
  FromExpired     = ParseCircuit( "fromexpired", o_Query )
  FromDeleted     = ParseCircuit( "fromdeleted", o_Query )
				 
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "0" OR Var_LoggedIn = "" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that, <a href=""javascript:\/\/"" onclick=""document.location.reload();"">click here</a> to log in."
	
  ElseIf Title = "" Then
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
	
  ElseIf IncBills = "" OR IncBills = "undefined" Then
    Proceed = 0
	RCode   = 6
	RText   = "Please select whether the rent amount is Including Bills or Excluding Bills"
	
  ElseIf Location = "" OR Location = "-" Then
    Proceed = 0
	RCode   = 7
	RText   = "Please select the location of your shortlet"
	
  ElseIf ProType = "-" Then
    Proceed = 0
	RCode   = 8
	RText   = "Please select the property type"
	
  ElseIf RoomAmount = "-" Then
    Proceed = 0
	RCode   = 9
	RText   = "Please select the amount of rooms available"
	
  ElseIf Desc = "" Then
    Proceed = 0
	RCode   = 10
	RText   = "Please enter a description for your advert"
	
  ElseIf ByEmail = "0" AND ByPhone = "0" Then
    Proceed = 0
	RCode   = 11
	RText   = "Please select at least one contact method by the checkboxes provided"
	
  ElseIf ByPhone = "0" AND ByEmailAddress = "0" Then
    Proceed = 0
	RCode   = 12
	RText   = "Please select at least one contact method by the checkboxes provided"
	
  ElseIf ByEmail = "1" AND Email = "" Then
    Proceed = 0
	RCode   = 13
	RText   = "Please enter a valid contact email address"
	
  ElseIf ByEmail = "1" AND Instr( Email, "@" ) = "0" Then
    Proceed = 0
	RCode   = 14
	RText   = "Please enter a valid contact email address"

  ElseIf ByEmail = "1" AND Instr( Email, "." ) = "0" Then
    Proceed = 0
	RCode   = 15
	RText   = "Please enter a valid contact email address"
	
  ElseIf ByPhone = "1" AND Phone = "" OR ByPhone = "1" AND IsNumeric(Phone) = False Then
    Proceed = 0
	RCode   = 16
	RText   = "Please enter a valid contact telephone number. No spaces or special characters."
	
  Else
    Proceed = 1
	RCode   = 17
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Temporary Data
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  TempId = Request.Cookies("tandgadform")("tempid")
  
  If TempId = "" Then
    RandId = Sha1(Timer()&Rnd())
    Response.Cookies("tandgadform")("tempid") = RandId
	TempId = RandId
  Else
    TempId = TempId
	Response.Cookies("tandgadform")("tempid") = TempId
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  AdSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM tempshortlets WHERE tempid='" & TempId & "'"
            Call FetchData( AdSQL, AdRs, ConnTemp )

  AdCount = AdRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------


    nDate      = Var_DateStamp
	nDate      = Left( NDate, 10 )
	nDateTime  = Var_DateStamp

  If AdCount > "0" Then
  
    nDate      = Var_DateStamp
	nDate      = Left( NDate, 10 )
	nDateTime  = Var_DateStamp
	
    UdSQL = "UPDATE tempshortlets SET " & _
	        "description='" & StringToHex(Desc) & "', refs='" & StringToHex(References) & "', adddate='" & nDate & "', adddatetime='" & nDateTime & "'" & _
	        " WHERE tempid='" & TempId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
  
  Else

    UdSQL = "INSERT INTO tempshortlets " & _
            "( tempid, description, refs, adddate, adddatetime )" & _
		    " VALUES( "  & _
			"'" & TempId & "', " & _
			"'" & StringToHex( Desc ) & "', " & _
			"'" & StringToHex( References ) & "', "  & _
			"'" & nDate     & "', " & _
			"'" & nDateTime & "' " & _
			")"
		    Call SaveRecord( UdSQL, UdRs, ConnTemp )
			
  
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Cookies
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    If IncBills = "undefined" Then IncBills = "" End If
  
    Response.Cookies("tandgadform")("adtitle")           = Title
    Response.Cookies("tandgadform")("availday")          = NextDay
    Response.Cookies("tandgadform")("availmonth")        = NextMonth
    Response.Cookies("tandgadform")("availyear")         = NextYear
    Response.Cookies("tandgadform")("adrent")            = Rent
    Response.Cookies("tandgadform")("adperiod")          = Period
    Response.Cookies("tandgadform")("adincbills")        = Incbills
    Response.Cookies("tandgadform")("adpostcode")        = PostCode
    Response.Cookies("tandgadform")("adlocation")        = Location
    Response.Cookies("tandgadform")("adprotype")         = ProType
    Response.Cookies("tandgadform")("adnoofbeds")        = RoomAmount
    Response.Cookies("tandgadform")("adbyemail")         = ByEmail
    Response.Cookies("tandgadform")("adbyphone")         = ByPhone
    Response.Cookies("tandgadform")("ademail")           = Email
    Response.Cookies("tandgadform")("adphone")           = Phone
	Response.Cookies("tandgadform")("adcontact")         = Contact
    Response.Cookies("tandgadform")("adphoto1")          = Photo1value
    Response.Cookies("tandgadform")("adphoto2")          = Photo2value
    Response.Cookies("tandgadform")("adphoto3")          = Photo3value
    Response.Cookies("tandgadform")("adphoto4")          = Photo4value
    Response.Cookies("tandgadform")("adphoto5")          = Photo5value
	Response.Cookies("tandgadform")("adphoto6")          = Photo6value
    Response.Cookies("tandgadform")("adphoto1isvert")    = Photo1isvert
    Response.Cookies("tandgadform")("adphoto2isvert")    = Photo2isvert
    Response.Cookies("tandgadform")("adphoto3isvert")    = Photo3isvert
    Response.Cookies("tandgadform")("adphoto4isvert")    = Photo4isvert
    Response.Cookies("tandgadform")("adphoto5isvert")    = Photo5isvert
	Response.Cookies("tandgadform")("adphoto6isvert")    = Photo6isvert
	Response.Cookies("tandgadform")("adphoto1width")     = Photo1width
	Response.Cookies("tandgadform")("adphoto2width")     = Photo2width
	Response.Cookies("tandgadform")("adphoto3width")     = Photo3width
	Response.Cookies("tandgadform")("adphoto4width")     = Photo4width
	Response.Cookies("tandgadform")("adphoto5width")     = Photo5width
	Response.Cookies("tandgadform")("adphoto6width")     = Photo6width
	Response.Cookies("tandgadform")("adsaveaction")      = SaveAction
	Response.Cookies("tandgadform")("listingid")         = ListingId
	Response.Cookies("tandgadform")("advertid")          = AdvertId
	Response.Cookies("tandgadform")("adtype")            = AdType
   
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  JSON = "{'listingid':'" & ListingId & "', 'rtext':'" & RText & "', 'adresponse':'" & AdResponseText & "', " & _
         "'tempid':'" & TempId & "', 'rcode':'" & RCode & "', 'proceed':'" & Proceed & "', 'rpath':'" & RPath & "', 'saveaction':'" & SaveAction & "', 'fromlive':'" & FromLive & "', 'fromsaved':'" & FromSaved & "', 'fromexpired':'" & FromExpired & "', 'fromdeleted':'" & FromDeleted & "'}"
         Response.Write JSON
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
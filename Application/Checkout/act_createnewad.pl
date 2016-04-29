<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query        = Request.Form
  o_Query        = Replace( o_Query, "&", ";" )
  o_Query        = Replace( o_Query, ";", vbcrlf )
  RPath          = ParseCircuit( "rpath", o_Query )
  PPlDesc        = ParseCircuit( "ppldesc", O_Query )
  PPlAmount      = ParseCircuit( "pplamount", o_Query )
  AdType         = ParseCircuit( "adtype", o_Query )
  PPlDuration    = ParseCircuit( "pplduration", o_Query )
  TrialExpired   = IsAccountExpired( Var_UserId, ConnTemp )
  ListingId      = Sha1( Timer() & Rnd() )
  AdvertId       = Sha1( Timer() & Rnd() )
  AdvertId       = Left( AdvertId, 10 )
  AdvertId       = UCase( AdvertId )
  TempId         = ParseCircuit( "tempid", o_Query )
  KillCookies    = 0
  LastExpCheck   = Var_DateStamp
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Description and References
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  RefSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM tempshortlets WHERE tempid='" & TempId & "'"
           Call FetchData( RefSQL, RefRs, ConnTemp )
		   
  RefCount = RefRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If RefCount > "0" Then
  
    RefSQL = "SELECT * FROM tempshortlets WHERE tempid='" & TempId & "'"
	         Call FetchData( RefSQL, RefRs, ConnTemp )
			 Desc       = RefRs("description")
			 References = RefRs("refs")
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  AdTitle        = Request.Cookies("tandgadform")("adtitle")  
  NextDay        = Request.Cookies("tandgadform")("availday") 
  NextMonth      = Request.Cookies("tandgadform")("availmonth") 
  NextYear       = Request.Cookies("tandgadform")("availyear")
  Rent           = Request.Cookies("tandgadform")("adrent") 
  Period         = Request.Cookies("tandgadform")("adperiod")
  Incbills       = Request.Cookies("tandgadform")("adincbills")
  PostCode       = Request.Cookies("tandgadform")("adpostcode")
  Location       = Request.Cookies("tandgadform")("adlocation")
  ProType        = Request.Cookies("tandgadform")("adprotype") 
  RoomAmount     = Request.Cookies("tandgadform")("adnoofbeds")
  Desc           = Desc
  References     = References
  ByEmail        = Request.Cookies("tandgadform")("adbyemail")  
  ByPhone        = Request.Cookies("tandgadform")("adbyphone") 
  AdEmail        = Request.Cookies("tandgadform")("ademail") 
  AdPhone        = Request.Cookies("tandgadform")("adphone")
  AdContact      = Request.Cookies("tandgadform")("adcontact")
  Photo1value    = Request.Cookies("tandgadform")("adphoto1") 
  Photo2value    = Request.Cookies("tandgadform")("adphoto2") 
  Photo3value    = Request.Cookies("tandgadform")("adphoto3") 
  Photo4value    = Request.Cookies("tandgadform")("adphoto4") 
  Photo5value    = Request.Cookies("tandgadform")("adphoto5") 
  Photo6value    = Request.Cookies("tandgadform")("adphoto6")
  Photo1isvert   = Request.Cookies("tandgadform")("adphoto1isvert")
  Photo2isvert   = Request.Cookies("tandgadform")("adphoto2isvert")
  Photo3isvert   = Request.Cookies("tandgadform")("adphoto3isvert")
  Photo4isvert   = Request.Cookies("tandgadform")("adphoto4isvert")
  Photo5isvert   = Request.Cookies("tandgadform")("adphoto5isvert")
  Photo6isvert   = Request.Cookies("tandgadform")("adphoto6isvert")
  Photo1Width    = Request.Cookies("tandgadform")("adphoto1width")
  Photo2Width    = Request.Cookies("tandgadform")("adphoto2width")
  Photo3Width    = Request.Cookies("tandgadform")("adphoto3width")
  Photo4Width    = Request.Cookies("tandgadform")("adphoto4width")
  Photo5Width    = Request.Cookies("tandgadform")("adphoto5width")
  Photo6Width    = Request.Cookies("tandgadform")("adphoto6width")
  nAdvertId      = Left( Location, 2 ) & Right( Location, 1 ) & AdvertId
  AdvertId       = nAdvertId
  AdvertId       = UCase( AdvertId )
  
  If AdType = "" Then AdType = "0" End If
  If AdContact > "" Then AdContact = StringToHex( AdContact ) End If
  
  If Photo1Value > "" Then Photo1Value = Photo1Value Else Photo1Value = "NULL" End If 
  If Photo1IsVert = "" OR Photo1IsVert = "0" Then Photo1IsVert = "0" End If
  If Photo2IsVert = "" OR Photo2IsVert = "0" Then Photo2IsVert = "0" End If
  If Photo3IsVert = "" OR Photo3IsVert = "0" Then Photo3IsVert = "0" End If
  If Photo4IsVert = "" OR Photo4IsVert = "0" Then Photo4IsVert = "0" End If
  If Photo5IsVert = "" OR Photo5IsVert = "0" Then Photo5IsVert = "0" End If
  If Photo6IsVert = "" OR Photo6IsVert = "0" Then Photo6IsVert = "0" End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Set Complete Path
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  Data        = "duration:" & PPlDuration & ";description:" & PPlDesc & ";amount:" & PPlAmount & ";adtype:" & AdType & ";listingid:" & ListingId & ";advertid:" & AdvertId
  Data        = StringToHex( Data )
  
  If AdType = "1" Then
    RPath = "/express/checkout/?data:" & Data 
  Else
    RPath = HexToString( RPath )
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Var_LoggedIn = "" OR Var_LoggedIn = "0" Then
    Proceed = 0
	RCode   = 1
  Else
    Proceed = 1
	RCode   = 2
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Format Title and Description
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
    AdTitle = StringToHex( AdTitle )
    'Desc    = StringToHex( Desc )
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
      Firstname         = CustRs("firstname")
      Surname           = CustRs("surname")
      Title             = CustRs("salutation")
      Telephone         = CustRs("telephone")
      Email             = CustRs("emailaddress")
      CustRef           = CustRs("payreference")
      CustomerId        = CustRs("customerid")
	  IsAdmin           = CustRs("administrator")
	  PaidUntilNoStamp  = CustRs("paiduntilnostamp")
	  PaidUntil         = CustRs("paiduntil")
	  NumDays           = CalcDaysPassed( PaidUntil )
	  NumDays           = Replace( NumDays, "-", "" )
    End If 
  End If  
  
  DateNoTime = Left( Var_DateStamp, 10 )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Featured Advert and Redirect to PayPal
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If AdType = "1" AND Proceed = "1" Then
  
    EndPoint         = "/express/checkout/?data:" & Data
    PaidUntilNoStamp = CustRs("paiduntilnostamp")
	PaidUntil        = CustRs("paiduntil")
	
	PaidDate         = Split( PaidUntil, "/" )
	NewAdDay         = PaidDate(0)
	NewAdMonth       = PaidDate(1)
	NewAdYear        = PaidDate(2)
	NewAdYear        = Left( NewAdYear,4 )
	NewAdYear        = Replace( NewAdYear, " ", "" )
	
	NewAdStamp       = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay & " " & Time
	NewAdNoStamp     = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay
	PhotoId2         = "2" & Sha1( Timer() & Rnd())
	PhotoId3         = "3" & Sha1( Timer() & Rnd())
	PhotoId4         = "4" & Sha1( Timer() & Rnd())
	PhotoId5         = "5" & Sha1( Timer() & Rnd())
	PhotoId6         = "6" & Sha1( Timer() & Rnd())
	
    SaveSQL = "INSERT INTO shortlets " & _
	          "( " & _
	          "customerid, advertid, listingid, photo, isvertical, title, nextday, nextmonth, nextyear, rent, " & _
	          "period, incbills, postcode, location, propertytype, roomamount, description, refs, byemail, " & _
	          "email, byphone, phone, contactname, datetimestamp, datestamp, status, pageviews, advertpaid, featured, paymentdescription, checkoutdata, lastexpirycheck" & _
			  " ) " & _
			  "VALUES (" & _
			  "'" & Var_UserId        & "', " & _
			  "'" & AdvertId          & "', " & _
			  "'" & ListingId         & "', " & _
			  "'" & Photo1Value       & "', " & _
			  "'" & Photo1isvert      & "', " & _
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
			  "'" & References        & "', " & _
			  "'" & ByEmail           & "', " & _
			  "'" & AdEmail           & "', " & _
			  "'" & ByPhone           & "', " & _
			  "'" & AdPhone           & "', " & _
			  "'" & AdContact         & "', " & _
			  "'" & Var_DateStamp     & "', " & _
			  "'" & DateNoTime        & "', " & _
			  "'5', " & _
			  "'0', " & _
			  "'0', " & _
			  "'" & AdType            & "', " & _
			  "'" & PPlDesc           & "', " & _
			  "'" & Data              & "', " & _
			  "'" & LastExpCheck      & "'  " & _
			  " )"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
			  
			 If Photo2Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId2    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo2Value & "', " & _
						 " '2', " & _
						 " '" & Photo2isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo3Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId3    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo3Value & "', " & _
						 " '3', " & _
						 " '" & Photo3isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo4Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId4    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo4Value & "', " & _
						 " '4', " & _
						 " '" & Photo4isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo5Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId5    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo5Value & "', " & _
						 " '5', " & _
						 " '" & Photo5isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo6Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId6    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo6Value & "', " & _
						 " '6', " & _
						 " '" & Photo6isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Standard advert for trial
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  If AdType ="0" AND TrialExpired = "0" AND Proceed = "1" Then
  
    EndPoint = "/dashboard/account/?advertsaved:1;listingid:" & ListingId & ";advertid:" & AdvertId
	
    PaidUntilNoStamp = CustRs("paiduntilnostamp")
	PaidUntil        = CustRs("paiduntil")
	
	PaidDate      = Split( PaidUntil, "/" )
	NewAdDay      = PaidDate(0)
	NewAdMonth    = PaidDate(1)
	NewAdYear     = PaidDate(2)
	NewAdYear     = Left( NewAdYear,4 )
	NewAdYear     = Replace( NewAdYear, " ", "" )
	
	NewAdStamp    = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay & " " & Time
	NewAdNoStamp  = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay
	PhotoId2      = "2" & Sha1( Timer() & Rnd())
	PhotoId3      = "3" & Sha1( Timer() & Rnd())
	PhotoId4      = "4" & Sha1( Timer() & Rnd())
	PhotoId5      = "5" & Sha1( Timer() & Rnd())
	PhotoId6      = "6" & Sha1( Timer() & Rnd())
	
    SaveSQL = "INSERT INTO shortlets " & _
	          "( " & _
	          "customerid, advertid, listingid, photo, isvertical, title, nextday, nextmonth, nextyear, rent, " & _
	          "period, incbills, postcode, location, propertytype, roomamount, description, refs, byemail, " & _
	          "email, byphone, phone, contactname, datetimestamp, datestamp, status, pageviews, adexpires, adexpiry, adduration, advertpaid, featured, paymentdescription, lastexpirycheck" & _
			  " ) " & _
			  "VALUES (" & _
			  "'" & Var_UserId        & "', " & _
			  "'" & AdvertId          & "', " & _
			  "'" & ListingId         & "', " & _
			  "'" & Photo1Value       & "', " & _
			  "'" & Photo1isvert      & "', " & _
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
			  "'" & References        & "', " & _
			  "'" & ByEmail           & "', " & _
			  "'" & AdEmail           & "', " & _
			  "'" & ByPhone           & "', " & _
			  "'" & AdPhone           & "', " & _
			  "'" & AdContact         & "', " & _
			  "'" & Var_DateStamp     & "', " & _
			  "'" & DateNoTime        & "', " & _
			  "'1', " & _
			  "'0', " & _
			  "'" & NewAdStamp        & "', " & _
			  "'" & NewAdNoStamp      & "', " & _
			  "'" & NumDays           & "', " & _
			  "'1', " & _
			  "'" & AdType & "', "     & _
			  "'" & PPlDesc           & "', " & _
			  "'" & LastExpCheck      & "'  " & _
			  " )"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
			  
			 If Photo2Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId2    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo2Value & "', " & _
						 " '2', " & _
						 " '" & Photo2isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo3Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId3    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo3Value & "', " & _
						 " '3', " & _
						 " '" & Photo3isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo4Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId4    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo4Value & "', " & _
						 " '4', " & _
						 " '" & Photo4isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo5Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId5    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo5Value & "', " & _
						 " '5', " & _
						 " '" & Photo5isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo6Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId6    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo6Value & "', " & _
						 " '6', " & _
						 " '" & Photo6isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
	
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Standard advert and Redirect to PayPal
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If AdType = "0" AND TrialExpired = "1"  AND Proceed = "1" Then
  
    EndPoint         = "/express/checkout/?data:" & Data
    PaidUntilNoStamp = CustRs("paiduntilnostamp")
	PaidUntil        = CustRs("paiduntil")
	
	PaidDate         = Split( PaidUntil, "/" )
	NewAdDay         = PaidDate(0)
	NewAdMonth       = PaidDate(1)
	NewAdYear        = PaidDate(2)
	NewAdYear        = Left( NewAdYear,4 )
	NewAdYear        = Replace( NewAdYear, " ", "" )
	
	NewAdStamp       = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay & " " & Time
	NewAdNoStamp     = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay
	PhotoId2         = "2" & Sha1( Timer() & Rnd())
	PhotoId3         = "3" & Sha1( Timer() & Rnd())
	PhotoId4         = "4" & Sha1( Timer() & Rnd())
	PhotoId5         = "5" & Sha1( Timer() & Rnd())
	PhotoId6         = "6" & Sha1( Timer() & Rnd())
	
    SaveSQL = "INSERT INTO shortlets " & _
	          "( " & _
	          "customerid, advertid, listingid, photo, isvertical, title, nextday, nextmonth, nextyear, rent, " & _
	          "period, incbills, postcode, location, propertytype, roomamount, description, refs, byemail, " & _
	          "email, byphone, phone, contactname, datetimestamp, datestamp, status, pageviews, advertpaid, featured, paymentdescription, checkoutdata, lastexpirycheck" & _
			  " ) " & _
			  "VALUES (" & _
			  "'" & Var_UserId        & "', " & _
			  "'" & AdvertId          & "', " & _
			  "'" & ListingId         & "', " & _
			  "'" & Photo1Value       & "', " & _
			  "'" & Photo1isvert      & "', " & _
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
			  "'" & References        & "', " & _ 
			  "'" & ByEmail           & "', " & _
			  "'" & AdEmail           & "', " & _
			  "'" & ByPhone           & "', " & _
			  "'" & AdPhone           & "', " & _
			  "'" & AdContact         & "', " & _
			  "'" & Var_DateStamp     & "', " & _
			  "'" & DateNoTime        & "', " & _
			  "'5', " & _
			  "'0', " & _
			  "'0', " & _
			  "'" & AdType            & "', " & _
			  "'" & PPlDesc           & "', " & _
			  "'" & Data              & "', " & _
			  "'" & LastExpCheck      & "'  " & _
			  " )"
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
			  
			 If Photo2Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId2    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo2Value & "', " & _
						 " '2', " & _
						 " '" & Photo2isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo3Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId3    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo3Value & "', " & _
						 " '3', " & _
						 " '" & Photo3isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo4Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId4    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo4Value & "', " & _
						 " '4', " & _
						 " '" & Photo4isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo5Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId5    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo5Value & "', " & _
						 " '5', " & _
						 " '" & Photo5isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
			 If Photo6Value > "" Then
			  
             ImgInsert = "INSERT INTO galleryphotos " & _
			             "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
						 " VALUES( " & _
						 " '" & PhotoId6    & "', " & _
						 " '" & ListingId   & "', " & _
						 " '" & Photo6Value & "', " & _
						 " '6', " & _
						 " '" & Photo6isvert & "', " & _
						 " '" & Var_UserId & "' " & _
						 " )"
						 Call SaveRecord( ImgInsert, ImgInsertRs, ConnTemp )
						 
			  End If
			  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Temporary Description and References
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND RefCount > "0" Then
  
    DelSQL = "DELETE FROM tempshortlets WHERE tempid='" & TempId & "'"
	         Call SaveRecord( DelSQL, DelRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
			  
  If Proceed = "1" And KillCookies = "1" Then
  
    Response.Cookies("tandgadform")("adtitle")           = ""
    Response.Cookies("tandgadform")("availday")          = ""
    Response.Cookies("tandgadform")("availmonth")        = ""
    Response.Cookies("tandgadform")("availyear")         = ""
    Response.Cookies("tandgadform")("adrent")            = ""
    Response.Cookies("tandgadform")("adperiod")          = ""
    Response.Cookies("tandgadform")("adincbills")        = ""
    Response.Cookies("tandgadform")("adpostcode")        = ""
    Response.Cookies("tandgadform")("adlocation")        = ""
    Response.Cookies("tandgadform")("adprotype")         = ""
    Response.Cookies("tandgadform")("adnoofbeds")        = ""
    Response.Cookies("tandgadform")("addescription")     = ""
    Response.Cookies("tandgadform")("adbyemail")         = ""
    Response.Cookies("tandgadform")("adbyphone")         = ""
    Response.Cookies("tandgadform")("ademail")           = ""
    Response.Cookies("tandgadform")("adphone")           = ""
	Response.Cookies("tandgadform")("adcontact")         = ""
    Response.Cookies("tandgadform")("adphoto1")          = ""
    Response.Cookies("tandgadform")("adphoto2")          = ""
    Response.Cookies("tandgadform")("adphoto3")          = ""
    Response.Cookies("tandgadform")("adphoto4")          = ""
    Response.Cookies("tandgadform")("adphoto5")          = ""
	Response.Cookies("tandgadform")("adphoto6")          = ""
    Response.Cookies("tandgadform")("adphoto1isvert")    = ""
    Response.Cookies("tandgadform")("adphoto2isvert")    = ""
    Response.Cookies("tandgadform")("adphoto3isvert")    = ""
    Response.Cookies("tandgadform")("adphoto4isvert")    = ""
    Response.Cookies("tandgadform")("adphoto5isvert")    = ""
	Response.Cookies("tandgadform")("adphoto6isvert")    = ""
	Response.Cookies("tandgadform")("adphoto1width")     = ""
	Response.Cookies("tandgadform")("adphoto2width")     = ""
	Response.Cookies("tandgadform")("adphoto3width")     = ""
	Response.Cookies("tandgadform")("adphoto4width")     = ""
	Response.Cookies("tandgadform")("adphoto5width")     = ""
	Response.Cookies("tandgadform")("adphoto6width")     = ""
	Response.Cookies("tandgadform")("adsaveaction")      = ""
	Response.Cookies("tandgadform")("adtype")            = ""
	Response.Cookies("tandgadform")("tempid")            = ""
  
  End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSOn Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'endpoint':'" & EndPoint & "'}"
  Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
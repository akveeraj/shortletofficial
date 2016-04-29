<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query        = fw_Query
  RPath          = ParseCircuit( "rpath", o_Query )
  Id             = ParseCircuit( "id", o_Query )
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
  Desc           = Request.Cookies("tandgadform")("addescription")
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
  Photo1isvert   = Request.Cookies("tandgadform")("adphoto1isvert")
  Photo2isvert   = Request.Cookies("tandgadform")("adphoto2isvert")
  Photo3isvert   = Request.Cookies("tandgadform")("adphoto3isvert")
  Photo4isvert   = Request.Cookies("tandgadform")("adphoto4isvert")
  Photo5isvert   = Request.Cookies("tandgadform")("adphoto5isvert")
  Photo1Width    = Request.Cookies("tandgadform")("adphoto1width")
  Photo2Width    = Request.Cookies("tandgadform")("adphoto2width")
  Photo3Width    = Request.Cookies("tandgadform")("adphoto3width")
  Photo4Width    = Request.Cookies("tandgadform")("adphoto4width")
  Photo5Width    = Request.Cookies("tandgadform")("adphoto5width")
  ListingId      = Request.Cookies("tandgadform")("listingid")
  SaveAction     = Request.Cookies("tandgadform")("adsaveaction")
  
  If RPath > "" Then RPath = HexToString( RPath ) End If
  
  If Photo1IsVert = "" OR Photo1IsVert = "0" Then Photo1IsVert = "0" End If
  If Photo2IsVert = "" OR Photo2IsVert = "0" Then Photo2IsVert = "0" End If
  If Photo3IsVert = "" OR Photo3IsVert = "0" Then Photo3IsVert = "0" End If
  If Photo4IsVert = "" OR Photo4IsVert = "0" Then Photo4IsVert = "0" End If
  If Photo5IsVert = "" OR Photo5IsVert = "0" Then Photo5IsVert = "0" End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if listing exists
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
                 Call FetchData( ShortSQL, ShortRs, ConnTemp )
			  
  ListCount = ShortRs("NumberOfRecords")

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_Loggedin = "" OR Var_LoggedIn = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that, <a href=""javascript://"" onclick=""document.location.reload();"">click here</a> to log in."
	RText   = UrlEncode( RText )
  
  ElseIf ListCount = "0" Then
    Proceed = 0
	RCode   = 2
	RText   = "The listing could not be found. Please go back and try again"
  
  Else
    Proceed = 1
	RCode   = 3
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Heading + Description
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
    If AdTitle > "" Then AdTitle = StringToHex( AdTitle ) End If
    If Desc > "" Then Desc = StringToHex( Desc ) End If
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Advert
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If AccAdStatus = "3" OR AccAdStatus = "4" Then
    AdStatus = AccAdStatus
  Else
    If NewStatus = "1" Then
	  AdStatus = NewStatus
	Else
	  AdStatus = NewStatus
    End If
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Advert
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If NextDay > "-" AND NextMonth > "-" AND NextYear > "-" Then
    DatePassed = CalcDaysPassed( NextYear & "/" & NextMonth & "/" & NextDay )
  End If
  
  If Var_ReviewAds = "1" Then NewStatus = "2" Else NewStatus = "1" End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
 
   UdSQL = "UPDATE shortlets SET " & _
           "photo='"          & Photo1Value   & "', " & _
		   "isvertical='"     & Photo1IsVert  & "', " & _
           "title='"          & AdTitle       & "', " & _
		   "nextday='"        & NextDay       & "', " & _
		   "nextmonth='"      & NextMonth     & "', " & _
		   "nextyear='"       & NextYear      & "', " & _
		   "rent='"           & Rent          & "', " & _
		   "period='"         & Period        & "', " & _
		   "incbills='"       & IncBills      & "', " & _
		   "postcode='"       & PostCode      & "', " & _
		   "location='"       & Location      & "', " & _
		   "propertytype='"   & ProType       & "', " & _
		   "roomamount='"     & RoomAmount    & "', " & _
		   "description='"    & Desc          & "', " & _
		   "byemail='"        & ByEmail       & "', " & _
		   "email='"          & AdEmail       & "', " & _
		   "byphone='"        & ByPhone       & "', " & _
		   "phone='"          & AdPhone       & "', " & _
		   "contactname='"    & AdContact     & "'  " & _
           "WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
		   Call SaveRecord( UdSQL, UdRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Photos
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PhotoSQL = "SELECT COUNT( uIndex ) As NumberOfRecords FROM galleryphotos WHERE photonumber='2' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
             Call FetchData( PhotoSQL, PhotoRs, ConnTemp )
			 
  PhotoCount = PhotoRs("NumberOfRecords")
  
  If PhotoCount = "1" AND Instr(PhotoValue2, "nopicsmall.png" ) = "0" Then
  
    UdSQL = "UPDATE galleryphotos SET " & _
	        "photo='" & Photo2Value & "', " & _
			"isvertical='" & Photo2IsVert & "'" & _
	        "WHERE photonumber='2' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
			
  ElseIf PhotoCount = "0" AND Instr(PhotoValue2, "nopicsmall.png" ) = "0" Then
  
    PhotoId2 = Sha1( Timer() & Rnd() )
  
    UdSQL = "INSERT INTO galleryphotos " & _
	        "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
		    " VALUES(" & _ 
			"'" & PhotoId2      & "', " & _
			"'" & ListingId     & "', " & _
			"'" & Photo2Value   & "', " & _
			"'2', " & _
			"'" & Photo2IsVert  & "', " & _
			"'" & Var_UserId    & "'  " & _
			" )"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
	        
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  PhotoSQL = "SELECT COUNT( uIndex ) As NumberOfRecords FROM galleryphotos WHERE photonumber='3' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
             Call FetchData( PhotoSQL, PhotoRs, ConnTemp )
			 
  PhotoCount = PhotoRs("NumberOfRecords")
  
  If PhotoCount = "1" AND Instr(PhotoValue3, "nopicsmall.png" ) = "0" Then
  
    UdSQL = "UPDATE galleryphotos SET " & _
	        "photo='" & Photo3Value & "', " & _
			"isvertical='" & Photo3IsVert & "'" & _
	        "WHERE photonumber='3' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
	        
  
  ElseIf PhotoCount = "0" AND Instr(PhotoValue3, "nopicsmall.png" ) = "0" Then
  
    PhotoId3 = Sha1( Timer() & Rnd() )
  
    UdSQL = "INSERT INTO galleryphotos " & _
	        "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
		    " VALUES(" & _ 
			"'" & PhotoId3      & "', " & _
			"'" & ListingId     & "', " & _
			"'" & Photo3Value   & "', " & _
			"'3', " & _
			"'" & Photo3IsVert  & "', " & _
			"'" & Var_UserId    & "'  " & _
			" )"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
	        
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PhotoSQL = "SELECT COUNT( uIndex ) As NumberOfRecords FROM galleryphotos WHERE photonumber='4' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
             Call FetchData( PhotoSQL, PhotoRs, ConnTemp )
			 
  PhotoCount = PhotoRs("NumberOfRecords")
  
  If PhotoCount = "1" AND Instr(PhotoValue4, "nopicsmall.png" ) = "0" Then
  
    UdSQL = "UPDATE galleryphotos SET " & _
	        "photo='" & Photo4Value & "', " & _
			"isvertical='" & Photo4IsVert & "'" & _
	        "WHERE photonumber='4' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
	        
  
  ElseIf PhotoCount = "0" AND Instr(PhotoValue4, "nopicsmall.png" ) = "0" Then
  
    PhotoId4 = Sha1( Timer() & Rnd() )
  
    UdSQL = "INSERT INTO galleryphotos " & _
	        "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
		    " VALUES(" & _ 
			"'" & PhotoId4      & "', " & _
			"'" & ListingId     & "', " & _
			"'" & Photo4Value   & "', " & _
			"'4', " & _
			"'" & Photo4IsVert  & "', " & _
			"'" & Var_UserId    & "'  " & _
			" )"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PhotoSQL = "SELECT COUNT( uIndex ) As NumberOfRecords FROM galleryphotos WHERE photonumber='5' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
             Call FetchData( PhotoSQL, PhotoRs, ConnTemp )
			 
  PhotoCount = PhotoRs("NumberOfRecords")
  
  If PhotoCount = "1" AND Instr(PhotoValue5, "nopicsmall.png" ) = "0" Then
  
    UdSQL = "UPDATE galleryphotos SET " & _
	        "photo='" & Photo5Value & "', " & _
			"isvertical='" & Photo5IsVert & "'" & _
	        "WHERE photonumber='5' AND advertid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
			
  ElseIf PhotoCount = "0" AND Instr(PhotoValue5, "nopicsmall.png" ) = "0" Then
  
    PhotoId5 = Sha1( Timer() & Rnd() )
  
    UdSQL = "INSERT INTO galleryphotos " & _
	        "( photoid, advertid, photo, photonumber, isvertical, customerid ) " & _
		    " VALUES(" & _ 
			"'" & PhotoId5      & "', " & _
			"'" & ListingId     & "', " & _
			"'" & Photo5Value   & "', " & _
			"'5', " & _
			"'" & Photo5IsVert  & "', " & _
			"'" & Var_UserId    & "'  " & _
			" )"
			Call SaveRecord( UdSQL, UdRs, ConnTemp )
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
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
    Response.Cookies("tandgadform")("adphoto1isvert")    = ""
    Response.Cookies("tandgadform")("adphoto2isvert")    = ""
    Response.Cookies("tandgadform")("adphoto3isvert")    = ""
    Response.Cookies("tandgadform")("adphoto4isvert")    = ""
    Response.Cookies("tandgadform")("adphoto5isvert")    = ""
	Response.Cookies("tandgadform")("adphoto1width")     = ""
	Response.Cookies("tandgadform")("adphoto2width")     = ""
	Response.Cookies("tandgadform")("adphoto3width")     = ""
	Response.Cookies("tandgadform")("adphoto4width")     = ""
	Response.Cookies("tandgadform")("adphoto5width")     = ""
	Response.Cookies("tandgadform")("adsaveaction")      = ""
  
  
  End If


// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSON = "{'rtext':'" & RText & "', 'adresponse':'" & AdResponseText & "', 'rcode':'" & RCode & "', 'proceed':'" & Proceed & "', 'rpath':'" & RPath & "', 'id':'" & Id & "'}"
         Response.Write JSON
		 
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
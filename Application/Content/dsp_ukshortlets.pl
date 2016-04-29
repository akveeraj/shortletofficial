<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_coatofarms.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
  o_Query       = UrlDecode( o_Query )
  o_Page        = ParseCircuit( "page", o_Query )
  Location      = ParseCircuit( "city", o_Query )
  ProType       = ParseCircuit( "protype", o_Query )
  NoRooms       = ParseCircuit( "rooms", o_Query )
  RentFreq      = ParseCircuit( "freq", o_Query )
  ByPassFilter  = ParseCircuit( "bypassfilter", o_Query )
  
  If IsEmpty( o_Page ) Then
    o_Page    = 1
  Else
    o_Page    = o_Page
  End If
  
  CurrentPage = o_Page
  PageSize    = 30
  
  Limit1      = ( o_Page - 1 ) * PageSize
  Limit2      = PageSize
  RPath       = "/createadvert/account/"
  RPath       = EncodeText( RPath )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' DEFINE SQL
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_Location > "" Then
    
	LocationSelect = Var_Location
	SQLProType     = Var_ProType
	SQLRoomAmount  = Var_NoRooms
	SQLPeriod      = Var_RentFrequency
	ResultFilter   = 1
  
  ElseIf Location > "" Then
    
	LocationSelect = Location
	SQLProType     = ProType
	SQLRoomAmount  = NoRooms
	SQLPeriod      = RentFreq
	ResultFilter   = 1
	
  Else
    
	LocationSelect = Location
	SQLProType     = ProType
	SQLRoomAmount  = NoRooms
	SQLPeriod      = RentFreq
	ResultFilter   = 0
	
  End If 
  
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_Location = "" AND Location = "" Then
    
    SQLSelect     = 4
    LocationLabel = "UK"	
  
	FCountSQL     = "SELECT COUNT(uIndex) As NumberOFRecords FROM shortlets " & _
	                "WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() "
	  
	FSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
					"ORDER BY datetimestamp DESC"
	  
	SCountSQL     = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets " & _
	                "WHERE status='1' AND NOT location='' AND featured='0' AND CURDATE() <= adexpires "
	SSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND featured='0' AND adexpires > CURRENT_TIMESTAMP() " & _
					"ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
					
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Else

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If ByPassFilter = "1" Then
    
	SQLSelect      = 0
	LocationLabel  = Location
	LocationSelect = Location
	  
	FCountSQL     = "SELECT COUNT(uIndex) As NumberOFRecords FROM shortlets " & _
	                "WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
					"AND location='"& LocationSelect & "'"
	  
	FSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND location='" & LocationSelect & "' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
					"ORDER BY datetimestamp DESC"
	  
	SCountSQL     = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets " & _
	                "WHERE status='1' AND NOT location='' AND location='" & LocationSelect & "' AND featured='0' AND CURDATE() <= adexpires "
	SSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND location='" & LocationSelect & "' AND featured='0' AND adexpires > CURRENT_TIMESTAMP() " & _
					"ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2 
	
  
  
  Else
  
    If ResultFilter = "1" Then
	  SQLSelect     = 1
	  LocationLabel = LocationSelect
	  
	  FCountSQL     = "SELECT COUNT(uIndex) As NumberOFRecords FROM shortlets " & _
	                  "WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
					  "AND location='"& LocationSelect & "' AND roomamount='" & SQLRoomAmount & "'"
	  
	  FSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
	                  "AND location='" & LocationSelect & "' AND roomamount='" & SQLRoomAmount & "' " & _
					  "ORDER BY datetimestamp DESC"  
	  
	  SCountSQL     = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets " & _
	                  "WHERE status='1' AND NOT location='' AND featured='0' AND adexpires > CURRENT_TIMESTAMP() " & _
					  "AND location='" & LocationSelect & "' AND roomamount='" & SQLRoomAmount & "' "
	  
	  SSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND featured='0' AND adexpires > CURRENT_TIMESTAMP() " & _
	                  "AND location='" & LocationSelect & "' AND roomamount='" & SQLRoomAmount & "' " & _
					  "ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
	  
	Else
	
	  SQLSelect     = 2
	  LocationLabel = LocationSelect
	  
	  FCountSQL     = "SELECT COUNT(uIndex) As NumberOFRecords FROM shortlets " & _
	                  "WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
					  "AND location='"& LocationSelect & "'"
	  
	  FSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND featured='1' AND adexpires > CURRENT_TIMESTAMP() " & _
					  "ORDER BY datetimestamp DESC"
	  
	  SCountSQL     = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets " & _
	                  "WHERE status='1' AND NOT location='' AND featured='0' AND CURDATE() <= adexpires "
	  SSQL          = "SELECT * FROM shortlets WHERE status='1' AND NOT location='' AND featured='0' AND adexpires > CURRENT_TIMESTAMP() " & _
					  "ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
	
	
	End If
  
  End If
  
  If City = "" Then
    City = "Oxford"
  Else
    City = LocationLabel
  End If
 
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  End If

  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Featured Count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  FeatSQL      = FCountSQL 
                 Call FetchData( FeatSQL, FeatRs, ConnTemp )
				 
  FeatCount    = FeatRs("NumberOfRecords")
				 
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Shortlet Count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL      = SCountSQL
                  Call FetchData( ShortSQL, ShortRs, ConnTemp )
			   
  ShortCount    = ShortRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  NewListCount  = CInt(FeatCount) + CInt(ShortCount)
  PageCount     = CountPages( CLng( ShortCount ) / CLng( PageSize ))
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If FeatCount > "0" Then
  
    FeatSQL = FSQL
	          Call FetchData( FeatSQL, FeatRs, ConnTemp )		  
			  
			  If FeatCount > "0" Then
			    AdNumber = 0
				
				Do While Not FeatRs.Eof
				
				FeatListingId  = FeatRs("listingid")
				FeatIsExpired  = IsAdvertExpired( FeatListingId, ConnTemp )
				
				AdNumber       = AdNumber + 1
				
				'If AdNumber Mod 2 = 1 Then
				'  TableStyle = "list_on"
				'Else
				'  TableStyle = "list_off"
				'End If
				
				FeatNumber         = AdNumber
				FeatAdNumber       = FeatNumber
				FeatAdvertId       = FeatRs("advertid")
				FeatPhoto          = FeatRs("photo")
				FeatThumbLen       = Len( FeatPhoto )
				FeatPrimaryPhoto   = FeatPhoto
				FeatIsVertical     = FeatRs("isvertical")
				FeatAdTitle        = FeatRs("title")
				FeatNextDay        = FeatRs("nextday")
				FeatNextMonth      = FeatRs("nextmonth")
				FeatNextYear       = FeatRs("nextyear")
				FeatDateAvail      = FeatNextDay & "/" & FeatNextMonth & "/" & FeatNextYear
				
				If FeatDateAvail > "" Then
				  FeatDateAvail = DoFormatDate( FeatDateAvail )
				End If
				
				FeatRent           = FeatRs("rent")
				FeatRent           = FormatNumber( FeatRent, 2 )
				FeatPeriod         = FeatRs("period")
				FeatIncBills       = FeatRs("incbills")
				FeatPostCode       = FeatRs("postcode")
				FeatLocation       = FeatRs("location")
				FeatProType        = FeatRs("propertytype")
				FeatRoomAmount     = FeatRs("roomamount")
				FeatDesc           = FeatRs("description")
				FeatDesc           = Replace( FeatDesc, vbcrlf, "" )
				FeatDescLen        = Len( FeatDesc )
				FeatByEmail        = FeatRs("byemail")
				FeatEmail          = FeatRs("email")
				FeatByPhone        = FeatRs("byphone")
				FeatPhone          = FeatRs("phone")
				FeatContact        = FeatRs("contactname")
				FeatDateTimeStamp  = FeatRs("datetimestamp")
				FeatDateStamp      = FeatRs("datestamp")
				FeatStatus         = FeatRs("status")
				FeatLetStatus      = FeatRs("leased")
				FeatIsFeatured     = FeatRs("featured")
				
	  If FeatRoomAmount = "Studio" Then
	    FeatRoomLabel = "" 
	  ElseIf FeatRoomAmount = "5" Then
	    FeatRoomLabel = " Bed Plus +"
	  ElseIf FeatRoomAmount = "Room" Then
	    FeatRoomLabel = ""
	  Else
	    FeatRoomLabel = " Bed"
	  End If
	  
	  If FeatThumbLen < 10 Then FeatShowThumb = 0 Else FeatShowThumb = 1 End If
	  If FeatThumbLen < 10 Then FeatPrimaryGalCount = "0" Else FeatPrimaryGalCount = "1" End If
	  If FeatIsVertical = "1" Then FeatImageWidth = "80" Else FeatImageWidth = "150" End If
	  If FeatDesc > "" Then FeatDesc = HexToString( FeatDesc ) End If
      '''If Desc > "" Then Desc = Replace( Desc, "%0A", "<br/>" )
	  If FeatDesc > "" Then FeatDesc = UrlDecode( FeatDesc ) End If
	  If FeatDescLen > 280 Then FeatDesc = Left( FeatDesc, 280 ) & "..." Else FeatDesc = FeatDesc End If
      If FeatAdTitle > "" Then FeatAdTitle = HexTostring( FeatAdTitle ) End If
	  If FeatAdTitle > "" Then FeatAdTitle = UrlDecode( FeatAdTitle ) End If
	  
	  If FeatProType = "House" OR FeatProType = "Flat" Then
	    FeatProType = "&nbsp;&nbsp&nbsp|&nbsp;&nbsp;&nbsp;" & FeatProType
	  Else
	    FeatProType = ""
	  End If
	  
	  If FeatPeriod = "Weekly" Then
	    FeatDurlabel = "pw"
	  ElseIf FeatPeriod = "Monthly" Then
	    FeatDurlabel = "pm"
	  Else
	    FeatDurlabel = ""
	  End If
	  
	  If FeatIncBills = "1" Then
	    FeatBillLabel = "including bills"
	  Else
	    FeatBillLabel = "excluding bills"
	  End If
	  
	  FeatDetailsLink  = FeatAdTitle
	  FeatDetailsLink  = LCase( FeatDetailsLink )
	  FeatDetailsLink  = Replace( FeatDetailsLink, " ", "-" )
	  FeatDetailsLink  = strClean( FeatDetailsLink )
	  FeatDetailsLink  = "/" & FeatDetailsLink & "*" & FeatAdvertId & "/details/"
	  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  FeatList   = FeatList & "<style type='text/css'>" & vbcrlf & _
                          ".img_" & FeatNumber & " img {" & vbcrlf & _
						  "display:block;" & vbcrlf & _
						  "margin-left:auto;" & vbcrlf & _
						  "margin-right:auto;" & vbcrlf & _
						  "width:" & FeatImageWidth & "px;" & vbcrlf & _
						  "z-index:800;"& vbcrlf & _
						  "}" & vbcrlf & _
						  "</style>" & vbcrlf &  vbcrlf 
						  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
    FGalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & FeatListingId & "' AND NOT photo='nopicsmall.png'"
              Call FetchData( FGalSQL, FGalRs, ConnTemp )
			
	FGalCount = FGalRs("NumberOfRecords")
	FGalCount = CInt(FGalCount) + CInt(FeatPrimaryGalCount)
	
	If FeatShowThumb > "0" Then
	  FImgCountLabel = "<span class='list_imgcount'><span class='list_imgcountholder'>" & FGalCount & "&nbsp;&nbsp;&nbsp;</span>"
	Else
	  FImgCountLabel = "<span class='list_imgcount'>&nbsp;&nbsp;</span>"
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  FeatPropImage      = GetPropertyImg( FeatPhoto, FeatNumber, FeatShowThumb, FeatIsFeatured, FImgCountLabel )
  ' FeatDetailsLink
  
  
  FeatList = FeatList & vbcrlf & "<div class='list_off'>" & vbcrlf & _
                                 "<a href='" & FeatDetailsLink & "'>" & vbcrlf & _
								 "<span class='list_cell' style='width:160px;'>" & FeatPropImage & "</span>" & vbcrlf & _
								 
								 "<!-- start featured advert information -->" & vbcrlf & _
								 "<span class='list_cell' style='width:600px; margin-left:5px;'>" & vbcrlf & _
								 "<span class='list_featsmalldescription'>" & FeatAdTitle & "</span><span class='featuredbox'>FEATURED AD</span>" & vbcrlf & _
								 "<span class='list_longdescription'>" & MakeCap(FeatDesc) & "</span>" & vbcrlf & _
								 "<span class='list_smalldetails'>" & vbcrlf & _
								 "<b>Date Available:&nbsp;</b>" & FeatDateAvail & "&nbsp;&nbsp;|&nbsp;&nbsp;" & vbcrlf & _
								 FeatRoomAmount & FeatRoomLabel & vbcrlf & _
								 FeatProType & "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;" & vbcrlf & _
								 FeatLocation & "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;" & vbcrlf & _
								 "<b>Advert ID:&nbsp;</b>" & FeatAdvertId & vbcrlf & _
								 "</span>" & vbcrlf & _
								 "</span>" & vbcrlf & _
								 "<!-- end featured advert information   -->" & vbcrlf & _
								 
								 "<!-- start pricing information         -->" & vbcrlf & _
								 "<span class='list_cell' style='float:right; margin-top:4px;'>" & vbcrlf & _
								 "<b>&pound;" & FeatRent & FeatDurLabel & "</b><br/>" & vbcrlf & _
								 "<span style='font-size:12px; font-weight:normal; text-align:right;'>" & FeatBillLabel & "</span>" & vbcrlf & _
								 "</span>" & vbcrlf & _
								 "<!-- end pricing information           -->" & vbcrlf & _
								 
								 "</a>" & vbcrlf & _
                                 "</div>" & vbcrlf & vbcrlf
  
  
  


  
   'FeatList = FeatList   & "<div class='list_off' onclick=""document.location.href='" & FeatDetailsLink & "'"">" & _
                          '"<span class='list_cell' style='width:160px;'>" & FeatPropImage & "</span>" & vbcrlf & _
                          '"<!-- start featured advert info -->" & vbcrlf & _
						  '"<span class='list_cell' style='width:500px; margin-left:5px;'>" & vbcrlf & _
						  '"<span class='list_xxxx'>xxxx" & FeatAdTitle & "</span><span class='featuredbox'>FEATURED AD</span>" & vbcrlf & _
						  '"<span class='list_longdescription'>" & MakeCap(FeatDesc) & "</span>" & vbcrlf & _
						  '"<span class='list_smalldetails'>" & vbcrlf & _
						  '"<b>Date Available</b>&nbsp;&nbsp;&nbsp;" & FeatDateAvail & vbcrlf & _
						  '"&nbsp;&nbsp;&nbsp|&nbsp;&nbsp;&nbsp;" & FeatRoomAmount & FeatRoomLabel & vbcrlf & _
						  'FeatProType & _
						  '"&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;Advert ID: " & FeatAdvertId & vbcrlf & _
						  '"</span>" & vbcrlf & _
						  '"</span>" & vbcrlf & _
						  '"<!-- start pricing information -->" & vbcrlf & _
						  '"<span class='list_cell' style='text-align:right; float:right; margin-top:4px;'>" & vbcrlf & _
						  '"<b>&pound;" & FeatRent & FeatDurLabel & "<br/><span style='font-size:12px; font-weight:normal; text-align:right;'>" & FeatBillLabel & "</span></b>" & vbcrlf & _
						  '"</span>" & vbcrlf & _
						  '"<!-- end pricing information -->" & vbcrlf & _
                          '"</div>" & vbcrlf & vbcrlf & vbcrlf 
						  
  FeatList = FeatList
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
				
				FeatRs.MoveNext 
				Loop
				
			  End If
			  
  Else
	AdNumber     = "0" 
  End If
  
  AdNumber = CInt( AdNumber )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If ShortCount > "0" Then
  
    ShortSQL = SSQL
	           Call FetchData( ShortSQL, ShortRs, ConnTemp )
			  
			  If ShortCount > "0" Then
				
				Do While Not ShortRs.Eof
				AdNumber    = AdNumber + 1
				NewAdNumber = AdNumber
				TableStyle  = SelectListCss( AdNumber )
				
				ShortListingId      = ShortRs("listingid")
				ShortAdvertId       = ShortRs("advertid")
				ShortPhoto          = ShortRs("photo")
				ShortThumbLen       = Len( ShortPhoto )
				ShortPrimaryPhoto   = ShortPhoto
				ShortIsVertical     = ShortRs("isvertical")
				ShortAdTitle        = ShortRs("title")
				ShortNextDay        = ShortRs("nextday")
				ShortNextMonth      = ShortRs("nextmonth")
				ShortNextYear       = ShortRs("nextyear")
				ShortDateAvail      = ShortNextDay & "/" & ShortNextMonth & "/" & ShortNextYear
				
				If ShortDateAvail > "" Then
				  ShortDateAvail = DoFormatDate( ShortDateAvail )
				End If
				
				ShortRent           = ShortRs("rent")
				ShortPeriod         = ShortRs("period")
				ShortIncBills       = ShortRs("incbills")
				ShortPostCode       = ShortRs("postcode")
				ShortLocation       = ShortRs("location")
				ShortProType        = ShortRs("propertytype")
				ShortRoomAmount     = ShortRs("roomamount")
				ShortDesc           = ShortRs("description")
				ShortDesc           = Replace( ShortDesc, vbcrlf, "" )
				ShortDescLen        = Len( ShortDesc )
				ShortByEmail        = ShortRs("byemail")
				ShortEmail          = ShortRs("email")
				ShortByPhone        = ShortRs("byphone")
				ShortPhone          = ShortRs("phone")
				ShortContact        = ShortRs("contactname")
				ShortDateTimeStamp  = ShortRs("datetimestamp")
				ShortDateStamp      = ShortRs("datestamp")
				ShortStatus         = ShortRs("status")
				ShortLetStatus      = ShortRs("leased")
				ShortIsFeatured     = ShortRs("featured")
				ShortIsExpired      = IsAdvertExpired( ShortListingId, ConnTemp )
				
	  If ShortProType = "House" or ShortProType = "Flat" Then
	    ShortProType = "&nbsp;&nbsp&nbsp|&nbsp;&nbsp;&nbsp;" & ShortProType
	  Else
	    ShortProType = ""
	  End If
				
	  If ShortRoomAmount = "Studio" Then
	    ShortRoomLabel = "" 
	  ElseIf ShortRoomAmount = "5" Then
	    ShortRoomLabel = "+ Bed"
      ElseIf ShortRoomAmount = "Room" Then
	    ShortRoomLabel = ""
	  Else
	    ShortRoomLabel = " Bed"
	  End If
	  
	  If ShortThumbLen < 10 Then ShortShowThumb = 0 Else ShortShowThumb = 1 End If
	  If ShortThumbLen < 10 Then ShortPrimaryGalCount = "0" Else ShortPrimaryGalCount = "1" End If
	  If ShortIsVertical = "1" Then ShortImageWidth = "80" Else ShortImageWidth = "150" End If
	  If ShortDesc > "" Then ShortDesc = HexToString( ShortDesc ) End If
      '''If Desc > "" Then Desc = Replace( Desc, "%0A", "<br/>" )
	  If ShortDesc > "" Then ShortDesc = UrlDecode( ShortDesc ) End If
	  If ShortDescLen > 280 Then ShortDesc = Left( ShortDesc, 280 ) & "..." Else ShortDesc = ShortDesc End If
      If ShortAdTitle > "" Then ShortAdTitle = HexTostring( ShortAdTitle ) End If
	  If ShortAdTitle > "" Then ShortAdTitle = UrlDecode( ShortAdTitle ) End If
	  
	  If ShortPeriod = "Weekly" Then
	    ShortDurlabel = "pw"
	  ElseIf ShortPeriod = "Monthly" Then
	    ShortDurlabel = "pm"
	  Else
	    ShortDurlabel = ""
	  End If
	  
	  If ShortIncBills = "1" Then
	    ShortBillLabel = "including bills"
	  Else
	    ShortBillLabel = "excluding bills"
	  End If
				
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  ShortList   = ShortList & vbcrlf & vbcrlf & "<style type='text/css'>" & vbcrlf & _
                          ".img_" & AdNumber & " img {" & vbcrlf & _
						  "display:block;" & vbcrlf & _
						  "margin-left:auto;" & vbcrlf & _
						  "margin-right:auto;" & vbcrlf & _
						  "width:" & ShortImageWidth & "px;" & vbcrlf & _
						  "z-index:800;"& vbcrlf & _
						  "}" & vbcrlf & _
						  "</style>"  & vbcrlf &  vbcrlf 
						  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    SGalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & ShortListingId & "' AND NOT photo='nopicsmall.png'"
              Call FetchData( SGalSQL, SGalRs, ConnTemp )
			
	SGalCount = SGalRs("NumberOfRecords")
	SGalCount = CInt(SGalCount) + CInt(ShortPrimaryGalCount)
	
	If ShortShowThumb > "0" Then
	  SImgCountLabel = "<span class='list_imgcount'><span class='list_imgcountholder'>" & SGalCount & "&nbsp;&nbsp;&nbsp;</span>"
	Else
	  SImgCountLabel = "<span class='list_imgcount'>&nbsp;&nbsp;</span>"
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortDetailsLink  = ShortAdTitle
  ShortDetailsLink  = LCase( ShortDetailsLink )
  ShortDetailsLink  = Replace( ShortDetailsLink, " ", "-" )
  ShortDetailsLink  = strClean( ShortDetailsLink )
  ShortDetailsLink  = "/" & ShortDetailsLink & "*" & ShortAdvertId & "/details/"

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortPropImage      = GetPropertyImg( ShortPhoto, NewAdNumber, ShortShowThumb, ShortIsFeatured, SImgCountLabel )

   ShortList = ShortList & vbcrlf & "<div class='list_on'>" & vbcrlf & _
                                    "<a href='" & ShortDetailsLink & "'>" & vbcrlf & _
									"<span class='list_cell' style='width:160px;'>" & ShortPropImage & "</span>" & vbcrlf & _
									
									"<!-- start shortlet advert information -->" & vbcrlf & _
									
									"<span class='list_cell' style='width:600px; margin-left:5px;'>" & vbcrlf & _
									"<span class='list_smalldescription_long'>" & ShortAdTitle & "</span>" & vbcrlf & _
									"<span class='list_longdescription'>" & MakeCap(ShortDesc) & "</span>" & vbcrlf & _
									"<span class='list_smalldetails'>" & vbcrlf & _
									"<b>Date Available:&nbsp;</b>" & ShortDateAvail & "&nbsp;&nbsp;|&nbsp;&nbsp;" & vbcrlf & _
									ShortRoomAmount & ShortRoomLabel & vbcrlf & _
									ShortProType & "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;" & vbcrlf & _
									ShortLocation & "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;" & vbcrlf & _
									"<b>Advert ID:&nbsp;</b>" & ShortAdvertId & vbcrlf & _
									"</span>" & vbcrlf & _
									"</span>" & vbcrlf & _
									
									"<!-- end shortlet advert information -->" & vbcrlf & _
									
									
									"<!-- start pricing information -->" & vbcrlf & _
									
									"<span class='list_cell' style='text-align:right; float:right; margin-top:4px;'>" & vbcrlf & _
									"<b>&pound;" & ShortRent & ShortDurLabel & "</b><br/>" & vbclrf & _
									"<span style='font-size:12px; font-weight:normal; text-align:right;'>" & ShortBillLabel & "</span>" & vbcrlf & _
									"</span>" & vbcrlf & _
									
									"<!-- end pricing information -->" & vbcrlf & _
									
									"</a></div>"
			  
  'ShortList = ShortList   & "<div class='" & TableStyle & "' onclick=""document.location.href='/details/doc/?listingid:" & ShortListingId & ";page:" & CurrentPage & "'"">" & _
   'ShortList = ShortList   & "<div class='list_on' onclick=""document.location.href='" & ShortDetailsLink & "'"">" & _
						  '"<span class='list_cell' style='width:160px;'>" & ShortPropImage & "</span>" & vbcrlf & _
                          '"<!-- start Shortlet advert info -->" & vbcrlf & _
						  '"<span class='list_cell' style='width:500px; margin-left:5px;'>" & vbcrlf & _
						  '"<span class='list_smalldescription_long'>" & ShortAdTitle & "</span>" & vbcrlf & _
						  '"<span class='list_longdescription'>" & MakeCap(ShortDesc) & "</span>" & vbcrlf & _
						  '"<span class='list_smalldetails'>" & vbcrlf & _
						  '"<b>Date Available</b>&nbsp;&nbsp;&nbsp;" & ShortDateAvail & vbcrlf & _
						  '"&nbsp;&nbsp;&nbsp|&nbsp;&nbsp;&nbsp;" & ShortRoomAmount & ShortRoomLabel & vbcrlf & _
						  'ShortProType & _
						  '"&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<b>Advert ID:</b> " & ShortAdvertId & vbcrlf & _
						  '"</span>" & vbcrlf & _
						  '"</span>" & vbcrlf & _
						  '"<!-- start pricing information -->" & vbcrlf & _
						  '"<span class='list_cell' style='float:right; margin-top:4px;'>" & vbcrlf & _
						  '"<b>&pound;" & ShortRent & ShortDurLabel & "<br/><span style='font-size:12px; font-weight:normal; text-align:right;'>" & ShortBillLabel & "</span></b>" & vbcrlf & _
						  '"</span>" & vbcrlf & _
						  '"<!-- end pricing information -->" & vbcrlf & _
                          '"</div>" & vbcrlf & vbcrlf & vbcrlf 
						  
  ShortList = ShortList
  
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
				
				ShortRs.MoveNext 
				Loop
				
			  End If
			  
  Else
    ShortNumber = "0"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PageNumber = 0
  
	o_Query    = fw_Query
	o_Query    = UrlDecode( o_Query )
	n_Query    = Request.QueryString
	n_Source   = ParseCircuit( "source", o_Query )
	n_Circuit  = ParseCircuit( "circuit", o_Query )
	n_Query    = UrlDecode( n_Query )
	If Location > "" Then
	  n_Query        = Replace( n_Query, n_Circuit, "" )
	  n_Query        = Replace( n_Query, n_Source, "" )
	  n_Query        = Replace( n_Query, "source=", "" )
	  n_Query        = Replace( n_Query, "circuit=", "" )
	  n_Query        = Replace( n_Query, "showdrop=1", "" )
	  n_Query        = Right(n_Query, Len(n_Query) - 2)
	  n_Query        = Remove_QS_Parameter(n_Query, "page" )
	End If

  For Ni = 1 to PageCount
    PageNumber = PageNumber + 1
	PageUrl    = "/ukshortlets/doc/?" & n_Query & "&page=" & Ni
	
	If Ni < CInt( CurrentPage ) Then
	  PageLinks = PageLinks & "<span class='pagingon'><a href='" & PageUrl & "' title='Go to page " & Ni & "'>" & Ni & "</a></span>"
    ElseIf Ni > CInt( CurrentPage ) Then
	  PageLinks = PageLinks & "<span class='pagingon' title='Go to page " & Ni & "'><a href='" & PageUrl & "'>" & Ni & "</a></span>"
	Else
	  PageLinks = PageLinks & "<span class='pagingoff'>" & Ni & "</span>"
	End If
	 
  Next
  
  PageLinks = PageLinks
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If ShowShield = "1" Then
    If Shield2 > "" Then Shields = Shield1 & Shield2 Else Shields = Shield1 End If
    ContentHeader = "<div class='contentheader3'>" & vbcrlf & _
	                Shields & "<span class='label'>" & LocationLabel & "</span>" & vbcrlf & _
	                "</div>"
  Else
    ContentHeader = "<div class='contentheader2'>" & LocationLabel & "</div>"
  End If
  
  Response.Write ContentHeader
  
  If o_Page < "2" Then
    Response.Write FeatList & ShortList & _
	               "<span class='list_end'></span>"
  Else
    Response.Write ShortList
  End If
  
  If NewListCount = "0" AND Location > "" Then 
    NoRecord = "<div class='list_norecord'><b>There are no Short Let Properties for the selected requirement.</b></div>"
	           Response.Write NoRecord
  End If
  
  If PageCount > "1" AND NewListCount > "0" Then 
    Paging = "<div class='list_pagingholder'>" & PageLinks & "</div>"
             Response.Write Paging
  End If
	  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<!--#include virtual="/application/content/dsp_otherservices.pl"-->

<div class='bottomspacer'>&nbsp;</div>




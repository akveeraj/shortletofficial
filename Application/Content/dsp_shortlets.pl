<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
  o_Query = UrlDecode( o_Query )
  o_Page  = ParseCircuit( "page", o_Query )
  noRooms = ParseCircuit( "norooms", o_Query )
  
  If IsEmpty( o_Page ) Then
    o_Page    = 1
  Else
    o_Page    = o_Page
  End If
  
  CurrentPage = o_Page
  PageSize    = 2
	
  Limit1      = ( o_Page - 1 ) * PageSize
  Limit2      = PageSize
  RPath       = "/createadvert/account/"
  RPath       = EncodeText( RPath )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  'If ByPassFilter = "1" OR NoRooms = "" Then
  
   ' FCountSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE status='1' AND location='Oxford' AND roomamount='" & NoRooms & "' AND featured='1' AND adexpires > CURRENT_TIMESTAMP()"
   ' FSQL      = "SELECT * FROM shortlets WHERE status='1' AND location='Oxford' AND featured='1' " & _
	'            "AND CURDATE() <= adexpires ORDER BY datetimestamp DESC "
	
	'SCountSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE status='1' AND location='Oxford' AND roomamount='" & NoRooms & "' AND Featured='0' AND adexpires > CURRENT_TIMESTAMP()"
	'SSQL      = "SELECT * FROM shortlets WHERE status='1' AND location='Oxford' AND roomamount='" & NoRooms & "' AND featured='0' " & _
	'            "AND adexpires > CURRENT_TIMESTAMP() ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
	
  'Else
  
    FCountSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE status='1' AND location='Oxford' AND featured='1' AND roomamount='" & noRooms & "' AND CURDATE() <= adexpires"
    FSQL      = "SELECT * FROM shortlets WHERE status='1' AND location='Oxford' AND featured='1' AND roomamount='" & noRooms & "'" & _
	            "AND adexpires > CURRENT_TIMESTAMP() ORDER BY datetimestamp DESC "
	
	SCountSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE status='1' AND location='Oxford' AND Featured='0' AND roomamount='" & noRooms & "' AND CURDATE() <= adexpires"
	SSQL      = "SELECT * FROM shortlets WHERE status='1' AND location='Oxford'  AND roomamount='" & NoRooms & "' AND featured='0' " & _
	            "AND adexpires > CURRENT_TIMESTAMP() ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
  
  'End If 
  
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
				
				AdNumber = AdNumber + 1
				
				If AdNumber Mod 2 = 1 Then
				  TableStyle = "list_off"
				Else
				  TableStyle = "list_on"
				End If
				
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
				FeatDateAvail      = FeatNextDay & "-" & FeatNextMonth & "-" & FeatNextYear
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
	    FeatRoomLabel = "+ Bed"
	  Else
	    FeatRoomLabel = " Bed"
	  End If
	  
	  If FeatThumbLen < 10 Then FeatShowThumb = 0 Else FeatShowThumb = 1 End If
	  If FeatThumbLen < 10 Then FeatPrimaryGalCount = "0" Else FeatPrimaryGalCount = "1" End If
	  If FeatIsVertical = "1" Then FeatImageWidth = "80" Else FeatImageWidth = "150" End If
	  If FeatDesc > "" Then FeatDesc = HexToString( FeatDesc ) End If
      '''If Desc > "" Then Desc = Replace( Desc, "%0A", "<br/>" )
	  If FeatDesc > "" Then FeatDesc = UrlDecode( FeatDesc ) End If
	  If FeatDescLen > 200 Then FeatDesc = Left( FeatDesc, 200 ) & "..." Else FeatDesc = FeatDesc End If
      If FeatAdTitle > "" Then FeatAdTitle = HexTostring( FeatAdTitle ) End If
	  If FeatAdTitle > "" Then FeatAdTitle = UrlDecode( FeatAdTitle ) End If
	  
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
				
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  FeatList   = FeatList & "<style type='text/css'>" & vbcrlf & _
                          ".img_" & FeatNumber & " img {" & vbcrlf & _
						  "display:block;" & vbcrlf & _
						  "margin-left:auto;" & vbcrlf & _
						  "margin-right:auto;" & vbcrlf & _
						  "width:" & FeatImageWidth & "px;" & vbcrlf & _
						  "z-index:800;"& vbcrlf & _
						  "}" & vbcrlf & _
						  "</style>"
						  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
    FGalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & FeatListingId & "'"
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
			  
  FeatList = FeatList   & "<div class='" & TableStyle & "' onclick=""document.location.href='/details/doc/?listingid:" & FeatListingId & ";page:" & CurrentPage & "'"">" & _
                          "<span class='list_cell' style='width:160px;'>" & FeatPropImage & "</span>" & vbcrlf & _
                          "<!-- start featured advert info -->" & vbcrlf & _
						  "<span class='list_cell' style='width:500px; margin-left:5px;'>" & vbcrlf & _
						  "<span class='list_smalldescription'>" & FeatAdTitle & "</span>" & vbcrlf & _
						  "<span class='list_longdescription'>" & MakeCap(FeatDesc) & "</span>" & vbcrlf & _
						  "<span class='list_smalldetails'>" & vbcrlf & _
						  "<b>Date Available</b>&nbsp;&nbsp;&nbsp;" & FeatDateAvail & vbcrlf & _
						  "&nbsp;&nbsp;&nbsp|&nbsp;&nbsp;&nbsp;" & FeatRoomAmount & FeatRoomLabel & vbcrlf & _
						  "&nbsp;&nbsp&nbsp|&nbsp;&nbsp;&nbsp;" & FeatProType & vbcrlf & _
						  "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;Advert ID: " & FeatAdvertId & vbcrlf & _
						  "</span>" & vbcrlf & _
						  "</span>" & vbcrlf & _
						  "<!-- start pricing information -->" & vbcrlf & _
						  "<span class='list_cell' style='float:right; margin-top:4px;'>" & vbcrlf & _
						  "<b>&pound;" & FeatRent & FeatDurLabel & "<br/><span style='font-size:12px; font-weight:normal; text-align:right;'>" & FeatBillLabel & "</span></b>" & vbcrlf & _
						  "</span>" & vbcrlf & _
						  "<!-- end pricing information -->" & vbcrlf & _
                          "</div>" & vbcrlf & vbcrlf & vbcrlf 
						  
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
				TableStyle = SelectListCss( AdNumber )
			
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
				ShortDateAvail      = ShortNextDay & "-" & ShortNextMonth & "-" & ShortNextYear
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
				
	  If ShortRoomAmount = "Studio" Then
	    ShortRoomLabel = "" 
	  ElseIf ShortRoomAmount = "5" Then
	    ShortRoomLabel = "+ Bed"
	  Else
	    ShortRoomLabel = " Bed"
	  End If
	  
	  If ShortThumbLen < 10 Then ShortShowThumb = 0 Else ShortShowThumb = 1 End If
	  If ShortThumbLen < 10 Then ShortPrimaryGalCount = "0" Else ShortPrimaryGalCount = "1" End If
	  If ShortIsVertical = "1" Then ShortImageWidth = "80" Else ShortImageWidth = "150" End If
	  If ShortDesc > "" Then ShortDesc = HexToString( ShortDesc ) End If
      '''If Desc > "" Then Desc = Replace( Desc, "%0A", "<br/>" )
	  If ShortDesc > "" Then ShortDesc = UrlDecode( ShortDesc ) End If
	  If ShortDescLen > 200 Then ShortDesc = Left( ShortDesc, 200 ) & "..." Else ShortDesc = ShortDesc End If
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
  
  ShortList   = ShortList & "<style type='text/css'>" & vbcrlf & _
                          ".img_" & AdNumber & " img {" & vbcrlf & _
						  "display:block;" & vbcrlf & _
						  "margin-left:auto;" & vbcrlf & _
						  "margin-right:auto;" & vbcrlf & _
						  "width:" & ShortImageWidth & "px;" & vbcrlf & _
						  "z-index:800;"& vbcrlf & _
						  "}" & vbcrlf & _
						  "</style>"
						  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    SGalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & ShortListingId & "'"
              Call FetchData( SGalSQL, SGalRs, ConnTemp )
			
	SGalCount = SGalRs("NumberOfRecords")
	SGalCount = CInt(SGalCount) + CInt(ShortPrimaryGalCount)
	
	If ShortShowThumb > "0" Then
	  SImgCountLabel = "<span class='list_imgcount'><span class='list_imgcountholder'>" & SGalCount & "&nbsp;&nbsp;&nbsp;</span>"
	Else
	  SImgCountLabel = "<span class='list_imgcount'>&nbsp;&nbsp;</span>"
	End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  ShortPropImage      = GetPropertyImg( ShortPhoto, NewAdNumber, ShortShowThumb, ShortIsFeatured, SImgCountLabel )
			  
  ShortList = ShortList   & "<div class='" & TableStyle & "' onclick=""document.location.href='/details/doc/?listingid:" & ShortListingId & ";page:" & CurrentPage & "'"">" & _
                          "<span class='list_cell' style='width:160px;'>" & ShortPropImage & "</span>" & vbcrlf & _
                          "<!-- start Shortlet advert info -->" & vbcrlf & _
						  "<span class='list_cell' style='width:500px; margin-left:5px;'>" & vbcrlf & _
						  "<span class='list_smalldescription'>" & ShortAdTitle & "</span>" & vbcrlf & _
						  "<span class='list_longdescription'>" & MakeCap(ShortDesc) & "</span>" & vbcrlf & _
						  "<span class='list_smalldetails'>" & vbcrlf & _
						  "<b>Date Available</b>&nbsp;&nbsp;&nbsp;" & ShortDateAvail & vbcrlf & _
						  "&nbsp;&nbsp;&nbsp|&nbsp;&nbsp;&nbsp;" & ShortRoomAmount & ShortRoomLabel & vbcrlf & _
						  "&nbsp;&nbsp&nbsp|&nbsp;&nbsp;&nbsp;" & ShortProType & vbcrlf & _
						  "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;Advert ID: " & ShortAdvertId & vbcrlf & _
						  "</span>" & vbcrlf & _
						  "</span>" & vbcrlf & _
						  "<!-- start pricing information -->" & vbcrlf & _
						  "<span class='list_cell' style='float:right; margin-top:4px;'>" & vbcrlf & _
						  "<b>&pound;" & ShortRent & ShortDurLabel & "<br/><span style='font-size:12px; font-weight:normal; text-align:right;'>" & ShortBillLabel & "</span></b>" & vbcrlf & _
						  "</span>" & vbcrlf & _
						  "<!-- end pricing information -->" & vbcrlf & _
                          "</div>" & vbcrlf & vbcrlf & vbcrlf 
						  
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
	  n_Query        = Replace( n_Query, n_Circuit, "" )
	  n_Query        = Replace( n_Query, n_Source, "" )
	  n_Query        = Replace( n_Query, "source=", "" )
	  n_Query        = Replace( n_Query, "circuit=", "" )
	If noRooms > "" Then
	  n_Query        = Right(n_Query, Len(n_Query) - 2)
	  n_Query        = Remove_QS_Parameter(n_Query, "page" )
	End If

  For Ni = 1 to PageCount
    PageNumber = PageNumber + 1
	PageUrl    = "/shortlets/doc/?" & n_Query & "&page=" & Ni
	
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
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Oxford Shortlets ~ Town and Gown Shortlets. Oxford";
});
</script>

<div class='contentheader2'>Oxford Shortlets</div>
<div class='textblock_large' style='border:solid 0px;'>
To place a shortlet advert for the Oxford area, <a href='/createadvert/account/?location:oxford'>click here</a>.
</div>

<% 
If o_Page < "2" Then
  Response.Write FeatList & ShortList & _
                            "<span class='list_end'></span>"
Else
  Response.Write ShortList
End If
%>


<% If NewListCount = "0" Then %>
<img src='/application/library/media/torent_splash1.png'/>
<% End If %>

<% IF PageCount > "1" AND NewListCount > "0" Then %>

<div class='list_pagingholder'>
<%=PageLinks%>
</div>

<% End If %>
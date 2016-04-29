<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If fw_Folder = "details" Then
    o_Query    = fw_Query
	o_Query    = UrlDecode( o_Query )
	Page       = ParseCircuit( "page", o_Query )
	nQuery     = fw_Source
	AdvertId   = SplitArray( nQuery, "*" )
  Else
    o_Query    = fw_Query
	o_Query    = UrlDecode( o_Query )
	Page       = ParseCircuit( "page", o_Query )
	ListingId  = ParseCircuit( "listingid", o_Query )
  End If
  
  If IsEmpty( Page ) Then
    Page    = 1
  Else
    Page    = Page
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() " & _
                 "OR advertid='" & AdvertId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() "
                 Call FetchData( ShortSQL, ShortRs, ConnTemp )
			  
  DetailCount = ShortRs("NumberOfRecords")
  
  If DetailCount > "0" Then
    ShowAdvert = "1"
  Else
    ShowAdvert = "0"
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If DetailCount > "0" AND Edit = "" Then
  
	ShortSQL = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() " & _
	           "OR advertid='" & AdvertId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() "
	           Call FetchData( ShortSQL, ShortRs, ConnTemp )
				
	ListingId        = ShortRs("listingid")
	AdvertId         = ShortRs("advertid")
	Photo            = ShortRs("photo")
	IsVert           = ShortRs("isvertical")
    AdTitle          = ShortRs("title")
    AdAvailDay       = ShortRs("nextday")
    AdAvailMonth     = ShortRs("nextmonth")
    AdAvailYear      = ShortRs("nextyear")
    AdRent           = ShortRs("rent")
    AdPeriod         = ShortRs("period")
    AdIncBills       = ShortRs("incbills")
    AdPostCode       = ShortRs("postcode")
    AdLocation       = ShortRs("location")
    AdProType        = ShortRs("propertytype")
    AdNoOfBeds       = ShortRs("roomamount")
    AdDescription    = ShortRs("description")
	AdDescription    = Replace(AdDescription, vbcrlf, "" )
	AdReferences     = ShortRs("refs")
	If AdReferences > "" Then AdReferences = Replace( AdReferences, vbcrlf, "" ) End If

    AdByEmail        = ShortRs("byemail")
    AdByPhone        = ShortRs("byphone")
    AdEmail          = ShortRs("email")
    AdPhone          = ShortRs("phone")
    AdContact        = ShortRs("contactname")
	DateTimeStamp    = ShortRs("datetimestamp")
	DateStamp        = ShortRs("datestamp")
	Status           = ShortRs("status")
	Photo1Src        = Photo
	Photo1IsVert     = ShortRs("isvertical")
	Photo1Value      = Photo
	PageViews        = ShortRs("pageviews")
	Featured         = ShortRs("featured")
	
	If AdContact > "" Then AdContact = HexToString( AdContact ) End If
	
	If DateStamp > "" Then
	  DateStamp = DoFormatDate( DateStamp )
	End If
	
	DateAvailable = AdAvailDay & "/" & AdAvailMonth & "/" & AdAvailYear
	
	If AdAvailDay > "" AND AdAvailMonth > "" AND AdAvailYear > "" Then
	  DateAvailable = DoFormatDate( DateAvailable )
	End If
	
	If AdTitle > "" Then AdTitle = HexToString( AdTitle ) End If
	If AdDescription > "" Then AdDescription = HexToString( AdDescription ) End If
	If AdDescription > "" Then AdDescription = Replace( AdDescription, "%0A", "<br/>" )
    If AdDescription > "" Then AdDescription = UrlDecode( AdDescription ) End If
	If AdReferences  > "" Then AdReferences  = HexToString( AdReferences ) End If
	If AdReferences  > "" Then AdReferences  = Replace( AdReferences, "%0A", "<br/>" )
	If AdReferences  > "" Then AdReferences  = UrlDecode( AdReferences ) End If
	
	AdRefLen = Len( AdReferences )
	
	If IsEmpty(ShowReferences) Then
	  ShowReferences = "0"
	Else
	  ShowReferences = "1"
	End If
	

// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	GalSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photonumber='2' AND advertid='" & ListingId & "'"
	            Call FetchData( GalSQL, GalRs, ConnTemp )
			 
	Gal2Count = GalRs("NumberOfRecords")
	
	If Gal2Count > "0" Then
	  GalSQL = "SELECT * FROM galleryphotos WHERE photonumber='2' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   Photo2Src     = GalRs("Photo")
			   Photo2Len     = Len( Photo2Src ) 
			   Photo2IsVert  = GalRs("isvertical")
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
	GalSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photonumber='3' AND advertid='" & ListingId & "'"
	            Call FetchData( GalSQL, GalRs, ConnTemp )
			 
	Gal3Count = GalRs("NumberOfRecords")
				
	If Gal3Count > "0" Then
	  GalSQL = "SELECT * FROM galleryphotos WHERE photonumber='3' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   Photo3Src     = GalRs("photo")
			   Photo3Len     = Len( Photo3Src )
			   Photo3IsVert  = GalRs("isvertical")
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    GalSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photonumber='4' AND advertid='" & ListingId & "'"
	            Call FetchData( GalSQL, GalRs, ConnTemp )
			  
	Gal4Count = GalRs("NumberOfRecords")
				
	If Gal4Count > "0" Then
	  GalSQL = "SELECT * FROM galleryphotos WHERE photonumber='4' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   Photo4Src     = GalRs("photo")
			   Photo4Len     = Len( Photo4Src )
			   Photo4IsVert  = GalRs("isvertical")
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    GalSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photonumber='5' AND advertid='" & ListingId & "'"
	            Call FetchData( GalSQL, GalRs, ConnTemp )
			  
	Gal5Count = GalRs("NumberOfRecords")
				
	If Gal5Count > "0" Then
	  GalSQL = "SELECT * FROM galleryphotos WHERE photonumber='5' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   Photo5Src     = GalRs("photo")
			   Photo5Len     = Len( Photo5Src )
			   Photo5IsVert  = GalRs("isvertical")
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    GalSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photonumber='6' AND advertid='" & ListingId & "'"
	            Call FetchData( GalSQL, GalRs, ConnTemp )
			  
	Gal6Count = GalRs("NumberOfRecords")
				
	If Gal6Count > "0" Then
	  GalSQL = "SELECT * FROM galleryphotos WHERE photonumber='6' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   Photo6Src     = GalRs("photo")
			   Photo6Len     = Len( Photo5Src )
			   Photo6IsVert  = GalRs("isvertical")
	End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Image Array
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PrimaryPhoto  = Photo1Value
  If Instr( PrimaryPhoto, "nopicsmall.png" ) > "0" OR PrimaryPhoto = "NULL" Then 
    PrimaryPhoto = "<img src='/application/library/media/bignophoto.png' class='img'/>"
  Else
    PrimaryPhoto = "<img src='/uploads/src/" & PrimaryPhoto & "' class='img'/>"
  End If
  
  Photo1isvert  = Replace( Photo1isvert, " ", "" )
  Photo2isvert  = Replace( Photo2isvert, " ", "" )
  Photo3isvert  = Replace( Photo3isvert, " ", "" )
  Photo4isvert  = Replace( Photo4isvert, " ", "" )
  Photo5isvert  = Replace( Photo5isvert, " ", "" )
  Photo6isvert  = Replace( Photo6isvert, " ", "" )
  
  PhotoArray1 = Photo1Value & ","
  PhotoArray2 = Photo2Src & ","
  PhotoArray3 = Photo3Src & ","
  PhotoArray4 = Photo4Src & ","
  PhotoArray5 = Photo5Src & ","
  PhotoArray6 = Photo6Src & ","
  
  If Instr( PhotoArray1, "/uploads/thumbs/nopicsmall.png" ) > "0" Then PhotoArray1 = "" End If
  If Instr( PhotoArray2, "/uploads/thumbs/nopicsmall.png" ) > "0" Then PhotoArray2 = "" End If
  If Instr( PhotoArray3, "/uploads/thumbs/nopicsmall.png" ) > "0" Then PhotoArray3 = "" End If
  If Instr( PhotoArray4, "/uploads/thumbs/nopicsmall.png" ) > "0" Then PhotoArray4 = "" End If
  If Instr( PhotoArray5, "/uploads/thumbs/nopicsmall.png" ) > "0" Then PhotoArray5 = "" End If
  If Instr( PhotoArray6, "/uploads/thumbs/nopicsmall.png" ) > "0" Then PhotoArray6 = "" End If
  
  PhotoArray = PhotoArray1& PhotoArray2& PhotoArray3& PhotoArray4&PhotoArray5&PhotoArray6
  NewArray   = Split( PhotoArray, "," )
  ImageCount = 0
  
  For I = 0 To UBound( NewArray )
    If Len(NewArray(i)) > "0" AND Instr(NewArray(i), "nopicsmall.png" ) = "0" Then
	ImageCount = CInt(ImageCount) + 1
	If ImageCount = "1" Then IsVert = Photo1IsVert End If
	If ImageCount = "2" Then IsVert = Photo2IsVert End If
	If ImageCount = "3" Then IsVert = Photo3IsVert End If
	If ImageCount = "4" Then IsVert = Photo4IsVert End If
	If ImageCount = "5" Then IsVert = Photo5IsVert End If
	If ImageCount = "6" Then IsVert = Photo6IsVert End If
	ThumbAction = "FetchImage('" & StringToHex("/uploads/src/" & NewArray(i)) & "', '" & IsVert & "', 'gallery');"
    PhotoList = PhotoList & "<span class='thumbs' title='Photo " & ImageCount & "' onclick=""" & ThumbAction & """><img src='/uploads/thumbs/" & NewArray(i) & "'/></span>"
	End If
  Next
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If AdPeriod = "Monthly" Then
    PeriodLabel = "pm"
  ElseIf AdPeriod = "Weekly" Then
    PeriodLabel = "pw"
  Else
    PeriodLabel = ""
  End If
  
  If AdNoOfBeds = "5" Then AdNoOfBeds = "5 +" End If
  If AdIncBills = "1" Then IncBillsLabel = "Including Bills" Else IncBillsLabel = "Excluding Bills" End If
  Adprice       = "&pound;" & AdRent & PeriodLabel
  
  
  If AdContact > "" Then
    ContactLabel = "Contact " & AdContact
  Else
    ContactLabel = "Contact Advertiser"
  End If
  
  If Photo1isvert = "1" Then ImageWidth = "300" Else ImageWidth = "544" End If
  If AdPostCode = "" Then AdPostCode = "Upon Request" Else AdPostCode = AdPostCode End If
  
  AdvertExpired = IsAdvertExpired( ListingId, ConnTemp )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Page Views
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If DetailCount > "0" Then
    NewPageViews = CInt(PageViews) + 1
   
    ViewSQL = "UPDATE shortlets SET " & _
	          "pageviews='" & NewPageViews & "' "    & _
			  "WHERE listingid='" & ListingId & "'"
	          Call SaveRecord( ViewSQL, ViewRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  RPath       = "/shortlets/doc/?page:" & Page
  ERPath      = "/details/doc/?listingid:" & ListingId & ";page:" & Page
  ERPath      = StringToHex( ERPath )  
  GalFeatured = "<div class='details_featuredtext'>FEATURED AD</div>"
  
  If Featured = "1" Then
    GalFeatured = GalFeatured
  Else
    GalFeatured = ""
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<% If DetailCount > "0" Then %>

<script type='text/javascript'>
// preload images
</script>

<style type='text/css'>
.details_holder .galleryholder .img {
  display:block;
  width:<%=ImageWidth%>px;
  z-index:800; 
  position:relative;
  margin-left:auto;
  margin-right:auto;
}
</style>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "<%=AdTitle%> ~ Town and Gown Shortlets UK";
});
</script> 


<div class='details_holder' style='margin-top:20px;'>

<!-- left content -->

  <span class='cell' style='width:550px; margin-right:5px;'>
  
  <div class='details_header' style='margin-top:20px;'><%=AdTitle%></div>
  
  <!-- gallery -->

  <span class='gallerywait' style='display:none;' id='gallerywait'></span>
  <div class='galleryholder' id='galleryholder'><span id='gallery'><%=PrimaryPhoto%></span></div>
  <% If ImageCount > "1" Then %>
  <div class='thumbsholder'>
  
  <span style='display:block; margin-left:auto; margin-right:auto;'>
  <%=PhotoList%>
  </span>
  </div>
  <% End If %>

   
  <!-- end gallery -->
  
  
  
  
  
  
  <div class='infoholder'>
  
    <span class='infocell' style='width:268px;'>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px;'><b>Property Type</b></span>
		<span class='cell' style='text-align:right; width:115px;'><%=AdProType%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px;'><b>Rental Amount</b></span>
		<span class='cell' style='text-align:right; width:115px;'>&pound;<%=AdRent%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px;'><b>Location</b></span>
		<span class='cell' style='text-align:right; width:115px;'><%=AdLocation%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px;'><b>Date Available</b></span>
		<span class='cell' style='text-align:right; width:115px;'><%=DateAvailable%></span>
	  </span>

	  
	</span>
	
	
	
    <span class='infocell' style='width:266px;'>
	  <span class='row'>
	    <span class='cell' style='width:135px;'><b>Rental Frequency</b></span>
		<span class='cell' style='text-align:right; width:117px;'><%=AdPeriod%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:135px;'><b>Number of Bedrooms</b></span>
		<span class='cell' style='text-align:right; width:117px;'><%=AdNoOfBeds%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:135px;'><b>Postcode</b></span>
		<span class='cell' style='text-align:right; width:117px;'><%=AdPostCode%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:135px;'><b>Posted</b></span>
		<span class='cell' style='text-align:right; width:117px;'><%=DateStamp%></span>
	  </span>
	</span>
  
  </div>
  
  
  </span>

<!-- end left content -->

<!-- right content -->

  <span class='cell' style='width:245px; float:right; margin-right:40px; margin-top:40px;'> 
    
    <div class='details_price'><%=AdPrice%><span class='incbills'><%=IncBillsLabel%></span></div>
	<%=GalFeatured%>
  
 <div class='contactbox'>
   <span class='contact'><%=ContactLabel%></span>
   <% If AdByPhone = "1" Then %><span class='phone'><%=AdPhone%></span><% End If %>
   <% If AdByEmail = "1" Then %><span class='email'><a href='/emailadvertiser/doc/?listingid:<%=ListingId%>;detailpath:<%=ERPath%>'>Email Advertiser</a></span><% End If %>
   
   
 </div>
  
  
  <span class='details_reportad'><a href='/reportad/doc/?listingid:<%=ListingId%>;rpath:<%=ERPath%>'>Report this Ad</a></span>
  
  </span>

<!-- end right content -->


</div>

<div class='details_holder' style='margin-left:10px; width:870px;'>

<div class='preview_optionheader' style='margin-left:0px; margin-bottom:15px; margin-top:0px;'>Description</div>
  
  <span class='textbox'>
  
  <%=AdDescription%><br/><br/>
 
  </span>
  
  <% If AdReferences > "" Then %>
  
<div class='preview_optionheader' style='margin-left:0px; margin-bottom:15px; margin-top:0px;'>Feedback</div>
  <span class='textbox'>
  
  <%=AdReferences%><br/><br/><br/><b>Advert ID:</b> <%=AdvertId%>
 
  </span>

<% End If %>

</div>

<% Else %>

  <span class='list_norecord'><b>The advert was removed or has expired.</b></span>

<% End If %>


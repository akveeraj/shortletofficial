<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  ListingId  = ParseCircuit( "listingid", o_Query )
  Return     = ParseCircuit( "detailpath", o_Query )
  nReturn    = HexToString( Return )
  RPath      = Return
  FromReg    = ParseCircuit( "fromregister", o_Query )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Advert Details
// --------------------------------------------------------------------------------------------------------------------------------------------------- 

  AdSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
          Call FetchData( AdSQL, AdRs, ConnTemp )
		  
  AdCount = AdRs("NumberOFRecords")
  
  
  If AdCount > "0" Then
  
    AdSQL = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "'"
	        Call FetchData( AdSQL, AdRs, ConnTemp )
			
	  ListingId      = AdRs("listingid")
	  CustomerId     = AdRs("customerid")
	  AdvertId       = AdRs("advertid")
	  Photo          = AdRs("photo")
	  ThumbLen       = Len( Photo )
	  PrimaryPhoto   = Photo
	  IsVertical     = AdRs("isvertical")
	  AdTitle        = AdRs("title")
	  NextDay        = AdRs("nextday")
	  NextMonth      = AdRs("nextmonth")
	  NextYear       = AdRs("nextyear")
	  DateAvail      = NextDay & "-" & NextMonth & "-" & NextYear
	  Rent           = AdRs("rent")
	  Period         = AdRs("period")
	  IncBills       = AdRs("incbills")
	  PostCode       = AdRs("postcode")
	  Location       = AdRs("location")
	  ProType        = AdRs("propertytype")
	  RoomAmount     = AdRs("roomamount")
	  Desc           = AdRs("description")
	  Desc           = Replace( Desc, vbcrlf, "" )
	  DescLen        = Len( Desc )
	  ByEmail        = AdRs("byemail")
	  Email          = AdRs("email")
	  ByPhone        = AdRs("byphone")
	  Phone          = AdRs("phone")
	  Contact        = AdRs("contactname")
	  DateTimeStamp  = AdRs("datetimestamp")
	  DateStamp      = AdRs("datestamp")
	  DateStamp      = Replace( DateStamp, "/", "-" )
	  Status         = AdRs("status")
	  LetStatus      = AdRs("leased")
	  If AdTitle > "" Then
	  AdTitle = HexToString( AdTitle )
	  Subject        = "Advert #" & AdvertId & " - " & AdTitle
	  End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Contact Advertiser ~ Town and Gown Shortlets. Oxford";
});
</script>

<div class='contentheader2'>Contact Advertiser</div> 


<div class='textblock' style='width:550px; margin-bottom:20px; margin-top:20px;'>
<b>Use the form below to contact the advertiser.</b><br/>Please ensure you enter a valid email address.<br/>
<b><a href='<%=nReturn%>'>Return to Advert</a></b>
</div>



<div class='createad_formholder' id='createadform'>
<span class='spacer'></span>


  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Your Email Address</span></span>
	<span class='cell'><input type='text' name='email' id='email' value='' autocomplete='off' placeholder='Required Field' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Phone Number</span></span>
	<span class='cell'><input type='text' name='phone' id='phone' value='' autocomplete='off' placeholder='Optional' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Your Name</span></span>
	<span class='cell'><input type='text' name='name' id='name' value='' autocomplete='off' placeholder='Required Field' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Subject</span></span>
	<span class='cell'><input type='text' name='subject' id='subject' value='RE: <%=Subject%>' autocomplete='off' placeholder='Required Field' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px; style='text-align:left;'><span class='label' style='text-align:left;'>&nbsp;&nbsp;Your Message</span></span>
  </div>
  
  <div class='row'>
    <textarea class='textarealarge' name='message' id='message' autocomplete='off' placeholder='Required Field'></textarea>
  </div>

  <span class='spacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:155px;'>&nbsp;</span>
	<span class='button' id='advbutton' style='float:right; margin-right:18px;'><a href='javascript://' onclick="contactadvertiser('<%=RPath%>','<%=ListingId%>', '<%=CustomerId%>');">Send Message &gt;</a></span>
	<span class='wait' style='display:none;' id='advwait'></span>
  </div>
  
  <span class='spacer'></span>
  
</div>
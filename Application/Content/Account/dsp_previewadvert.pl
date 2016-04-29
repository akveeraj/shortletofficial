<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Title         = Request.Cookies("tandgadform")("adtitle")  
  NextDay       = Request.Cookies("tandgadform")("availday") 
  NextMonth     = Request.Cookies("tandgadform")("availmonth") 
  NextYear      = Request.Cookies("tandgadform")("availyear")
  DateStamp     = Day(Now) & "/" & Month(Now) & Year(Now)
  DateStamp     = DoFormatDate( Day(now) & "/" & Month(Now) & "/" & Year(Now) )
  TempId        = ParseCircuit( "tempid", o_Query )
  
  If NextDay > "" AND NextMonth > "" AND NextYear > "" Then
    DateAvailable = DoFormatDate( NextDay & "/" & NextMonth & "/" & NextYear )
  End If
  
  Rent            = Request.Cookies("tandgadform")("adrent") 
  Period          = Request.Cookies("tandgadform")("adperiod")
  Incbills        = Request.Cookies("tandgadform")("adincbills")
  PostCode        = Request.Cookies("tandgadform")("adpostcode")
  Location        = Request.Cookies("tandgadform")("adlocation")
  ProType         = Request.Cookies("tandgadform")("adprotype") 
  RoomAmount      = Request.Cookies("tandgadform")("adnoofbeds")
  
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
			 Desc       = HexToString( Desc )
			 References = RefRs("refs")
			 References = HexToString( References )
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If References > "" Then
    ShowRefs = 1
  Else
    ShowRefs = 0
  End If
  
  IsTrialExpired  = IsAccountExpired( Var_UserId, ConnTemp )
  TrialRemaining  = TrialRemainingCount( Var_UserId, ConnTemp )
  
  If PostCode = "" Then  PostCode = "Upon Request" End If
  
  If Desc > "" Then Desc = Replace( Desc, "%0A", "<br/>" )
  If Desc > "" Then Desc = UrlDecode( Desc ) End If
  If References > "" Then References = Replace( References, "%0A", "<br/>" ) End If
  If References > "" Then References = UrlDecode( References ) End If 
  
  ByEmail       = Request.Cookies("tandgadform")("adbyemail")  
  ByPhone       = Request.Cookies("tandgadform")("adbyphone") 
  Email         = Request.Cookies("tandgadform")("ademail") 
  Phone         = Request.Cookies("tandgadform")("adphone")
  Contact       = Request.Cookies("tandgadform")("adcontact")
  Photo1value   = Request.Cookies("tandgadform")("adphoto1") 
  Photo2value   = Request.Cookies("tandgadform")("adphoto2") 
  Photo3value   = Request.Cookies("tandgadform")("adphoto3") 
  Photo4value   = Request.Cookies("tandgadform")("adphoto4") 
  Photo5value   = Request.Cookies("tandgadform")("adphoto5") 
  Photo6value   = Request.Cookies("tandgadform")("adphoto6")
  Photo1isvert  = Request.Cookies("tandgadform")("adphoto1isvert")
  Photo2isvert  = Request.Cookies("tandgadform")("adphoto2isvert")
  Photo3isvert  = Request.Cookies("tandgadform")("adphoto3isvert")
  Photo4isvert  = Request.Cookies("tandgadform")("adphoto4isvert")
  Photo5isvert  = Request.Cookies("tandgadform")("adphoto5isvert")
  Photo6isvert  = Request.Cookies("tandgadform")("adphoto6isvert")
  Photo1Width   = Request.Cookies("tandgadform")("adphoto1width")
  Photo2Width   = Request.Cookies("tandgadform")("adphoto2width")
  Photo3Width   = Request.Cookies("tandgadform")("adphoto3width")
  Photo4Width   = Request.Cookies("tandgadform")("adphoto4width")
  Photo5Width   = Request.Cookies("tandgadform")("adphoto5width")
  Photo6Width   = Request.Cookies("tandgadform")("adphoto6width")
  SaveAction    = Request.Cookies("tandgadform")("adsaveaction")
  ListingId     = Request.Cookies("tandgadform")("listingid")
  AdType        = Request.Cookies("tandgadform")("adtype")

  RPath         = ParseCircuit( "rpath", o_Query )
  RPath         = HexToString( RPath )
  RPath         = RPath & ";tempid:" & TempId
  CompPath      = "/dashboard/account/?advertsaved:1"
  CompPath      = StringToHex( CompPath )
  
  PrimaryPhoto  = Photo1Value
  If Instr( PrimaryPhoto, "nopicsmall.png" ) > "0" Then 
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
  PhotoArray2 = Photo2Value & ","
  PhotoArray3 = Photo3Value & ","
  PhotoArray4 = Photo4Value & ","
  PhotoArray5 = Photo5Value & ","
  PhotoArray6 = Photo6Value & ""
  
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
	ThumbAction = "FetchImage('" & StringToHex("/uploads/src/" & NewArray(i)) & "', '" & IsVert & "', 'galleryholder');"
    PhotoList = PhotoList & "<span class='thumbs' title='Photo " & ImageCount & "' onclick=""" & ThumbAction & """><img src='/uploads/thumbs/" & NewArray(i) & "'/></span>"
  
	End If
  Next

  If Period = "Monthly" Then
    PeriodLabel = "pm"
  ElseIf Period = "Weekly" Then
    PeriodLabel = "pw"
  Else
    PeriodLabel = ""
  End If
  
  If RoomAmount = "5" Then RoomAmount = "5 +" End If
  If IncBills = "1" Then IncBillsLabel = "Including Bills" Else IncBillsLabel = "Excluding Bills" End If
  Adprice       = "&pound;" & Rent & PeriodLabel
  
  
  If Contact > "" Then
    ContactLabel = "Contact " & Contact
  Else
    ContactLabel = "Contact Advertiser"
  End If
  
  If SaveAction = "1" Then
    SaveLabel = "Edit Advert"
  ElseIf SaveAction = "2" Then
    SaveLabel = "Edit Advert Changes"
  End If
  
  If Instr( RPath, "/editadvert/account/" ) > "0" Then
    ContinueLabel = "Save Advert &gt;"
  Else
    ContinueLabel = "Place Advert Now &gt;"
  End If
  
  If Photo1isvert = "1" Then ImageWidth = "300" Else ImageWidth = "544" End If
  If Photo1Value  = "" Then PrimaryPhoto = "/application/library/media/bignophoto.png" End If
  If Photo1Value  = "" Then PrimaryPhoto = "<img src='" & PrimaryPhoto & "'/>" End If
  
  If IsTrialExpired = "0" Then
    SelectAdType   = "settotrialad();"
	DefaultSelect  = "0"
  Else
    SelectAdType   = "fetchadprices('0', '0'); hidetrial();"
	DefaultSelect  = "0"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

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
  function settotrialad(){
    var adtype          = "<%=DefaultSelect%>";
    var istrialexpired  = "<%=IsTrialExpired%>";
    var trialremaining  = "<%=TrialRemaining%>";
    var tempfeatured    = document.getElementById('featured');
	var ppladtype       = document.getElementById('ppladtype');
	var pplduration     = document.getElementById('pplduration');
	var pplamount       = document.getElementById('pplamount');
	var ppldescription  = document.getElementById('ppldescription');
	var trialnotice     = document.getElementById('trialnotice');
	var adduration      = document.getElementById('adduration');
	var paypallogo      = document.getElementById('paypallogo');
    var adoptions       = document.getElementById('selectoptions');
    var adoptionswait   = document.getElementById('selectoptionswait'); 
	var adoptionsedit   = document.getElementById('selectoptionsedit');
	
	adoptionswait.style.display = "none";
	adoptions.style.display     = "block";
	adoptionsedit.style.display = "none";
	
	trialnotice.style.display = "block";
	trialnotice.innerHTML  = "Standard Ad - Trial (" + trialremaining + " days remaining)"
	ppladtype.value = "0";
	pplduration.value = trialremaining;
	pplamount.value = "0.00";
	ppldescription.value = "Standard " + trialremaining + " day trial advert";
	adduration.innerHTML = "";
	paypallogo.style.display = "none";
  }
  
  function hidetrial(){
    var trialnotice     = document.getElementById('trialnotice');
	var paypallogo      = document.getElementById('paypallogo');
	var adoptions       = document.getElementById('selectoptions');
    var adoptionswait   = document.getElementById('selectoptionswait'); 
	var adoptionsedit   = document.getElementById('selectoptionsedit');
	
	trialnotice.style.display   = "none";
	paypallogo.style.display    = "block";
	adoptionsedit.style.display = "block";
  }
  
</script>

<script type='text/javascript'>
  document.observe("dom:loaded", function() {
    document.title = "** PREVIEW ** - <%=Title%> ~ Town and Gown Shortlets UK";
    var istrialexpired = "<%=IsTrialExpired%>";
	var paypallogo      = document.getElementById('paypallogo');
	var adoptions       = document.getElementById('selectoptions');
    var adoptionswait   = document.getElementById('selectoptionswait'); 
	var adoptionsedit   = document.getElementById('selectoptionsedit');
	
	$j('input:radio[name="featured"]').filter('[value="0"]').attr('checked', true);
	
	if ( istrialexpired == "1" ) {
	  fetchadprices('0','0');
	  paypallogo.style.display    = "block";
	  adoptionsedit.style.display = "block";
	  
	} else {
	  settotrialad();
	  paypallogo.style.display = "none";
	}
  });
</script> 


<div class='contentheader2'>Ad Preview</div>


<div class='details_holder' style='margin-top:20px;'>

<!-- left content -->


  <span class='cell' style='width:550px; margin-right:5px;'>
  
  <div class='details_header' style='margin-top:20px;'><span class='title'><%=Title%></span></div>
  
  <!-- gallery -->

  <span class='gallerywait' style='display:none;' id='gallerywait'></span>
  <div class='galleryholder' id='galleryholder'><%=PrimaryPhoto%></div>
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
		<span class='cell' style='text-align:right; width:115px;'><%=ProType%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px;'><b>Rental Amount</b></span>
		<span class='cell' style='text-align:right; width:115px;'>&pound;<%=Rent%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px'><b>Location</b></span>
		<span class='cell' style='text-align:right; width:115px;'><%=Location%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:120px;'><b>Date Available</b></span>
		<span class='cell' style='text-align:right; width:115px;'><%=DateAvailable%></span>
	  </span>

	  
	</span>
	
	
	
    <span class='infocell' style='width:266px;'>
	  <span class='row'>
	    <span class='cell' style='width:130px;'><b>Rental Frequency</b></span>
		<span class='cell' style='text-align:right; float:right;'><%=Period%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:130px;'><b>Number of Bedrooms</b></span>
		<span class='cell' style='text-align:right; float:right;'><%=RoomAmount%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:130px;'><b>Post Code</b></span>
		<span class='cell' style='text-align:right; float:right;'><%=PostCode%></span>
	  </span>
	  
	  <span class='row'>
	    <span class='cell' style='width:130px;'><b>Posted</b></span>
		<span class='cell' style='text-align:right; float:right;'><%=DateStamp%></span>
	  </span>
	  
	  
	</span>
  
  </div>
  
  
  </span>

<!-- end left content -->

<!-- right content -->

  <span class='cell' style='width:245px; float:right; margin-right:40px; margin-top:40px;'> 
  
  <div class='details_price'><%=AdPrice%><span class='incbills'><%=IncBillsLabel%></span></div>
  
 <div class='contactbox'>
   <span class='contact'><%=ContactLabel%></span>
   <% If ByPhone = "1" Then %><span class='phone'><%=Phone%></span><% End If %>
   <% If ByEmail = "1" Then %><span class='email'><a href='javascript://' onclick="alert('This option is unavailable in the preview');">Email Advertiser</a></span><% End If %>

 </div>
  
  </span>

<!-- end right content -->


</div>


<div class='details_holder' style='margin-left:10px; width:770px;'>

<div class='preview_optionheader' style='margin-left:0px; margin-bottom:15px; margin-top:0px; border-bottom:0px;'>Description</div>
  
  <span class='textbox' style='margin-bottom:20px;'>
  
  <%=Desc%>
  
  </span>
  
  <% If References > "" Then %>
  <div class='preview_optionheader' style='margin-left:0px; margin-bottom:15px; margin-top:0px; border-bottom:0px;'>Feedback</div>
  
  <span class='textbox' style='margin-bottom:20px;'>
  <%=References%>
  </span>
  
  <% End If %>

</div>





<div class='preview_spacerline'></div>

<div class='preview_optionheader'>
Advert Options<br/>
<span class='smalltext'>Featured Adverts appear and remain towards the top of listings for the duration of your paid period.<br/></span>
<span class='smalltext'>Standard adverts are displayed in the date order they are published.</span>
</div>

<!-- start advert options -->

  <form action="" id='optionsform' name='optionsform'>

<div class='preview_adoptions' id='adoptions'>
  <div class='row'>
    
	<span class='cell'>
	
	  <span class='inner_row'>
	    <span class='inner_cell'><span class='label'><input type='radio' id='featured' name='featured' value='1' autocomplete='off' onclick="fetchadprices('1', '0'); hidetrial();"/></span></span>
		<span class='inner_cell' style='width:110px;'><span class='featuredad'>Featured Ad</span></span>
	  </span>
	  
	  <span class='inner_row'>
	    <span class='inner_cell'><span class='label'><input type='radio' id='featured' name='featured' value='0' autocomplete='off' onclick="<%=SelectAdType%>"/></span></span>
		<span class='inner_cell' style='width:110px;'><span class='standardad'>Standard Ad</span></span>
	  </span>
	  
	  
	  
	</span>
	
	
	
	
	
	
	<span class='cell'>
	  <span class='label' style='margin-top:0px;'><span id='adduration'></span><span class='trialnotice' id='trialnotice' style='display:none;'></span><span class='wait' id='adoptions_wait' style='display:none;'></span></span>
	</span>
	
	<span class='wait' id='selectoptionswait' style='margin-top:35px; display:none;'>Please Wait...</span>
	
	
	
	
	<span class='cell' style='float:right; display:none;' id='selectoptions'>
	  <span class='edit' id='previewedit'><a href='<%=RPath%>'>&lt; Edit Advert</a></span>
	  <span class='save' id='previewsave'><a href='javascript://' onclick="CreateNewAd('<%=CompPath%>', '<%=IsTrialExpired%>', '<%=TempId%>')">Place Advert Now &gt;</a></span>
	  <span class='newwait' id='previewwait' style='margin-top:25px; display:none;'>Please Wait...</span>
	</span>
	
	<span class='cell' style='float:right; display:none; margin-top:28px;' id='selectoptionsedit'>
	  <span class='edit' id='previewedit'><a href='<%=RPath%>'>&lt; Edit Advert</a></span>
	</span>

	
  </div>
</div>

	<div class='preview_paypallogo' id='paypallogo' style='display:none;'></div>

</form>

<!-- end advert options -->


<!-- start paypal setup -->
<input type='hidden' name='falseduration' id='falseduration' value='1' autocomplete='off'/>
<input type='hidden' name='ppldescription' id='ppldescription' value='' autocomplete='off'/>
<input type='hidden' name='pplamount' id='pplamount' value='' autocomplete='off'/>
<input type='hidden' name='pplduration' id='pplduration' value='' autocomplete='off'/>
<input type='hidden' name='ppladtype' id='ppladtype' value='' autocomplete='off'/>

<!-- end paypal setup -->

<input type='hidden' name='title' id='title' value="<%=Title%>" autocomplete='off'/>
<input type='hidden' name='nextday' id='nextday' value='<%=NextDay%>' autocomplete='off'/>
<input type='hidden' name='nextmonth' id='nextmonth' value='<%=NextMonth%>' autocomplete='off'/>
<input type='hidden' name='nextyear' id='nextyear' value='<%=NextYear%>' autocomplete='off'/>
<input type='hidden' name='rent' id='rent' value='<%=Rent%>' autocomplete='off'/>
<input type='hidden' name='period' id='period' value='<%=Period%>' autocomplete='off'/>
<input type='hidden' name='incbills' id='incbills' value='<%=IncBills%>' autocomplete='off'/>
<input type='hidden' name='postcode' id='postcode' value='<%=PostCode%>' autocomplete='off'/>
<input type='hidden' name='location' id='location' value='<%=Location%>' autocomplete='off'/>
<input type='hidden' name='protype' id='protype' value='<%=ProType%>' autocomplete='off'/>
<input type='hidden' name='roomamount' id='roomamount' value='<%=RoomAmount%>' autocomplete='off'/>
<input type='hidden' name='byemail' id='byemail' value='<%=ByEmail%>' autocomplete='off'/>
<input type='hidden' name='byphone' id='byphone' value='<%=ByPhone%>' autocomplete='off'/>
<input type='hidden' name='email' id='email' value='<%=Email%>' autocomplete='off'/>
<input type='hidden' name='phone' id='phone' value='<%=Phone%>' autocomplete='off'/>
<input type='hidden' name='contact' id='contact' value='<%=Contact%>' autocomplete='off'/>
<input type='hidden' name='photo1value' id='photo1value' value='<%=Photo1Value%>' autocomplete='off'/>
<input type='hidden' name='photo2value' id='photo2value' value='<%=Photo2Value%>' autocomplete='off'/>
<input type='hidden' name='photo3value' id='photo3value' value='<%=Photo3Value%>' autocomplete='off'/>
<input type='hidden' name='photo4value' id='photo4value' value='<%=Photo4Value%>' autocomplete='off'/>
<input type='hidden' name='photo5value' id='photo5value' value='<%=Photo5Value%>' autocomplete='off'/>
<input type='hidden' name='photo1isvert' id='photo1isvert' value='<%=Photo1IsVert%>' autocomplete='off'/>
<input type='hidden' name='photo2isvert' id='photo2isvert' value='<%=Photo2IsVert%>' autocomplete='off'/>
<input type='hidden' name='photo3isvert' id='photo3isvert' value='<%=Photo3IsVert%>' autocomplete='off'/>
<input type='hidden' name='photo4isvert' id='photo4isvert' value='<%=Photo4IsVert%>' autocomplete='off'/>
<input type='hidden' name='photo5isvert' id='photo5isvert' value='<%=Photo5IsVert%>' autocomplete='off'/>
<input type='hidden' name='photo1width' id='photo1width' value='<%=Photo1Width%>' autocomplete='off'/>
<input type='hidden' name='photo2width' id='photo2width' value='<%=Photo2Width%>' autocomplete='off'/>
<input type='hidden' name='photo3width' id='photo3width' value='<%=Photo3Width%>' autocomplete='off'/>
<input type='hidden' name='photo4width' id='photo4width' value='<%=Photo4Width%>' autocomplete='off'/>
<input type='hidden' name='photo5width' id='photo5width' value='<%=Photo5Width%>' autocomplete='off'/>

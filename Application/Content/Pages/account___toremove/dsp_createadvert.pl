<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
  o_Query     = UrlDecode( o_Query )
  FromReg     = ParseCircuit( "fromregister", o_Query )
  AccExpired  = IsAccountExpired( Var_UserId, ConnTemp )
  Location    = ParseCircuit( "location", o_Query )
  Edit        = ParseCircuit( "edit", o_Query )
  RPath       = "/createadvert/account/?edit:1"
  RPath       = StringToHex(RPath)
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get list of cities
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  CitySQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM uk_Cities"
              Call FetchData( CitySQL, CityRs, ConnTemp )
			  
  CityCount = CityRs("NumberOfRecords")
  
  If CityCount > "0" Then
  
    CitySQL = "SELECT * FROM uk_cities ORDER BY city ASC"
	          Call FetchData( CitySQL, CityRs, ConnTemp )
			  
	Do WHILE NOT CityRs.Eof
	  City     = CityRs("city")
	  CityList = CityList & "<option value='" & City & "'>" & City & "</option>"
	
	CityRs.MoveNext
	Loop
  
  End If
			  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Generate Days
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  StartDay = 1
  EndDay   = 31
  
  For i = StartDay to EndDay
    i = FixSingleDigits( i )
    DayOption = DayOption & "<option value='" & i & "'>" & i & "</option>"
  Next

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Generate Months
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  StartMonth = 1
  EndMonth   = 12
  
  For i = StartMonth to EndMonth
    i = FixSingleDigits( i )
    MonthOption = MonthOption & "<option value='" & i & "'>" & GenMonth(i) & "</option>"
  Next

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Generate Years
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  StartYear = CDBL(Year(Now))
  EndYear   = StartYear+30
  
  For i = StartYear to EndYear
    YearOption = YearOption & "<option value='" & i & "'>" & i & "</option>"
  Next
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Generate Rooms
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  RoomStart = 1
  RoomEnd   = 4
  
  For i = RoomStart to RoomEnd
    RoomOption = RoomOption & "<option value='" & i & "'>" & i & "</option>"
  Next

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Form Cookies
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Edit = "1" Then
  
	ListingId        = Request.Cookies("tandgadform")("listingid")
	AdvertId         = Request.Cookies("tandgadform")("advertid")
    AdTitle          = Request.Cookies("tandgadform")("adtitle")
    AdAvailDay       = Request.Cookies("tandgadform")("availday")
    AdAvailMonth     = Request.Cookies("tandgadform")("availmonth")
    AdAvailYear      = Request.Cookies("tandgadform")("availyear")
    AdRent           = Request.Cookies("tandgadform")("adrent")
    AdPeriod         = Request.Cookies("tandgadform")("adperiod")
    AdIncBills       = Request.Cookies("tandgadform")("adincbills")
    AdPostCode       = Request.Cookies("tandgadform")("adpostcode")
    AdLocation       = Request.Cookies("tandgadform")("adlocation")
    AdProType        = Request.Cookies("tandgadform")("adprotype")
    AdNoOfBeds       = Request.Cookies("tandgadform")("adnoofbeds")
    AdDescription    = Request.Cookies("tandgadform")("addescription")
	AdDescription    = Replace(AdDescription, vbcrlf, "" )
	
    If AdDescription > "" Then AdDescription = Replace( AdDescription, "%0A", vbcrlf )
    If AdDescription > "" Then AdDescription = UrlDecode( AdDescription ) End If
	
    AdByEmail        = Request.Cookies("tandgadform")("adbyemail")
    AdByPhone        = Request.Cookies("tandgadform")("adbyphone")
    AdEmail          = Request.Cookies("tandgadform")("ademail")
    AdPhone          = Request.Cookies("tandgadform")("adphone")
    AdContact        = Request.Cookies("tandgadform")("adcontact")
	AdType           = Request.Cookies("tandgadform")("adtype")
	
	Photo1Src        = Request.Cookies("tandgadform")("adphoto1")
	Photo1Len        = Len( Photo1Src )
	Photo1IsVert     = Request.Cookies("tandgadform")("adphoto1isvert")
	
	Photo2Src        = Request.Cookies("tandgadform")("adphoto2")
	Photo2Len        = Len( Photo2Src )
	Photo2IsVert     = Request.Cookies("tandgadform")("adphoto2isvert")
	
	Photo3Src        = Request.Cookies("tandgadform")("adphoto3")
	Photo3Len        = Len( Photo3Src )
	Photo3IsVert     = Request.Cookies("tandgadform")("adphoto3isvert")
	
	Photo4Src        = Request.Cookies("tandgadform")("adphoto4")
	Photo4Len        = Len( Photo4Src )
	Photo4IsVert     = Request.Cookies("tandgadform")("adphoto4isvert")
	
	Photo5Src        = Request.Cookies("tandgadform")("adphoto5")
	Photo5Len        = Len( Photo5Src )
	Photo5IsVert     = Request.Cookies("tandgadform")("adphoto5isvert")
	
  End If
  
  
  If Edit = "1" Then
  
    Photo1Image = Photo1Src
    Photo2Image = Photo2Src
    Photo3Image = Photo3Src
    Photo4Image = Photo4Src
    Photo5Image = Photo5Src
  
    If Photo1Image = "" OR Photo1Image = "nopicsmall.png" OR Photo1Image = "NULL" OR Len( Photo1Image ) = "0" Then Photo1Image = "nopicsmall.png" Else Photo1Image = Photo1Image End If
    If Photo2Image = "" OR Photo2Image = "nopicsmall.png" OR Photo2Image = "NULL" OR Len( Photo2Image ) = "0" Then Photo2Image = "nopicsmall.png" Else Photo2Image = Photo2Image End If
    If Photo3Image = "" OR Photo3Image = "nopicsmall.png" Or Photo3Image = "NULL" OR Len( Photo3Image ) = "0" Then Photo3Image = "nopicsmall.png" Else Photo3Image = Photo3Image End If
    If Photo4Image = "" OR Photo4Image = "nopicsmall.png" Or Photo4Image = "NULL" OR Len( Photo4Image ) = "0" Then Photo4Image = "nopicsmall.png" Else Photo4Image = Photo4Image End If
    If Photo5Image = "" OR Photo5Image = "nopicsmall.png" Or Photo5Image = "NULL" OR Len( Photo5Image ) = "0" Then Photo5Image = "nopicsmall.png" Else Photo5Image = Photo5Image End If
  
    Photo1Src   = Photo1Image
    Photo2Src   = Photo2Image
    Photo3Src   = Photo3Image
    Photo4Src   = Photo4Image
    Photo5Src   = Photo5Image
  
    Photo1Html  = "<img src='/uploads/thumbs/" & Photo1Image & "' id='photo1img'/>"
    Photo2Html  = "<img src='/uploads/thumbs/" & Photo2Image & "' id='photo2img'/>"
    Photo3Html  = "<img src='/uploads/thumbs/" & Photo3Image & "' id='photo3img'/>"
    Photo4Html  = "<img src='/uploads/thumbs/" & Photo4Image & "' id='photo4img'/>"
    Photo5Html  = "<img src='/uploads/thumbs/" & Photo5Image & "' id='photo5img'/>"
  
  Else 
  
    Photo1Html = "<img src='/uploads/thumbs/nopicsmall.png' id='photo1img'/>"
	Photo2Html = "<img src='/uploads/thumbs/nopicsmall.png' id='photo2img'/>"
	Photo3Html = "<img src='/uploads/thumbs/nopicsmall.png' id='photo3img'/>"
	Photo4Html = "<img src='/uploads/thumbs/nopicsmall.png' id='photo4img'/>"
	Photo5Html = "<img src='/uploads/thumbs/nopicsmall.png' id='photo5img'/>"
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
<% If Edit = "1" Then %>
document.observe("dom:loaded", function() {
  document.getElementById('nextday').value       = "<%=AdAvailDay%>";
  document.getElementById('nextmonth').value     = "<%=AdAvailMonth%>";
  document.getElementById('nextyear').value      = "<%=AdAvailYear%>";
  document.getElementById('rent').value          = "<%=AdRent%>";
  document.getElementById('period').value        = "<%=AdPeriod%>";
  document.getElementById('postcode').value      = "<%=AdPostCode%>";
  document.getElementById('location').value      = "<%=AdLocation%>";
  document.getElementById('propertytype').value  = "<%=AdProType%>";
  var tempincbills = document.getElementById('incbills');
  var incbills     = "<%=AdIncBills%>";
  if ( incbills == "1" ) { tempincbills.checked = true; } else { tempincbills.checked = false; }
  document.getElementById('roomamount').value         = "<%=AdNoOfBeds%>";
  document.getElementById('photo1holder').innerHTML   = "<%=Photo1Html%>";
  document.getElementById('photo2holder').innerHTML   = "<%=Photo2Html%>";
  document.getElementById('photo3holder').innerHTML   = "<%=Photo3Html%>";
  document.getElementById('photo4holder').innerHTML   = "<%=Photo4Html%>";
  document.getElementById('photo5holder').innerHTML   = "<%=Photo5Html%>";
  var tempbyemail = document.getElementById('byemail');
  var byemail = "<%=AdByEmail%>";
  if ( byemail == "1" ) { tempbyemail.checked = true; } else { tempbyemail.checked = false; }
  document.getElementById('email').value = "<%=AdEmail%>";
  var tempbyphone = document.getElementById('byphone');
  var byphone = "<%=AdByPhone%>";
  if ( byphone == "1" ) { tempbyphone.checked = true; } else { tempbyphone.checked = false; }
  document.getElementById('telephone').value      = "<%=AdPhone%>";
  document.getElementById('contactname').value    = "<%=AdContact%>";
  
  document.getElementById('photo1value').value    = "<%=Photo1Src%>";
  document.getElementById('photo1isvert').value   = "<%=Photo1IsVert%>";
  document.getElementById('photo2value').value    = "<%=Photo2Src%>";
  document.getElementById('photo2isvert').value   = "<%=Photo2IsVert%>";
  document.getElementById('photo3value').value    = "<%=Photo3Src%>";
  document.getElementById('photo3isvert').value   = "<%=Photo3IsVert%>";
  document.getElementById('photo4value').value    = "<%=Photo4Src%>";
  document.getElementById('photo4isvert').value   = "<%=Photo4IsVert%>";
  document.getElementById('photo5value').value    = "<%=Photo5Src%>";
  document.getElementById('photo5isvert').value   = "<%=Photo5IsVert%>";
  
  //var adtype         = "<%=AdType%>";
  //var tempfeatured   = document.getElementById('featured');
  //$j('input:radio[name="featured"]').filter('[value="<%=AdType%>"]').attr('checked', true);
  
});

<% Else %>

document.observe("dom:loaded", function() {
  var tempbyemail = document.getElementById('byemail');
  var byemail = "<%=AdByEmail%>";
  if ( byemail == "1" ) { tempbyemail.checked = true; } else { tempbyemail.checked = false; }
  document.getElementById('email').value = "<%=AdEmail%>";
  var tempbyphone = document.getElementById('byphone');
  var byphone = "<%=AdByPhone%>";
  if ( byphone == "1" ) { tempbyphone.checked = true; } else { tempbyphone.checked = false; }
  document.getElementById('telephone').value          = "<%=AdPhone%>";
  document.getElementById('contactname').value        = "<%=AdContact%>";
  var roomamount = document.getElementById('roomamount');
  roomamount.options[roomamount.selectedIndex].value = "<%=AdNoOfBeds%>";
  document.getElementById('photo1holder').innerHTML   = "<%=Photo1Html%>";
  document.getElementById('photo2holder').innerHTML   = "<%=Photo2Html%>";
  document.getElementById('photo3holder').innerHTML   = "<%=Photo3Html%>";
  document.getElementById('photo4holder').innerHTML   = "<%=Photo4Html%>";
  document.getElementById('photo5holder').innerHTML   = "<%=Photo5Html%>";
  
  var adtype         = "<%=AdType%>";
  var tempfeatured   = document.getElementById('featured');
  $j('input:radio[name="featured"]').filter('[value="<%=AdType%>"]').attr('checked', true);
  
});

<% End If %>
</script>

<script type='text/javascript'>
document.observe("dom:loaded", function() { document.title = "Place an Ad ~ Town and Gown Shortlets UK"; });
</script>

<script type="text/javascript">
function limiter(textarea, count, counter){
var counter = document.getElementById(counter);
var count   = count;
var tex     = document.getElementById(textarea).value;
var len     = tex.length;
if(len > count){
tex = tex.substring(0,count);
  counter.innerHTML = tex;
return false;
}
counter.innerHTML = count-len + " characters remaining";
}
</script> 

<div class='contentheader2'>Place an Ad</div>

<% If FromReg = "1" Then %>
<div class='createad_justregistered'>
  <span class='bigtext'><b>Registration Complete</b><br/></span>
  Thank you for registering, your account is now active and you can start adding your first advert.
  <br/>A confirmation email has been sent to <b><%=AccEmail%></b> containing
   your log in details.
</div>
<% End If %> 

<div class='textblock' style='margin-bottom:20px; border-bottom:solid 1px #eeeeee; text-align:center;'>
  <b>Fill out the form below to place an advert.</b>
</div>



<div class='createad_formholder' id='createadform'>

<span class='spacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Advert Title</span></span>
	<span class='cell'><input type='text' name='title' id='title' value='<%=AdTitle%>' autocomplete='off' placeholder='Required Field - 90 Characters maximum' class='input' onkeyup="limiter('title', '90', 'titlecount')" maxlength="90"/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>&nbsp;</span></span>
    <span class='cell'><span class='textcount' id='titlecount'></span></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Date Available</span></span>
	<span class='cell'>
	<select name='nextday' id='nextday' autocomplete='off' class='selectsmall'>
	<option value='-'>Day</option>
	<option value='-'>-------------------</option>
	<%=DayOption%>
	</select>
	</span>
	
	<span class='cell'>
	<select name='nextmonth' id='nextmonth' autocomplete='off' class='selectsmall' style='width:120px;'>
	<option value='-'>Month</option>
	<option value='-'>-------------------</option>
	<%=MonthOption%>
	</select>
	</span>
	
	<span class='cell'>
	<select name='nextyear' id='nextyear' autocomplete='off' class='selectsmall'>
	<option value='-'>Year</option>
	<option value='-'>-------------------</option>
	<%=YearOption%>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Rent &pound;</span></span>
	<span class='cell'><input type='text' name='rent' id='rent' value='' autocomplete='off' class='inputsmall'/></span>
	<span class='cell'><span class='label'>Rent Period</span></span>
	<span class='cell'>
	<select name='period' id='period' autocomplete='off' class='selectmedium'>
	<option value='-'>-- Choose --</option>
	<option value='-'>-------------------</option>
	<option value='Weekly'>Weekly</option>
	<option value='Monthly'>Monthly</option>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Including Bills?</span></span>
	<span class='cell'><span class='label' style='margin-top:5px;'><input type='checkbox' name='incbills' id='incbills' value='' autocomplete='off'/></span></span>
  </div>
  
  <div class='row'>
	<span class='cell' style='width:150px;'><span class='label'>Location</span></span>
	<span class='cell'>
	  <select name='location' id='location' autocomplete='off' class='inputsmall' style='width:170px;'>
	  <%=CityList%>
	  </select>
	</span>
	
    <span class='cell'><span class='label'>Postcode</span></span>
	<span class='cell'><input type='text' name='postcode' id='postcode' value='' autocomplete='off' class='inputsmall' placeholder='optional'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Property Type</span></span>
	<span class='cell'>
	<select name='propertytype' id='propertytype' autocomplete='off' class='selectmedium'>
	<option value='-'>-- Choose --</option>
	<option value='-'>-------------------</option>
	<option value='Flat'>Flat</option>
	<option value='House'>House</option>
	</select>
	</span> 
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Number of Bedrooms</span></span>
	<span class='cell'>
	<select name='roomamount' id='roomamount' autocomplete='off' class='selectmedium'>
	<option value='-'>-- Choose --</option>
	<option value='-'>--------------</option>
	<option value='Studio'>Studio</option>
	<%=RoomOption%>
	<option value='5'>5 +</option>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Advert Description</span></span>
  </div>
  
  <div class='row'>
    <textarea class='textarealarge' name='description' id='description' autocomplete='off' placeholder='3000 characters maximum' onkeyup="limiter('description', '3000', 'descriptioncount')" maxlength="3000"><%=AdDescription%></textarea>
  </div>
  
  <div class='row'>
    <span class='cell'><span id='descriptioncount' class='textcount' style='margin-left:20px;'></span></span>
  </div>
  
  <span class='formheader' style='border-top:solid 1px #deb865;'><span style='float:left;'>Add your Photos<br/><span style='font-size:14px; font-weight:normal;'>Photo 1 is your main display photo - So make this as attractive as possible!<br/><b>IMPORTANT:</b> Do not browse away from the page while your photos are uploading.</span></span></span>
  <span class='spacer'></span>
  <!--#include virtual="/application/content/pages/account/dsp_standalone_uploader.pl"-->
  <span class='spacer'></span>

  
<span class='formheader' style='border-top:solid 1px #deb865;'><span style='float:left;'>Contact Details</span></span>
  
  <div class='row'>
    <span class='forminstruction'><b>Please select at least one contact option for your ad</b><br/>Your email address won't appear on your advert, but will only be revealed if you reply to an enquiry.</span>
    <span class='cell'><span class='label' style='margin-top:5px;'><input type='checkbox' name='byemail' id='byemail' value='' autocomplete='off'/></span></span>
	<span class='cell' style='width:105px;'><span class='labelleft'>by email on</span></span>
	<span class='cell'><input type='text' name='email' id='email' value='' autocomplete='off' class='input' placeholder='enter a valid email address'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='text-align:left;'><span class='labelleft' style='margin-top:5px;'><input type='checkbox' name='byphone' id='byphone' value='' autocomplete='off'/></span></span>
	<span class='cell' style='width:105px;'><span class='labelleft'>by phone on</span></span>
	<span class='cell'><input type='text' name='telephone' id='telephone' value='' autocomplete='off' class='input' placeholder='enter a valid phone number'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:30px;'></span>
	<span class='cell' style='width:105px;'><span class='labelleft'>Contact Name</span></span>
	<span class='cell'><input type='text' name='contactname' id='contactname' value='' autocomplete='off' class='input' placeholder='enter a contact name ( optional )'/></span>
  </div>
  
<span class='spacer'></span>
  
  <div class='row' style='border-top:solid 2px #deb865; padding-top:18px;'>
	<span class='cancelbutton' style='float:left; margin-left:10px;'><a href='/dashboard/account/'>&lt; Back to My Adverts</a></span>
	<span class='button' id='advbutton' style='float:right; margin-right:10px;'><a href='javascript://' onclick="previewadvert();">Preview Advert &gt;</a></span>
	<span class='wait' style='display:none; float:right;' id='advwait'></span>
  </div>
  
  <span class='spacer'></span>
  
</div>



<input type='hidden' name='photo1value'   id='photo1value'    value='<%=Photo1Src%>'      autocomplete='off'/>
<input type='hidden' name='photo1isvert'  id='photo1isvert'   value='<%=Photo1IsVert%>'   autocomplete='off'/>

<input type='hidden' name='photo2value'   id='photo2value'    value='<%=Photo2Src%>'      autocomplete='off'/>
<input type='hidden' name='photo2isvert'  id='photo2isvert'   value='<%=Photo2IsVert%>'   autocomplete='off'/>

<input type='hidden' name='photo3value'   id='photo3value'    value='<%=Photo3Src%>'      autocomplete='off'/>
<input type='hidden' name='photo3isvert'  id='photo3isvert'   value='<%=Photo3IsVert%>'   autocomplete='off'/>

<input type='hidden' name='photo4value'   id='photo4value'    value='<%=Photo4Src%>'      autocomplete='off'/>
<input type='hidden' name='photo4isvert'  id='photo4isvert'   value='<%=Photo4IsVert%>'   autocomplete='off'/>

<input type='hidden' name='photo5value'   id='photo5value'    value='<%=Photo5Src%>'      autocomplete='off'/>
<input type='hidden' name='photo5isvert'  id='photo5isvert'   value='<%=Photo5IsVert%>'   autocomplete='off'/>

<input type='hidden' name='photo1width'   id='photo1width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo2width'   id='photo2width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo3width'   id='photo3width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo4width'   id='photo4width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo5width'   id='photo5width'    value=''                    autocomplete='off'/>
<input type='hidden' name='rpath'         id='rpath'          value='<%=RPath%>'          autocomplete='off'/>
<input type='hidden' name='saveaction'    id='saveaction'     value='1'                   autocomplete='off'/>
<input type='hidden' name='listingid'     id='listingid'      value='<%=ListingId%>'      autocomplete='off'/>
<input type='hidden' name='advertid'      id='advertid'       value='<%=AdvertId%>'       autocomplete='off'/>


<input type='hidden' name='contracttype' id='contracttype' value='2' autocomplete='off'/>





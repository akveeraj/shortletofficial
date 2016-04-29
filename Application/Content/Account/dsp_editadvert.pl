<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
  ListingId    = ParseCircuit( "listingid", o_Query )
  'RPath        = "/editadvert/account/?edit:1;listingid:" & ListingId
  'RPath        = StringToHex(RPath)
  Edit         = ParseCircuit( "edit", o_Query )
  CityList     = WriteCities(ConnTemp)
  FromLive     = ParseCircuit( "fromlive", o_Query )
  FromSaved    = ParseCircuit( "fromsaved", o_Query )
  FromExpired  = ParseCircuit( "fromexpired", o_Query )
  FromDeleted  = ParseCircuit( "fromdeleted", o_Query )
  TempId       = ParseCircuit( "tempid", o_Query )
  
  If FromLive     = "" Then  FromLive     = "0"  Else FromLive     = FromLive     End If
  If FromSaved    = "" Then  FromSaved    = "0"  Else FromSaved    = FromSaved    End If
  If FromExpired  = "" Then  FromExpired  = "0"  Else FromExpired  = FromExpired  End If
  If FromDeleted  = "" Then  FromDeleted  = "0"  Else FromDeleted  = FromDeleted  End If
  
  If FromLive > "0" Then
    RPath     = "/editadvert/account/?edit:1;listingid:" & ListingId & ";fromsaved:" & FromSaved
	BackPath  = "/dashboard/account/?tab:1"
	BackLabel = "&lt; Back to Active Ads"
  ElseIf FromSaved > "0" Then
    RPath     = "/editadvert/account/?edit:1;listingid:" & ListingId & ";fromsaved:" & FromSaved
	BackPath  = "/dashboard/account/?tab:4"
	BackLabel = "&lt; Back to Saved Ads"
  ElseIf FromExpired > "0" Then
    RPath     = "/editadvert/account/?edit:1;listingid:" & ListingId & ";fromsaved:" & FromSaved
	BackPath  = "/dashboard/account/?tab:3"
	BackLabel = "&lt; Back to Expired Ads"
  ElseIf FromDeleted > "0" Then
    RPath     = "/editadvert/account/?edit:1;listingid:" & ListingId & ";fromsaved:" & FromSaved
	BackPath  = "/dashboard/account/?tab:2"
	BackLabel = "&lt; Back to Deleted Ads"
  Else
    RPath     = "/editadvert/account/?edit:1;listingid:" & ListingId
	BackPath  = "/dashboard/account/"
	BackLabel = "&lt; Back to My Adverts"
  End If
  
  RPath = StringToHex(RPath)
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Description and References
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Edit = "1" Then

  RefSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM tempshortlets WHERE tempid='" & TempId & "'"
           Call FetchData( RefSQL, RefRs, ConnTemp )
		   
  RefCount = RefRs("NumberOfRecords")
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If RefCount > "0" AND Edit = "1" Then
  
    RefSQL = "SELECT * FROM tempshortlets WHERE tempid='" & TempId & "'"
	         Call FetchData( RefSQL, RefRs, ConnTemp )
			 Desc       = RefRs("description")
			 Desc       = HexToString( Desc )
			 References = RefRs("refs")
			 References = HexToString( References )
  
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
  
  StartYear = "2014"'CDBL(Year(Now)) 
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
// ' Get Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
                 Call FetchData( ShortSQL, ShortRs, ConnTemp )
			  
  DetailCount = ShortRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If DetailCount > "0" AND Edit = "" Then
  
	ShortSQL = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
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
	If AdReferences > "" Then Adreferences = Replace( Adreferences, vbcrlf, "" ) End If
    AdByEmail        = ShortRs("byemail")
    AdByPhone        = ShortRs("byphone")
    AdEmail          = ShortRs("email")
    AdPhone          = ShortRs("phone")
    AdContact        = ShortRs("contactname")
	AdContact        = HexToString( AdContact )
	DateTimeStamp    = ShortRs("datetimestamp")
	DateStamp        = ShortRs("datestamp")
	Status           = ShortRs("status")
	Photo1Src        = Photo
	Photo1IsVert     = ShortRs("isvertical")
	
	If AdDescription > "" Then AdDescription = HexToString( AdDescription ) End If
	If AdTitle > "" Then AdTitle = HexToString( AdTitle ) End If
	If AdDescription > "" Then AdDescription = UrlDecode( AdDescription ) End If
	If AdReferences > "" Then AdReferences = HexToString( AdReferences ) End If
	If AdReferences > "" Then AdReferences = UrlDecode( AdReferences ) End If
	
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
			   Photo2Id      = GalRs("photoid")
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
			   Photo3Id      = GalRs("photoid")
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
			   Photo4Id      = GalRs("photoid")
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
			   Photo5Id      = GalRs("photoid")
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    GalSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photonumber='6' AND advertid='" & ListingId & "'"
	            Call FetchData( GalSQL, GalRs, ConnTemp )
			  
	Gal6Count = GalRs("NumberOfRecords")
				
	If Gal6Count > "0" Then
	  GalSQL = "SELECT * FROM galleryphotos WHERE photonumber='6' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   Photo6Src     = GalRs("photo")
			   Photo6Len     = Len( Photo6Src )
			   Photo6IsVert  = GalRs("isvertical")
			   Photo6Id      = GalRs("photoid")
	End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
	
  End If
  
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
    AdDescription    = Desc
	AdDescription    = Replace(AdDescription, vbcrlf, "" )
	AdReferences     = References
	AdReferences     = Replace(AdReferences, vbcrlf, "" )
	
    If AdDescription > "" Then AdDescription = Replace( AdDescription, "%0A", vbcrlf ) End If
    If AdDescription > "" Then AdDescription = UrlDecode( AdDescription ) End If
	If AdReferences > "" Then AdReferences = Replace( AdReferences, "%0A", vbcrlf ) End If
	If AdReferences > "" Then AdReferences = UrlDecode( AdReferences ) End If
	
    AdByEmail        = Request.Cookies("tandgadform")("adbyemail")
    AdByPhone        = Request.Cookies("tandgadform")("adbyphone")
    AdEmail          = Request.Cookies("tandgadform")("ademail")
    AdPhone          = Request.Cookies("tandgadform")("adphone")
    AdContact        = Request.Cookies("tandgadform")("adcontact")
	
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
	
	Photo6Src        = Request.Cookies("tandgadform")("adphoto6")
	Photo6Len        = Len( Photo6Src )
	Photo6IsVert     = Request.Cookies("tandgadform")("adphoto6isvert")
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Photo1Image = Photo1Src
  Photo2Image = Photo2Src
  Photo3Image = Photo3Src
  Photo4Image = Photo4Src
  Photo5Image = Photo5Src
  Photo6Image = Photo6Src
  
  If Photo1Image = "" OR Photo1Image = "nopicsmall.png" OR Photo1Image = "NULL" OR Len( Photo1Image ) = "0" Then Photo1Image = "nopicsmall.png" Else Photo1Image = Photo1Image End If
  If Photo2Image = "" OR Photo2Image = "nopicsmall.png" OR Photo2Image = "NULL" OR Len( Photo2Image ) = "0" Then Photo2Image = "nopicsmall.png" Else Photo2Image = Photo2Image End If
  If Photo3Image = "" OR Photo3Image = "nopicsmall.png" Or Photo3Image = "NULL" OR Len( Photo3Image ) = "0" Then Photo3Image = "nopicsmall.png" Else Photo3Image = Photo3Image End If
  If Photo4Image = "" OR Photo4Image = "nopicsmall.png" Or Photo4Image = "NULL" OR Len( Photo4Image ) = "0" Then Photo4Image = "nopicsmall.png" Else Photo4Image = Photo4Image End If
  If Photo5Image = "" OR Photo5Image = "nopicsmall.png" Or Photo5Image = "NULL" OR Len( Photo5Image ) = "0" Then Photo5Image = "nopicsmall.png" Else Photo5Image = Photo5Image End If
  If Photo6Image = "" OR Photo6Image = "nopicsmall.png" Or Photo6Image = "NULL" OR Len( Photo6Image ) = "0" Then Photo6Image = "nopicsmall.png" Else Photo6Image = Photo6Image End If
  
  Photo1Src   = Photo1Image
  Photo2Src   = Photo2Image
  Photo3Src   = Photo3Image
  Photo4Src   = Photo4Image
  Photo5Src   = Photo5Image
  Photo6Src   = Photo6Image
  
  Photo1Html  = "<img src='/uploads/thumbs/" & Photo1Image & "' id='photo1img'/>"
  Photo2Html  = "<img src='/uploads/thumbs/" & Photo2Image & "' id='photo2img'/>"
  Photo3Html  = "<img src='/uploads/thumbs/" & Photo3Image & "' id='photo3img'/>"
  Photo4Html  = "<img src='/uploads/thumbs/" & Photo4Image & "' id='photo4img'/>"
  Photo5Html  = "<img src='/uploads/thumbs/" & Photo5Image & "' id='photo5img'/>"
  Photo6Html  = "<img src='/uploads/thumbs/" & Photo6Image & "' id='photo6img'/>"

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Photo1Src > "" AND Instr( Photo2Src, "nopicsmall.png" ) = "0" Then
    RemovePhoto1 = 1
  Else
    RemovePhoto1 = 0
  End If
  
  If Gal2Count > "0" AND Instr( Photo2Src, "nopicsmall.png" ) = "0" Then
    RemovePhoto2 = 1
  Else
    RemovePhoto2 = 0
  End If
	
  If Gal3Count > "0" AND Instr( Photo3Src, "nopicsmall.png" ) = "0" Then
    RemovePhoto3 = 1
  Else
    RemovePhoto3 = 0
  End If
	
  If Gal4Count > "0" AND Instr( Photo4Src, "nopicsmall.png" ) = "0" Then
    RemovePhoto4 = 1
  Else
    RemovePhoto4 = 0
  End If
	
  If Gal5Count > "0" AND Instr( Photo5Src, "nopicsmall.png" ) = "0" Then
    RemovePhoto5 = 1
  Else
    RemovePhoto5 = 0
  End If
  
  If Gal6Count > "0" AND Instr( Photo6Src, "nopicsmall.png" ) = "0" Then
    RemovePhoto6 = 1
  Else
    RemovePhoto6 = 0
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Edit Advert ~ Town and Gown Shortlets UK";
});
</script>


<script type='text/javascript'>
  document.observe("dom:loaded", function() {
  
  document.getElementById('title').value         = "<%=AdTitle%>";
  document.getElementById('nextday').value       = "<%=AdAvailDay%>";
  document.getElementById('nextmonth').value     = "<%=AdAvailMonth%>";
  document.getElementById('nextyear').value      = "<%=AdAvailYear%>";
  document.getElementById('rent').value          = "<%=AdRent%>";
  document.getElementById('period').value        = "<%=AdPeriod%>";
  document.getElementById('postcode').value      = "<%=AdPostCode%>";
  document.getElementById('location').value      = "<%=AdLocation%>";
  document.getElementById('propertytype').value  = "<%=AdProType%>";
  
  //var tempincbills = document.getElementById('incbills');
  //var incbills     = "<%=AdIncBills%>";
  //if ( incbills == "1" ) { tempincbills.checked = true; } else { tempincbills.checked = false; }
  
  document.getElementById('roomamount').value         = "<%=AdNoOfBeds%>";
  document.getElementById('photo1holder').innerHTML   = "<%=Photo1Html%>";
  document.getElementById('photo2holder').innerHTML   = "<%=Photo2Html%>";
  document.getElementById('photo3holder').innerHTML   = "<%=Photo3Html%>";
  document.getElementById('photo4holder').innerHTML   = "<%=Photo4Html%>";
  document.getElementById('photo5holder').innerHTML   = "<%=Photo5Html%>";
  document.getElementById('photo6holder').innerHTML = "<%=Photo6Html%>";
  
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
  document.getElementById('photo6value').value    = "<%=Photo6Src%>";
  document.getElementById('photo6isvert').value   = "<%=Photo6IsVert%>";
  
  $j('input:radio[name="incbills"]').filter('[value="<%=AdIncBills%>"]').attr('checked', true);
  });
</script>

<script type="text/javascript">
  document.observe("dom:loaded", function() {
  // show or hide remove photo
  
  var photo1remove = document.getElementById('photo1replace');
  var photo2remove = document.getElementById('photo2replace');
  var photo3remove = document.getElementById('photo3replace');
  var photo4remove = document.getElementById('photo4replace');
  var photo5remove = document.getElementById('photo5replace');
  var photo6remove = document.getElementById('photo6replace');
  
  var removephoto1 = "<%=RemovePhoto1%>";
  var removephoto2 = "<%=RemovePhoto2%>";
  var removephoto3 = "<%=RemovePhoto3%>";
  var removephoto4 = "<%=RemovePhoto4%>";
  var removephoto5 = "<%=RemovePhoto5%>";
  var removephoto6 = "<%=RemovePhoto6%>";
  
  if ( removephoto1 == "1" ){
    photo1remove.style.display    = "block";
	photo1uploader.style.display  = "none";
  } else {
    photo1remove.style.display    = "none";
	photo1uploader.style.display  = "block";
  }
  
  if ( removephoto2 == "1" ){
    photo2remove.style.display    = "block";
	photo2uploader.style.display  = "none";
  } else {
    photo2remove.style.display    = "none";
	photo2uploader.style.display  = "block";
  }
  
  if ( removephoto3 == "1" ){
    photo3remove.style.display    = "block";
	photo3uploader.style.display  = "none";
  } else {
    photo3remove.style.display    = "none";
	photo3uploader.style.display  = "block";
  }
  
  if ( removephoto4 == "1" ){
    photo4remove.style.display    = "block";
	photo4uploader.style.display  = "none";
  } else {
    photo4remove.style.display    = "none";
	photo4uploader.style.display  = "block";
  }
  
  if ( removephoto5 == "1" ){
    photo5remove.style.display    = "block";
	photo5uploader.style.display  = "none";
  } else {
    photo5remove.style.display    = "none";
	photo5uploader.style.display  = "block";
  }
  
  if ( removephoto6 == "1" ){
    photo6remove.style.display    = "block";
	photo6uploader.style.display  = "none";
  } else {
    photo6remove.style.display    = "none";
	photo6uploader.style.display  = "block";
  }
  
  });
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

<div class='contentheader2'>Edit Advert</div>
<div class='textblock' style='text-align:center; margin-top:30px;'><b>Use the form below to update your advert.</b><br/>Click the Preview Advert to preview and save your advert.<br/><br/></div>


<div class='createad_formholder' id='createadform'>

<span class='spacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Advert Title</span></span>
	<span class='cell'><input type='text' name='title' id='title' value='' autocomplete='off' placeholder='Required Field - 200 Characters maximum' class='input' onkeyup="limiter('title', '200', 'titlecount')" maxlength="200"/></span>
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
	<span class='cell'><input type='text' name='rent' id='rent' value='' autocomplete='off' class='inputsmall' placeholder='0.00'/></span>
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
  
  <span class='spacer'></span>
  
  <div class='row'>
    <div class='rowinner'>
	  <span class='cellinner' style='width:156px;'><span class='label'>Including Bills</span></span>
	  <span class='cellinner'><span class='labelinner'><input type='radio' name='incbills' id='incbills' value='1' autocomplete='off'/></span></span>
	</div>
	
	<div class='rowinner'>
	  <span class='cellinner' style='width:156px;'><span class='label'>Excluding Bills</span></span>
	  <span class='cellinner'><span class='labelinner'><input type='radio' name='incbills' id='incbills' value='0' autocomplete='off'/></span></span>
	</div>
  
  </div>
  
  <span class='spacer'></span>
  
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
	<option value='Other'>Other</option>
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
	<option value='Room'>Room</option>
	<%=RoomOption%>
	<option value='5'>5 +</option>
	</select>
	</span>
  </div>
  
    <span class='spacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Advert Description</span></span>
  </div>
  
  <div class='row'>
    <textarea class='textarealarge' name='description' id='description' autocomplete='off' placeholder='3500 characters maximum' onkeyup="limiter('description', '3500', 'descriptioncount')" maxlength="3500"><%=AdDescription%></textarea>
  </div>
  
  <div class='row'>
    <span class='cell'><span id='descriptioncount' class='textcount' style='margin-left:40px;'></span></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:250px;'><span class='label'>References for feedback (Optional)</span></span>
  </div>
  
  <div class='row'>
    <textarea class='textarealarge' name='references' id='references' autocomplete='off' placeholder='3500 characters maximum' onkeyup="limiter('references', '3500', 'referencecount')" maxlength="3500"><%=AdReferences%></textarea>
  </div>
  
  <span class='row'>
    <span class='cell'><span id='referencecount' class='textcount' style='margin-left:40px;'></span></span>
  </span>
  
  <span class='spacer'></span>
  
  <span class='formheader' style='border-top:solid 1px #deb865;'><span style='float:left;'>Add your Photos<br/><span style='font-size:14px; font-weight:normal;'>Photo 1 is your primary photo, this will appear on the advert list.<br/><b>IMPORTANT:</b> Do not browse away from the page while your photos are uploading.</span></span></span>
  <span class='spacer'></span>
  <!--#include virtual="/application/content/account/dsp_standalone_uploader.pl"-->
  <span class='spacer'></span>

  
<span class='formheader' style='border-top:solid 1px #deb865;'><span style='float:left;'>Contact Details</span></span>
  
  <div class='row'>
    <span class='forminstruction'><b>Please select at least one contact option for your ad</b><br/>Your email address won't appear on your advert.</span>
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
	<span class='cancelbutton' style='float:left; margin-left:10px;'><a href='<%=BackPath%>'><%=BackLabel%></a></span>
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

<input type='hidden' name='photo6value'   id='photo6value'    value='<%=Photo6Src%>'      autocomplete='off'/>
<input type='hidden' name='photo6isvert'  id='photo6isvert'   value='<%=Photo6IsVert%>'   autocomplete='off'/>

<input type='hidden' name='photo1width'   id='photo1width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo2width'   id='photo2width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo3width'   id='photo3width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo4width'   id='photo4width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo5width'   id='photo5width'    value=''                    autocomplete='off'/>
<input type='hidden' name='photo6width'   id='photo6width'    value=''                    autocomplete='off'/>

<input type='hidden' name='rpath'         id='rpath'          value='<%=RPath%>'          autocomplete='off'/>
<input type='hidden' name='saveaction'    id='saveaction'     value='2'                   autocomplete='off'/>
<input type='hidden' name='listingid'     id='listingid'      value='<%=ListingId%>'      autocomplete='off'/>
<input type='hidden' name='advertid'      id='advertid'       value='<%=AdvertId%>'       autocomplete='off'/>
<input type='hidden' name='fromlive'      id='fromlive'       value='<%=FromLive%>'       autocomplete='off'/>
<input type='hidden' name='fromsaved'     id='fromsaved'      value='<%=FromSaved%>'      autocomplete='off'/>
<input type='hidden' name='fromexpired'   id='fromexpired'    value='<%=FromExpired%>'    autocomplete='off'/>
<input type='hidden' name='fromdeleted'   id='fromdeleted'    value='<%=FromDeleted%>'    autocomplete='off'/>


<input type='hidden' name='contracttype' id='contracttype' value='2' autocomplete='off'/>











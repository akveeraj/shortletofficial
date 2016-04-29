<script src='/application/library/javascript/jscript/dropit.js' type='text/javascript'></script>
<link rel="stylesheet" type="text/css" href="/application/library/stylesheets/dropit.css" media="screen"/>


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query        = fw_Query 
  o_Query        = UrlDecode( o_Query )
  Rooms          = ParseCircuit( "rooms", o_Query )
  ShowDrop       = ParseCircuit( "showdrop", o_Query )
  SelectedCity   = Request.Cookies("tandgshortlets")("location")
  City           = ParseCircuit( "city", o_Query )
  
  If City > "" Then
    SelectedCity = City
	Response.Cookies("tandgshortlets")("location") = SelectedCity
	Response.Cookies("tandgshortlets")("norooms")  = Rooms
  ElseIf City = "" And SelectedCity > "" Then
    SelectedCity = SelectedCity
	Response.Cookies("tandgshortlets")("location") = SelectedCity
	Response.Cookies("tandgshortlets")("norooms")  = Rooms
  Else
    SelectedCity = "Oxford"
	Response.Cookies("tandgshortlets")("location") = SelectedCity
	Response.Cookies("tandgshortlets")("norooms")  = Rooms
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  UkSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM uk_cities"
          Call FetchData( UkSQL, UkRs, ConnTemp )
		  
  UkCount = UkRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write UK Cities
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If UkCount > "0" Then
  
    UkSQL = "SELECT * FROM uk_cities WHERE status='1' ORDER BY city ASC" 
	        Call FetchData( UkSQL, UkRs, ConnTemp )
	
    Do While Not UkRs.Eof	
      HrefId = Sha1(Timer()&Rnd())	
	  City   = UkRs("city")	
	  nCity  = City
	  nCity  = Replace( nCity, ".", "" )
	  nCity  = Replace( nCity, " ", "_" )
	  
	  'UkList  = UkList & "<span class='ukcities'><a href='/" & nCity & "/permalink/' onclick=""SetCity('" & City & "');"" title='" & City & "'>" & City & "</a></span>"
	  UkList  = UkList & "<span class='ukcities'>" & vbcrlf & "<a href='/" & nCity & "/permalink/' onclick=""DisableHref('" & HrefId & "'); SetCity('" & City & "');"" title='" & City & "' id='" & HrefId & "'>" & City & "</a>" & vbcrlf & "</span>" & vbcrlf & vbcrlf
    UkRs.MoveNext
	Loop
	
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write UK Options for drop down
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  UKOptSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM uk_cities"
             Call FetchData( UkOptSQL, UkOptRs, ConnTemp )
			 
  UkOptCount = UkOptRs("NumberOfRecords")
  
  If UkOptCount > "0" Then
  
    UkOptSQL = "SELECT * FROM uk_cities WHERE status='1' ORDER BY city ASC"
	           Call FetchData( UkOptSQL, UkOptRs, ConnTemp )
			   
	  Do While Not UkOptRs.Eof
	  
	    UKCity    = UkOptRs("city")
	    UkOptList = UkOptList & "<option value='" & UkCity & "'>" & UkCity & "</option>"
	  
	  UkOptRs.MoveNext
	  Loop
 
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Build City Dropdown Option
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  CityOptions = "<ul class='link' id='menu1'>" & vbcrlf & _
                "<li>" & vbcrlf & _
				"<a href='javascript://' onclick=""document.getElementById('menu2-drop').style.display = 'none';"">UK Properties</a>" & vbcrlf & _
				"<ul class='dropdown' style='display:none;' id='menu1-drop'>" & vbcrlf & _
				"<li style='font-size:12px; padding:10px; padding-left:10px; border-bottom:solid 4px #d4bb83; background:#ead4a3; text-transform:uppercase; text-align:left;'><b>Select a Location</b></li>" & vbcrlf & _
				"<li>" & vbcrlf & _
				"<span class='citylist'>" & vbcrlf & _
				UkList & vbcrlf & _
				"</span>" & vbcrlf & _
				"</li>" & vbcrlf & _
				"</ul>" & vbcrlf & _
				"</li>" & vbcrlf & _
				"</ul>" & vbcrlf & _
				"<span class='spacer'></span>" & vbcrlf & vbcrlf
				
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Build City Requirements Options
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    If SelectedCity = "" And City = "" Then
  
      RequirementOptions = "<span class='' id='dropmenu'><ul class='link' id='menu2'>" & vbcrlf & _
	                       "<li>" & vbcrlf & _
						   "<a href='javascript://'>Oxford Properties</a>" & vbcrlf & _
						   "<ul class='dropdown' style='display:none;' id='menu2-drop'>" & vbcrlf & _
						   "<li style='font-size:12; padding:10px; padding-left:10px; border-bottom:solid 4px #d4bb83; background:#ead4a3; margin-bottom:1px; text-transform:uppercase;'><b>Select your Requirements</b></li>" & vbcrlf & _
						   "<li>" & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('Room');"" title='Rooms'>Rooms</a></li>"      & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('Studio');"" title='Studio'>Studio</a></li>"   & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('1');"" title='1 Bedroom'>1 Bedroom</a></li>"     & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('2');"" title='2 Bedrooms'>2 Bedrooms</a></li>"    & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('3');"" title='3 Bedrooms'>3 Bedrooms</a></li>"    & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('4');"" title='4 Bedrooms'>4 Bedrooms</a></li>"    & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('5');"" title='5 Bedrooms'>5 Bedrooms +</a></li>"  & vbcrlf & _
						   "</li>" & vbcrlf & _
						   "</ul>" & vbcrlf & _
						   "</li>" & vbcrlf & _
						   "</ul></span>" & vbcrlf & _
						   "<input type='hidden' name='uklocation' id='uklocation' value='Oxford' autocomplete='off'/>" & vbcrlf & _
						   "<span class='spacer'></span>" & vbcrlf & vbcrlf
  
    Else 
  
      RequirementOptions = "<span class='' id='dropmenu'><ul class='link' id='menu2'>" & vbcrlf & _
	                       "<li>" & vbcrlf & _
						   "<a href='javascript://'>" & SelectedCity & "</a>"    & vbcrlf & _
						   "<ul class='dropdown' style='display:none;' id='menu2-drop'>"  & vbcrlf & _
						   "<li style='font-size:12px; padding:10px; padding-left:10px; border-bottom:solid 4px #d4bb83; background:#ead4a3; margin-bottom:1px; text-align:left; text-transform:uppercase;'><b>Select your Requirements</b></li>" & vbcrlf & _
						   "<li>" & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('Room');"" title='Rooms'>Rooms</a></li>"      & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('Studio');"" title='Studio'>Studio</a></li>"   & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('1');"" title='1 Bedroom'>1 Bedroom</a></li>"     & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('2');"" title='2 Bedrooms'>2 Bedrooms</a></li>"    & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('3');"" title='3 Bedrooms'>3 Bedrooms</a></li>"    & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('4');"" title='4 Bedrooms'>4 Bedrooms</a></li>"    & vbcrlf & _
						   "<li><a href='javascript://' onclick=""SelectCity('5');"" title='5 Bedrooms'>5 Bedrooms +</a></li>"  & vbcrlf & _
						   "</li>" & vbcrlf & _
						   "</ul>" & vbcrlf & _
						   "</li>" & vbcrlf & _
						   "</ul></span>" & vbcrlf & _
						   "<input type='hidden' name='uklocation' id='uklocation' value='" & SelectedCity & "' autocomplete='off'/>" & vbcrlf & _
						   "<span class='spacer'></span>" & vbcrlf & vbcrlf
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Build Header Links
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "" OR Var_LoggedIn = "0" Then
    HeaderLinks = "<span class='link' id='homelink'><a href='/'>Home</a></span>" & _
	              "<span class='spacer'></span>" & vbcrlf & _
				  CityOptions & vbcrlf & _
				  RequirementOptions & vbcrlf & _
	              "<span class='link' id='createlink'><a href='/register/doc/'>Create Account</a></span>" & _
	              "<span class='spacer'></span>" & _
				  "<span class='link' id='placelink'><a href='/dashboard/account/'>Place or Manage Ads</a></span>" & _
				  "<span class='spacer'></span>" & _
				  "<span class='link' id='adcostlink'><a href='/adcost/doc/'>Ad Cost</a></span>" & _
				  "<span class='spacer'></span>" & _
	              "<span class='link' id='alertservice'><a href='/alertservice/doc/'>Alert Service</a></span>" & _
				  "<span class='spacer'></span>" & _
				  "<span class='weathericon'><a href='http://www.metoffice.gov.uk/' title='Weather'></a></span>"
  
    LoggedInBox = ""
  
  Else
    
	HeaderLinks = "<span class='link' id='homelink'><a href='/'>Home</a></span>" & _
	              "<span class='spacer'></span>" & vbcrlf & _
		          CityOptions & vbcrlf & _
				  RequirementOptions & vbcrlf & _
				  "<span class='link' id='placelink'><a href='/dashboard/account/'>Place or Manage Ads</a></span>" & _
				  "<span class='spacer'></span>" & _
				  "<span class='link' id='adcostlink'><a href='/adcost/doc/'>Ad Cost</a></span>" & _
				  "<span class='spacer'></span>" & _
				  "<span class='link' id='alertservice'><a href='/alertservice/doc/'>Alert Service</a></span>" & _
                  "<span class='spacer'></span>" & _
				  "<span class='weathericon'><a href='http://www.metoffice.gov.uk/' title='Weather'></a></span>"
    
	LoggedInBox = "<div class='dash_menu' id='loggedin'>" & vbcrlf & _
	              "<b><span style='color:#ca0e3a;'>You are logged in</span> as " & Global_Firstname & "&nbsp;" & Global_Surname & "</b>" & vbcrlf & _
				  "<span style='float:right; margin-right:20px;'>" & vbcrlf & _
				  "<a href='/details/account/'>Edit Personal Details</a>" & vbcrlf & _
				  "&nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='/logout/actions/?output:1'>Log Out</a>" & vbcrlf & _
				  "</span>" & vbcrlf & _
	              "</div>"
	
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script src='/application/library/javascript/jscript/dropit.js' type='text/javascript'></script>
<link rel="stylesheet" type="text/css" href="/application/library/stylesheets/dropit.css" media="screen"/>
 
<script>
$j(document).ready(function() {
    $j('#menu1').dropit();
	$j('#menu2').dropit();
	<% If ShowDrop = "1" AND City > "" Then %>
	document.getElementById('menu2-drop').style.display = "block";
	<% End If %>
	var source = "<%=fw_Source%>";
	
	if ( source == ""  ) {
	  id       = "homelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	
	} else if ( source == "register" ) {
	  id       = "createlink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	
	} else if ( source == "place" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	
	} else if ( source == "login" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	  
	} else if ( source == "createadvert" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	  
	} else if ( source == "editadvert" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	
	} else if ( source == "dashboard" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	  
	} else if ( source == "previewadvert" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	  
	} else if ( source == "previeweditadvert" ) {
	  id       = "placelink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	
	} else if ( source == "adcost" ) {
	  id       = "adcostlink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	
	} else if ( source == "freetrial" ) {
	  id       = "triallink";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	  
	} else if ( source == "alertservice" ) {
	  id       = "alertservice";
	  newclass = "link_on";
	  SwapClass( id, newclass );
	 
	} else if ( source == "ukshortlets" ) {
	  id       = "dropmenu";
	  newclass = "dropmenu_on";
	  SwapClass( id, newclass );
	}
});

function SwapClass(id, newclass ) {
  var id        = document.getElementById(id);
  var newclass  = newclass; 
  id.className  = newclass;
}


$j(document).on('click', function (e) {
    if ($j(e.target).closest("#menu1-drop").length === 0) {
        $j("#menu1-drop").hide();
	}
});

$j(document).on('click', function (e) {
    if ($j(e.target).closest("#menu2-drop").length === 0) {
        $j("#menu2-drop").hide();
	}
});
     
</script>


<div class='header'></div>



<div class='header_holder'>
<%=HeaderLinks%>
</div>
<%=LoggedInBox%>


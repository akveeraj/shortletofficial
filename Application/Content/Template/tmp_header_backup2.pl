<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query   = fw_Query 
  o_Query   = UrlDecode( o_Query )
  City      = ParseCircuit( "city", o_Query )
  Rooms     = ParseCircuit( "rooms", o_Query )
  ShowDrop  = ParseCircuit( "showdrop", o_Query )

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
	  City = UkRs("city")	
	  UkList = UkList & "<span class='ukcities'><a href='javascript://' onclick=""SetCity('" & City & "');"" title='" & City & "'>" & City & "</a></span>"
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
%>




<script src='/application/library/javascript/jscript/dropit.js' type='text/javascript'></script>
<link rel="stylesheet" type="text/css" href="/application/library/stylesheets/dropit.css" media="screen"/>

<script>
$j(document).ready(function() {
    $j('#menu1').dropit();
	$j('#menu2').dropit();
	<% If ShowDrop = "1" Then %>
	document.getElementById('menu2-drop').style.display = "block";
	<% End If %>
});


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

<div class='header'><span class='reg_freetrial_small'><a href='/freetrial/doc/' title='Click for details'></a></span></div> 
<div class='toplinkholder' id='toplinkholder'>

<span class='link' style='margin-left:14px;'><a href='/'>Home</a></span>
<span class='spacer'></span>

<% If Global_Location > "" Then %>

<ul class='link' id='menu2'>
  <li>
    <a href='javascript://'><%=Var_Location%> Shortlets</a>
    <ul class='dropdown' style='display:none;' id='menu2-drop'>
	  <li style='font-size:12px; padding:10px; padding-left:10px; border-bottom:solid 3px #e2cea1;'><b>Select a Location</b></li>
	  <li>
	  <select name='uklocation' id='uklocation' autocomplete='off' class='select' onChange="SwapCity();">
	  <%=UkOptList%>
	  <% If Var_Location > "" Then %>
	  <option value='<%=Var_Location%>' selected><%=Var_Location%></option>
	  <% End If %>
	  </select>
	  </li>
	  <li style='font-size:12px; padding:10px; padding-left:10px; border-bottom:solid 3px #e2cea1;'><span id='dropselarea'><b><%=Var_Location%> Properties</b></span></li>
	  <li><a href='javascript://' onclick="SelectCity('1');">1 Bed</a></li>
	  <li><a href='javascript://' onclick="SelectCity('2');">2 Bed</a></li>
	  <li><a href='javascript://' onclick="SelectCity('3');">3 Bed</a></li>
	  <li><a href='javascript://' onclick="SelectCity('4');">4 Bed</a></li>
	  <li><a href='javascript://' onclick="SelectCity('5');">5 Bed +</a></li> 
	  <li><a href='javascript://' onclick="SelectCity('Studio');">Studio</a></li>
	</ul>
  
  </li>
</ul>

<% Else %>

<ul class='link' id='menu2'>
  <li>
    <a href='javascript://'>UK Shortlets</a>
    <ul class='dropdown' style='display:none;' id='menu2-drop'>
	  <li style='font-size:12px; padding:10px; padding-left:10px; border-bottom:solid 3px #e2cea1;'><b>Select a Location</b></li>
	  <li>
	  <span class='citylist'>
	  <%=UkList%>
	  </span>
	  </li>
	</ul>
  
  </li>
</ul>

<% End If %>


<span class='spacer'></span>

<ul class='link' id='menu1'>
  <li>
    <a href='javascript://'>Oxford Shortlets</a>
    <ul class='dropdown' style='display:none;' id='menu1-drop'>
	  <li><a href='/shortlets/doc/?city:Oxford;norooms:1'>1 Bed</a></li>
	  <li><a href='/shortlets/doc/?city:Oxford;norooms:2'>2 Bed</a></li>
	  <li><a href='/shortlets/doc/?city:Oxford;norooms:3'>3 Bed</a></li>
	  <li><a href='/shortlets/doc/?city:Oxford;norooms:4'>4 Bed</a></li>
	  <li><a href='/shortlets/doc/?city:Oxford;norooms:5'>5 Bed +</a></li> 
	  <li><a href='/shortlets/doc/?city:Oxford;norooms:Studio'>Studio</a></li>
	</ul>
  
  </li>
</ul>

<span class='spacer'></span>

<% If Var_LoggedIn = "" OR Var_LoggedIn = "0" Then %><span class='link'><a href='/register/doc/'>Create an Account</a></span><% End If %>
<% If Var_LoggedIn = "" OR Var_LoggedIn = "0" Then %><span class='spacer'></span><% End If %>
<span class='link'><a href='/createadvert/account/'>Place an Ad</a></span>
<span class='spacer'></span>
<span class='link'><a href='/adcost/doc/'>Ad Cost</a></span>
<span class='spacer'></span>
<% If Var_LoggedIn = "1" Then %><span class='link'><a href='/dashboard/account/'><span style='color:#ff0000;'>Manage my Ads</span></a></span> <% Else %><span class='link'><a href='/dashboard/account/'><span>Manage my Ads</span></a></span><% End If %>

</div>

<% If Var_LoggedIn = "1" Then %>
<div class='dash_menu'>
  <b>You are logged in as <%=Global_Firstname%>&nbsp;<%=Global_Surname%></b>
  &nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='/details/account/'>Edit Personal Details</a>
  &nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='/logout/actions/?output:1'>Log Out</a>
</div>
<% End If %>



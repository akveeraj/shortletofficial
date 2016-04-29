<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
  o_Query = UrlDecode( o_Query )
  Data    = ParseCircuit( "data", o_Query )
  
  If Data > "" Then Data = HexToString( Data ) End If
  
  nData   = Data
  nData   = Replace( nData, ";", vbcrlf )
  Email   = ParseCircuit( "email", nData )
  SubId   = ParseCircuit( "subid", nData )
  TxId    = ParseCircuit( "txid", nData )

// ---------------------------------------------------------------------------------------------------------
// ' Check Subscription
// ---------------------------------------------------------------------------------------------------------

  SubSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "'"
           Call FetchData( SubSQL, SubRs, ConnTemp )
		   
  SubCount = SubRs("NumberOfRecords")
  Call CloseRecord( SubRs, ConnTemp )
  
// --------------------------------------------------------------------------------------------------------------------------
// ' Get Subscription Details
// --------------------------------------------------------------------------------------------------------------------------

  If SubCount > "0" Then
  
    SubSQL = "SELECT * FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "'"
	         Call FetchData( SubSQL, SubRs, ConnTemp )
			 
			 SubEmail         = SubRs("email")
			 SubDesc          = SubRs("subdesc")
			 SubMethod        = SubRs("alertmethod")
			 SubId            = SubRs("subid")
			 SubExpDate       = SubRs("expirydate")
			 SubCity          = SubRs("city")
			 SubReq           = SubRs("requirement")
			 SubCountryCode   = SubRs("countrycode")
			 SubMobileNumber  = SubRs("mobile")
			 
			 If SubDesc > "" Then SubDesc = HexToString( SubDesc ) End If
			 If SubExpDate > "" Then SubExpDate = FormatDateTime( SubExpDate, 1 ) End If
			 
			 Call CloseRecord( SubRs, ConnTemp )
  
  End If

// --------------------------------------------------------------------------------------------------------------------------
// ' Build City List
// --------------------------------------------------------------------------------------------------------------------------

  AlertCitySQL = "SELECT * FROM uk_cities ORDER BY city ASC"
                 Call FetchData( AlertCitySQL, AlertCityRs, ConnTemp )
				 
  Do While Not AlertCityRs.Eof
    CityName      = AlertCityRs("city")
    AlertCityList = AlertCityList & "<option value='" & CityName & "'>" & CityName & "</option>"
  AlertCityRs.MoveNext
  Loop
  
  Call CloseRecord( AlertCityRs, ConnTemp )

// --------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
  var mobile = document.getElementById('mobile');
  var method = document.getElementById('method');
  
  if ( method.value == "1" ) {
    mobile.style.display = "none";
  }
  
});
</script>

<div class='contentheader2'>Amend your Property Alert Subscription</div>

<div class='textblock' style='border:solid 0px; width:550px; margin-top:30px; margin-bottom:0px; text-align:center;'>
  <b>Use the form below to update your subscription.</b>
</div>



<div class='createad_formholder' id='alertform' style='margin-top:5px; margin-bottom:5px;'>
<span class='spacer'></span>

  <div class='currentsub'>
    <div class='subrow'>
	  <span class='subcell' style='width:150px; text-align:right;'><b>Subscription:</b></span>
	  <span class='subcell'><%=SubDesc%></span>
	</div>
	
    <div class='subrow'>
	  <span class='subcell' style='width:150px; text-align:right;'><b>Expiry Date:</b></span>
	  <span class='subcell'><%=SubExpDate%></span>
	</div>
	
    <div class='subrow' style='border-bottom:solid 0px transparent;'>
	  <span class='subcell' style='width:150px; text-align:right;'><b>Subscription ID:</b></span>
	  <span class='subcell'><%=SubId%></span>
	</div>
	
	
  </div>
  
<span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>I'm looking for a</span></span>
	<span class='cell'>
	<select name='requirement' id='requirement' autocomplete='off' class='selectsmall'>
	  <option value='-'>- Select -</option>
	  <% If SubReq > "" Then %><option value='-'>------------</option><option value='<%=SubReq%>' selected><%=SubReq%></option><% End If %>
	  <option value='-'>------------</option>
	  <option value='Rooms'>Room</option>
	  <option value='Studio'>Studio</option>
	  <option value='1 Bed'>1 Bed</option>
	  <option value='2 Bed'>2 Bed</option>
	  <option value='3 Bed'>3 Bed</option>
	  <option value='4 Bed'>4 Bed</option>
	  <option value='5 Bed'>5 Bed</option>
	  <option value='6 Bed +'>6 Bed +</option>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>In Which City?</span></span>
	<span class='cell'>
	<select name='city' id='city' autocomplete='off' class='selectmedium'>
	<option value='-'>- Select City -</option>
	<% If SubCity > "" Then %><option value='-'>------------</option><option value='<%=SubCity%>' selected><%=SubCity%></option><% End If %>
	<option value='-'>------------</option>
	<%=AlertCityList%>
	</select>
	</span>
  </div>
  
  
  <div class='row'>
     <span class='cell' style='width:150px;'><span class='label'>My Email Address is</span></span>
	 <span class='cell'><input type='text' name='email' id='email' value='<%=SubEmail%>' autocomplete='off' class='inputmedium' placeholder='Enter a valid email address'/></span>
  </div>
  
  <div class='row' id='mobile'>
    <span class='cell' style='width:150px;'><span class='label'>Mobile Number +</span></span>
	<span class='cell'><input type='text' name='countrycode' id='countrycode' value='<%=SubCountryCode%>' autocomplete='off' style='width:60px;' class='inputsmall' placeholder='00'/></span>
	<span class='cell'><input type='text' name='mobilenumber' id='mobilenumber' value='<%=SubMobileNumber%>' autocomplete='off' style='width:260px;' class='inputmedium' placeholder='Enter mobile number without first zero'/></span>
  </div>
  
<span class='spacer'></span>


  <div class='row' id='alerttotalarea'>
  <span class='spacer'></span>
  <span class='alert_spacer'></span>
    <span class='cell' style='width:0px;'>&nbsp;</span>
    <span class='cell'><span id='totallabel' class='alert_totallabel' style='width:350px;'>&nbsp;</span></span>
	<span class='cell' style='float:right; display:none;' id='formwait'><span class='alert_formwait'>&nbsp;</span></span>
	<span class='cell' style='float:right;' id='processbutton'><span class='alert_ppbutton'><a href='javascript://' onclick="UpdateSubscription();">Update Subscription &gt;</a></span></span>
	<span class='spacer'></span>
  </div>
  
  
</div>


<input type='hidden' name='subid' id='subid' value='<%=SubId%>' autocomplete='off'/>
<input type='hidden' name='txid'  id='txid' value='<%=TxId%>' autocomplete='off'/>
<input type='hidden' name='method' id='method' value='<%=SubMethod%>' autocomplete='off'/>
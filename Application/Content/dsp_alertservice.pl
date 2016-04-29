<!--#include virtual="/includes.inc"-->

<link rel="stylesheet" href="/application/library/stylesheets/lightbox.css">
<%
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

<div class='contentheader2'>Alert Service</div> 

<div class='textblock' style='border:solid 0px; width:550px; margin-top:30px; margin-bottom:0px;'>
  If you are too busy to search the internet looking for a suitable short let, we can do the searching for you.<br/><br/>
  Simply fill in your requirements and Email Address below and then decide how many weeks you would like us to send you alerts, being anything from 1 to 4 weeks.<br/><br/>
</div>

<div class='createad_formholder' id='alertform' style='margin-top:5px; margin-bottom:5px;'>
<span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>I'm looking for a</span></span>
	<span class='cell'>
	<select name='requirement' id='requirement' autocomplete='off' class='selectsmall'>
	  <option value='-'>- Select -</option>
	  <option value='-'>------------</option>
	  <option value='Rooms'>Room</option>
	  <option value='Studio'>Studio</option>
	  <option value='1 Bed'>1 Bed</option>
	  <option value='2 Bed'>2 Bed</option>
	  <option value='3 Bed'>3 Bed</option>
	  <option value='4 Bed'>4 Bed</option>
	  <option value='5 Bed'>5 Bed +</option>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>In Which City?</span></span>
	<span class='cell'>
	<select name='city' id='city' autocomplete='off' class='selectmedium'>
	<option value='-'>- Select City -</option>
	<option value='-'>------------</option>
	<%=AlertCityList%>
	</select>
	</span>
  </div>
  
  <div class='row'>
     <span class='cell' style='width:150px;'><span class='label'>My Email Address is</span></span>
	 <span class='cell'><input type='text' name='email' id='email' value='' autocomplete='off' class='inputmedium' placeholder='Enter a valid email address'/></span>
  </div>
  
<span class='spacer'></span>
  
  <div class='row'>
     <span class='cell' style='width:150px;'><span class='label'>Option 1</span></span>
	 <span class='cell'><span class='label' style='text-align:left;'><input type='radio' name='alertmethod' id='alertmethod' value='1' autocomplete='off' onclick="SelectAlertType('1');  UpdateAlertPricing(); SwitchAlertDisclaimer()"/></span></span>
	 <span class='cell' style='width:330px; margin-left:5px; background:#e3c581; text-transform:uppercase;'><span class='alertlabel' style='text-align:left;'>Weekly Email Alert&nbsp;&nbsp;&nbsp;&middot;&nbsp;&nbsp;<span class='alertexample'><a href='/application/library/media/propertyalertsexample.png' data-lightbox="example-1" title='Email Alerts Example'>view example</a></span></span></span>
  </div>
  
<span class='spacer' style='height:6px;'></span>

  <div class='row'>
     <span class='cell' style='width:150px;'><span class='label'>Option 2</span></span>
	 <span class='cell'><span class='label' style='text-align:left;'><input type='radio' name='alertmethod' id='alertmethod' value='2'  autocomplete='off' onclick="SelectAlertType('2');  UpdateAlertPricing(); SwitchAlertDisclaimer()"/></span></span>
	 <span class='cell' style='width:330px; margin-left:5px; background:#e3c581; text-transform:uppercase;'>
	 <span class='alertlabel' style='text-align:left;'>Weekly Email Alert</span>
	 <span class='plus_sign'></span>
	 <span class='alertlabel'>Daily Text Alerts</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:180px;'>&nbsp;</span>
    <span class='cell'>
	
      <div class='infobox'>* Select Option 2 if your requirements are urgent.</div>
	
	</span>
  </div>
  

 
  
  <div id='mobile' style='display:none;'>

  
     <div class='row'>
	   <span class='cell' style='width:180px;'><span class='label'>Enter your Country Code</span></span>
	   <span class='cell'><span class='plus_sign'></span></span>
	   <span class='cell'><input type='text' name='countrycode' id='countrycode' value='' maxlength='5' autocomplete='off' style='width:95px;' class='inputsmall' placeholder='Country Code'/></span>
	   <span class='cell' style='margin-top:8px;'><span class='alertexample' style='font-weight:normal;'><a href='http://countrycode.org/' title='Find Country Code' target='_blank'>Find Country Code</a></span></span>
	 </div>
  
  
     <div class='row'>
	   <span class='cell' style='width:180px;'><span class='label'>Enter your Mobile Number</span></span>
	   <span class='cell' style='width:20px;'>&nbsp;</span>
	   <span class='cell'><input type='text' name='mobilenumber' id='mobilenumber' value='' autocomplete='off' style='width:260px;' class='inputmedium' placeholder="Enter your number without the first '0'"/></span>
	   <span class='spacer'></span>
	 </div>
	 
  </div>

<div id='durationarea' style='display:none;'>
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>Select Alert Duration</span></span>
	<span class='cell'><span class='label' style='text-align:left;'><input type='radio' name='duration' id='duration' value='7' autocomplete='off'  onclick="SelectAlertDuration('7'); UpdateAlertPricing();"/></span></span>
	<span class='cell' style='width:330px; margin-left:5px; background:#e3c581; text-transform:uppercase;'>
	  <span class='alertlabel' style='text-align:left;'>7 Day @ &pound;15.00</span><span id='price1'></span>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>&nbsp;</span></span>
	<span class='cell'><span class='label' style='text-align:left;'><input type='radio' name='duration' id='duration' value='14' autocomplete='off' onclick="SelectAlertDuration('14'); UpdateAlertPricing();"/></span></span>
	<span class='cell' style='width:330px; margin-left:5px; background:#e3c581; text-transform:uppercase;'>
	  <span class='alertlabel' style='text-align:left;'>14 Day @ &pound;30.00</span><span id='price2'></span>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>&nbsp;</span></span>
	<span class='cell'><span class='label' style='text-align:left;'><input type='radio' name='duration' id='duration' value='21' autocomplete='off'  onclick="SelectAlertDuration('21'); UpdateAlertPricing();"/></span></span>
	<span class='cell' style='width:330px; margin-left:5px; background:#e3c581; text-transform:uppercase;'>
	  <span class='alertlabel' style='text-align:left;'>21 Day @ &pound;45.00</span><span id='price3'></span>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:150px;'><span class='label'>&nbsp;</span></span>
	<span class='cell'><span class='label' style='text-align:left;'><input type='radio' name='duration' id='duration' value='28' autocomplete='off'  onclick="SelectAlertDuration('28'); UpdateAlertPricing();"/></span></span>
	<span class='cell' style='width:330px; margin-left:5px; background:#e3c581; text-transform:uppercase;'>
	  <span class='alertlabel' style='text-align:left;'>28 Day @ &pound;60.00</span><span id='price4'></span>
	</span>
    <span class='spacer'></span>
  </div>

</div>

<div class='row' id='alertwait' style='display:none;'>
  <span class='alert_wait'>&nbsp;</span>
</div>

  <div class='row' id='alerttotalarea' style='display:none;'>
  <span class='alert_spacer'></span>
  <span class='spacer'></span>
    <span class='cell' style='width:0px;'>&nbsp;</span>
    <span class='cell'><span id='totallabel' class='alert_totallabel' style='width:350px; line-height:2.5; font-weight:bold;'>&nbsp;</span></span>
	<span class='cell' style='float:right; display:none;' id='formwait'><span class='alert_formwait'>&nbsp;</span></span>
	<span class='cell' style='float:right; margin-right:10px; margin-top:70px;' id='processbutton'><span class='alert_ppbutton'><a href='javascript://' onclick="ProcessAlertPayment();">Now Process by PayPal</a></span></span>
	<span class='spacer'></span>
	<span class='alertdisclaimer' id='alertdisclaimer'></span>
  </div>

</div>

<div class='preview_paypallogo' id='paypallogo' style='display:none;'></div>

<input type='hidden' name='selectmethod'    id='selectmethod'   value='' autocomplete='off'/>
<input type='hidden' name='selectduration'  id='selectduration' value='' autocomplete='off'/>
<input type='hidden' name='alerttotal'      id='alerttotal'     value='' autocomplete='off'/>
<input type='hidden' name='alertdesc'       id='alertdesc'      value='' autocomplete='off'/>
<script src="/application/library/javascript/jscript/lightbox.js"></script>
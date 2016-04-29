<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query   = fw_Query
  RPath     = ParseCircuit( "rpath", o_Query )
  TrialMode = ParseCircuit( "trial", o_Query )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='contentheader2'>Create an Account</div>

<div class='textblock' style='width:500px; padding-top:25px; line-height:1.4em;'>
Before you can place an advert for your Shortlet Property, you need to Create an Account by 
filling in the form below.<br/><br/>

The email address you use will be the one replies to your Ad go to.<br/><br/>

<b>*Only Create an Account if you have a Property to Advertise.</b><br/><br/>

* If you are looking to Rent a Shortlet Property, click on the <br/>'UK Properties' title on the Home Page to select your City.<br/><br/>

</div>



<div class='reg_form' id='regform'>
  <span class='formheader'>Personal Details</span>
  <span class='formspacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Title</span></span>
	<span class='cell'>
	<select name='title' id='title' autocomplete='off' class='input'>
	<option value='-'>-- Select One --</option>
	<option value='Mr'>Mr</option>
	<option value='Mrs'>Mrs</option>
	<option value='Miss'>Miss</option>
	<option value='Ms'>Ms</option>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>First Name</span></span>
	<span class='cell'><input type='text' name='firstname' id='firstname' value='' autocomplete='off' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Surname</span></span>
	<span class='cell'><input type='text' name='surname' id='surname' value='' autocomplete='off' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Email Address</span></span>
	<span class='cell'><input type='text' name='email' id='email' value='' autocomplete='off' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Telephone Number</span></span>
	<span class='cell'><input type='text' name='telephone' id='telephone' value='' autocomplete='off' placeholder='Without spaces or special characters' class='input'/></span>
  </div>
  
<span class='formspacer'></span>
  
  <span class='formheader'>Set a Password</span>
  <span class='formspacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Password</span></span>
	<span class='cell'><input type='password' name='password' id='password' value='' autocomplete='off' class='input' placeholder='5 alphanumeric characters minimum'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Confirm Password</span></span>
	<span class='cell'><input type='password' name='password2' id='password2' value='' autocomplete='off' class='input' placeholder='Enter what you typed in the Password field'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'>&nbsp;</span>
	<span class='cell' style='width:338px;'>
	<span class='button' id='regbutton'><a href='javascript://' onclick="checkregistration();">Continue &gt;</a></span>
	<span class='wait' id='regwait' style='display:none;'>&nbsp;</span>
	</span>
  </div>
  
<span class='formspacer'></span>

  
</div>

<div class='textblock' style='margin-top:30px; width:500px;'>* Your info is not shared or sold to any third parties.</div>

<div style='display:block; width:100px; height:100px;'></div>
<input type='hidden' name='trial' id='trial' value='<%=TrialMode%>'/>
<input type='hidden' name='page' id='page' value='<%=RPath%>'/>
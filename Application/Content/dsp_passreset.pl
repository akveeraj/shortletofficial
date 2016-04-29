<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
  o_Query = UrlDecode( o_Query )
  RPath   = ParseCircuit( "rpath", o_Query )
  RPath   = "/login/doc/?rpath:" & RPath

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='contentheader2'>Reset Password</div>
<div class='textblock' style='border:solid 0px; margin-bottom:20px; margin-top:20px; text-align:center;'>
<b>Fill in the form below to request a password reminder.</b><br/>
Your password will be sent to your registered email address.
</div>

<div class='login_box' id='loginform'>
  <span class='login_box_spacer'></span>
  
  
  <span class='row'>
    <span class='cell'><span class='label'>Email Address</span></span>
	<span class='cell'><input type='text' name='username' id='username' value='' autocomplete='off' placeholder='Required Field' class='textbox'/></span>
  </span>
  
  <span class='row'>
    <span class='cell' style='width:109px; text-align:right;'>&nbsp;</span>
	<span class='link'><a href='<%=RPath%>'>Back to Log in</a></span>
	<span class='button' id='loginbutton'><a href='javascript://' onclick="resetpassword();">Continue &gt;</a></span>
	<span class='wait' id='loginwait' style='display:none;'></span>
  </span>
  
  
  <span class='login_box_spacer'></span>
</div>

<input type='hidden' name='returnpath' id='returnpath' value='<%=RPath%>'/>

<div class='contentmainspacer'></div>
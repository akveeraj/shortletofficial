<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query 
  o_Query      = UrlDecode( o_Query )
  RPath        = ParseCircuit( "rpath", o_Query )
  NotLoggedIn  = ParseCircuit( "loggedin", o_Query ) 
  
  If RPath > "" Then
    RegisterPath  = "/register/doc/?rpath:"  & RPath
	ForgotPath    = "/passreset/doc/?rpath:" & RPath
  Else
    RegisterPath  = "/register/doc/?rpath:"  & EncodeText( "dashboard/account/" )
	ForgotPath    = "/passreset/doc/?rpath:" & EncodeText( "dashboard/account/" )
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
<script type='text/javascript'>

$j(document).keypress(function(e) {
    if(e.which == 13) {
        validatelogin();
    }
});
</script>

<div class='contentheader2'>Place or Manage Ads</div>


<%
'<div class='textblock' style='text-align:center; margin-top:5px; padding-bottom:15px; border-bottom:solid 1px #eeeeee;'>
'Before you can Place or Manage your Ads, you need to <a href='/register/doc/'><b>Create An Account</b></a>.
'</div>
%>

<div class='textblock_centerwline'>
Before you can Place or Manage your Ads, you need to <a href='/register/doc/'><b>Create An Account</b></a>.
</div>

<div class='textblock_center' style='margin-top:30px; margin-bottom:25px;'>
<b>Login to Access your Account</b>
</div>


<div class='login_box' id='loginform' style='margin-top:0px;'>
  <span class='login_box_spacer'></span>
  
  
  <span class='row'>
    <span class='cell'><span class='label'>Email Address</span></span>
	<span class='cell'><input type='text' name='username' id='username' value='' autocomplete='off' placeholder='Required Field' class='textbox'/></span>
  </span>
  
  <span class='row'>
    <span class='cell'><span class='label'>Password</span></span>
	<span class='cell'><input type='password' name='password' id='password' value='' autocomplete='off' class='textbox' placeholder='Required Field'/></span>
  </span>
  
  <span class='row'>
    <span class='cell' style='width:109px; text-align:right;'>&nbsp;</span>
	<span class='link'><a href='<%=ForgotPath%>'>Forgot Password ?</a></span>
	<span class='button' id='loginbutton'><a href='javascript://' onclick="validatelogin();">Log in</a></span>
	<span class='wait' id='loginwait' style='display:none;'></span>
  </span>
  
  
  <span class='login_box_spacer'></span>
</div>

<input type='hidden' name='page' id='page' value='<%=RPath%>'/>

<div class='contentmainspacer'></div>
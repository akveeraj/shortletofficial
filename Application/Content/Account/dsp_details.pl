<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query   = fw_Query
  RPath     = ParseCircuit( "rpath", o_Query )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Personal Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  UserSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
            Call FetchData( UserSQL, UserRs, ConnTemp )
			
  UserCount = UserRs("NumberOFRecords")
  
  If UserCount > "0" Then
    DisplayForm = 1
	
	UserSQL = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
	          Call FetchData( UserSQL, UserRs, ConnTemp )
			  
			  Title      = UserRs("salutation")
			  FirstName  = UserRs("firstname")
			  Surname    = UserRs("surname")
			  Email      = UserRs("emailaddress")
			  Phone      = UserRs("telephone")
			  Password   = UserRs("password")
	
  Else
    DisplayForm = 0
  End If
  
  DeleteReturnUrl       = "/accountdeleted/doc/?deleted:1"
  DeleteReturnUrl       = StringToHex( DeleteReturnUrl )
  DeleteActionUrl       = "DoDeleteAccount('" & Var_UserId & "', '" & DeleteReturnUrl & "');"
  DeleteActionUrl       = StringToHex( DeleteActionUrl )
  DeletePromptText      = "<b>Are you sure you want to close your account?</b><br/><br/>This will remove your personal details and adverts. Click YES to continue."
  DeletePromptTitle     = "Close your Account?"

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Edit Personal Details ~ Town and Gown Shortlets. Oxford";
});
</script>

<script type='text/javascript'>
 function DeleteAccount(){
    PromptDelete('<%=DeleteActionUrl%>', '<%=DeletePromptText%>', '<%=DeletePromptTitle%>', '2');
 }
</script>

<% If UserCount > "0" Then %>

<div class='contentheader2'>Edit Personal Details</div>
<div class='textblock' style='text-align:center; margin-bottom:15px; margin-top:15px;'>Use the form below to update your personal details and change your password.</div>


<div class='reg_form' id='regform'>
  <span class='formheader'>Personal Details</span>
  <span class='formspacer'></span>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Title</span></span>
	<span class='cell'>
	<select name='title' id='title' autocomplete='off' class='input'>
	<option value='-'>-- Select One --</option>
	<% If Title > "" Then %>
	<option value='<%=Title%>' selected><%=Title%></option>
	<% End If %>
	<option value='Mr'>Mr</option>
	<option value='Mrs'>Mrs</option>
	<option value='Miss'>Miss</option>
	<option value='Ms'>Ms</option>
	</select>
	</span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>First Name</span></span>
	<span class='cell'><input type='text' name='firstname' id='firstname' value='<%=Firstname%>' autocomplete='off' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Surname</span></span>
	<span class='cell'><input type='text' name='surname' id='surname' value='<%=Surname%>' autocomplete='off' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Email Address</span></span>
	<span class='cell'><input type='text' name='email' id='email' value='<%=Email%>' autocomplete='off' class='input'/></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:130px;'><span class='label'>Telephone Number</span></span>
	<span class='cell'><input type='text' name='telephone' id='telephone' value='<%=Phone%>' autocomplete='off' placeholder='Without spaces or special characters' class='input'/></span>
  </div>
  
<span class='formspacer'></span>
  
  <span class='formheader'>Change Password<br/><span style='font-size:12px; font-weight:normal;'>Only enter a new password below if you intend on changing it.</span></span>
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
	<span class='button' id='regbutton'><a href='javascript://' onclick="updateregistration();">Save Details &gt;</a></span>
	<span class='wait' id='regwait' style='display:none;'>&nbsp;</span>
	</span>
  </div>
  
<span class='formspacer'></span>
  
  
</div>


<div class='contentheader2' style='margin-top:40px;'>Close your Account</div>
<div class='textblock' style='text-align:center; margin-bottom:100px;'>
Click the button below to close your account. This will delete all your personal details and adverts.<br/><br/>

  <span class='closeaccount'><a href='javascript://' onclick="DeleteAccount();">Close your Account</a></span>
  
</div>

<% Else %>

<span class='list_norecord'>We were unable to load your personal details, please ensure you are logged in.</span>

<% End If %>
<!--#include virtual="/includes.inc"-->
<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  Data       = ParseCircuit( "data", o_Query )
  Data       = HexToString( Data )
  Data       = Replace( Data, ";", vbcrlf )
  Email      = ParseCircuit( "email", Data )
  Firstname  = ParseCircuit( "name", Data )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script language="javascript" type="text/javascript"> 
function closeWindow() { 
var myWin = window.open('','_parent','');
myWin.close();
} 
</script>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Confirm Registration ~ Town and Gown Shortlets UK";
 
  if ($j("#loggedin").length === 1){
	$j("#loggedin").hide();
  }
  
  setTimeout(function(){document.location.href = "/"}, 300000);
 
});
</script>

<div class='contentheader2'>Confirm Registration</div>

<div class='createad_justregistered' style='margin-top:20px;'>
  <b>Thank you <%=Firstname%></b><br/>
  Your registration is almost complete, we have sent a message to you with a link to confirm your registration which you simply click on to complete your registration.<br/><br/>
  
  Your message should arrive within a few minutes, but please allow up to 20 minutes for it to arrive before requesting a new
   link and check your spam folder if you don't recieve it.<br/><br/>You may close this page once your account shows that it is active in a new window.
   &nbsp;&nbsp;<br/>This page will close automatically in 5 minutes.  

</div>
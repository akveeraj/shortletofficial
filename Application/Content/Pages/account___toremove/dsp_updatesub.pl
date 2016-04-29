<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  SandBox = 1
  
  If Sandbox = "1" Then
    PPUrl       = "https://www.sandbox.paypal.com/cgi-bin/webscr"
	PPEmail     = "paypal-facilitator@townandgownshortlets.co.uk"
  Else
    PPUrl       = "https://www.paypal.com/cgi-bin/webscr"
	PPEmail     = "paypal@townandgownshortlets.co.uk"
  End If
  
  ReturnUrl     = "http://" & Fw__FQDN & "/renewsub/actions/?output:1;data:"
  ReturnVars    = "cid:" & Var_UserId & ";fpp:1;requesttime:" & Var_DateStamp & ";duration:"
  CancelReturn  = "http://" & Fw__FQDN & "/subresponse/account/?response:2"
  AccExpired    = IsAccountExpired( Var_UserId, ConnTemp )
  RequestId     = Sha1(Timer()&Rnd())
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Renew your Subscription ~ Town and Gown Shortlets. Oxford";
});
</script>

<div class='contentheader2'>Renew your Subscription</div>

<% If AccExpired = "1" Then %>

<div class='textblock' style='margin-bottom:20px;'>
  <b>To renew your subscription, choose a subscription package from below.</b><br/>
  Your subscription does NOT auto-renew after expiry, so please be aware of this.
</div>

<div class='dash_subholder'>
  <span class='row'>
    <span class='cell' style='width:150px; margin-top:5px;'><b>1 Month subscription</b></span>
	<span class='cell' style='width:80px; margin-top:5px;'>&pound;30.00</span>
	<span class='cell'>


<form action="<%=PPUrl%>" method="post" id='sub1' name='sub1'>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="<%=PPEmail%>">
<input type="hidden" name="item_name_1" value="1 Month Subscription - Ref: <%=Var_PayRef%>/<%=Global_Email%> -  Town and Gown Shortlets">
<input type="hidden" name="amount_1" value="30.00">
<input type="hidden" name="return" id='return1' value="<%=ReturnUrl%><%=EncodeText(ReturnVars & "31;desc:1 Month Subscription")%>;amount:30.00" autocomplete='off'>
<span class='paypalbutton' id='paypalbutton1'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('1', '1 Month Subscription', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
<span class='wait' id='paypalwait1' style='display:none;'>Connecting to PayPal...</span>
<input type="hidden" name="currency_code" value="GBP">
<input type="hidden" name="lc" value="GB">
<input type="hidden" name="rm" value="1">
</form>



	
	</span>
  </span>
  
  <span class='row' style='background:#eeeeee;'>
    <span class='cell' style='width:150px; margin-top:5px;'><b>3 Month subscription</b></span>
	<span class='cell' style='width:80px; margin-top:5px;'>&pound;90.00</span>
	<span class='cell'>
<form action="<%=PPUrl%>" method="post" id='sub2' name='sub2'>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="<%=PPEmail%>">
<input type="hidden" name="item_name_1" value="3 Month Subscription - Ref: <%=Var_PayRef%>/<%=Global_Email%> -  Town and Gown Shortlets">
<input type="hidden" name="amount_1" value="90.00">
<input type="hidden" name="return" id='return2' value="<%=ReturnUrl%><%=EncodeText(ReturnVars & "93;desc:3 Month Subscription")%>;amount:90.00" autocomplete='off'>
<span class='paypalbutton' id='paypalbutton2'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('2', '3 Month Subscription', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
<span class='wait' id='paypalwait2' style='display:none;'>Connecting to PayPal...</span>
<input type="hidden" name="currency_code" value="GBP">
<input type="hidden" name="lc" value="GB">
<input type="hidden" name="rm" value="1">
</form>
	</span>
  </span>
  
  <span class='row'>
    <span class='cell' style='width:150px; margin-top:5px;'><b>6 Month subscription</b></span>
	<span class='cell' style='width:80px; margin-top:5px;'>&pound;180.00</span>
	<span class='cell'>
<form action="<%=PPUrl%>" method="post" id='sub3' name='sub3'>
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="upload" value="1">
<input type="hidden" name="business" value="<%=PPEmail%>">
<input type="hidden" name="item_name_1" value="6 Month Subscription - Ref: <%=Var_PayRef%>/<%=Global_Email%> -  Town and Gown Shortlets">
<input type="hidden" name="amount_1" value="180.00">
<input type="hidden" name="return" id='return3' value="<%=ReturnUrl%><%=EncodeText(ReturnVars & "186;desc:6 Month Subscription")%>;amount:180.00" autocomplete='off'>
<span class='paypalbutton' id='paypalbutton3'><a href='javascript://' title='Pay with PayPal' onclick="registerpayment('3', '6 Month Subscription', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
<span class='wait' id='paypalwait3' style='display:none;'>Connecting to PayPal...</span>
<input type="hidden" name="currency_code" value="GBP">
<input type="hidden" name="lc" value="GB">
<input type="hidden" name="rm" value="1">
</form>
</span>
  </span>


</div>

<% Else %>
<span class='dash_subexpired'>Your subscription has not yet expired.<br/><a href='/dashboard/account/'>Click here to return to My Adverts</a></span>
<% End If %>
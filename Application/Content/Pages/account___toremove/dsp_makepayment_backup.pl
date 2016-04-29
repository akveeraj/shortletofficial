<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
  o_Query     = UrlDecode( o_Query )
  ListingId   = ParseCircuit( "listingid", o_Query )
  AdvertId    = ParseCircuit( "advertid", o_Query )
  NewAdvert   = ParseCircuit( "newadvert", o_Query )

  SandBox = 1
  
  If Sandbox = "1" Then
    PPUrl      = "https://www.sandbox.paypal.com/cgi-bin/webscr"
	PPEmail    = "paypal-facilitator@townandgownshortlets.co.uk"
  Else
    PPUrl      = "https://www.paypal.com/cgi-bin/webscr"
	PPEmail    = "paypal@townandgownshortlets.co.uk"
  End If
  
  ReturnUrl    = "http://template.townandgownshortlets.co.uk/updatepayment/actions/?output:1;data:" 
  ReturnVars   = "cid:" & Var_UserId & ";listingid:" & ListingId & ";advertid:" & AdvertId & ";fpp:1;requesttime:" & Var_DateStamp & ";duration:"
  CancelReturn = "http://template.townandgownshortlets.co.uk/subresponse/account/?response:2"
  AdExpired    = IsAdvertExpired( ListingId, ConnTemp )
  RequestId    = Sha1(Timer()&Rnd())
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Pay for your advert ~ Town and Gown Shortlets. Oxford";
});
</script>

<div class='contentheader2'>Pay for your Advert</div>

<div class='textblock' style='margin-bottom:20px;'>
  <b>To pay for your advert, choose a package that suits your requirements.</b><br/>
  Your adverts does NOT auto-renew after expiry, so please be aware of this.
</div>





<div class='dash_subholder'>
<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b>Advert for 1 Week</b></span>
<span class='cell' style='width:80px; margin-top:5px;'>&pound;10.00</span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub1' name='sub1'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='Advert for 1 Week - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='10.00'/>
	<input type='hidden' name='return' id='return1' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & "7;featured:0;desc:Advert for 1 Week")%>;amount:10.00' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton1'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('1', '1 Advert for 1 Week ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait1' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span>
</span>


<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b>Advert for 1 Month</b></span>
<span class='cell' style='width:80px; margin-top:5px;'>&pound;25.00</span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub2' name='sub2'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='Advert for 1 Month - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='25.00'/>
	<input type='hidden' name='return' id='return2' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & "31;featured:0;desc:Advert for 1 Month")%>;amount:25.00' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton2'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('2', 'Advert for 1 Month ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait2' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span>
</span>


<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b>Advert for 3 Months</b></span>
<span class='cell' style='width:80px; margin-top:5px;'>&pound;50.00</span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub3' name='sub3'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='Advert for 3 Months - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='50.00'/>
	<input type='hidden' name='return' id='return3' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & "93;featured:0;desc:Advert for 3 Months")%>;amount:50.00' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton3'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('3', 'Advert for 3 Months ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait3' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span>
</span>

<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b>Advert for 6 Months</b></span>
<span class='cell' style='width:80px; margin-top:5px;'>&pound;100.00</span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub4' name='sub4'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='Advert for 6 Months - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='100.00'/>
	<input type='hidden' name='return' id='return4' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & "186;featured:0;desc:Advert for 6 Months")%>;amount:100.00' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton4'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('4', 'Advert for 6 Months ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait4' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span>
</span>


<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b>Advert for 12 Months</b></span>
<span class='cell' style='width:80px; margin-top:5px;'>&pound;100.00</span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub5' name='sub5'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='Advert for 12 Months - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='175.00'/>
	<input type='hidden' name='return' id='return5' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & "372;featured:0;desc:Advert for 12 Months")%>;amount:175.00' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton5'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('5', 'Advert for 12 Months ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait5' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span> 
</span>


<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b>Featured Advert for 14 Days</b></span>
<span class='cell' style='width:80px; margin-top:5px;'>&pound;25.00</span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub6' name='sub6'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='Featured Advert for 14 Days - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='25.00'/>
	<input type='hidden' name='return' id='return6' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & "14;featured:1;desc:Featured Advert for 14 Days")%>;amount:25.00' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton6'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('6', 'Featured Advert for 14 Days ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait6' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span>
</span>

</div>
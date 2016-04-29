<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
  o_Query     = UrlDecode( o_Query )
  ListingId   = ParseCircuit( "listingid", o_Query )
  AdvertId    = ParseCircuit( "advertid", o_Query )
  NewAdvert   = ParseCircuit( "newadvert", o_Query )
  FromCreate  = ParseCircuit( "fromcreate", o_Query )
  AdType      = ParseCircuit( "adtype", o_Query )

  SandBox = 0
  
  If Sandbox = "1" Then
    PPUrl      = "https://www.sandbox.paypal.com/cgi-bin/webscr"
	PPEmail    = "paypal-facilitator@townandgownshortlets.co.uk"
  Else
    PPUrl      = "https://www.paypal.com/cgi-bin/webscr"
	PPEmail    = "townandgowninfo@aol.com"
  End If
  
  ReturnUrl        = "http://" & FQDN & "/updatepayment/actions/?output:1;data:" 
  ReturnVars       = "cid:" & Var_UserId & ";listingid:" & ListingId & ";advertid:" & AdvertId & ";fpp:1;requesttime:" & Var_DateStamp & ";duration:"
  CancelReturn     = "http://" & FQDN & "/subresponse/account/?responsecode:1;listingid:" & ListingId & ";advertid:" & AdvertId
  AdExpired        = IsAdvertExpired( ListingId, ConnTemp )
  IsTrialExpired   = IsAccountExpired( Var_UserId, ConnTemp )
  RequestId        = Sha1(Timer()&Rnd())
  
  PaySQL       = "SELECT COUNT(uIndex) As NumberOfRecords FROM priceplans"
                 Call FetchData( PaySQL, PayRs, ConnTemp )
				 
  PayCount     = PayRs("NumberOfRecords")
  
  If PayCount > "0" Then
  
    PaySQL = "SELECT * FROM priceplans"
	         Call FetchData( PaySQL, PayRs, ConnTemp )
  
  End If

  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Pay for your Advert ~ Town and Gown Shortlets UK";
});
</script>



<div class='contentheader2'>Pay for your Advert</div>

<div class='textblock' style='margin-bottom:20px; text-align:center;'>
  <b>Choose an advert type and duration from the list below.</b><br/>
  Your adverts does NOT auto-renew after expiry, so please be aware of this.
</div>



<div class='dash_subholder'>

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If PayCount > "0" Then
    Do While Not PayRs.Eof
	Period    = PayRs("period")
	Price     = PayRs("price")
	LineId    = PayRs("lineid")
	Featured  = PayRs("featured")
	AdLength  = PayRs("adlength")

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<span class='row'>
<span class='cell' style='width:210px; margin-top:5px; font-size:14px; font-weight:bold;'><b><%=Period%></b></span>
<span class='cell' style='width:80px; margin-top:5px; color:green;'>&pound;<%=Price%></span>

<span class='cell'>

  <form action="<%=PPUrl%>" method="POST" id='sub<%=LineId%>' name='sub<%=LineId%>'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='<%=Period%> - Ref: <%=Var_PayRef%> / <%=Global_Email%> / Ad ID:<%=AdvertId%>'/>
	<input type='hidden' name='amount_1' value='<%=Price%>'/>
	<input type='hidden' name='return' id='return<%=LineId%>' value='<%=ReturnUrl%><%=EncodeText(ReturnVars & Adlength & ";featured:" & Featured & ";desc:" & Period )%>;amount:" & Price & "' autocomplete='off'/>
	<input type='hidden' name='cancel_return' id='cancel<%=LineId%>' value='<%=CancelReturn%>' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<span class='paypalbutton' id='paypalbutton<%=LineId%>'><a href='javascript://' title='Pay with PayPal'  onclick="registerpayment('<%=LineId%>', '<%=Period%> ( Ad ID:<%=AdvertId%> / Pay Ref: <%=Var_PayRef%> )', '<%=Var_PayRef%>', '<%=Var_UserId%>');">Pay with PayPal</a></span>
    <span class='wait' id='paypalwait<%=LineId%>' style='display:none;'>Connecting to PayPal...</span>
  </form>

</span>
</span>

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PayRs.MoveNext
  Loop

 End If
 
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

</div>
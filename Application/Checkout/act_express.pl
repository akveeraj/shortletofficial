<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->


<%
// ----------------------------------------------------------------------------------------------------------------------------------

  o_Query        = fw_Query
  o_Query        = UrlDecode( o_Query )
  Data           = ParseCircuit( "data", o_Query )
  Data           = HexToString( Data )
  nData          = Data
  nData          = Replace( nData, ";", vbcrlf )
  
  Desc           = ParseCircuit( "description", nData )
  Amount         = ParseCircuit( "amount", nData )
  ListingId      = ParseCircuit( "listingid", nData )
  AdvertId       = ParseCircuit( "advertid", nData )
  Duration       = ParseCircuit( "duration", nData )
  AdType         = ParseCircuit( "adtype", nData )
  PayRef         = Sha1( Timer() & Rnd() )
  PayRef         = Left( PayRef, 8 )
  PayRef         = UCase( PayRef )
  FromUpgrade    = ParseCircuit( "fromupgrade", nData )
  Tab            = ParseCircuit( "tab", nData )
  HostName       = Request.ServerVariables("HTTP_HOST")
  
  If FromUpgrade = "1" Then
  
  PayDescription = Desc & " - Ref: " & PayRef & " / " & Global_Email & " / " & "Advert ID: " & AdvertId
  MainDesc       = Desc
  
  CancelReturn   = "http://" & HostName & "/payresponse/checkout/?data:"
  CancelVars     = "tab:" & Tab & ";responsecode:1;listingid:" & ListingId & ";advertid:" & AdvertId & ";fromupgrade:" & FromUpgrade
  CancelVars     = StringToHex( CancelVars )
  CancelReturn   = CancelReturn & CancelVars
  
  ReturnUrl      = "http://" & HostName & "/updatepayment/checkout/?output:1;data:"
  ReturnVars     = "cid:" & Var_UserId & ";listingid:" & ListingId & ";advertid:" & AdvertId & ";fpp:1;requesttime:" & Var_DateStamp & ";duration:" & Duration & ";" & _
                   "featured:" & AdType & ";desc:" & MainDesc & ";amount:" & Amount
  ReturnVars     = StringToHex( ReturnVars )
  ReturnUrl      = ReturnUrl & ReturnVars
  
  ElseIf FromExpired = "1" Then
  
  PayDescription = Desc & " - Ref: " & PayRef & " / " & Global_Email & " / " & "Advert ID: " & AdvertId
  MainDesc       = Desc
  
  CancelReturn   = "http://" & HostName & "/payresponse/checkout/?data:"
  CancelVars     = "tab:" & Tab & ";responsecode:1;listingid:" & ListingId & ";advertid:" & AdvertId & ";fromexpired:" & FromExpired
  CancelVars     = StringToHex( CancelVars )
  CancelReturn   = CancelReturn & CancelVars
  
  ReturnUrl      = "http://" & HostName & "/updatepayment/checkout/?output:1;data:"
  ReturnVars     = "cid:" & Var_UserId & ";listingid:" & ListingId & ";advertid:" & AdvertId & ";fpp:1;requesttime:" & Var_DateStamp & ";duration:" & Duration & ";" & _
                   "featured:" & AdType & ";desc:" & MainDesc & ";amount:" & Amount
  ReturnVars     = StringToHex( ReturnVars )
  ReturnUrl      = ReturnUrl & ReturnVars
  
  Else
  
  PayDescription = Desc & " - Ref: " & PayRef & " / " & Global_Email & " / " & "Advert ID: " & AdvertId
  MainDesc       = Desc
  
  CancelReturn   = "http://" & HostName & "/payresponse/checkout/?data:"
  CancelVars     = "tab:" & Tab & ";responsecode:1;listingid:" & ListingId & ";advertid:" & AdvertId
  CancelVars     = StringToHex( CancelVars )
  CancelReturn   = CancelReturn & CancelVars
  
  ReturnUrl      = "http://" & HostName & "/updatepayment/checkout/?output:1;data:"
  ReturnVars     = "cid:" & Var_UserId & ";listingid:" & ListingId & ";advertid:" & AdvertId & ";fpp:1;requesttime:" & Var_DateStamp & ";duration:" & Duration & ";" & _
                   "featured:" & AdType & ";desc:" & MainDesc & ";amount:" & Amount
  ReturnVars     = StringToHex( ReturnVars )
  ReturnUrl      = ReturnUrl & ReturnVars
  
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Setup PayPal Endpoints
// ----------------------------------------------------------------------------------------------------------------------------------

  Sandbox = 0
  
  If Sandbox = "1" Then
    PPUrl    = "https://www.sandbox.paypal.com/cgi-bin/webscr"
	PPEmail  = "paypal-facilitator@smartervps.co.uk"
  Else
    PPUrl    = "https://www.paypal.com/cgi-bin/webscr"
	PPEmail  = "tgshortlets@aol.co.uk"
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
%>

<script>
  function paypalsubmit(){
    var paypalform = document.getElementById('paypalform');
	paypalform.submit();
  }
</script>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Pay for your Advert | Town and Gown Shortlets UK";
 paypalsubmit();

  if ($j("#loggedin").length === 1){
	$j("#loggedin").hide();
  }
 
});
</script>

<div class='contentheader2'>Pay for your Advert</div>


<div class='paypal_redirect'>

  <b>Connecting to PayPal...</b><br/><br/>
  <span class='small'><a href='javascript://' onclick="paypalsubmit();">Click here</a> if you are not redirected in a few seconds.<br/></span>
  <span class='small'>If you were creating an advert, this has been saved to your Saved Ads tab.</span>

</div>

<div class='preview_paypallogo' style='margin-top:20px;'></div>



  <form action="<%=PPUrl%>" method="POST" id='paypalform' name='sub<%=LineId%>'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='<%=PayDescription%>'/>
	<input type='hidden' name='amount_1' value='<%=Amount%>'/>
	<input type='hidden' name='return' id='return' value='<%=ReturnUrl%>' autocomplete='off'/>
	<input type='hidden' name='cancel_return' id='cancel' value='<%=CancelReturn%>' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<input type='hidden' name='no_shipping' value='1'/>
  </form>
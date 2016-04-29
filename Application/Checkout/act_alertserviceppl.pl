<!--#include virtual="/includes.inc"-->

<%
// ----------------------------------------------------------------------------------------------------------------------------------
  
  o_Query        = fw_Query
  o_Query        = UrlDecode( o_Query )
  oData          = ParseCircuit( "data", o_Query )
  Data           = ParseCircuit( "data", o_Query )
  Data           = HexToString( Data )
  nData          = Data
  nData          = Replace( nData, ";", vbcrlf )
  Req            = ParseCircuit( "req", nData )
  City           = ParseCircuit( "city", nData )
  Email          = ParseCircuit( "email", nData )
  Method         = ParseCircuit( "method", nData )
  Total          = ParseCircuit( "total", nData )
  Desc           = ParseCircuit( "desc", nData )
  Mobile         = ParseCircuit( "mobile", nData )
  CountryCode    = ParseCircuit( "countrycode", nData )
  TxId           = ParseCircuit( "txid", nData )
  TxId           = UCase( TxId )
  SubId          = ParseCircuit( "subid", nData )
  SubId          = UCase( SubId )
  ExpiryDate     = ParseCircuit( "expirydate", nData )
  ExpiryDateTime = ParseCircuit( "expirydatetime", nData )
  HostName       = Request.ServerVariables("HTTP_HOST")
 
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
  
  If oData > "" Then oData = HexToString( oData ) End If
  
  oData = oData & ";referrer:" & PPUrl
  
  If oData > "" Then oData = StringToHex( oData ) End If
  
  PayDescription  = Desc & " - " & Email & " - " & SubId
  MainDesc        = Desc
  
  CancelReturn    = "http://" & HostName & "/alertpaycancelled/checkout/?data:" & oData
  ReturnUrl       = "http://" & HostName & "/alertpayconfirm/checkout/?output:1;data:" & oData
 

// ----------------------------------------------------------------------------------------------------------------------------------
%>

<script>
  function paypalsubmit(){
    var paypalform = document.getElementById('paypalform');
	//paypalform.submit();
  }
</script>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Pay for your Alert Service Subscription | Town and Gown Shortlets UK";
 paypalformsubmit();

  if ($j("#loggedin").length === 1){
	$j("#loggedin").hide();
  }
 
});
</script>


<div class='contentheader2'>Pay for your Alert Service Subscription</div>
<div class='paypal_redirect'>

  <b>Connecting to PayPal...</b><br/><br/>
  <span class='small'><a href='javascript://' onclick="paypalformsubmit();">Click here</a> if you are not redirected in a few seconds.<br/></span>

</div>

<div class='preview_paypallogo' style='margin-top:20px;'></div>

  <form action="<%=PPUrl%>" method="POST" id='paypalform' name='sub<%=LineId%>'>
    <input type='hidden' name='cmd' value='_cart'/>
	<input type='hidden' name='upload' value='1'/>
	<input type='hidden' name='business' value='<%=PPEmail%>'/>
	<input type='hidden' name='item_name_1' value='<%=PayDescription%>'/>
	<input type='hidden' name='amount_1' value='<%=Total%>'/>
	<input type='hidden' name='return' id='return' value='<%=ReturnUrl%>' autocomplete='off'/>
	<input type='hidden' name='cancel_return' id='cancel' value='<%=CancelReturn%>' autocomplete='off'/>
	<input type='hidden' name='currency_code' value='GBP'/>
	<input type='hidden' name='1c' value='GB'/>
    <input type='hidden' name='rm' value='1'>
	<input type='hidden' name='no_shipping' value='1'/>
  </form>
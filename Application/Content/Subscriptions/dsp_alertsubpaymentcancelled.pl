<!--#include virtual="/includes.inc"-->

<%
// -------------------------------------------------------------------------------------------------------

  o_Query  = fw_Query
  o_Query  = UrlDecode( o_Query )
  Data     = ParseCircuit( "data", o_Query )



// -------------------------------------------------------------------------------------------------------
%>


<div class='contentheader2'>Payment Cancelled</div>

<div class='createad_justregistered' style='margin-top:20px;'>
<b>Your payment was cancelled.</b><br/>
You have not been charged.<br/><br/>

<a href='/alertserviceppl/checkout/?data:<%=Data%>'><b>Click here</b></a> to try your payment again.<br/>
Or<br/>
<a href='/alertservice/doc/?data:<%=Data%>'><b>Click here</b></a> to create a new Alert Service Subscription
</div>
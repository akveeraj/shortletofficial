<!--#include virtual="/includes.inc"-->

<%
// --------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
  o_Query = UrlDecode( o_Query )
  Data    = ParseCircuit( "data", o_Query )
  
  If Data > "" Then Data = HexToString( Data ) End If
  
  nData   = Data
  nData   = Replace( nData, ";", vbcrlf )
  TxId    = ParseCircuit( "txid", nData )
  SubId   = ParseCircuit( "subid", nData )
  Email   = ParseCircuit( "email", nData )

// --------------------------------------------------------------------------------------------------------------------------
%>

<div class='contentheader2'>Subscription Cancelled</div>

<div class='createad_justregistered' style='margin-top:20px;'>
  <b>Your Subscription was cancelled successfully</b>
  <br/>We have sent an email confirmation to <span style='color:#cc0000;'><b><%=Email%></b></span>
  <br/><br/><a href='/'><b>Click here</b></a> to return to the home page.
</div>
<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query         = fw_Query
  o_Query         = UrlDecode( o_Query )
  Data            = ParseCircuit( "data", o_Query )
  Data            = HexToString( Data )
  Data            = Replace( Data, ";", vbcrlf )
  Firstname       = ParseCircuit( "firstname", Data )
  CustomerId      = ParseCircuit( "customerid", Data )
  AccountClosed   = ParseCircuit( "accountclosed", Data )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='contentheader2' style='margin-bottom:20px;'>Account Closed</div>

<div class='createad_justregistered'>
<b>Your account has been closed.</b><br/> Thank you for using Town and Gown Shortlets UK.


</div>
<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
  o_Query     = UrlDecode( o_Query )
  Data        = ParseCircuit( "data", o_Query )
  Data        = HexToString( Data )
  Data        = Replace( Data, ";", vbcrlf )
  RCode       = ParseCircuit( "responsecode", Data )
  ListingId   = ParseCircuit( "listingid", Data )
  AdvertId    = ParseCircuit( "advertid", Data )
  FromUpgrade = ParseCircuit( "fromupgrade", Data )
  Tab         = ParseCircuit( "tab", Data )
  
  If Tab = "" Then
    Tab = "1" 
  End If
  
  If RCode = "1" Then
    Response.Redirect "/dashboard/account/?tab:" & Tab & ";rtab:" & Tab & ";paymentcancelled:1;listingid:" & ListingId & ";advertid:" & AdvertId & ";fromupgrade:" & FromUpgrade
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
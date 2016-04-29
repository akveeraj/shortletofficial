<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query         = Request.Form
  o_Query         = Replace( o_Query, ";", vbcrlf )
  CustomerId      = ParseCircuit( "customerid", o_Query )
  ListingId       = ParseCircuit( "listingid", o_Query )
  AdvertId        = ParseCircuit( "advertid", o_Query )
  PPlDesc         = ParseCircuit( "ppldesc", o_Query )
  PPlAmount       = ParseCircuit( "pplamount", o_Query )
  PPlDuration     = ParseCircuit( "pplduration", o_Query )
  PPlDuration     = CInt( PplDuration)
  AdType          = ParseCircuit( "adtype", o_Query )
  FromUpgrade     = ParseCircuit( "fromupgrade", o_Query )
  Tab             = ParseCircuit( "tab", o_Query )
  TrialRemaining  = TrialRemainingCount( Var_UserId, ConnTemp )
  TrialRemaining  = CInt( TrialRemaining )
  
  If TrialRemaining > "0" Then
    PPlDuration = TrialRemaining + PPlDuration
  End If
  
  If Tab = "" Then
    Tab = "0"
  Else
    Tab = Tab
  End If
  
  If FromUpgrade = "1" Then
    FromUpgrade = "1"
  Else
    FromUpgrade = "0"
  End If
  
  Data         = "tab:" & Tab & ";fromupgrade:" & FromUpgrade & ";duration:" & PPlDuration & ";description:" & PPlDesc & ";adtype:" & AdType & ";listingid:" & ListingId & ";advertid:" & AdvertId & ";amount:" & PPLAmount
  Data         = StringToHex( Data )
  EndPath      = "/express/checkout/?data:" & Data
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  JSOn = "{'endpoint':'" & EndPath & "'}"
  Response.Write JSOn
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
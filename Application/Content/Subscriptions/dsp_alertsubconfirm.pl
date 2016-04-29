<!--#include virtual="/includes.inc"-->

<%

  o_Query = fw_Query
  Data    = ParseCircuit( "data", o_Query )
  
  If Data > "" Then Data = HexToString( Data ) End If
  
  nData   = Data
  nData   = Replace( nData, ";", vbcrlf )
  SubId   = ParseCircuit( "subid", nData )
  TxId    = ParseCircuit( "txid", nData )
  RText   = ParseCircuit( "rtext", nData )
  RCode   = ParseCircuit( "rcode", nData )
  Paid    = ParseCircuit( "paid", nData )
  Email   = ParseCircuit( "email", nData )
				 
  If RCode < 15 Then
    
	ConfirmMessage = RText & "<br/>Your subscription ID is :" & SubId
  
  Else
  
    ConfirmMessage = "<b>Your Short Let Property Alert Subscription is now active.</b><br/><br/>" & _
	                 "We have sent a confirmation message and Receipt to <b><span style='color:#cc0000;'>" & Email & "</span></b><br/>" & _
					 "You will be notified when properties with your requirements are available via your chosen alert method.<br/><br/>" & _
					 "<a href='/'><b>Click here</b></a> to return to the home page."
  End If

%>

<div class='contentheader2'>Subscription Confirmation</div>



<div class='createad_justregistered' style='margin-top:20px;'>
<%=ConfirmMessage%>
</div>
<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  o_Query       = fw_Query
  o_Query       = UrlDecode( o_Query )
  ResponseCode  = ParseCircuit( "responsecode", o_Query )
  FromAds       = ParseCircuit( "fromads", o_Query )
  ListingId     = ParseCircuit( "listingid", o_Query )
  AdvertId      = ParseCircuit( "advertid", o_Query )
  
  If FromAds = "1" Then
    HeaderLabel = "Pay for your Advert"
  Else
    HeaderLabel = "Pay for your Advert"
  End If
  
  Select Case( ResponseCode )
    Case(1)
	  Response.Redirect "/dashboard/account/?paymentcancelled:1;listingid:" & ListingId & ";advertid:" & AdvertId
	Case(2)
	  Response.Redirect "/dashboard/account/?paymentsuccess:1;listingid:" & ListingId & ";advertid:" & AdvertId
	Case Else
	  RMessage = "<b>Something went wrong</b><br/><a href='/dashboard/account/'>Return to My Adverts</a>"
  End Select
  
  'Select Case( ResponseCode )
 '   Case(1)
'	  RMessage = "<b>Your subscription was updated successfully</b>.<br/>A receipt for your purchase has been emailed to you.<br/>" & _
'	             "You may log in to your account at www.paypal.com to view details of this transaction."
'	Case(2)
'	  RMessage = "<b>Your payment was cancelled</b><br/><a href='/updatesub/account/'>Click here</a> to return to subscription options."
'	Case(3)
'	  RMessage = "<b>Your payment was successful</b><br/>A receipt for your purchase has been emailed to you.<br/>" & _
'	             "You may log in to your account at www.paypal.com to view details of this transaction."
'	Case Else
'	  RMessage = "<b>Sorry, something went wrong</b><br/><a href='/updatesub/account/'>Click here</a> to return to your Adverts."
  'End Select
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='textblock' style='margin-bottom:20px;'>
<%=RMessage%><br/><br/>
</div>
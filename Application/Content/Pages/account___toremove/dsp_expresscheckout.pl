<!--#include virtual="/includes.inc"-->


<%
// ----------------------------------------------------------------------------------------------------------------------------------

  o_Query     = fw_Query
  o_Query     = UrlDecode( o_Query )
  ListingId   = ParseCircuit( "listingid", o_Query )
  AdvertId    = ParseCircuit( "advertid", o_Query )
  NewAdvert   = ParseCircuit( "newadvert", o_Query )
  FromCreate  = ParseCircuit( "fromcreate", o_Query )
  AdType      = ParseCircuit( "adtype", o_Query )
  
  SandBox     = 1
  
  If SandBox = "1" Then
    PayPalUrl = "https://api.sandbox.paypal.com"
  Else
    PayPalUrl = "https://api-3t.paypal.com/nvp"
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------

  PayPalPassword = "elysium08512"
  PayPalUser     = "paypal-facilitator@smartervps.co.uk"
  PayPalSig      = "EGtxbxBtDQaoBaqiD-HmrDCt3auMVCE9M1NmAWgcsiKHtVdi2cZX0xA0vGIr"
  Amount         = "19.95"
  CurrencyCode   = "GBP"
  ReturnUrl      = ""
  CancelUrl      = ""
  Description    = ""
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Make First API Call
// ----------------------------------------------------------------------------------------------------------------------------------

  Params = "Accept=application/json" & _
           "&Accept-Language= en_US"  & _
		   "&grant_type=client_credentials"
		   
  ClientId  = "paypal_api1.smartervps.co.uk"
  SecretKey = "ZHZUHRRLS4MNQKS5"
  
  TokenUrl = "https://api.sandbox.paypal.com/v1/oauth2/token"
  
  'TokenResponse = CurlNoAuth( TokenUrl, "POST", params, "application/x-www-form-urlencoded" )
  

'curl -v https://api.sandbox.paypal.com/v1/oauth2/token \
 ' -H "Accept: application/json" \
 ' -H "Accept-Language: en_US" \
 ' -u "EOJ2S-Z6OoN_le_KS1d75wsZ6y0SFdVsY9183IvxFyZp:EClusMEUk8e9ihI7ZdVLF5cZ6y0SFdVsY9183IvxFyZp" \
 ' -d "grant_type=client_credentials"
			   
// ----------------------------------------------------------------------------------------------------------------------------------
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' MAKE API CALL
// ----------------------------------------------------------------------------------------------------------------------------------

'curl -s --insecure https://api-3t.sandbox.paypal.com/nvp -d
'"USER=<callerID>                         # User ID of the PayPal caller account
'&PWD=<callerPswd>                        # Password of the caller account
'&SIGNATURE=<callerSig>                   # Signature of the caller account
'&METHOD=SetExpressCheckout
'&VERSION=93
'&PAYMENTREQUEST_0_PAYMENTACTION=SALE     # type of payment
'&PAYMENTREQUEST_0_AMT=19.95              # amount of transaction
'&PAYMENTREQUEST_0_CURRENCYCODE=USD       # currency of transaction
'&RETURNURL=http://www.example.com/success.html  # URL of your payment confirmation page
'&CANCELURL=http://www.example.com/cancel.html"  # URL redirect if customer cancels payment



%>
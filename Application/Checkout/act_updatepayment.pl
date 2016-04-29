<!--#include virtual="/includes.inc"-->

<%
// ----------------------------------------------------------------------------------------------------------------------------------

  o_Query   = fw_Query
  o_Query   = UrlDecode( o_Query )
  Data      = ParseCircuit( "data", o_Query )
  Data      = HexToString( Data )
  Data      = Replace( Data, ";", vbcrlf )
  
  CId       = ParseCircuit( "cid", Data )
  ListingId = ParseCircuit( "listingid", Data )
  AdvertId  = ParseCircuit( "advertid", Data )
  FromPPal  = ParseCircuit( "fpp", Data )
  ReqTime   = ParseCircuit( "requesttime", Data )
  Duration  = ParseCircuit( "duration", Data )
  Featured  = ParseCircuit( "featured", Data )
  Desc      = ParseCircuit( "desc", Data )
  Amount    = ParseCircuit( "amount", Data )
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Check Listing ID
// ----------------------------------------------------------------------------------------------------------------------------------

  ListSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
              Call FetchData( ListSQL, ListRs, ConnTemp )
			
  ListCount = ListRs("NumberOfRecords")
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ----------------------------------------------------------------------------------------------------------------------------------

  If CId = "" Then
    Proceed = 0
	RCode   = 1
	RText   = "An expected parameter `CID` is missing, Check your email for payment confirmation"
  ElseIf ListingId = "" Then
    Proceed = 0
	RCode   = 2
	RText   = "An expected parameter `LISTINGID` is missing, Check your email for payment confirmation"
  ElseIf ListCount = "0" Then
    Proceed = 0
	RCode   = 3
	RText   = "The listing id passed could not be found on our system. It may have been removed."
  ElseIf AdvertId = "" Then
    Proceed = 0
	RCode   = 4
	RText   = "An expected parameter `ADVERTID` is missing, Check your email for payment confirmation"
  ElseIf FromPPal = "" OR FromPPal = "0" Then
    Proceed = 0
	RCode   = 5
	RText   = "An expected parameter `FROMPPAL` is missing, Check your email for payment confirmation"
  ElseIf ReqTime = "" Then
    Proceed = 0
	RCode   = 6
	RText   = "An expected parameter `REQTIME` is missing, Check your email for payment confirmation"
  ElseIf Duration = "" Then
    Proceed = 0
	RCode   = 7
	RText   = "An expected parameter `DURATION` is missing, Check your email for payment confirmation"
  ElseIf Featured = "" Then
    Proceed = 0
	RCode   = 8
	RText   = "An expected parameter `FEATURED` is missing, Check your email for payment confirmation"
  ElseIf Desc = "" Then
    Proceed = 0
	RCode   = 9
	RText   = "An expected parameter `DESC` is missing, Check your email for payment confirmation"
  ElseIf Amount = "" Then
    Proceed = 0
	RCode   = 10
	RText   = "An expected parameter `AMOUNT` is missing, Check your email for payment confirmation"
  Else
    Proceed = 1
	RCode   = 11
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Set Duration
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Duration > "" Then
    PaidUntil         = DateAdd( "d", Duration, Var_DateNoTimeStamp )
	nPaidUntil        = Split( PaidUntil, "/" )
	PaidDay           = nPaidUntil(0)
	PaidMonth         = nPaidUntil(1)
	PaidYear          = nPaidUntil(2)
	PaidYear          = Left( PaidYear, 4 )
	PaidUntil         = PaidYear & "-" & PaidMonth & "-" & PaidDay & " " & Time
	PaidUntilNoTime   = PaidYear & "-" & PaidMonth & "-" & PaidDay
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------
// ' Update Payment
// ----------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
  DateStamp   = Var_DateStamp
  DateStamp   = Left( DateStamp, 10 )

  UdSQL = "UPDATE shortlets SET " & _
          "adexpires='" & PaidUntil & "', adexpiry='" & PaidUntilNoTime & "', datetimestamp='" & Var_DateStamp & "', datestamp='" & DateStamp & "', " & _
		  "adduration='" & Duration & "', advertpaid='1', featured='" & Featured & "', paymentdescription='" & Desc & "', status='1' " & _
          "WHERE advertid='" & AdvertId & "' AND listingid='" & ListingId & "'"
		  Call SaveRecord( UdSQL, UdRs, ConnTemp )
		  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Kill Cookies
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
  
    Response.Cookies("tandgadform")("adtitle")           = ""
    Response.Cookies("tandgadform")("availday")          = ""
    Response.Cookies("tandgadform")("availmonth")        = ""
    Response.Cookies("tandgadform")("availyear")         = ""
    Response.Cookies("tandgadform")("adrent")            = ""
    Response.Cookies("tandgadform")("adperiod")          = ""
    Response.Cookies("tandgadform")("adincbills")        = ""
    Response.Cookies("tandgadform")("adpostcode")        = ""
    Response.Cookies("tandgadform")("adlocation")        = ""
    Response.Cookies("tandgadform")("adprotype")         = ""
    Response.Cookies("tandgadform")("adnoofbeds")        = ""
    Response.Cookies("tandgadform")("addescription")     = ""
    Response.Cookies("tandgadform")("adbyemail")         = ""
    Response.Cookies("tandgadform")("adbyphone")         = ""
    Response.Cookies("tandgadform")("ademail")           = ""
    Response.Cookies("tandgadform")("adphone")           = ""
	Response.Cookies("tandgadform")("adcontact")         = ""
    Response.Cookies("tandgadform")("adphoto1")          = ""
    Response.Cookies("tandgadform")("adphoto2")          = ""
    Response.Cookies("tandgadform")("adphoto3")          = ""
    Response.Cookies("tandgadform")("adphoto4")          = ""
    Response.Cookies("tandgadform")("adphoto5")          = ""
    Response.Cookies("tandgadform")("adphoto1isvert")    = ""
    Response.Cookies("tandgadform")("adphoto2isvert")    = ""
    Response.Cookies("tandgadform")("adphoto3isvert")    = ""
    Response.Cookies("tandgadform")("adphoto4isvert")    = ""
    Response.Cookies("tandgadform")("adphoto5isvert")    = ""
	Response.Cookies("tandgadform")("adphoto1width")     = ""
	Response.Cookies("tandgadform")("adphoto2width")     = ""
	Response.Cookies("tandgadform")("adphoto3width")     = ""
	Response.Cookies("tandgadform")("adphoto4width")     = ""
	Response.Cookies("tandgadform")("adphoto5width")     = ""
	Response.Cookies("tandgadform")("adsaveaction")      = ""
	Response.Cookies("tandgadform")("adtype")            = ""
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Redirect
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
    Response.Redirect "/dashboard/account/?paymentsuccess:1;listingid:" & ListingId & ";advertid:" & AdvertId
  Else
    Response.Redirect "/dashboard/account/?payerror:1;errortext:" & RText & ";listingid:" & ListingId & ";advertid:" & AdvertId
  End If

// ----------------------------------------------------------------------------------------------------------------------------------
%>
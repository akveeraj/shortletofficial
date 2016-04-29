<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"--> 


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  o_Query     = fw_Query
  o_Query     = UrlDecode( o_Query )
  Data        = ParseCircuit( "data", o_Query )
  Data        = DecodeText( Data )
  Data        = Replace( Data, ";", vbcrlf )
  CId         = ParseCircuit( "cid", Data )
  ListingId   = ParseCircuit( "listingid", Data )
  AdvertId    = ParseCircuit( "advertid", Data )
  FPP         = ParseCircuit( "fpp", Data )
  ReqTime     = ParseCircuit( "requesttime", Data )
  Duration    = ParseCircuit( "duration", Data )
  Featured    = ParseCircuit( "featured", Data )
  Desc        = ParseCircuit( "desc", Data )
  Desc        = StringToHex( Desc )
  Amount      = ParseCircuit( "amount", o_Query )
  RequestId   = ParseCircuit( "requestid", o_Query )
  DateStamp   = Var_DateStamp
  DateStamp   = Left( DateStamp, 10 )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
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
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ListSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
              Call FetchData( ListSQL, ListRs, ConnTemp )
			
  ListCount = ListRs("NumberOfRecords")
			
  ReqSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM renewalrequests WHERE requestid='" & RequestId & "'"
              Call FetchData( ReqSQL, ReqRs, ConnTemp )
			
  ReqCount = ReqRs("NumberOfRecords")
			
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If ListCount = "0" Then
    Proceed = 0
	RCode   = 1
	Response.Redirect "/subresponse/actions/?responsecode:4"
  
  ElseIf FPP = "" Then
    Proced  = 0
	RCode   = 2
	Response.Redirect "/subresponse/actions/?responsecode:4"
  
  ElseIf ReqCount = "0" Then
    Proceed = 0
	RCode   = 3
	Response.Redirect "/subresponse/actions/?responsecode:4"
  
  Else
    Proceed = 1
	RCode   = 3 
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Advert
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then

  UdSQL = "UPDATE shortlets SET " & _
          "adexpires='" & PaidUntil & "', adexpiry='" & PaidUntilNoTime & "', datetimestamp='" & Var_DateStamp & "', datestamp='" & DateStamp & "', adduration='" & Duration & "', advertpaid='1', featured='" & Featured & "', paymentdescription='" & Desc & "' " & _
          "WHERE advertid='" & AdvertId & "' AND listingid='" & ListingId & "'"
		  Call SaveRecord( UdSQL, UdRs, ConnTemp )
		  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Original Request
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND ReqCount > "0" Then
  
    DelSQL = "DELETE FROM renewalrequests WHERE requestid='" & RequestId & "'"
	         Call SaveRecord( DelSQL, DelRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Redirect
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
    Response.Redirect "/subresponse/account/?responsecode:2;fromads:1"
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
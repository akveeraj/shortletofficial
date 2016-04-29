<!--#include virtual="/includes.inc"-->



<%
// -----------------------------------------------------------------------------------------------------------------------------

  o_Query     = Request.Form
  o_Query     = UrlDecode( o_Query )
  o_Query     = Replace( o_Query, ";", vbcrlf )
  ListingId   = ParseCircuit( "listingid", o_Query )
  ReturnUrl   = ParseCircuit( "returnurl", o_Query )
  
  If ReturnUrl > "" Then ReturnUrl = HexToString( ReturnUrl ) End If
  
// -----------------------------------------------------------------------------------------------------------------------------
// ' Advert Count
// -----------------------------------------------------------------------------------------------------------------------------

  AdSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
            Call FetchData( AdSQL, AdRs, ConnTemp )
		  
  AdCount = AdRs("NumberOfRecords")
  
// -----------------------------------------------------------------------------------------------------------------------------
// ' Get Advert Details
// -----------------------------------------------------------------------------------------------------------------------------

  If AdCount > "0" Then
    AdSQL = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "'"
	        Call FetchData( AdSQL, AdRs, ConnTemp )
			Photo = AdRs("photo")
  End If
  
// -----------------------------------------------------------------------------------------------------------------------------
// ' Validate
// -----------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "" Or Var_LoggedIn = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that, <a href=""javascript://"" onclick=""document.location.reload();"">click here</a> to log in."
	RText   = UrlEncode( RText )
	
  ElseIf ListingId = "" Or AdCount = "0" Then
    Proceed = 0
	RCode   = 2
	RText   = "The advert could not be found, it may have been deleted or a temporary error occurred"
	
  ElseIf ReturnUrl = "" Then
    Proceed = 0
	RCode   = 3
	RText   = "Something went wrong, we will try our best to fix the problem as soon as possible"
	
  Else
    Proceed = 1
	RCode   = 4
	RText   = "OK"
  End If
  
// -----------------------------------------------------------------------------------------------------------------------------
// ' Restore Advert
// -----------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
  UdSQL = "UPDATE shortlets SET " & _
          "status='1' " & _
		  "WHERE listingid='" & ListingId & "'"
		  Call SaveRecord( UdSQL, UdRs, ConnTemp )
  End If
  
// -----------------------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// -----------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rtext':'" & RText & "', 'rcode':'" & RCode & "', 'proceed':'" & Proceed & "', 'rpath':'" & ReturnUrl & "'}"
  Response.Write JSOn

// -----------------------------------------------------------------------------------------------------------------------------
%>
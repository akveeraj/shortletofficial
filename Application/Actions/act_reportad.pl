<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = Request.Form
  o_Query    = Replace( o_Query, "&", ";" )
  o_Query    = Replace( o_Query, ";", vbcrlf )
  ListingId  = ParseCircuit( "listingid", o_Query )
  RPath      = ParseCircuit( "rpath", o_Query )
  ReportId   = Sha1( Timer() & Rnd() )
  Reason     = ParseCircuit( "reason", o_Query )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
  
  If RPath = "" Then
    RPath = "/" 
  Else
    RPath = RPath
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Advert Details
// ---------------------------------------------------------------------------------------------------------------------------------------------

  AdSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
            Call FetchData( AdSQL, AdRs, ConnTemp )
		  
  AdCount = AdRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------

  If AdCount = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "The advert could not be found. It may have been removed."
  Else
    Proceed = 1
	RCode   = 2
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Send Report
// ---------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    AddSQL = "INSERT INTO reportedads " & _
	         "( listingid, reportid, dateadded, reason ) " & _
			 " VALUES( " & _
			 "'" & ListingId     & "', " & _
			 "'" & ReportId      & "', " & _
			 "'" & Var_DateStamp & "', " & _
			 "'" & Reason        & "' "  & _
			 " )"
			 Call SaveRecord( AddSQL, AddRs, ConnTemp )
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// ---------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'rpath':'" & RPath & "'}"
  Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------------------------------------------------------
%>
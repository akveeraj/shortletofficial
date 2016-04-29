<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
  ListingId    = ParseCircuit( "listingid", o_Query )
  AdvertId     = ParseCircuit( "advertid", o_Query )
  WithOptions  = ParseCircuit( "withoptions", o_Query )
  Tab          = ParseCircuit( "tab", o_Query )
  Repost       = ParseCircuit( "repost", o_Query )
  
  If Repost = "" Then
    Repost = "0"
  Else
    Repost = "1"
  End If
  
  If Tab = "" Then
    Tab = "1"
  Else
    Tab = Tab
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  SQL = "SELECT Count(uIndex) AS NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
        Call FetchData( SQL, SQLRs, ConnTemp )
		
  SQLCount = SQLRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If SQLCount > "0" Then
  
    SQL = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "'"
	      Call FetchData( SQL, SQLRs, ConnTemp )
		  
	      Data    = SQLRs("checkoutdata")
		  AdType  = SQLRs("featured")
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If SQLCount > "0" AND WithOptions = "" OR SQLCount > "0" AND WithOptions = "" Then
    Response.Redirect "/express/checkout/?data:" & Data & ";adtype:" & AdType
  ElseIf SQLCount > "0" AND WithOptions = "1" Then
    Response.Redirect "/expresswithoptions/checkout/?repost:" & Repost & ";tab:" & Tab & ";listingid:" & ListingId & ";adtype:" & AdType & ";advertid:" & AdvertId
  Else
    Response.Redirect "/dashboard/account/"
  End If


// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
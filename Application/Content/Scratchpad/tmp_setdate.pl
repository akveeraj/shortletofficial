<!--#include virtual="/includes.inc"-->

<%
// -----------------------------------------------------------------------------------------------------------------------------

  SQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE adexpires < CURRENT_TIMESTAMP() AND NOT STATUS='0'"
        'Call FetchData( SQL, RsTemp, ConnTemp )
		'RCount = RsTemp("NumberOfRecords")
		
		'Call CloseRecord( RsTemp, ConnTemp )
		
  SQL = "SELECT * FROM shortlets WHERE adexpires < CURRENT_TIMESTAMP() AND NOT STATUS='0'"
        'Call FetchData( SQL, RsTemp, ConnTemp )
		
  'Do While Not RsTemp.Eof
  
   ' AdvertId   = RsTemp("advertid")
	'ListingId  = RsTemp("listingid")
	
	'AdSQL = AdSQL & "UPDATE shortlets SET " & _
	               ' "adexpires='2018-03-01 15:19:44', adexpiry='2018-03-01'" & _
			        '"WHERE advertid='" & AdvertId & "' AND listingid='" & ListingId & "';" & vbcrlf
  
 ' RsTemp.MoveNext
  'Loop
  
  'Response.Write AdSQL
  
  
  
  

  'SQL = "SELECT * FROM shortlets WHERE datetimestamp < CURRENT_TIMESTAMP()"
        'Call FetchData( SQL, RsTemp, ConnTemp )
		
		'LineNumber = 0
		'Do While NOT RsTemp.Eof
		  'LineNumber   = CInt(LineNumber) + 1
		  'LastChecked  = "2015-02-01 11:00:00"
		  'ShortLetId   = RsTemp("listingid")
		  
		'nSQL = ""
		
		'Response.Write LineNumber & "<br/>"
		
		'RsTemp.MoveNext
		'Loop
		
		'Call CloseRecord( RsTemp, ConnTemp )

// -----------------------------------------------------------------------------------------------------------------------------
%>
<!--#include virtual="/includes.inc"-->

<%
//--------------------------------------------------------------------------------------------------------------------------------
// ' GET LISTINGS
//--------------------------------------------------------------------------------------------------------------------------------

  SQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE nextyear LIKE '%2014%' AND NOT customerid='35bc79581b3c891b2d158ffdafe98500cabe551e'"
        Call FetchData( SQL, RsTemp, ConnTemp )
		
  ShortCount = RsTemp("NumberOfRecords")
  Call CloseRecord( RsTemp, ConnTemp )

  If ShortCount > "0" Then
  
  SQL = "SELECT * FROM shortlets WHERE nextyear LIKE '%2014%' AND NOT customerid='35bc79581b3c891b2d158ffdafe98500cabe551e'"
        Call FetchData( SQL, RsTemp, ConnTemp )
		
		Do While Not RsTemp.Eof
		  
		  AdvertId   = RsTemp("advertid")
		  CustomerId = RsTemp("customerid")
		  
		  UpdSQL = UpdSQL & "UPDATE shortlets SET " & _
		           "nextmonth='03', nextyear='2015' " & _
				   " WHERE customerid='" & CustomerId & "' AND advertid='" & AdvertId & "';" & vbcrlf
		
		
		RsTemp.MoveNext
		Loop
		
		Response.Write UpdSQL
		
		Call CloseRecord( RsTemp, ConnTemp )
		
  End If

//--------------------------------------------------------------------------------------------------------------------------------
%>
<!--#include virtual="/includes.inc"-->
<%

  SQL = "SELECT * FROM uk_cities" 
        Call FetchData( SQL, RsTemp, ConnTemp )
		
  Do While Not RsTemp.Eof
    City       = RsTemp("city")
	nCity      = City
	nCity      = Replace( nCity, ".", "" )
	nCity      = Replace( nCity, " ", "_" )
	
	'Robots = Robots & "Allow: /" & nCity & "/permalink/" & vbcrlf 
	
  RsTemp.MoveNext
  Loop
  Response.Write Robots
%>
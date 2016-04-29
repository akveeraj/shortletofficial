<!--#include virtual="/includes.inc"-->


<%

  SQL       = "SELECT COUNT(uIndex) As NumberOfRecords FROM recommendedservices WHERE logo='avis.png'"
              Call FetchData( SQL, RsTemp, ConnTemp )
		
  LogoCount = RsTemp("NumberOfRecords")
  
  SQL = "SELECT * FROM recommendedservices WHERE logo='avis.png'"
        Call FetchData( SQL, RsTemp, ConnTemp )
  
  Do While Not RsTemp.Eof
  
    'uIndex = RsTemp("uIndex")
	Location = RsTemp("location")
	
	Response.Write Location & "<br/>"
  
  RsTemp.MoveNext
  Loop



%>
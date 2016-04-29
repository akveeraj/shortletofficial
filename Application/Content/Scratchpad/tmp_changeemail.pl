<--#include virtual="/includes.inc"-->


<%

'  mysql = "select * from MEMBERS"
'  Call FetchData( mysql, rstemp, conntemp )
  
'  Do while not rstemp.eof 
  
'  UpdSQL = "UPDATE SET shortlets " & _ 
'           "email='tgshortlets@aol.co.uk'
'		   Call SaveRecord(updsql, rstemp, conntemp )
  

  
  'rsTemp.MoveNext
  'Loop
  
  mysql = "SELECT * FROM shortlets"
          Call FetchData( mysql, rstemp, conntemp )
		  
  LineId = 0
		  
  Do While Not RsTemp.Eof
    LineId = CInt(LineId)+1
  
  
    UpdSQL = "UPDATE SET shortlets "
	         "email='tgshortlets@aol.com' " & _
			 "WHERE ____ = ''"
  
  RsTemp.MoveNext 
  Loop 
  




%>
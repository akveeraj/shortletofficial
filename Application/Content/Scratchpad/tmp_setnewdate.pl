<!--#include virtual="/includes.inc"-->

<%
// --------------------------------------------------------------------------------------------

  
  AccSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members"
             Call FetchData( AccSQL, AccRs, ConnTemp )
  
  AccCount = AccRs("NumberOfRecords")
  
  Call CloseRecord( AccRs, ConnTemp )
  
// --------------------------------------------------------------------------------------------
  
  If AccCount > "0" Then
  
    AccSQL = "SELECT * FROM members"
	         Call FetchData( AccSQL, AccRs, ConnTemp )
			 
	Do While NOT AccRs.Eof
	  
	  CustomerID = AccRs("customerid")

	  UpdSQL = "UPDATE members SET " & _
	           "lastexpirycheck='2015-03-01', lastexpirychecktime='2015-03-01 11:00:01' " & _
			   "WHERE customerid='" & CustomerId & "'"
			   Call SaveRecord( UpdSQL, UpdRs, ConnTemp )
               Call CloseRecord( UpdRs, ConnTemp )
			   
	AccRs.MoveNext
	Loop
	
	Call CloseRecord( AccRs, ConnTemp )
	
  End If
  
// --------------------------------------------------------------------------------------------
%>
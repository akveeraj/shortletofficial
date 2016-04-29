<!--#include virtual="/includes.inc"-->

<%

  SQL = "SELECT * FROM uk_cities"
        Call FetchData( SQL, RsTemp, ConnTemp )
		
  Do While Not RsTemp.Eof
    City       = RsTemp("city")
    SelectList = SelectList & "    Case(""" & City & """)" & vbcrlf & _
	                          "      TopMenuWidth=""0px"""  & vbcrlf
  RsTemp.MoveNext
  Loop
  
  Response.Write SelectList

%>
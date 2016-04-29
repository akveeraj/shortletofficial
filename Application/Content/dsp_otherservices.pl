<%
// -------------------------------------------------------------------------------------------------------------------
  
  ServiceLocation = ParseCircuit( "city", o_Query )
  
  ServSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM recommendedservices WHERE location='" & ServiceLocation & "'"
              Call FetchData( ServSQL, ServRs, ConnTemp )
			
  ServCount = ServRs("NumberOfRecords")
			
  ServSQL   = "SELECT * FROM recommendedservices WHERE location='" & ServiceLocation & "' ORDER BY ordernumber ASC"
              Call FetchData( ServSQL, ServRs, ConnTemp )
			  
  If ServCount > "0" Then
  
    AdCount = 0
  
    Do While Not ServRs.Eof
	    AdCount = CInt(AdCount) + 1
	  
	  If AdCount = 5 OR AdCount = 10 OR AdCount = 15 OR AdCount = 20 OR AdCount = 25 Then 
	    ServiceStyle = ""
	  Else
	    ServiceStyle = "<span class='services_logo_spacer'></span>"
	  End If
	  
	  ServiceLocation = ServRs("location")
	  ServiceLogo     = ServRs("logo")
	  ServiceLogo     = ServiceLocation & "/" & ServiceLogo
	  ServiceTitle    = ServRs("linktitle")
	  ServiceUrl      = ServRs("link")
	  ServiceLinks    = ServiceLinks &  "<span class='services_logo'><a href='" & ServiceUrl & "' target='_blank' title=""" & ServiceTitle & """><img src='/application/library/media/servicelogos/" & ServiceLogo & "'/></a></span>" & vbcrlf & vbcrlf  & _
	                                    ServiceStyle
	
    ServRs.MoveNext
    Loop	
  
  End If

// -------------------------------------------------------------------------------------------------------------------
%>


<% If ServCount > "0" Then %>
<div class='services_header'>Recommended Services</div>


<div class='services_holder'>
  <%=ServiceLinks%>
</div>
<% End If %>
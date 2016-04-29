<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  UkSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM uk_cities"
          Call FetchData( UkSQL, UkRs, ConnTemp )
		  
  UkCount = UkRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write UK Cities
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If UkCount > "0" Then
  
    UkSQL = "SELECT * FROM uk_cities ORDER BY city ASC"
	        Call FetchData( UkSQL, UkRs, ConnTemp )
	
    Do While Not UkRs.Eof		
	  City = UkRs("city")	
	  UkList = UkList & "<span class='ukcities'><option value='" & City & "'>" & City & "</option></span>"
    UkRs.MoveNext
	Loop
	
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='ukshortholder'>
  
  <!-- left content -->
  <span class='cell' style='width:260px;'>
  <span class='selectlocation'>Select a Location</span>
  
  <span class='formrow'>
  <span class='formcell'>
  <select name='uklocation' id='uklocation' autocomplete='off' class='dropdown'>
  <% If Var_Location > "" Then %>
  <option value='<%=Var_Location%>' selected><%=Var_Location%></option>
  <% End If %>
  <%=UkList%>
  </select>
  </span>
  </span>
  
  
  
  </span>
  <!-- end left content -->
  
  
  <!-- right content -->
  
  <span class='cell' style='width:266px; border-left:solid 4px #baa573;'>
  
  
  <span class='selectlocation' style='margin-left:5px;'>Requirements</span>
  
  <span class='formrow'>
  <span class='formcell' style='width:120px;'><span class='label'><b>Property Type</b></span></span>
  <span class='formcell'>
  <select name='ukprotype' id='ukprotype' autocomplete='off'>
  <% If Var_ProType > "" Then %>
  <option value='<%=Var_ProType%>' selected><%=Var_ProType%></option>
  <% End If%>
  <option value='House'>House</option>
  <option value='Flat'>Flat</option></select>
  </span>
  </span>
  
  <span class='formrow'>
  <span class='formcell' style='width:120px;'><span class='label'><b>Number of Rooms</b></span></span>
  <span class='formcell'>
  <select name='uknorooms' id='uknorooms' autocomplete='off'>
  <% If Var_NoRooms > "" Then %>
  <option value='<%=Var_NoRooms%>' selected><%=Var_NoRooms%></option>
  <% End If%>
  <option value='Studio'>Studio</option>
  <option value='1'>1</option>
  <option value='2'>2</option>
  <option value='3'>3</option>
  <option value='4'>4</option>
  <option value='5 Plus'>5 Plus</option>
  </select>
  </span>
  </span>
  
  <span class='formrow'>
  <span class='formcell' style='width:120px;'><span class='label'><b>Rental Frequency</b></span></span>
  <span class='formcell'>
  <select name='ukrentfrequency' id='ukrentfrequency' autocomplete='off'>
  <% If Var_RentFrequency > "" Then %>
  <option value='<%=Var_RentFrequency%>' selected><%=Var_RentFrequency%></option>
  <% End If %>
  <option value='Weekly'>Weekly</option>
  <option value='Monthly'>Monthly</option>
  </select>
  </span>
  </span>
  
  
  </span>
  
  <!-- end right content -->
 
</div>

  <div class='ukshortfooter'>
    <span class='closebutton'><a href='javascript://' onclick="CloseModalBox();">Close</a></span>
	<span class='continuebutton'><a href='javascript://' onclick="SelectCity();">Continue &gt;</a></span>
  
  </div>

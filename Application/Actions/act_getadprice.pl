<!--#include virtual="/includes.inc"-->

<%
// ----------------------------------------------------------------------------------------------------------------------------------------

  o_Query             = fw_Query 
  o_Query             = UrlDecode( o_Query )
  AdType              = ParseCircuit( "adtype", o_Query )
  ByPassTrial         = ParseCircuit( "bypasstrial", o_Query )
  IsTrialExpired      = IsAccountExpired( Var_UserId, ConnTemp )
  TrialDaysRemaining  = Var_TrialLength
  
// ----------------------------------------------------------------------------------------------------------------------------------------
  
  If BypassTrial = "" Then
    BypassTrial = "0"
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------------

  AccSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
           Call FetchData( AccSQL, AccRs, ConnTemp )
		   
  AccCount = AccRs("NumberOfRecords")
  
  If AccCount > "0" Then
  
    AccSQL = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
	         Call FetchData( AccSQL, AccRs, ConnTemp )
			 ExpiryDate    = AccRs("paiduntilnostamp")
			 ExpiryDate    = Replace( ExpiryDate, "/", "-" )
			 nExpiryDate   = AccRs("paiduntilnostamp")
			 SubDesc       = AccRs("subdescription")
			 
			 If nExpiryDate > "" Then
			 DaysRemaining = CalcDaysPassed( nExpiryDate )
			 DaysRemaining = Replace( DaysRemaining, "-", "" )
			 DaysRemaining = CInt( DaysRemaining )
			 End If
  
  End If
  
// ----------------------------------------------------------------------------------------------------------------------------------------

  FeaturedList       = "<option value='7'>1 Week Featured Ad - &pound;15.00</option>" & _
                       "<option value='14'>2 Week Featured Ad - &pound;30.00</option>" & _
					   "<option value='30'>1 Month Featured Ad - &pound;45.00</option>" & _
					   "<option value='93'>3 Month Featured Ad - &pound;120.00</option>"  & _
					   "<option value='186'>6 Month Featured Ad - &pound;200.00</option>" 
  
  StandardList       = "<option value='7'>1 Week Standard Ad - &pound;7.50</option>" & _
                       "<option value='14'>2 Week Standard Ad - &pound;15.00</option>" & _
					   "<option value='30'>1 Month Standard Ad - &pound;25.00</option>" & _
					   "<option value='93'>3 Month Standard Ad - &pound;60.00</option>" & _
					   "<option value='186'>6 Month Standard Ad - &pound;100.00</option>"
  
  StandardListTrial  = "<option value='" & DaysRemaining & "'>Standard Ad - " & DaysRemaining & " Days - Free Trial Option</option>"
  
  
  If BypassTrial = "1" Then
  
    If AdType = "1" Then
    AdDuration = "<b>Select your Advert Duration</b><br/>" & _
	             "<select name='duration' id='duration' autocomplete='off' class='selectmedium' style='margin-top:8px;' onchange=""setppcheckout('" & AdType & "', '" & ByPassTrial & "');"">" & _
				 "<option value='-'>-- Select One --</option>" & _
				 "<option value='-'>-------------------------------------------------</option>" & _
				 FeaturedList & _
				 "</select>"
	ElseIf AdType = "0" Then
	AdDuration = "<b>Select your Advert Duration</b><br/>" & _
	             "<select name='duration' id='duration' autocomplete='off' class='selectmedium' style='margin-top:8px;' onchange=""setppcheckout('" & AdType & "', '" & ByPassTrial & "');"">" & _
				 "<option value='-'>-- Select One --</option>" & _
				 "<option value='-'>-------------------------------------------------</option>" & _
				 StandardList & _
				 "</select>"
	End If
  
  
  
  Else 


  If AdType = "1" Then
  
    AdDuration = "<b>Select your Advert Duration</b><br/>" & _
	             "<select name='duration' id='duration' autocomplete='off' class='selectmedium' style='margin-top:8px;' onchange=""setppcheckout('" & AdType & "', '" & ByPassTrial & "');"">" & _
				 "<option value='-'>-- Select One --</option>" & _
				 "<option value='-'>-------------------------------------------------</option>" & _
				 FeaturedList & _
				 "</select>"
  
  ElseIf AdType = "0" AND IsTrialExpired = "1" Then
    
	AdDuration = "<b>Select your Advert Duration</b><br/>" & _
	             "<select name='duration' id='duration' autocomplete='off' class='selectmedium' style='margin-top:8px;' onchange=""setppcheckout('" & AdType & "', '" & ByPassTrial & "');"">" & _
				 "<option value='-'>-- Select One --</option>" & _
				 "<option value='-'>-------------------------------------------------</option>" & _
				 StandardList & _
				 "</select>"
  
  ElseIf AdType = "0" AND IsTrialExpired = "0" Then
  
    AdDuration = "<b>Select your Advert Duration</b><br/>" & _
	             "<select name='duration' id='duration' autocomplete='off' class='selectmedium' style='margin-top:8px;' onchange=""setppcheckout('" & AdType & "', '" & ByPassTrial & "');"">" & _
				 "<option value='-'>-- Select One --</option>" & _
				 "<option value='-'>-------------------------------------------------</option>" & _
				 StandardListTrial & _
				 "</select>"
  
  End If
  
  End If
  
  Response.Write AdDuration

// ----------------------------------------------------------------------------------------------------------------------------------------
%>
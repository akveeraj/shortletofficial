<!--#include virtual="/includes.inc"-->


<%
// --------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
  o_Query       = UrlDecode( o_Query )
  AdType        = ParseCircuit( "adtype", o_Query )
  Duration      = ParseCircuit( "duration", o_Query )
  TrialExpired  = IsAccountExpired( Var_UserId, ConnTemp )
  BypassTrial   = ParseCircuit( "bypasstrial", o_Query )
  
  If ByPassTrial = "" Then
    ByPassTrial = "0"
  End If
  
// --------------------------------------------------------------------------------------------------------------------------------

  If ByPassTrial = "1" Then
  
    If AdType = "1" AND Duration = "7" Then
	  AdPrice     = "15.00"
	  AdDesc      = "1 Week Featured Ad"
	  AdDuration  = "7"
	  
	ElseIf AdType = "1" AND Duration = "14" Then
	  AdPrice     = "30.00"
	  AdDesc      = "2 Week Featured Ad"
	  AdDuration  = "14"
	ElseIf AdType = "1" AND Duration = "30" Then
	  AdPrice     = "45.00"
	  AdDesc      = "1 Month Featured Ad"
	  AdDuration  = "30"
	ElseIf AdType = "1" AND Duration = "93" Then
	  AdPrice     = "120.00"
	  AdDesc      = "3 Month Featured Ad"
	  AdDuration  = "93"
	ElseIf AdType = "1" AND Duration = "186" Then
	  AdPrice     = "200.00"
	  AdDesc      = "6 Month Featured Ad"
	  AdDuration  = "186"
	ElseIf AdType = "0" AND Duration = "7" Then
	  AdPrice     = "7.50"
	  AdDesc      = "1 Week Standard Ad"
	  AdDuration  = Duration
	ElseIf AdType = "0" AND Duration = "14" Then
      AdPrice     = "15.00"
	  AdDesc      = "2 Week Standard Ad"
	  AdDuration  = Duration
	ElseIf AdType = "0" AND Duration = "30" Then
	  AdPrice     = "25.00"
	  AdDesc      = "1 Month Standard Ad"
	  AdDuration  = Duration
	ElseIf AdType = "0" AND Duration = "93" Then
      AdPrice     = "60.00"
	  AdDesc      = "3 Month Standard Ad"
	  AdDuration  = Duration
	ElseIf AdType = "0" AND Duration = "186" Then
      AdPrice     = "100.00"
	  AdDesc      = "6 Month Standard Ad"
	  AdDuration  = "186"
	Else
	  AdPrice     = ""
	  AdDesc      = ""
	  AdDuration  = ""
	End If
  End If

// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------

If ByPassTrial = "0" OR BypassTrial = "undefined" Then

  If AdType = "1" AND Duration = "7" AND ByPassTrial = "0" Then
    
	AdPrice     = "15.00"
	AdDesc      = "1 Week Featured Ad"
	AdDuration  = "7"
  
  ElseIf AdType = "1" AND Duration = "14" AND ByPassTrial = "0" Then
    
	AdPrice     = "30.00"
	AdDesc      = "2 Week Featured Ad"
	AdDuration  = "14"
  
  ElseIf AdType = "1" AND Duration = "30" AND ByPassTrial = "0" Then
    
	AdPrice     = "45.00"
	AdDesc      = "1 Month Featured Ad"
	AdDuration  = "31"
	
  ElseIf AdType = "1" AND Duration = "93" AND ByPassTrial = "0" Then
    
	AdPrice     = "120.00"
	AdDesc      = "3 Month Featured Ad"
	AdDuration  = "93"
	
  ElseIf AdType = "1" AND Duration = "186" AND ByPassTrial = "0" Then
    AdPrice     = "200.00"
	AdDesc      = "6 Month Featured Ad"
	AdDuration  = "186"
	
// --------------------------------------------------------------------------------------------------------------------------------
	
  ElseIf AdType = "0" AND Duration = "7" AND TrialExpired = "1" AND ByPassTrial = "0" Then
    
	AdPrice     = "7.50"
	AdDesc      = "1 Week Standard Ad"
	AdDuration  = Duration
	
  ElseIf AdType = "0" AND Duration = "14" AND TrialExpired = "1" AND ByPassTrial = "0" Then
  
    AdPrice     = "15.00"
	AdDesc      = "2 Week Standard Ad"
	AdDuration  = Duration
	
  ElseIf AdType = "0" AND Duration = "30" AND TrialExpired = "1" AND ByPassTrial = "0" Then
    
	AdPrice     = "25.00"
	AdDesc      = "1 Month Standard Ad"
	AdDuration  = Duration
	
  ElseIf AdType = "0" AND Duration = "93" AND TrialExpired = "1" AND ByPassTrial = "0" Then
  
    AdPrice     = "60.00"
	AdDesc      = "3 Month Standard Ad"
	AdDuration  = Duration
	
  ElseIf AdType = "0" AND Duration = "186" AND TrialExpired = "1" AND ByPassTrial = "0" Then
  
    AdPrice     = "100.00"
	AdDesc      = "6 Month Standard Ad"
	AdDuration  = Duration
	
// --------------------------------------------------------------------------------------------------------------------------------
	
  ElseIf AdType = "0" AND TrialExpired = "0" AND ByPassTrial = "0" Then
    AdPrice     = "0.00"
	AdDesc      = Duration & " Day Standard Ad"
	AdDuration  = Duration
	
  Else
  
    AdPrice     = ""
	AdDesc      = ""
	AdDuration  = ""
  
  End If
  
End If
	
// --------------------------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// --------------------------------------------------------------------------------------------------------------------------------

  JSOn  = "{'price':'" & AdPrice & "', 'desc':'" & AdDesc & "', 'duration':'" & AdDuration & "', 'trialexpired':'" & TrialExpired & "', 'adtype':'" & AdType & "'}"
  Response.Write JSOn

// --------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------
%>
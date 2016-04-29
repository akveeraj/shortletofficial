<!--#include virtual="/includes.inc"-->

<%
// ------------------------------------------------------------------------------------------------------------------------

  o_Query = Request.Form
  o_Query = Replace( o_Query, "&", ";" )
  o_Query = Replace( o_Query, ";", vbcrlf )
  
  SelectDuration  = ParseCircuit( "selectduration", o_Query )
  SelectMethod    = ParseCircuit( "selectmethod", o_Query )
  
// ------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ------------------------------------------------------------------------------------------------------------------------

  If SelectDuration = "" Then
    ShowPrice = 0
  ElseIf SelectMethod = "" Then
    ShowPrice = 0
  Else
    ShowPrice = 1
  End If
  
  If ShowPrice = "1" Then
    SMSPrice = SelectDuration * "1.00"
    SMSPrice = FormatNumber( SMSPrice, 2 )
  End If
  
// ------------------------------------------------------------------------------------------------------------------------
// ' Format Pricing
// ------------------------------------------------------------------------------------------------------------------------

  If ShowPrice = "1" Then
  
    Select Case( SelectMethod )
	  Case(1)
	  Case(2)
	End Select
	
	If SelectMethod = "1" AND SelectDuration = "7" Then
	  
	  NewSelectPrice = "15.00"
	  NewSelectDesc  = "7 Day Email Alert"
	ElseIf SelectMethod = "1" AND SelectDuration = "14" Then
	  
	  NewSelectPrice = "30.00"
	  NewSelectDesc  = "14 Day Email Alert"
	  
	ElseIf SelectMethod = "1" AND SelectDuration = "21" Then
	  
	  NewSelectPrice = "45.00"
	  NewSelectDesc  = "21 Day Email Alert"
	  
	ElseIf SelectMethod = "1" AND SelectDuration = "28" Then
	  
	  NewSelectPrice = "60.00"
	  NewSelectDesc  = "28 Day Email Alert"
	  
	ElseIf SelectMethod = "2" AND SelectDuration = "7" Then
	  
	  NewSelectPrice = CDbl("15.00") + SMSPrice
	  NewSelectPrice = FormatNumber( NewSelectPrice, 2 )
	  NewSelectDesc  = "7 Day Email Alert <b>+</b> Daily Text Alert Service"
	  
	ElseIf SelectMethod = "2" AND SelectDuration = "14" Then
	  
	  NewSelectPrice = CDbl("30.00") + SMSPrice
	  NewSelectPrice = FormatNumber( NewSelectPrice, 2 )
	  NewSelectDesc  = "14 Day Email Alert <b>+</b> Daily Text Alert Service"
	  
	ElseIf SelectMethod = "2" AND SelectDuration = "21" Then
	  
	  NewSelectPrice = CDbl("45.00") + SMSPrice
	  NewSelectPrice = FormatNumber( NewSelectPrice, 2 )
	  NewSelectDesc  = "21 Day Email Alert <b>+</b> Daily Text Alert Service"
	  
	ElseIf SelectMethod = "2" AND SelectDuration = "28" Then
	  
	  NewSelectPrice = CDbl("60.00") + CInt(SMSPrice)
	  NewSelectPrice = FormatNumber( NewSelectPrice, 2 )
	  NewSelectDesc  = "28 Day Email Alert <b>+</b> Daily Text Alert Service"
	  
	Else
	  NewSelectPrice = "0.00"
	  NewSelectDesc  = ""
	End If
	
  Else
  
    NewSelectPrice = "0.00"
  
  End If
  
  'If NewSelectDesc > "" Then NewSelectDesc = UrlEncode( NewSelectDesc ) End If
  
// ------------------------------------------------------------------------------------------------------------------------
// ' Write Json Response
// ------------------------------------------------------------------------------------------------------------------------

  JSON = "{'newprice':'" & NewSelectPrice & "', 'smsprice':'" & SMSPrice & "', 'showprice':'" & ShowPrice & "', 'selectdesc':'" & NewSelectDesc & "'}"
  Response.Write JSON

// ------------------------------------------------------------------------------------------------------------------------
%>
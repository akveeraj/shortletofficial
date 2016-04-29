<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = Request.Form
  o_Query = Replace( o_Query, ";", vbcrlf  )
  
  SubNumber   = ParseCircuit( "subnumber", o_Query )
  Desc        = ParseCircuit( "desc", o_Query )
  PayRef      = ParseCircuit( "payref", o_Query )
  CustomerId  = ParseCircuit( "customerid", o_Query )
  RequestId   = Sha1( Timer() & Rnd() )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If SubNumber = "" Then
    Proceed = 0
	RCode   = 1
	RText   = "Sorry, something went wrong, please try again later."
  ElseIf Desc = "" Then
    Proceed = 0
	RCode   = 2
	RText   = "Sorry, something went wrong, please try again later."
  ElseIf PayRef = "" Then
    Proceed = 0
	RCode   = 3
	RText   = "Sorry, something went wrong, please try again later."
  ElseIf CustomerID = "" Then
    Proceed = 0
	RCode   = 4
	RText   = "Sorry, something went wrong, please try again later."
  Else
    Proceed = 1
	RCode   = 5
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write to renewal requests table
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
  
    SaveSQL = "INSERT INTO renewalrequests " & _
	          "( subnumber, description, payref, customerid, requestid, requestdate )" & _ 
			  " VALUES( " & _
			  "'" & SubNumber       & "', "  & _
			  "'" & Desc            & "', "  & _
			  "'" & PayRef          & "', "  & _
			  "'" & CustomerId      & "', "  & _
			  "'" & RequestId       & "', "  & _
			  "'" & Var_DateStamp   & "' "   & _
			  ")" 
			  Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
			
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSON Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rtext':'" & RText & "', 'rcode':'" & RCode & "', 'proceed':'" & Proceed & "', 'subid':'" & SubNumber & "', 'requestid':'" & RequestId & "'}"
  Response.Write JSOn
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
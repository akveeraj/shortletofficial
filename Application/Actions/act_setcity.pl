<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query     = Request.Form
  o_Query     = UrlDecode( o_Query )
  o_Query     = Replace( o_Query, ";", vbcrlf )
  UkLocation  = ParseCircuit("uklocation", o_Query )
  UkNoRooms   = ParseCircuit("uknorooms", o_Query )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If UkLocation > "" Then Response.Cookies("tandgshortlets")("location")       = UkLocation End If
  If UkNoRooms  > "" Then Response.Cookies("tandgshortlets")("norooms")        = UkNoRooms  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSOn Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSON = "{'location':'" & UkLocation & "', 'norooms':'" & UkNoRooms & "', 'proceed':'1' }"
  Response.Write JSOn
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    o_Query        = fw_Query
	o_Query        = UrlDecode( o_Query )
	ActionUrl      = ParseCircuit( "actionurl", o_Query )
	ResponseText   = ParseCircuit( "responsetext", o_Query )
	PageTitle      = ParseCircuit( "pagetitle", o_Query )
	CmdType        = ParseCircuit( "cmdtype", o_Query )
	
	If ActionUrl > "" Then ActionUrl = HexToString( ActionUrl ) End If
	
	If CmdType = "1" Then
	  ProceedCode = "<span class='modal_proceed' id='modalaction'><a href='" & ActionUrl & "'>YES</a></span>"
	Else
	  ProceedCode = "<span class='modal_proceed' id='modalaction'><a href=""javascript://"" onclick=""" & ActionUrl & """>YES</a></span>"
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='modal_header'>
  <span class='modal_label'><%=PageTitle%></span>
  <span class='modal_close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span>
</div>

<div class='modal_content'>
  <span class='cell' style='width:48px; margin-left:10px; margin-right:10px;'><img src='/application/library/media/icons/question-icon.png'/></span>
  <span class='cell' style='width:300px; margin-top:10px;'><%=ResponseText%></span>
</div>

<div class='modal_footer'>
  <span class='modal_cancel' id='modalcancel'><a href='javascript://' onclick="CloseModalBox();">Cancel</a></span>
  <%=ProceedCode%>
  <span class='modal_wait' id='modalwait' style='display:none;'>&nbsp;</span>
</div>
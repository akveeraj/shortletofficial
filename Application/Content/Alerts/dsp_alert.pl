<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
  o_Query       = UrlDecode( o_Query )
  ResponseText  = ParseCircuit( "responsetext", o_Query )
  Title         = ParseCircuit( "pagetitle", o_Query )
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='modal_header'>
  <span class='modal_label'><%=Title%></span>
  <span class='modal_close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span>
</div>

<div class='modal_content'>
  <span class='cell' style='width:48px; margin-left:10px; margin-right:10px;'><img src='/application/library/media/icons/alert-icon.png'/></span>
  <span class='cell' style='width:300px; margin-top:10px;'><%=ResponseText%></span>
</div>

<div class='modal_footer'>
  <span class='modal_proceed' id='modalaction'><a href='javascript://' onclick="CloseModalBox();">OK</a></span>
  <span class='modal_wait' id='modalwait' style='display:none;'>&nbsp;</span>
</div>

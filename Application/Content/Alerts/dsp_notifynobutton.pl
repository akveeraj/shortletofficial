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
  <span class='cell' style='width:348px; text-align:center;'>
  <%=ResponseText%><br/><span style='color:green;'>This message will close automatically<br/><br/></span>
      <span style='font-size:11px; text-align:center;'>
  Not closing? <a href='javascript://' onclick="CloseModalBox();">Click here</a> to close this message.
  </span>
  </span>

</div>
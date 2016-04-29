<!--#include virtual="/includes.inc"-->

<%
  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  Src        = ParseCircuit("src", o_Query )
  Width      = ParseCircuit("width", o_Query )
  IsVertical = ParseCircuit("isvertical", o_Query )
  If IsVertical = "1" Then ImageWidth = "300" Else ImageWidth = "544" End If
  If Src > "" Then Src = HexToString(Src) End If
%>

<style type='text/css'>
.details_holder .galleryholder .img {
  display:block;
  width:<%=ImageWidth%>px;
  z-index:800; 
  position:relative;
  margin-left:auto;
  margin-right:auto;
}
</style>

<img src='<%=Src%>' width="auto" class='img'/>
<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = fw_Query
  o_Query = UrlDecode( o_Query )
  PayRef  = ParseCircuit( "payref", o_Query )
  Amount  = ParseCircuit( "amount", o_Query )
  Amount  = FormatNumber( Amount,2  )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='modal_header'>
  <span class='modal_label'>How to make a payment</span>
  <span class='modal_close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span>
</div>


<div class='modal_content_scrollable'>
  <span class='cell' style='width:348px;'>
    The registration fee needs to be paid by bank transfer. Read the instructions below in order to make your payment.<br/><br/>
	
  <span class='redtext'>Please ensure you quote the Payment Reference <b><%=PayRef%></b> when making your transfer, If you do not include your payment reference, we will not
	 be able to verify your payment.</span><br/><br/>
	 
	 <span class='row'>
	   <span class='cell' style='width:125px;'><b>Account Number</b></span>
	   <span class='cell'><%=Fw__Account%></span>
	 </span>
	 
	 <span class='row'>
	   <span class='cell' style='width:125px;'><b>Sort Code</b></span>
	   <span class='cell'><%=Fw__SortCode%></span>
	 </span>
	 
	 <span class='row'>
	   <span class='cell' style='width:125px;'><b>Name on Account</b></span>
	   <span class='cell'><%=Fw__NameOnAccount%></span>
	 </span>
	 
	 <span class='row'>
	   <span class='cell' style='width:125px;'><b>Bank Name</b></span>
	   <span class='cell'><%=Fw__BankName%></span>
	 </span>
	 
	 <span class='row'>
	   <span class='cell' style='width:125px;'><b>Payment Reference</b></span>
	   <span class='cell'><%=PayRef%><br/><br/></span>
	 </span>
	
  </span>
</div>

<div class='modal_footer'>
  <span class='modal_proceed' id='modalaction'><a href='javascript://' onclick="CloseModalBox();">CLOSE</a></span>
  <span class='modal_wait' id='modalwait' style='display:none;'>&nbsp;</span>
</div>

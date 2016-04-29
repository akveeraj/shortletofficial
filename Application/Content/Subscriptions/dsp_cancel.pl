<!--#include virtual="/includes.inc"-->


<%
// ------------------------------------------------------------------------------------------------
  
  o_Query = fw_Query
  o_Query = UrlDecode( o_Query )
  Data    = ParseCircuit("data", o_Query )
  
  If Data > "" Then Data = HexToString( Data ) End If
  
  nData   = Data
  nData   = Replace( nData, ";", vbcrlf )
  Email   = ParseCircuit( "email", nData )
  SubId   = ParseCircuit( "subid", nData )
  TxId    = ParseCircuit( "txid", nData )
  
// ------------------------------------------------------------------------------------------------
// ' Get Subscription Details
// ------------------------------------------------------------------------------------------------

  SubSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "'"
           Call FetchData( SubSQL, SubRs, ConnTemp )
		   
  SubCount = SubRs("NumberOfRecords")
  Call CloseRecord( SubRs, ConnTemp )
  
// ------------------------------------------------------------------------------------------------
  
  If SubCount > "0" Then
  
    SubSQL = "SELECT * FROM propertyalerts WHERE subid='" & SubId & "' AND txid='" & TxId & "'"
	         Call FetchData( SubSQL, SubRs, ConnTemp )
			 
			 SubDesc      = SubRs("subdesc")
			 SubExpiry    = SubRs("expirydate")
             SubId        = SubRs("subid")	
             SubDuration  = SubRs("duration")
             SubReq       = SubRs("requirement")
			 SubCity      = SubRs("city")
             SubEmail     = SubRs("email")
			 
			 If SubDesc > "" Then SubDesc = HexToString( SubDesc ) End If
             If SubExpiry > "" Then SubExpiry = FormatDateTime( SubExpiry, 1 ) End If
			 
			 SubDesc = SubDesc & "<br/>" & SubReq & " in " & SubCity & " - " & SubEmail

          			 
  
  End If
  
// ------------------------------------------------------------------------------------------------
%>



<div class='contentheader2'>Cancel Property Alerts Subscription</div> 
<% If SubCount > "0" Then %>
<div class='textblock' style='border:solid 0px; width:550px; margin-top:30px; margin-bottom:0px; text-align:center;'>
To cancel your Subscription, Click the cancel button below.
</div>


<div class='createad_formholder' style='margin-top:20px;'>

<span class='spacer'></span>

  <div class='currentsub'>
    <div class='subrow'>
	  <span class='subcell' style='width:150px; text-align:right;'><b>Subscription:</b></span>
	  <span class='subcell'><%=SubDesc%></span>
	</div>
	
    <div class='subrow'>
	  <span class='subcell' style='width:150px; text-align:right;'><b>Expiry Date:</b></span>
	  <span class='subcell'><%=SubExpiry%></span>
	</div>
	
    <div class='subrow' style='border-bottom:solid 0px transparent;'>
	  <span class='subcell' style='width:150px; text-align:right;'><b>Subscription ID:</b></span>
	  <span class='subcell'><%=SubId%></span>
	</div>
	
	
  </div>
  
  
  <div class=''>
    <span class='cell' style='float:right;'><span class='alert_formwait' id='formwait' style='display:none;'>&nbsp;</span></span>
	<span class='cell' style='margin-right:10px; float:right;'><span class='alert_ppbutton' id='formbutton'><a href='javascript://' onclick="CancelSubscription();">Cancel Subscription &gt;</a></span></span>
  </div>
  
  
<span class='spacer'></span>
</div>

<% Else %>

<div class='createad_justregistered' style='margin-top:50px;'>
  <b>Subscription Not Found</b><br/>
  The subscription has already been cancelled or does not exist.<br/><br/>
  If you believe this is an error, please contact <a href='/contact/doc/'>Customer Services</a>.
</div>

<% End If %>

<input type='hidden' name='subid' id='subid' value='<%=SubId%>' autocomplete='off'/>
<input type='hidden' name='txid' id='txid' value='<%=TxId%>' autocomplete='off'/>
<input type='hidden' name='txid' id='email' value='<%=SubEmail%>' autocomplete='off'/>
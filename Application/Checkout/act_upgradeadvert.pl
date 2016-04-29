<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query         = fw_Query
  o_Query         = UrlDecode( o_Query )
  Data            = ParseCircuit( "data", o_Query )
  Data            = HexToString( Data )
  Data            = Replace( Data, ";", vbcrlf )
  ListingId       = ParseCircuit( "listingid", Data )
  AdvertId        = ParseCircuit( "advertid", Data )
  SelectedTab     = ParseCircuit( "tab", o_Query )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "Feature your Advert ~ Town and Gown Shortlets UK";
 
  var adtype         = "<%=AdType%>";
  var tempfeatured   = document.getElementById('featured');
  var adoptions       = document.getElementById('selectoptions');
  var adoptionswait   = document.getElementById('selectoptionswait'); 
  var adoptionsedit   = document.getElementById('selectoptionsedit');
  
  $j('input:radio[name="featured"]').filter('[value="1"]').attr('checked', true);
  fetchadprices('1', '0');
  adoptionsedit.style.display = "block";
});
</script> 


<div class='contentheader2' style='margin-bottom:20px;'>Feature your Advert</div>
<div class='textblock'>
 Featured Ads appear towards the top of listings where they remain for the duration of your selected payment period. <br/>To upgrade to a Featured Ad, simply select
   the duration you would like to feature your advert and click using the PayPal button below.
</div>
 

<div class='details_holder' style='width:500px; margin-left:auto; margin-right:auto; margin-top:20px;'>
<!-- start advert options -->

  <form action="" id='optionsform' name='optionsform'>

<div class='preview_adoptions' id='adoptions' style='margin-left:0px;'>
  <div class='row'>
    
	<span class='cell'>
	
	  <span class='inner_row'>
	    <span class='inner_cell'><span class='label'><input type='radio' id='featured' name='featured' value='1' autocomplete='off' onclick="fetchadprices('1', '0');"/></span></span>
		<span class='inner_cell' style='width:110px;'><span class='featuredad'>Featured Ad</span></span>
	  </span>
	  
	</span>
	
	
	
	
	
	
	<span class='cell'>
	  <span class='label' style='margin-top:0px;'><span id='adduration'></span><span class='wait' id='adoptions_wait' style='display:none;'></span></span>
	</span>
	
	
	
	
	<span class='cell' style='float:right; margin-top:5px; display:none;' id='selectoptions'>
	  <span class='edit' id='previewedit'><a href='/dashboard/account/?tab:1'>&lt; Cancel Payment</a></span>
	  <span class='save' id='previewsave'><a href='javascript://' onclick="PayNow('<%=ListingId%>', '<%=Var_UserId%>', '<%=AdvertId%>')">Pay with PayPal &gt;</a></span>
	  <span class='wait' id='previewwait' style='display:none;'>Please Wait...</span>
	</span>
	
	<span class='wait' id='selectoptionswait' style='margin-top:35px; display:none;'>Please Wait...</span>
	
	<span class='cell' style='float:right; display:none; margin-top:28px;' id='selectoptionsedit'>
	  <span class='edit' id='previewedit'><a href='/dashboard/account/?tab:1'>&lt; Cancel Payment</a></span>
	</span>

	
  </div>
</div>

</form>

<!-- end advert options -->

</div>

<div class='preview_paypallogo'></div>

<!-- start paypal setup -->

<input type='hidden' name='ppldescription' id='ppldescription' value='' autocomplete='off'/>
<input type='hidden' name='pplamount' id='pplamount' value=''      autocomplete='off'/>
<input type='hidden' name='pplduration' id='pplduration' value=''  autocomplete='off'/>
<input type='hidden' name='ppladtype' id='ppladtype' value=''      autocomplete='off'/>
<input type='hidden' name='fromupgrade' id='fromupgrade' value='1' autocomplete='off'/>
<input type='hidden' name='tab' id='tab' value='<%=SelectedTab%>'  autocomplete='off'/>

<!-- end paypal setup -->






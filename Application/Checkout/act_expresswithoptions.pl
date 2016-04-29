<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  o_Query          = fw_Query
  o_Query          = UrlDecode( o_Query )
  ListingId        = ParseCircuit( "listingid", o_Query )
  AdvertId         = ParseCircuit( "advertid", o_Query )
  AdType           = ParseCircuit( "adtype", o_Query )
  IsTrialExpired   = IsAccountExpired( Var_UserId, ConnTemp )
  TrialRemaining   = TrialRemainingCount( Var_UserId, ConnTemp )
  SelectedTab      = ParseCircuit( "tab", o_Query )
  Repost           = ParseCircuit( "repost", o_Query )
  
  If Repost = "" Then
    Repost = "0"
  End If
  
  If SelectedTab = "" Then
    SelectedTab = "1"
  End If
  
  RPath            = "/dashboard/account/?tab:" & SelectedTab
  
  If Repost = "1" Then
    PageHeader = "Repost your Advert"
	PageText   = "To repost your advert, use the form below."
  Else
    PageHeader = "Pay for your Advert"
	PageText   = "To continue placing your advert, use the form below."
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if listing exists
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ListSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
               Call FetchData( ListSQL, ListRs, ConnTemp )
			
  ListCount  = ListRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If ListCount > "0" Then
  
    ListSQL = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "'"
	          Call FetchData( ListSQL, ListRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If IsTrialExpired = "0" AND Repost = "0" Then
    SelectAdType   = "settotrialad();"
	DefaultSelect  = "0"
  ElseIf IsTrialExpired = "0" AND Repost = "1" Then
    SelectAdType   = "fetchadprices('0', '" & Repost & "'); hidetrial();"
  Else
    SelectAdType   = "fetchadprices('0', '" & Repost & "'); hidetrial();"
	DefaultSelect  = "0"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
// document.title = "<%=PageHeader%> ~ Town and Gown Shortlets UK";
});

  if ($j("#loggedin").length === 1){
	$j("#loggedin").hide();
  }

</script> 


<script type='text/javascript'>
  function settotrialad(){
    var adtype          = "<%=DefaultSelect%>";
    var istrialexpired  = "<%=IsTrialExpired%>";
    var trialremaining  = "<%=TrialRemaining%>";
    var tempfeatured    = document.getElementById('featured');
	var ppladtype       = document.getElementById('ppladtype');
	var pplduration     = document.getElementById('pplduration');
	var pplamount       = document.getElementById('pplamount');
	var ppldescription  = document.getElementById('ppldescription');
	var trialnotice     = document.getElementById('trialnotice');
	var adduration      = document.getElementById('adduration');
	var paypallogo      = document.getElementById('paypallogo');
	var previewedit     = document.getElementById('previewedit');
	var previewback     = document.getElementById('previewback');
	var previewsave     = document.getElementById('previewsave');
	var previewplace    = document.getElementById('previewplace');
    var adoptions       = document.getElementById('selectoptions');
    var adoptionswait   = document.getElementById('selectoptionswait'); 
	var adoptionsedit   = document.getElementById('selectoptionsedit');
	var contentheader   = document.getElementById('contentheader');
	var contenttext     = document.getElementById('contenttext');
	
	adoptionswait.style.display = "none";
	adoptions.style.display     = "block";
	adoptionsedit.style.display = "none";
	
	trialnotice.style.display = "block";
	trialnotice.innerHTML  = "Standard Ad - Trial (" + trialremaining + " days remaining)"
	ppladtype.value = "0";
	pplduration.value = trialremaining;
	pplamount.value = "0.00";
	ppldescription.value = "Standard " + trialremaining + " day trial advert";
	adduration.innerHTML = "";
	paypallogo.style.display = "none";
	previewedit.style.display  = "none";
	previewback.style.display  = "block";
	previewsave.style.display  = "none";
	previewplace.style.display = "block";
	trialnotice.style.display  = "block";
	contentheader.innerHTML    = "Place your Advert";
  }
  
  function hidetrial(){
	var previewedit    = document.getElementById('previewedit');
	var previewback    = document.getElementById('previewback');
	var previewsave    = document.getElementById('previewsave');
	var previewplace   = document.getElementById('previewplace');
    var trialnotice    = document.getElementById('trialnotice');
	var paypallogo     = document.getElementById('paypallogo');
    var adoptions       = document.getElementById('selectoptions');
    var adoptionswait   = document.getElementById('selectoptionswait'); 
	var adoptionsedit   = document.getElementById('selectoptionsedit');
	var contentheader   = document.getElementById('contentheader');
	var contenttext     = document.getElementById('contenttext');
	
	trialnotice.style.display   = "none";
	paypallogo.style.display    = "block";
	
	previewedit.style.display   = "block";
	previewback.style.display   = "none";
	previewsave.style.display   = "block";
	previewplace.style.display  = "none";
	adoptionsedit.style.display = "block";
	contentheader.innerHTML     = "Pay for your Advert"
  }
  
</script>

<script type='text/javascript'>
  document.observe("dom:loaded", function() {
	var previewedit     = document.getElementById('previewedit');
	var previewback     = document.getElementById('previewback');
	var previewsave     = document.getElementById('previewsave');
	var previewplace    = document.getElementById('previewplace');
    var istrialexpired  = "<%=IsTrialExpired%>";
	var paypallogo      = document.getElementById('paypallogo');
	var trialnotice     = document.getElementById('trialnotice');
	var trialremaining  = "<%=TrialRemaining%>";
	var repost          = "<%=Repost%>";
    var adoptions       = document.getElementById('selectoptions');
    var adoptionswait   = document.getElementById('selectoptionswait'); 
	var adoptionsedit   = document.getElementById('selectoptionsedit');
	var contentheader   = document.getElementById('contentheader');
	var contenttext     = document.getElementById('contenttext');
	
	if ( repost == "1" ) {
	  fetchadprices('1', '1');
	  hidetrial();
	  $j('input:radio[name="featured"]').filter('[value="1"]').attr('checked', true);
	} else {
	
	if ( istrialexpired == "1" ) {
	  fetchadprices('1', '0');
	  paypallogo.style.display = "block";
	  $j('input:radio[name="featured"]').filter('[value="1"]').attr('checked', true);
	  previewedit.style.display  = "block";
	  previewback.style.display  = "none";
	  previewsave.style.display  = "block";
	  previewplace.style.display = "none";
	  trialnotice.style.display  = "none";
	  adoptionsedit.style.display = "block";
	  
	} else {
	  paypallogo.style.display = "none";
	  $j('input:radio[name="featured"]').filter('[value="0"]').attr('checked', true);
	  previewedit.style.display  = "none";
	  previewback.style.display  = "block";
	  previewsave.style.display  = "none";
	  previewplace.style.display = "block";
	  trialnotice.style.display  = "block";
	  trialnotice.innerHTML      = "Standard Ad - Trial (" + trialremaining + " days remaining)";
	  adoptions.style.display    = "block";
	  contentheader.innerHTML    = "Place your Advert";
	}
	
	}
  });
</script> 










<div class='contentheader2' style='margin-bottom:20px;' id='contentheader'><%=PageHeader%></div>
<div class='textblock' style='text-align:center;' id='contenttext'>
<%=PageText%>
</div>



<!-- start advert options -->

  <form action="" id='optionsform' name='optionsform'>

<div class='preview_adoptions' id='adoptions'>
  <div class='row'>
    
	<span class='cell'>
	
	  <span class='inner_row'>
	    <span class='inner_cell'><span class='label'><input type='radio' id='featured' name='featured' value='1' autocomplete='off' onclick="fetchadprices('1', '<%=Repost%>'); hidetrial();"/></span></span>
		<span class='inner_cell' style='width:110px;'><span class='featuredad'>Featured Ad</span></span>
	  </span>
	  
	  <span class='inner_row'>
	    <span class='inner_cell'><span class='label'><input type='radio' id='featured' name='featured' value='0' autocomplete='off' onclick="<%=SelectAdType%>"/></span></span>
		<span class='inner_cell' style='width:110px;'><span class='standardad'>Standard Ad</span></span>
	  </span>
	  
	  
	  
	</span>
	
	
	
	
	
	
	<span class='cell'>
	  <span class='label' style='margin-top:0px;'><span id='adduration'></span><span class='trialnotice' id='trialnotice' style='display:none;'></span><span class='wait' id='adoptions_wait' style='display:none;'></span></span>
	</span>
	
	<span class='wait' id='selectoptionswait' style='margin-top:35px; display:none;'>Please Wait...</span>
	
	
	
	
	<span class='cell' style='float:right; display:none;' id='selectoptions'>
	  <span class='edit' id='previewedit'><a href='<%=RPath%>'>&lt; Cancel Payment</a></span>
	  <span class='edit' id='previewback' style='display:none;'><a href='<%=RPath%>'>&lt; Cancel</a></span>
	  <span class='save' id='previewsave'><a href='javascript://' onclick="PayNow('<%=ListingId%>', '<%=Var_UserId%>', '<%=AdvertId%>')">Pay with PayPal &gt;</a></span>
	  <span class='save' id='previewplace' style='display:none;'><a href='javascript://' onclick="PlaceTrialAd('<%=ListingId%>', '<%=Var_UserId%>', '<%=AdvertId%>', '<%=TrialRemaining%>');">Place Advert Now &gt;</a></span>
	  <span class='wait' id='previewwait' style='margin-top:25px; display:none;'>Please Wait...</span>
	</span>
	
    <span class='cell' style='float:right; display:none; margin-top:28px;' id='selectoptionsedit'>
	  <span class='edit' id='previewedit'><a href='<%=RPath%>'>&lt; Cancel Payment</a></span>
	</span>

	
  </div>
</div>

	<div class='preview_paypallogo' id='paypallogo' style='display:none;'></div>

</form>

<!-- end advert options -->




<!-- start paypal setup -->

<input type='hidden' name='ppldescription' id='ppldescription' value='' autocomplete='off'/>
<input type='hidden' name='pplamount' id='pplamount' value='' autocomplete='off'/>
<input type='hidden' name='pplduration' id='pplduration' value='' autocomplete='off'/>
<input type='hidden' name='ppladtype' id='ppladtype' value='' autocomplete='off'/>
<input type='hidden' name='fromupgrade' id='fromupgrade' value='0' autocomplete='off'/>
<input type='hidden' name='tab' id='tab' value='<%=SelectedTab%>' autocomplete='off'/>

<!-- end paypal setup -->
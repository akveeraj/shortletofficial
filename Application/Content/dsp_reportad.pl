<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  ListingId  = ParseCircuit( "listingid", o_Query )
  RPath      = ParseCircuit( "rpath", o_Query )
  RPath      = HexToString( RPath )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Advert Details
// ---------------------------------------------------------------------------------------------------------------------------------------------

  AdSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
            Call FetchData( AdSQL, AdRs, ConnTemp )
		  
  AdCount = AdRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------

  If AdCount > "0" Then
  
    AdSQL    = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "'"
	           Call FetchData( AdSQL, AdRs, ConnTemp )
  
    AdPhoto  = AdRs("photo")
	AdTitle  = AdRs("title")
	AdTitle  = HexToString( AdTitle )
	AdvertId = AdRs("advertid")
	AdPhoto  = "/uploads/thumbs/" & AdPhoto
	AdPhoto  = "<img src='" & AdPhoto & "' style='width:100px;'/>"
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type="text/javascript">
function limiter(textarea, count, counter){
var counter = document.getElementById(counter);
var count   = count;
var tex     = document.getElementById(textarea).value;
var len     = tex.length;
if(len > count){
tex = tex.substring(0,count);
  counter.innerHTML = tex;
return false;
}
counter.innerHTML = count-len + " characters remaining";
}
</script>

<script type='text/javascript'>
document.observe("dom:loaded", function() { document.title = "Report an Ad ~ Town and Gown Shortlets UK"; });
</script>

<div class='contentheader2'>Report an Advert</div>

<% If AdCount > "0" Then %>

<div class='textblock' style='margin-bottom:20px; border-bottom:solid 1px #eeeeee; text-align:center;'>
  <b>Fill out the form below to report the selected Advert.</b>
</div>

<div class='createad_formholder' id='createadform'>

  <span class='row'>
    <span class='cell'><%=AdPhoto%></span>
	<span class='cell' style='margin-top:10px; font-size:14px;'><b><%=AdTitle%></b><br/><b>Advert ID:</b> <%=AdvertId%></span>
  </span>

  <span class='spacer_line'></span>

  <span class='row'>
    <span class='cell'><span class='label'>Select a reason why you are reporting this advert:</span></span>
  </span>

  <div class='row'>
    <span class='cell' style='width:40px;'><span class='label'><input type='radio' id='reason' name='reason' value='This ad is illegal/fraudulent' autocomplete='off'/></span></span>
	<span class='cell'><span class='label_large'>This ad is illegal/fraudulent</span></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:40px;'><span class='label'><input type='radio' id='reason' name='reason' value='This ad is spam' autocomplete='off'/></span></span>
	<span class='cell'><span class='label_large'>This ad is spam</span></span>
  </div>
  
  <div class='row'>
    <span class='cell' style='width:40px;'><span class='label'><input type='radio' id='reason' name='reason' value='This ad is a duplicate' autocomplete='off'/></span></span>
	<span class='cell'><span class='label_large'>This ad is a duplicate</span></span>
  </div>
  
<span class='spacer'></span>

  <span class='row'>
    <span class='cell'><span class='label'>Enter more information about why you are reporting this advert:</span></span>
  </span>
  
<span class='spacer'></span>
  
  <div class='row'>
    <textarea class='textarealarge' name='details' id='details' autocomplete='off' placeholder='Please provide more information' onkeyup="limiter('details', '1500', 'detailcount')" maxlength="1500"></textarea>
  </div>
  
  <div class='row'>
    <span class='cell'><span id='detailcount' class='textcount' style='margin-left:40px;'></span></span>
  </div>

  <span class='spacer'></span>
  
  <div class='row' style='border-top:solid 2px #deb865; padding-top:18px;'>
	<span class='cancelbutton' style='float:left; margin-left:10px;'><a href='<%=RPath%>'>&lt; Cancel</a></span>
	<span class='button' id='advbutton' style='float:right; margin-right:10px;'><a href='javascript://' onclick="reportad('<%=ListingId%>', '<%=RPath%>');">Send Report &gt;</a></span>
	<span class='wait' style='display:none; float:right;' id='advwait'></span>
  </div>
  
  <span class='spacer'></span>
</div>

<% Else %>

  <span class='list_norecord'>Sorry, the advert could not be found. It may have been removed.<br/><a href='<%=RPath%>'>Click here</a> to return to the previous page</span>

<% End If %>
<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------

  o_Query       = fw_Query
  LoggedIn      = Request.Cookies("shortlets")("loggedin") 
  NewCache      = Sha1( Timer() & Rnd() )
  MetaKeywords  = "short let, uk, short let accommodation, holiday lettings, Oxford, serviced apartment, holiday cottages, accommodation, hotel, introductory platform, shortlet owners "
				 
  
  If fw_OutPut = 0 OR fw_OutPut = "" Then
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" />
<%'<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.5, user-scalable=yes"/>%>
<!--[if IE]><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><![endif]-->
<title><%=SEOPageTitle%></title> 
<meta name="description" content="<%=SEODescription%>">
<%'<meta name="keywords"    content="shortlet uk, uk short lets, oxfordshortlets, Oxford Short Lets, Oxford Shortlets, Oxford Short lets, Shortlet, Short Let, Short Let flats and houses, Shortlet flats and houses, Short term property rentals, Short term property rental, Short let accommodation, Short stay accommodation, Holiday homes UK, Holiday lets, Holiday lettings, UK Short lets, UK Holiday lets, UK Short term property rentals, Oxfordshortlets, ukshortlets, britishsohrtlets, englishaccommodatoin, cheapukshortlets, prviateshoertlesuk, briitsihukshortletaccomodaoin, ukshorttrmrelat places to sayt, popular shorttrem accommodation in the uk, twnandgownshortlets.uk,shortlettersuk, best uk shortlets, seflcatring uk rentals uk, uk rentasl uk, bwitshhotows, rentals, shortlet uk">%>
<meta name="keywords" content="<%=MetaKeywords%>">
<meta name="robots"      content="<%=SEOIndex%>"> 
<meta name="generator"   content="<%=Fw__Generator%>">
<link rel="icon" type="image/png" href="/favicon.png" />

<link rel="stylesheet" type="text/css" href="/application/library/stylesheets/styles.css?nocache:<%=NewCache%>" media="screen"/>
<link rel="stylesheet" type="text/css" href="/application/library/stylesheets/styles.css?nocache:<%=NewCache%>" media="print"/>
<script src='/application/library/javascript/prototype/source.js?nocache:<%=NewCache%>'       type='text/javascript'></script>
<script src='/application/library/javascript/scripty/scriptaculous.js?nocache:<%=NewCache%>'  type='text/javascript'></script>
<script src='/application/library/javascript/jquery/source.js?nocache:<%=NewCache%>'          type='text/javascript'></script>
<script src='/application/library/javascript/jquery/jquery-ui.js?nocache:<%=NewCache%>'       type='text/javascript'></script>
<script> var $j = jQuery.noConflict();</script>
<script src='/application/library/javascript/jscript/functions.js?nocache:<%=NewCache%>'       type='text/javascript'></script>
<script src='/application/library/javascript/jscript/ppl.js?nocache:<%=NewCache%>'             type='text/javascript'></script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-55362275-2', 'auto');
  ga('send', 'pageview');

</script>


<script type='text/javascript'>
document.observe("dom:loaded", function() {
<% If Var_LoggedIn  = "1" Then %>setInterval("CheckAccountStatus()",60000); <% End If %>
});
</script>

</head>

<body>


<!-- modal box -->

<div class='modal_wrap' id='modalwrap'>
  <div class='modal_overlay'>&nbsp;</div>
	
	<div class='modal_offset'>
	  <div class='modal_box' id='modalbox'>
        -------
	  </div>
	</div>
</div>

<!-- end modal box -->


<div class='container'>
<!--#include virtual="/application/content/template/tmp_header.pl"-->

<div class='content'><% Call LoadSourceFile( fw_Circuit ) %></div>
<div class='contentspacer_bottom'></div>
<!--#include virtual="/application/content/template/tmp_footer.pl"-->

</div>

</body>
</html>

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Else
    Call LoadSourceFile( fw_Circuit )
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------
%>
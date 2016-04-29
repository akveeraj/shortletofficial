
<style>

.weathericon a {
  display:block;
  float:left;
  width:34px;
  height:27px;
  background:url('/application/library/media/weathericon.png') no-repeat;
  margin-left:5px;
}

.footerurllink a {
  display:block;
  float:right;
  text-align:center;
  font-size:12px;
  font-weight:bold;
  padding:5px;
  padding-left:12px; 
  padding-right:12px;
  background:#ead4a3;
  text-align:center;
  text-decoration:underline;
  margin-right:5px;
  color:#7a6a51;
}

.footerurllink a:hover {
  text-decoration:none;
}


/*
.worldclock a{
  display:block;
  width:100px;
  float:right;
  font-size:12px;
  font-weight:bold;
  padding:5px;
  background:#ead4a3;
  color:#000000;
  text-align:center;
  margin-top:-5px;
  text-decoration:underline;
}

.worldclock a:hover {
  text-decoration:none;
}

.currency a {
  display:block;
  width:130px;
  float:right;
  font-size:12px;
  font-weight:bold;
  padding:5px;
  background:#ead4a3;
  color:#000000;
  text-align:center;
  margin-top:-5px;
  text-decoration:underline;
  margin-left:10px;
}

.currency a:hover {
  text-decoration:none;
}



.calendar a{
  display:block;
  width:100px;
  float:right;
  font-size:12px;
  font-weight:bold;
  padding:5px;
  background:#ead4a3;
  color:#000000;
  text-align:center;
  margin-top:-5px;
  text-decoration:underline;
  margin-right:10px;
}

.calendar a:hover {
  text-decoration:none;
}

.translate a{
  display:block;
  width:140px;
  float:right;
  margin-left:10px;
  font-size:12px;
  font-weight:bold;
  padding:5px;
  background:#ead4a3;
  color:#000000;
  text-align:center;
  margin-top:-5px;
  text-decoration:underline;
}

.translate a:hover {
  text-decoration:none;
}

.weathericon a{
  display:block;
  float:right;
  width:34px;
  height:27px;
  background:url('/application/library/media/weathericon.png') no-repeat pink;
  margin-left:5px;
}

*/

</style>

<div class='footer'>
  
  <span style='float:right; width:2px; height:2px; margin-right:40px;'>&nbsp;</span>
  <span class='footerurllink'><a href='http://translate.google.com' target='_blank' title='Google Translate'>Google Translate</a></span>
  <span class='footerurllink'><a href='http://www.xe.com' target='_blank' title='Currency Rates'>Currency Rates</a></span>
  <span class='footerurllink'><a href='http://www.timeanddate.com/worldclock/' target='_blank' title='Click here to view date and time in the UK'>World Clock</a></span>
  <span class='footerurllink'><a href='http://www.timeanddate.com/calendar/?year=<%=Year(Now)%>&country=9' title='Year <%=Year(Now)%> Calendar' target='_blank'>Calendar</a></span>
  
  <span style='float:left; width:2px; height:2px; margin-left:40px;'>&nbsp;</span>
  <span class='link'><a href='/contact/doc/' title='Contact Us'>Contact Us</a></span>
  <span class='spacer'>&middot;</span>
  <span class='link'><a href='/terms/doc/' title='Terms & Conditions'>Terms &amp; Conditions</a></span>
  <span class='spacer'>&middot;</span>
  <span class='link'><a href='/cookies/doc/' title='Cookie Policy'>Cookie Policy</a></span>
</div>
  
  <div class='footercopyright'>
  Town and Gown Shortlets UK &copy; <%=Year(Now)%> <span style='float:right;'>Any unauthorised copying or duplication of any content on this site is illegal.</span>
  </div>
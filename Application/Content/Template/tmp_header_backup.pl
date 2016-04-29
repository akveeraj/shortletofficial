<div class='header'>&nbsp;</div>
<div class='toplinkholder'>
  <a href='/' style='margin-left:10px;'>Home</a>
  <span class='spacer'></span>
  <a href='/shortlets/doc/'>Shortlets</a>
  <span class='spacer'></span>
  <% If Var_LoggedIn = "1" Then %>
  <a href='/dashboard/account/' style='color:#ff0000;'>My Adverts</a>
  <span class='spacer'></span>
  <% Else%>
  <a href='/login/doc/'>Log in or Register</a>
  <span class='spacer'></span>
  <% End If %>
  <a href='/deposit/doc/'>Deposit Scheme</a>
  <span class='spacer'></span>
  <a href='/services/doc/'>Other Services</a>
  <span class='spacer'></span>
  <a href='/contact/doc/'>Contact Us</a>
  <span class='spacer'></span>
  <a href='/pictures/doc/'>Oxford Pictures</a>
</div>

<% If Var_LoggedIn = "1" Then %>
<div class='dash_menu'>
  <b>You are logged in as <%=Global_Firstname%>&nbsp;<%=Global_Surname%></b>
  &nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='/createadvert/account/'>Create Advert</a>
  &nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='/details/account/'>Edit Personal Details</a>
  &nbsp;&nbsp;&middot;&nbsp;&nbsp;<a href='/logout/actions/?output:1'>Log Out</a>
</div>
<% End If %>
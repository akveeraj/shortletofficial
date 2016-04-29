<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Response.Cookies("tandgshortlets")("token")      = ""
  Response.Cookies("tandgshortlets")("userid")     = ""
  Response.Cookies("tandgshortlets")("firstname")  = ""
  Response.Cookies("tandgshortlets")("surname")    = ""
  Response.Cookies("tandgshortlets")("email")      = ""
  Response.Cookies("tandgshortlets")("loggedin")   = ""
  Response.Redirect "/login/doc/"
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
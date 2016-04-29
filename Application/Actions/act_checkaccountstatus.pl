<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  LoggedIn      = Var_LoggedIn
  AccountStatus = CheckAccountStatus(Var_UserId, ConnTemp)
  
  If LoggedIn = "1" AND AccountStatus = "0" Then
  
    Response.Cookies("tandgshortlets")("token")      = ""
    Response.Cookies("tandgshortlets")("userid")     = ""
    Response.Cookies("tandgshortlets")("firstname")  = ""
    Response.Cookies("tandgshortlets")("surname")    = ""
    Response.Cookies("tandgshortlets")("email")      = ""
    Response.Cookies("tandgshortlets")("loggedin")   = ""
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'accstatus':'" & AccountStatus & "', 'loggedin':'" & LoggedIn & "'}"
         Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
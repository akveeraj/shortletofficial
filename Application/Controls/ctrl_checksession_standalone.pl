<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query        = fw_Query
  o_Query        = UrlDecode( o_Query )
  n_Query        = Request.QueryString
  n_Source       = ParseCircuit( "source", o_Query )
  n_Circuit      = ParseCircuit( "circuit", o_Query )
  n_Query        = UrlDecode( n_Query )
  n_Query        = Replace( n_Query, n_Circuit, "" )
  n_Query        = Replace( n_Query, n_Source, "" )
  n_Query        = Replace( n_Query, "&", "" )
  n_Query        = Replace( n_Query, "source=", "" )
  n_Query        = Replace( n_Query, "circuit=", "" )
  
  If n_Query > "" Then
    n_ReturnPath = n_Source & "/" & n_Circuit & "/?" & n_Query
  Else
    n_ReturnPath = n_Source & "/" & n_Circuit & "/" 
  End If
  
  n_ReturnPath = EncodeText( n_ReturnPath )
  
  PrimaryPath = "/login/doc/?loggedin:0;rpath:" & n_ReturnPath
  
  If Var_LoggedIn = "" OR Var_LoggedIn = "0" Then
    Response.Redirect "/login/doc/?loggedin:0;rpath:" & n_Returnpath
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
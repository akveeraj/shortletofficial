<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query   = fw_Query
  o_Query   = UrlDecode( o_Query )
  ShortCode = fw_Source
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate ShortCode
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL   = "SELECT COUNT(uIndex) As NumberOFRecords FROM shorturl WHERE shortcode='" & ShortCode & "'"
               Call FetchData( ShortSQL, ShortRs, ConnTemp )
			 
  ShortCount = ShortRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If ShortCount > "0" Then
  
    ShortSQL = "SELECT * FROM shorturl WHERE shortcode='" & ShortCode & "'"
	           Call FetchData( ShortSQL, ShortRs, ConnTemp )
			   nShortUrl = ShortRs("url")
			   
			   If Len( nShortUrl ) > 10 Then
			     Response.Redirect nShortUrl
			   Else
			     Response.Write "<div style='display:block; font-size:14px; text-align:center; margin-top:10px; line-height:1.8;'>" & _
			                    "Sorry, We received a malformed url, if this problem continues, please contact us." & _
							    "</div>"
			   End If
  
  Else
  
    Response.Write "<div style='display:block; font-size:14px; text-align:center; margin-top:40px; line-height:1.8;'>" & _
	               "<b>We could not find the url you requsted.</b><br/> Some of our email links are time sensitive for security reasons.<br/>Contact us should this continue to happen." & _
	               "<br/><a href='/'>Click here</a> to return to the home page." & _
				   "</div>"
  
  End If
  


// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
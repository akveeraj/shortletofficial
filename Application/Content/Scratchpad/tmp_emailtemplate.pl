<%

  HostName = Request.ServerVariables("HTTP_HOST")
  
  EmailHeader = "<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">" & vbcrlf & _
                "<html xmlns=""http://www.w3.org/1999/xhtml"">" & vbcrlf & _
				"<head>" & vbcrlf & _
				"<meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8""/>" & vbcrlf & _
				"<title></title>" & vbcrlf & _
				"<meta name=""viewport"" content=""width=device-width, initial-scale=1.0""/>" & vbcrlf & _
				"</head>" & vbcrlf & _
				"<body style=""margin:0; padding:0; background:#fdfbf8;"">" & vbcrlf & _
				"<table border=""0"" cellpadding=""0"" cellspacing=""0"" width=""799"" align=""center"" style='border:solid 5px #e0d3b6; padding:1px; margin-top:10px;'>" & vbcrlf & _
				"<tr>" & vbcrlf & _
				"<td><img src='http://" & HostName & "/application/library/media/emailheader.png' alt='header'/></td>" & vbcrlf & _
				"</tr>" & vbcrlf & _
				"<tr>" & vbcrlf & _
				"<td bgcolor=""#fff5de"" style=""cursor:default; border-top:solid 4px #cdae68; color:#333333; border-bottom:solid 4px #cdae68; padding: 40px 30px 40px 30px; font-family:arial, serif; font-size:14px; line-height:1.6em;"">" & vbcrlf
  
  EmailFooter = "<br/><br/>Kind Regards,<br/>" & vbcrlf & _
				"Town and Gown Shortlets UK<br/>" & vbcrlf & _
				"<b>web:</b> <a href='http://www.townandgownshortlets.uk' target='_blank'>www.townandgownshortlets.uk</a><br/>" & vbcrlf & _
				"<b>Email:</b> tgshortlets@aol.co.uk<br/>" & vbcrlf & _
				"<b>Tel:</b> +44 (0)7468 238 219" & vbcrlf & _
				
                "</td>"    & vbcrlf & _
                "</tr>"    & vbcrlf & _
				"<tr>"     & vbcrlf & _
				"<td bgcolor=""#f1dbaa""  style=""padding: 30px 30px 30px 30px; border-bottom:solid 1px #cdae68; cursor:default;"">" & vbcrlf & _
				"<table border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"" style='font-family: arial, serif; font-size:12px; line-height:1.6em;'>" & vbcrlf & _
				"<tr>"     & vbcrlf & _
				"<td style='border-bottom-left-radius:10px; border-bottom-right-radius:10px; border-top-left-radius:0px; border-top-right-radius:0px;'>" & vbcrlf & _
				"<b>&copy;" & Year(Now) & " Town and Gown Shortlets UK</b><br/>" & vbcrlf & _
				"You have received this message because you are either a registered member " & vbcrlf & _
				" at townandgownshortlets.uk or you have subscribed to one of our alert services. <a href='http://" & HostName & "/details/account/'>Click here to cancel your account</a>" & vbcrlf & _
				"</td>"    & vbcrlf & _
				"</tr>"    & vbcrlf & _
				"</table>" & vbcrlf & _
				"</td>"    & vbcrlf & _
				"</tr>"    & vbcrlf & _
				"</table>" & vbcrlf & _
				"</body>"  & vbcrlf & _
				"</html>"  & vbcrlf
				
				Response.Write EmailHeader & EmailFooter
				
%>

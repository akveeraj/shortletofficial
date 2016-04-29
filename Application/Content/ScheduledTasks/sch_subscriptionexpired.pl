<!--#include virtual="/includes.inc"-->
<!--#include virtual="/framework/extensions/json/json.parser.plugin"-->

<%
// --------------------------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  Label      = ParseCircuit( "tasklabel", o_Query )
  IpAddress  = Request.ServerVariables("REMOTE_HOST") 
  
  If Label = "" Then
    Proceed = 0
  Else
    Proceed = 1
  End If

// --------------------------------------------------------------------------------------------------------------------------
// ' Check Alert Subscriptions
// --------------------------------------------------------------------------------------------------------------------------

  SubSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM propertyalerts"
           Call FetchData( SubSQL, SubRs, ConnTemp )
		   
  SubCount = SubRs("NumberOfRecords")
  Call CloseRecord( SubRs, ConnTemp )

// --------------------------------------------------------------------------------------------------------------------------

  If SubCount > "0" Then
    
	SubSQL = "SELECT * FROM propertyalerts"
	         Call FetchData( SubSQL, SubRs, ConnTemp )
			 
			 ExpNumber = 0 
			 Do While Not SubRs.Eof
			   ExpNumber          = CInt(ExpNumber) + CInt(1)
			   SubEmail           = SubRs("email")
			   SubExpiryDate      = SubRs("expirydatetime")
			   SubExpiry          = SubRs("expirydate")
			   SubId              = SubRs("subid")
			   SubTxId            = SubRs("txid")
			   SubEmail           = SubRs("email")
			   ExpiryCheck        = SubRs("lastexpirycheck")
			   ExpiryCheckTime    = SubRs("lastexpirychecktime")
			   LastExpiryCheck    = CheckDateDifference( ExpiryCheck, Date() )
			   ExpiredAlert       = IsAlertExpired( SubExpiry )
			   SubReq             = SubRs("requirement")
			   SubCity            = SubRs("city")
			   SubMethod          = SubRs("alertmethod")
			   SubDuration        = SubRs("duration")
			   SubTotal           = SubRs("paytotal")
			   SubDesc            = SubRs("subdesc")
			   SubMobile          = SubRs("mobile")
			   SubCountryCode     = SubRs("countrycode")
			   SubTxId            = SubRs("txid")
			   ExpDate            = DateAdd( "d", SubDuration, Date() )
			   ExpDate            = Split( ExpDate, "/" )
			   ExpDay             = ExpDate(0)
			   ExpDay             = FixSingleDigits( ExpDay )
			   ExpMonth           = ExpDate(1)
			   ExpMonth           = FixSingleDigits( ExpMonth )
			   ExpYear            = ExpDate(2)
			   ExpTime            = Var_TimeStamp
			   ExpDate            = ExpYear & "-" & ExpMonth & "-" & ExpDay
			   ExpDateTime        = ExpDate & " " & ExpTime
			   SubEmailDesc       = SubReq & " in " & SubCity & " [" & SubId & "]"
			   NewTxId            = Sha1( Timer() & Rnd() )
			   
  If SubDesc > "" Then SubDesc = HexToString( SubDesc ) End If
  
  Response.Write LastExpiryCheck & " - " & ExpiredAlert & "<br/>"
			   
  If LastExpiryCheck > 4 AND ExpiredAlert = 1 AND Proceed = "1" Then
 
// --------------------------------------------------------------------------------------------------------------------------
// ' Update Last Expiry Check
// --------------------------------------------------------------------------------------------------------------------------

  UpdSQL = "UPDATE propertyalerts SET " & _
           "lastexpirycheck='" & Var_DateNoTimeStamp & "', lastexpirychecktime='" & Var_DateStamp & "'" & _
           "WHERE subid='" & SubId & "' AND txid='" & SubTxId & "' AND email='" & SubEmail & "'"
		   'Call SaveRecord( UpdSQL, UpdRs, ConnTemp )
		   'Call CloseRecord( UpdRs, ConnTemp )
		   
// --------------------------------------------------------------------------------------------------------------------------
// ' Write Data
// --------------------------------------------------------------------------------------------------------------------------

  Data  = "req:" & SubReq & ";city:" & SubCity & ";method:" & SubMethod & ";" & _
		  "duration:" & SubDuration & ";total:" & SubTotal & ";desc:" & SubDesc & ";" & _
		  "mobile:" & SubMobile & ";countrycode:" & SubCountryCode & ";txid:" & SubTxId & ";newtxid:" & NewTxId & ";" & _
		  "subid:" & SubId & ";expirydate:" & ExpDate & ";expirydatetime:" & ExpDateTime & ";email:" & SubEmail
		  
  If Data > "" Then Data = StringToHex( Data ) End If
		   
// --------------------------------------------------------------------------------------------------------------------------
// ' Send Expired Alert Confirmation
// --------------------------------------------------------------------------------------------------------------------------
  
  HostName    = Request.ServerVariables("HTTP_HOST")
  EmailUrl    = "http://" & HostName & "/alertservicerenewppl/checkout/?data:" & Data
  NewShortUrl = ShortUrl(EmailUrl)
  EmailBody   = "Your subscription `<b>" & SubEmailDesc & "</b>` is expiring.<br/>" & _
                "So that you don't miss out on Property Alerts, please click the link below to renew your subscription.<br/><br/>" & _
			    "<b><a href='" & NewShortUrl & "' target='_blank'>" & NewShortUrl & "</a></b><br/><br/>" & vbcrlf & _
			    "Once your subscription has been renewed, you will continue to receive your Weekly Alerts."
   
  EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Your Property Alert Subscription is expiring</h2>" & vbcrlf & _
                  EmailBody & vbcrlf
					
  MxSubject   = "Your Property Alert Subscription is expiring"
  MxReplyTo   = "tgshortlets@aol.co.uk"
  MxFrom      = "support@townandgownshortlets.uk"
  MxFromName  = "Town and Gown Shortlets UK"
  MxQueue     = False
  MxIsHtml    = True
  MxRecipient = SubEmail
  MxAppend    = False
  MxTLS       = 0
  Salutation  = "Subscriptions Team"
  PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooterNoRegister(Salutation)
	
  Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )

// --------------------------------------------------------------------------------------------------------------------------
				 
  End If
			   
			 SubRs.MoveNext
			 Loop

  End If  
  
// --------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = 1 Then

  SQL = "INSERT INTO scheduledtask_log " & _
        "( " & _
		"task, completed, ipaddress"  & _
		") " & _
		"VALUES(" & _
		"'Email Alert Expiry Check', " & _
		"'" & Var_DateStamp & "', " & _
		"'" & IpAddress     & "'  " & _
		")"
		Call SaveRecord( SQL, RsTemp, ConnTemp )
		Call CloseRecord( RsTemp, ConnTemp )
		
  End If

// --------------------------------------------------------------------------------------------------------------------------
%>
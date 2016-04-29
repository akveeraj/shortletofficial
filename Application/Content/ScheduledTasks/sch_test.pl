<!--#include virtual="/includes.inc"-->
<!--#include virtual="/framework/extensions/json/json.parser.plugin"-->

<%
// ---------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
  Label      = ParseCircuit( "tasklabel", o_Query )
  IpAddress  = Request.ServerVariables("REMOTE_HOST") 
  
  If Label = "" Then
    Proceed = 0
  Else
    Proceed = 1
  End If
  
// ---------------------------------------------------------------------------------------------------------
// ' GET PROPERTY COUNT
// ---------------------------------------------------------------------------------------------------------

  Function GetPropertyCount( Req, City, ConnTemp )
  
	Req   = Replace( Req," Bed", "" )
	Req   = Replace( Req,"+", "" )
	Req   = Replace( Req,"Rooms", "Room" )
  
    ProCSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE location='" & City & "' AND roomamount='" & Req & "'"
	          Call FetchData( ProCSQL, ProCRs, ConnTemp )
			  
	ProCCount = ProCRs("NumberOfRecords")
	Call CloseRecord( ProCRs, ConnTemp )
	
	GetPropertyCount = ProCCount
  
  End Function
  
// ---------------------------------------------------------------------------------------------------------
// ' GET PROPERTY LIST
// ---------------------------------------------------------------------------------------------------------

  Function GetPropertyList( Req, City, ConnTemp )
    Req   = Req
	Req   = Replace( Req," Bed", "" )
	Req   = Replace( Req,"+", "" )
	Req   = Replace( Req,"Rooms", "Room" )
	City  = City
  
    ProSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE location='" & City & "' AND roomamount='" & Req & "'"
	         Call FetchData( ProSQL, ProRs, ConnTemp )
			   
    ProCount = ProRs("NumberOfRecords")
	Call CloseRecord( ProRs, ConnTemp )
	
	LineId = 0
	
	If ProCount > "0" Then
	
	  ProSQL = "SELECT * FROM shortlets WHERE location='" & City & "' AND roomamount='" & Req & "' ORDER BY RAND() LIMIT 20"
	           Call FetchData( ProSQL, ProRs, ConnTemp )
			   
	  Do While Not ProRs.Eof
	  LineId = CInt(LineId) + 1
	  
	  ProTitle    = ProRs("title")
	  If ProTitle > "" Then ProTitle = HexToString( ProTitle ) End If
	  
	  ProPrice       = ProRs("rent")
	  IncBills       = ProRs("incbills")
	  ListingId      = ProRs("listingid")
	  AdvertId       = ProRs("advertid")
	  Location       = ProRs("location")
	  Thumb          = ProRs("photo")
	  Period         = ProRs("period")
	  NextDay        = ProRs("nextday")
	  NextMonth      = ProRs("nextmonth")
	  NextYear       = ProRs("nextyear")
	  AvailDate      = NextDay & "/" & NextMonth & "/" & NextYear
	  AvailDate      = FormatDateTime( AvailDate, 2 )
	  ProDesc        = ProRs("description")
	  ProIsVert      = ProRs("isvertical")
	  ProDescLen     = Len(ProDesc)
	  
	  If ProDesc > "" Then ProDesc = HexToString( ProDesc ) End If
	  If ProDesc > "" Then ProDesc = UrlDecode( ProDesc ) End If
	  If ProDescLen > 280 Then ProDesc = Left( ProDesc, 280 ) & "...." End If
	  If ProIsVert = "1" Then ThumbWidth = "80" Else ThumbWidth = "150" End If
	  
	  If Period = "Weekly" Then
	    Period = "pw"
	  ElseIf Period = "Monthly" Then
	    Period = "pm"
	  End If
	  
	  FixProTitle = Replace( ProTitle, " ", "-" )
	  FixProTitle = strClean( FixProTitle )
	  HostName    = Request.ServerVariables("HTTP_HOST")
	  LongUrl     = "http://" & HostName & "/" & FixProTitle & "*" & AdvertId & "/details/"
	  NewShortUrl = ShortUrl( LongUrl )
	  
	  If LineId Mod 2 = 1 Then
	    TableStyle = "#ffffff"
	  Else
	    TableStyle = "#ffffff"
	  End If
	  
	  If IncBills = "1" Then IncBills = "including bills" Else IncBills = "excluding bills" End If

	  BuildList = BuildList & vbcrlf & vbcrlf & _
	              "<table width=""730"" border=""0"" align=""center"" bordercolor=""#ffffff"" cellspacing=""0"" style='cursor:default; font-family:arial, serif; line-height:1.8em; clear:both; margin-bottom:5px;' cellpadding=""10"">" & vbcrlf & _
	              "<tr bgcolor=""" & TableStyle & """ valign='top'>" & vbcrlf & _
				  "<td width='150' align=""center""><img src='http://" & HostName & "/uploads/thumbs/" & Thumb & "' width=""" & ThumbWidth & """/></td>" & vbcrlf & _
				  "<td>" & vbcrlf & _
				  "<span style='font-size:12pt;'><b>" & ProTitle & "</b></span><br/>" & vbcrlf & _
				  "<span style='font-size:10pt; color:#cc0000; margin-bottom:5px;'>&pound;" & ProPrice & Period & " " & IncBills & " (" & Location & ") - Available Date: " & AvailDate & "</span>" & vbcrlf & _
				  "<span style='font-size:10pt; color:#333333; line-height:1.6em;'>" & vbcrlf & _
				  "<br/><br/>" & ProDesc & vbcrlf & _
				  "<br/><br/><b>Click for full details: <a href='" & NewShortUrl & "' target='_blank'>" & NewShortUrl & "</b></a>" & vbcrlf & _
				  "</span>" & vbcrlf & _
				  "</td>" & vbcrlf & _
				  "</tr>" & vbcrlf & _
				  "</table><span style='display:block; clear:both; width:100px; height:10px;'></span>" & vbcrlf & vbcrlf & vbcrlf
				  
	  ProRs.MoveNext
	  Loop
	  Call CloseRecord( ProRs, ConnTemp )
				  
	  GetPropertyList = BuildList
		
	End If
  
  End Function

// ---------------------------------------------------------------------------------------------------------
// ' Get Subscriptions
// ---------------------------------------------------------------------------------------------------------

  SubSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM propertyalerts WHERE expirydatetime > CURRENT_TIMESTAMP() AND paid='1'"
           Call FetchData( SubSQL, SubRs, ConnTemp )
		   
  SubCount = SubRs("NumberOfRecords")
  
  If SubCount > "0" Then
  
    SubSQL = "SELECT * FROM propertyalerts WHERE expirydatetime > CURRENT_TIMESTAMP() AND paid='1'"
	         Call FetchData( SubSQL, SubRs, ConnTemp )
			 
	Do While Not SubRs.Eof
	  
	  Requirement  = SubRs("requirement")
	  City         = SubRs("city")
	  PropertyList = GetPropertyList( Requirement, City, ConnTemp )
	  SubId        = SubRs("subid")
	  Expiry       = SubRs("expirydate")
	  Expiry       = FormatDateTime( Expiry, 1 )
	  EmailAddress = SubRs("email")
	  SubId        = SubRs("subid")
	  TxId         = SubRs("txid")
	  
	  PropertyCount = GetPropertyCount( Requirement, City, ConnTemp )
	  
	  If PropertyCount > "0" Then

// ---------------------------------------------------------------------------------------------------------
// ' Send Email Alerts
// ---------------------------------------------------------------------------------------------------------

  ActionData  = "email:" & EmailAddress & ";subid:" & SubId & ";txid:" & TxId
  ActionData  = StringToHex( ActionData )
  CurrentDate = Var_DateStamp
  CurrentDate = FormatDateTime( CurrentDate, 1 )
  
  If IsNumeric( Requirement ) Then Requirement = Requirement & " Bed" End If
  
  EmailBody   = "Please find below our list of properties based on " & _
                "your subscription '" & Requirement & " in " & City & "'.<br/>" & _
			    "<b>Your Subscription will expire on <span color:#cc0000;'>" & Expiry & "</span></b><br/><br/>" & _
			    PropertyList & "<br/>" & _
			    "<a href='http://" & HostName & "/amend/subscriptions/?data:"  & ActionData & "'><b>Click here</b></a> if you would like to amend your Property Alert Subscription Requirements<br/>" & _
			    "<a href='http://" & HostName & "/cancel/subscriptions/?data:" & ActionData & "'><b>Click here</b></a> if you would like to cancel your Property Alert Subscription."
			  
			  
			  
   EmailContent  = "<h2 style=""color:#7a6a51; font-weight:bold;"">Weekly Property Alerts " & CurrentDate & ".</h2>" & vbcrlf & _
                   EmailBody & vbcrlf
					
	MxSubject   = "Weekly Property Alerts " & CurrentDate
	MxReplyTo   = "tgshortlets@aol.co.uk"
	MxFrom      = "support@townandgownshortlets.uk"
	MxFromName  = "Town and Gown Shortlets UK"
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = EmailAddress
	MxAppend    = False
	MxTLS       = 0
					
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooterNoRegister()
	
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
			  
			  
// ---------------------------------------------------------------------------------------------------------
	 
	  End If

	SubRs.MoveNext
	Loop
			 
    Call CloseRecord( SubRs, ConnTemp )
  
  
  End If

// ---------------------------------------------------------------------------------------------------------

  If Proceed = 1 Then

  SQL = "INSERT INTO scheduledtask_log " & _
        "( " & _
		"task, completed, ipaddress"  & _
		") " & _
		"VALUES(" & _
		"'" & Label & " - " & SubCount & " Email Alerts Sent', " & _
		"'" & Var_DateStamp & "', " & _
		"'" & IpAddress     & "'  " & _
		")"
		Call SaveRecord( SQL, RsTemp, ConnTemp )
		Call CloseRecord( RsTemp, ConnTemp )
		
  End If
  
// ---------------------------------------------------------------------------------------------------------
%>
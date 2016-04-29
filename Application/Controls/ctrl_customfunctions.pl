<%
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' File Name : ctrl_customfunctions.pl
// ' Function  : Put all your custom SUBROUTINES and FUNCTIONS here
// ' Author    : Patrick Johnson - me@patrickjohnson.co.uk
// ' Updated   : 30 September 2014
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Account
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function CheckAccountStatus(CustomerId, ConnTemp)
   CustomerId = CustomerId
   
   AccSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & CustomerId & "'"
            Call FetchData( AccSQL, AccRs, ConnTemp )
			
   AccCount = AccRs("NumberOfRecords")
   
   CheckAccountStatus = AccCount
   
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate File Name for uploading
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function ValidateFileName(String)
    Set regEx = New RegExp
	  regEx.IgnoreCase = False
	  regEx.Pattern = "[\\\/:\*\?""',;<>|]"
	  ValidFile = regEx.Test(Trim(String))
	  ValidFile = LCase( ValidFile )
	Set regEx = Nothing
	
	If ValidFile = "true" Then
	  ValidateFileName = 0
	Else
	  ValidateFileName = 1
	End If
	
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Clean String
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function strClean (strtoclean)
    'Dim objRegExp, outputStr
    Set objRegExp = New Regexp

    objRegExp.IgnoreCase = True
    objRegExp.Global = True
    objRegExp.Pattern = "((?![a-zA-Z0-9]).)+"
    outputStr = objRegExp.Replace(strtoclean, "-")

    objRegExp.Pattern = "\-+"
    outputStr = objRegExp.Replace(outputStr, "-")

    strClean = outputStr
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Split Array
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function SplitArray( String, Constraint )
    String     = String
	Constraint = Constraint
	On Error Resume Next
	
	If String > "" AND Constraint > "" Then
	  String     = Split( String, Constraint )
	  SplitArray = String(1)
	Else
	  SplitArray = ""
	End If
  End Function

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Generate Month
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function GenMonth(String)
    If String > "" Then
      String   = String
	  GenMonth = MonthName(String)
	Else
	  GenMonth = ""
	End If
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Format Date
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function DoFormatDate(String)
    If String > "" Then
	  String = Split( String, "/" )
	  FormDay      = String(0)
	  FormMonth    = String(1)
	  FormYear     = String(2)
	  FormYear     = Left( FormYear, 4 )
	  DoFormatDate = FormDay & " " & UCase(Left(MonthName(FormMonth),3)) & " " & FormYear
	Else
	  DoFormatDate = ""
	End If
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Get City List 
// ---------------------------------------------------------------------------------------------------------------------------------------------
  
  Public Function WriteCities(ConnTemp)
    CitySQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM uk_Cities"
              Call FetchData( CitySQL, CityRs, ConnTemp )
			  
    CityCount = CityRs("NumberOfRecords")
  
    If CityCount > "0" Then
  
      CitySQL = "SELECT * FROM uk_cities ORDER BY city ASC"
	            Call FetchData( CitySQL, CityRs, ConnTemp )
			  
	  Do WHILE NOT CityRs.Eof
	    City     = CityRs("city")
	    CityList = CityList & "<option value='" & City & "'>" & City & "</option>"
	
	  CityRs.MoveNext
	  Loop
	  
	  WriteCities = CityList
  
  End If
  
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Function SelectListCss(listid) 
    If listid Mod 2 = 1 Then
	  TableStyle = "list_on"
	Else
	  TableStyle = "list_off"
	End If
	
	SelectListCss = TableStyle
	
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Function Remove_QS_Parameter(qs, p)
    Dim retVal, re
    Set re = New RegExp
    re.Pattern = "(\?|&)" & p & "=.*?(&|$)"
    retVal = re.Replace(qs,"$2")
    If Left(retVal,1) = "&" Then retVal = "?" & Mid(retVal,2)
    Remove_QS_Parameter = retVal
  End Function

// ---------------------------------------------------------------------------------------------------------------------------------------------


  Public Function IsAdvertExpired( ListingId, ConnTemp )
    
	ListingId = ListingId
	ConnTemp  = ConnTemp
	
	AdCountSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
	             Call FetchData( AdCountSQL, AdCountRs, ConnTemp )
				 
	AdCount = AdCountRs("NumberOfRecords")
	
	If AdCount > "0" Then
	
	  AdExpiredSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "' AND adexpires < CURRENT_TIMESTAMP()"
	                 Call FetchData( AdExpiredSQL, AdExpiredRs, ConnTemp )
					 
      AdExpiredCount = AdExpiredRs("NumberOfRecords")
	  
	  If AdExpiredCount > "0" Then
	    AdExpired = 1
	  Else
	    AdExpired = 0
	  End If
	
	  IsAdvertExpired = AdExpired
	  
	End If
	
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Public Function GetMyAdvertImg( ImgSrc, ImgAdNumber, ShowThumb, IsFeatured )
    ImgSrc       = "/uploads/thumbs/" & ImgSrc
	ImgAdNumber  = "img_" & ImgAdNumber
	
	If ShowThumb = "1" AND IsFeatured = "0" Then
      
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='dash_list_picture'>" & vbcrlf & _
	             "<span class='" & ImgAdNumber & "'><img src='" & ImgSrc & "'/></span>" & _
	             "</div>" & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	  
	ElseIf ShowThumb = "1" AND IsFeatured = "1" Then
      
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='dash_list_picture'>" & vbcrlf & _
	             "<span class='" & ImgAdNumber & "'><span class='dash_picture_featured'></span><img src='" & ImgSrc & "'/></span>" & _
	             "</div>" & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	
	ElseIf ShowThumb = "0" AND IsFeatured = "1" Then
	  
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='dash_list_picture'>" & vbcrlf & _
	             "<span class='" & ImgAdNumber & "'><img src='/application/library/media/featuredlabelnoimg.png'/></span>" & _
	             "</div>" & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	  
	Else
	  
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='dash_list_picture'>" & vbcrlf & _
	             "<img src='/application/library/media/notlet_nopic.png'/>" & _
	             "</div>" & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	  
	End If
	
	GetMyAdvertImg = ThumbSrc
  
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  Public Function GetPropertyImg( ImgSrc, ImgAdNumber, ShowThumb, IsFeatured, ImgCountlabel  )
  
    ImgSrc = "/uploads/thumbs/" & ImgSrc
	ImgAdNumber = "img_" & ImgAdNumber
	
	If ShowThumb = "1" AND IsFeatured = "0" Then
      
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='list_picture'>" & vbcrlf & _
	             "<span class='" & ImgAdNumber & "'><img src='" & ImgSrc & "'/></span>" & _
	             "</div>" & vbcrlf & _
	             ImgCountLabel & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	  
	ElseIf ShowThumb = "1" AND IsFeatured = "1" Then
      
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='list_picture'>" & vbcrlf & _
	             "<span class='" & ImgAdNumber & "'><img src='" & ImgSrc & "'/></span>" & _
	             "</div>" & vbcrlf & _
	             ImgCountLabel & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	
	ElseIf ShowThumb = "0" AND IsFeatured = "1" Then
	  
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='list_picture'>" & vbcrlf & _
	             "<span class='" & ImgAdNumber & "'><img src='/application/library/media/notlet_nopic.png'/></span>" & _
	             "</div>" & vbcrlf & _
	             ImgCountLabel & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	  
	Else
	  
	  ThumbSrc = "<div class='cell' style='width:160px;'>" & vbcrlf & _
	             "<div class='list_picture'>" & vbcrlf & _
	             "<img src='/application/library/media/notlet_nopic.png'/>" & _
	             "</div>" & vbcrlf & _
	             ImgCountLabel & vbcrlf & _
	             "</div>" & vbcrlf & vbcrlf 
	  
	End If
	
	GetPropertyImg = ThumbSrc
  
  End function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Trial Remaining Count
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function TrialRemainingCount( customerid, ConnTemp )
    
	AccSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
	           Call FetchData( AccSQL, AccRs, ConnTemp )
			 
    AccCount = AccRs("NumberOfRecords")
	
	If AccCount > "0" Then
	
	  AccSQL = "SELECT * FROM members WHERE customerid='" & CustomerId & "'"
	           Call FetchData( AccSQL, AccRs, ConnTemp )

			   EndDate          = AccRs("paiduntilnostamp")
			   TrialDuration    = AccRs("sublength")
			   EndDays          = CalcDaysPassed( EndDate )
			   
			   If Instr( EndDays, "-" ) = "0" Then
			     EndDays = "0"
			   End If
			   
			   If EndDays > "" Then EndDays = Replace( EndDays, "-", "" )
			   
			   TrialRemainingCount = EndDays

	End If
  
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if account is expired
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function IsAccountExpired( Var_UserId, ConnTemp )
  
    On Error Resume Next
	Var_UserId = Var_UserId
	COnnTemp   = ConnTemp
	
	AccSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
	            Call FetchData( AccSQL, AccRs, ConnTemp )
			 
	AccCount  = AccRs("NumberOfRecords")
	
	If AccCount > "0" Then
	
	  AccSQL  = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
	            Call FetchData( AccSQL, AccRs, ConnTemp )
				
				EndDate        = AccRs("paiduntilnostamp")
				TrialDuration  = AccRs("sublength")
                EndDays        = CalcDaysPassed( EndDate )
                
                If Instr( EndDays, "-" ) = "0" Then
                  TrialExpired = 1
                Else
                  TrialExpired = 0
                End If

      IsAccountExpired = TrialExpired				
	
	End If
	
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function WriteEmailHeader()
  
  HostName    = Request.ServerVariables("HTTP_HOST")
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
				"<td style='line-height: 0; margin:0; padding: 0px 0px 0px 0px;'><img src='http://" & HostName & "/application/library/media/emailheader.png' alt='header' style='margin:0px; padding:0px;'/></td>" & vbcrlf & _
				"</tr>" & vbcrlf & _
				"<tr>" & vbcrlf & _
				"<td bgcolor=""#fff5de"" style=""cursor:default; border-top:solid 4px #4d4739; margin-bottom:1px; color:#333333; border-bottom:solid 4px #cdae68; padding: 40px 30px 40px 30px; font-family:arial, serif; font-size:14px; line-height:1.6em;"">" & vbcrlf
				
    WriteEmailHeader = EmailHeader
				
  End Function

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Write Email Footer
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function WriteEmailFooter(Salutation)
  
    If Salutation > "" Then Salutation = Salutation & "<br/>" End If
    
	HostName    = Request.ServerVariables("HTTP_HOST")
    EmailFooter = "<br/><br/>Kind Regards,<br/>" & vbcrlf & _
	              Salutation & vbcrlf & _
				  "Town and Gown Shortlets UK<br/><br/>" & vbcrlf & _
				  "<b>Web:</b> <a href='http://www.townandgownshortlets.uk' target='_blank'>www.townandgownshortlets.uk</a><br/>" & vbcrlf & _
				  "<b>Email Support: </b> tgshortlets@aol.co.uk<br/>" & vbcrlf & _
				  "</td>"    & vbcrlf & _
                  "</tr>"    & vbcrlf & _
				  "<tr>"     & vbcrlf & _ 
				  "<td bgcolor=""#f1dbaa""  style=""padding: 30px 30px 30px 30px; border-bottom:solid 1px #cdae68; cursor:default;"">" & vbcrlf & _
				  "<table border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"" style='font-family: arial, serif; font-size:12px; line-height:1.6em;'>" & vbcrlf & _
				  "<tr>"     & vbcrlf & _
				  "<td style='border-bottom-left-radius:10px; border-bottom-right-radius:10px; border-top-left-radius:0px; border-top-right-radius:0px;'>" & vbcrlf & _
				  "<b>&copy;" & Year(Now) & " Town and Gown Shortlets UK</b><br/>" & vbcrlf & _
				  "You have received this message because you are a registered member " & vbcrlf & _
				  " at townandgownshortlets.uk. <a href='http://" & HostName & "/details/account/'>Click here to cancel your account</a>" & vbcrlf & _
				  "<br/> <span style='font-size:8pt;'>Message sent at " & Var_DateStamp & "</span>" & vbcrlf & _
				  "</td>"    & vbcrlf & _
				  "</tr>"    & vbcrlf & _
				  "</table>" & vbcrlf & _
				  "</td>"    & vbcrlf & _
				  "</tr>"    & vbcrlf & _
				  "</table>" & vbcrlf & _
				  "</body>"  & vbcrlf & _
				  "</html>"  & vbcrlf
  
    WriteEmailFooter = EmailFooter
  
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
  
  Public Function WriteEmailFooterNoRegister(Salutation)
  
    If Salutation > "" Then Salutation = Salutation & "<br/>" End If
  
	HostName    = Request.ServerVariables("HTTP_HOST")
    EmailFooter = "<br/><br/>Kind Regards,<br/>" & vbcrlf & _
	              Salutation & vbcrlf & _
				  "Town and Gown Shortlets UK<br/><br/>" & vbcrlf & _
				  "<b>Web:</b> <a href='http://www.townandgownshortlets.uk' target='_blank'>www.townandgownshortlets.uk</a><br/>" & vbcrlf & _
				  "<b>Email Support: </b> tgshortlets@aol.co.uk<br/>" & vbcrlf & _
				  "<b>For Live Support: </b> +44 (0)7468 238 219 ( 12pm - 4pm GMT )" & vbcrlf & _
				  "</td>"    & vbcrlf & _
                  "</tr>"    & vbcrlf & _
				  "<tr>"     & vbcrlf & _
				  "<td bgcolor=""#f1dbaa""  style=""padding: 30px 30px 30px 30px; border-bottom:solid 1px #cdae68; cursor:default;"">" & vbcrlf & _
				  "<table border=""0"" cellpadding=""0"" cellspacing=""0"" width=""100%"" style='font-family: arial, serif; font-size:12px; line-height:1.6em;'>" & vbcrlf & _
				  "<tr>"     & vbcrlf & _
				  "<td style='border-bottom-left-radius:10px; border-bottom-right-radius:10px; border-top-left-radius:0px; border-top-right-radius:0px;'>" & vbcrlf & _
				  "<b>&copy;" & Year(Now) & " Town and Gown Shortlets UK</b><br/>" & vbcrlf & _
				  "You have received this message because you are subscribed to our Property Alert Service." & vbcrlf & _
				  "<br/><span style='font-size:8pt;'>Message sent at " & Var_DateStamp & "</span>" & vbcrlf & _
				  "</td>"    & vbcrlf & _
				  "</tr>"    & vbcrlf & _
				  "</table>" & vbcrlf & _
				  "</td>"    & vbcrlf & _
				  "</tr>"    & vbcrlf & _
				  "</table>" & vbcrlf & _
				  "</body>"  & vbcrlf & _
				  "</html>"  & vbcrlf
  
    WriteEmailFooterNoRegister = EmailFooter
  End Function
  	
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Get date in the past
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function GetPastDate( DayMonthWeek, PlusMinusDate, FormatDate )
	  Date1       = DateAdd( DayMonthWeek, PlusMinusDate, FormatDate )
		GetPastDate = Date1
	End Function

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Write Record Paging
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function WriteRecordPaging( PageSize, PageWidth )
	
	End Function
	
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if file exists
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function CheckFileSource( String )
	SET fs = Server.CreateObject("Scripting.FileSystemObject")
	  If FS.FileExists( String ) = true Then
	    FileDoesExist = 1
	  Else
		FileDoesExist = 0
	  End If
		
	  CheckFileSource = FileDoesExist
		
	SET fs = Nothing
	
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Send SMS through Gateway
// ---------------------------------------------------------------------------------------------------------------------------------------------
  
	Public Function SendSMS( SMSNumber, SMSBody, SMSUser, SMSPass, ParametersDict, SMSUrl )
	  
		SMSUrl   = SMSUrl
		SMSUser  = SMSUser
		SMSPass  = SMSPass
		Pars     = "Username=" & SMSUser & "&Password=" & SMSPass
		
		Items = ParametersDict.Items
		Keys  = ParametersDict.Keys
		
		For i = 0 To UBound( Items )
		  Pars = Pars & "&" & Keys(i) & "=" & Items(i)
		Next
		
		Set SMSHttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
		  SMSHttp.Open "POST", SMSUrl, False
			SMSHttp.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
			SMSHttp.Send Pars
			Response.ContentType = "text/html"
			PostResponse = SMSHttp.ResponseText
		Set SMSHttp = Nothing
		
	End Function
	
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Google Short Url API
// ---------------------------------------------------------------------------------------------------------------------------------------------

  Public Function ShortUrl( Url )
    Method       = "POST"
	ReqAuth      = 0
	APIKey       = "AIzaSyBAYTRIUi5JKTeGaE6lnk1DDVsI-pOIjsQ"
	EndPoint     = "https://www.googleapis.com/urlshortener/v1/url?key=" & APIKey
	Params       = "{""longUrl"": """ & Url & """}"
	ContentType  = "application/json"
	ShortUrl     = Curl( EndPoint, Method, ReqAuth, AuthUser, AuthPass, Params, ContentType )
	
	Set GetShortUrl = New JSONParser
	  On Error Resume Next
	  GetShortUrl.ParseJSON( ShortUrl )
	  NewShortUrl = GetShortUrl.Data("id")
	  NewLongUrl  = GetShortUrl.Data("longurl")
	Set GetShortUrl = Nothing
	
	ShortUrl = NewShortUrl
  
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' Date Difference
// ---------------------------------------------------------------------------------------------------------------------------------------------
 
  Function CheckDateDifference( DateFrom, DateTo )
	CheckDateDifference = DateDiff("d", DateFrom, DateTo )
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------
// ' IsAlertExpired
// ---------------------------------------------------------------------------------------------------------------------------------------------
  
  Function IsAlertExpired( String )
  
    ExpiryDate     = String
	DaysPassed     = CalcDaysPassed( ExpiryDate )
	
	IsAlertExpired = DaysPassed
	
	If Instr( DaysPassed, "-" ) = "0" Then
	  IsAlertExpired = 1 ' Expired
	Else
	  IsAlertExpired = 0 ' Not Expired
	End If
  
  End Function

// ---------------------------------------------------------------------------------------------------------------------------------------------
%>
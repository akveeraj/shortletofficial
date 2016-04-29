<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = Request.Form
  o_Query      = Replace( o_Query, ";", vbcrlf  )
  Email        = ParseCircuit( "email", o_Query )
  Email        = UrlDecode( email )
  ReplyEmail   = Email
  Phone        = ParseCircuit( "phone", o_Query )
  Phone        = UrlDecode( phone )
  Name         = ParseCircuit( "name", o_Query )
  Name         = UrlDecode( Name )
  Subject      = ParseCircuit( "subject", o_Query )
  Subject      = UrlDecode( Subject )
  Message      = ParseCircuit( "message", o_Query )
  Message      = UrlDecode( Message )
  RPath        = ParseCircuit( "rpath", o_Query )
  ListingId    = ParseCircuit( "listingid", o_Query )
  CustomerId   = ParseCircuit( "customerid", o_Query )
  
  If RPath > "" Then RPath = HexToString( RPath ) End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  AdSQL   =  "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
	         Call FetchData( AdSQL, AdRs, ConnTemp )
			 
  AdCount =  AdRs("NumberOfRecords")
  
  If AdCount > "0" Then
  
    AdSQL = "SELECT * FROM shortlets WHERE listingid='" & ListingId & "'"
	        Call FetchData( AdSQL, AdRs, ConnTemp )
            CUEmail    = AdRs("email")
			CULocation = AdRs("location") 
			AdvertId   = AdRs("advertid")
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate Form
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If AdCount = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "Sorry, something went wrong, we were unable to find the advert you are enquiring about."
  
  ElseIf ListingId = "" Then
    Proceed = 0
	RCode   = 2
	RText   = "Sorry, something went wrong, we will get this fixed as soon as possible."
  
  ElseIf RPath = "" Then
    Proceed = 0
	RCode   = 3
	RText   = "Sorry, something went wrong, we will get this fixed as soon as possible."
	
  ElseIf Email = "" Or Instr( Email, "@" ) = "0" Or Instr( Email, "." ) = "0" Then
    Proceed = 0
	RCode   = 4
	RText   = "Please enter a valid Email Address."
  
  ElseIf Phone > "" AND IsNumeric(Phone) = "0" Then
    Proceed = 0
	RCode   = 5
	RText   = "Please enter a valid Phone Number. Without Spaces or special characters."
  
  ElseIf Name = "" Then
    Proceed = 0
	RCode   = 6
	RText   = "Please enter your Name."
  
  ElseIf Subject = "" Then
    Proceed = 0
	RCode   = 7
	RText   = "Please enter a Message Subject."
  
  ElseIf Message = "" Then
    Proceed = 0
	RCode   = 8
	RText   = "Please enter a message to send to the advertiser."
 
  Else
    Proceed = 1
	RCode   = 9
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Advertiser Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    CuSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & CustomerId & "'"
	          Call FetchData( CuSQL, CuRs, ConnTemp )
			
	CuCount = CuRs("NumberOfRecords")
	
	If CuCount > "0" Then
	
	  CuSQL = "SELECT * FROM members WHERE customerid='" & CustomerId & "'"
	          Call FetchData( CuSQL, CuRs, ConnTemp )
			  
			 Firstname = CuRs("firstname")

	
	End If
    
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND CuCount > "0" Then
  
  EmailBody    = "Hello, " & Firstname & vbcrlf & _
                 "You have a new enquiry from " & Name & ", click the reply button on your email application to respond directly with" & _
				 " the person sending the message.<br/><br/>" & _ 
				 "<hr style='margin-top:10px; margin-bottom:10px;'/><br/>" & _
				 "<b>Name    :</b> " & Name & "<br/>" & _
				 "<b>Phone   :</b> " & Phone & "<br/>" & _
				 "<b>Email   :</b> " & Email & "<br/>" & _
				 "<b>Subject :</b> " & Subject & "<br/><br/><br/>" & _
				 "<b>Message :</b> <br/>" & Message & "<br/><br/><br/>" & _
				 "<hr style='margin-top:10px; margin-bottom:10px;'/>"
				 
  EmailContent = "<h2 style=""color:#7a6a51; font-weight:bold;"">You have a new enquiry</h2>" & vbcrlf & _ 
                 EmailBody & vbcrlf
				 
	MxSubject   = Subject & " (" & UCase(CULocation) & ")"
	MxReplyTo   = ReplyEmail
	MxFrom      = "support@townandgownshortlets.uk" 
	MxFromName  = "Town and Gown Shortlets UK" 
	MxQueue     = False
	MxIsHtml    = True
	MxRecipient = CUEmail
	MxAppend    = False
	MxTLS       = 0
	Salutation  = ""
	
	PlainText   = WriteEmailHeader() & EmailContent & WriteEmailFooter(Salutation)
	Call PersitsMailer( PlainText, MxSubject, MxRecipient, MxReplyTo, MxFrom, MxFromName, MxQueue, MxIsHtml, MxAppend, MxTLS )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Enquiry to logs
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    LineId    = Sha1( Timer()&Rnd() )
	IpAddress = Request.ServerVariables("REMOTE_ADDR")
	DateSent  = Var_DateStamp
  
    LogSQL =  "INSERT INTO ad_enquiry_log " & _
	          "( " & _
			  "listingid, advertid, lineid, emailaddress, recipient, phone, name, subject, message, ipaddress, datesent" & _
			  " )" & _
			  " VALUES ( " & _
			  "'" & ListingId  & "', " & _
			  "'" & AdvertId   & "', " & _
			  "'" & LineId     & "', " & _
			  "'" & StringToHex( Email )      & "', " & _
			  "'" & StringToHex( CUEmail )    & "', " & _
			  "'" & StringToHex( Phone )      & "', " & _
			  "'" & StringToHex( Name )       & "', " & _
			  "'" & StringToHex( Subject )    & "', " & _
			  "'" & StringToHex( EmailBody )    & "', " & _
			  "'" & StringToHex( IpAddress )  & "', " & _
			  "'" & DateSent                  & "'  " & _
			  " )"
			  Call SaveRecord( LogSQL, LogRs, ConnTemp )

  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'rpath':'" & RPath & "'}"
  Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>


<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = Request.Form
  o_Query      = Replace( o_Query, ";", vbcrlf )
  AdTitle      = ParseCircuit( "title", o_Query )
  AdTitle      = Replace( AdTitle, "%C2%A3", "&pound;" )
  AdTitle      = UrlDecode( AdTitle )
  NextDay      = ParseCircuit( "nextday", o_Query )
  NextDay      = UrlDecode( NextDay )
  NextMonth    = ParseCircuit( "nextmonth", o_Query )
  NextMonth    = UrlDecode(NextMonth)
  NextYear     = ParseCircuit( "nextyear", o_Query )
  NextYear     = UrlDecode(NextYear)
  Rent         = ParseCircuit( "rent", o_Query )
  Rent         = UrlDecode(Rent)
  Period       = ParseCircuit( "period", o_Query )
  Period       = UrlDecode(Period)
  IncBills     = ParseCircuit( "incbills", o_Query )
  IncBills     = UrlDecode(IncBills)
  PostCode     = ParseCircuit( "postcode", o_Query )
  PostCode     = UrlDecode(PostCode)
  Location     = ParseCircuit( "location", o_Query )
  Location     = UrlDecode(Location)
  ProType      = ParseCircuit( "protype", o_Query )
  ProType      = UrlDecode(ProType)
  RoomAmount   = ParseCircuit( "roomamount", o_Query )
  RoomAmount   = UrlDecode(RoomAmount)
  Desc         = ParseCircuit( "desc", o_Query )
  Desc         = Replace( Desc, "%C2%A3", "&pound;" )
  ByEmail      = ParseCircuit( "byemail", o_Query )
  ByEmail      = UrlDecode(ByEmail)
  Email        = ParseCircuit( "email", o_Query )
  Email        = UrlDecode( Email )
  ByPhone      = ParseCircuit( "byphone", o_Query )
  ByPhone      = UrlDecode( ByPhone )
  Phone        = ParseCircuit( "phone", o_Query )
  Phone        = UrlDecode( Phone )
  Contact      = ParseCircuit( "contact", o_Query )
  Contact      = UrlDecode( Contact )
  ListingId    = ParseCircuit( "listingid", o_Query )
  ListingId    = UrlDecode( ListingId )
  
  If NextDay > "-" AND NextMonth > "-" AND NextYear > "-" Then
    DatePassed = CalcDaysPassed( NextYear & "/" & NextMonth & "/" & NextDay )
  End If
  
  If Var_ReviewAds = "1" Then NewStatus = "2" Else NewStatus = "1" End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check if listing exists
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
                 Call FetchData( ShortSQL, ShortRs, ConnTemp )
			  
  ListCount = ShortRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If ListCount > "0" Then
  
    ShortSQL = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
	           Call FetchData( ShortSQL, ShortRs, ConnTemp )
			   AccAdvertId = ShortRs("advertid")
			   AccPostCode = ShortRs("postcode")
			   AccAdStatus = ShortRs("status")
			   
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "0" OR Var_LoggedIn = "" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that, <a href=""javascript://"" onclick=""document.location.reload();"">click here</a> to log in."
	RText   = UrlEncode( RText )
	
  ElseIf ListCount = "0" Then
    Proceed = 0
	RCode   = 2
	RText   = "The advert you are trying to modify could not be found."
	
  ElseIf AdTitle = "" Then
    Proceed = 0
	RCode   = 3
	RText   = "Please enter your advert title"
	
  ElseIf NextDay = "-" OR NextMonth = "-" Or NextYear = "-" Then
    Proceed = 0
	RCode   = 4
	RText   = "Please select a valid Available Date."
	
  ElseIf Rent = "" Then
    Proceed = 0
	RCode   = 5
	RText   = "Please enter the rent amount in whole pounds only"

  ElseIf Period = "-" Then
    Proceed = 0
	RCode   = 6
	RText   = "Please select the rental period"
	
  ElseIf ProType = "-" Then
    Proceed = 0
	RCode   = 7
	RText   = "Please select the property type"
	
  ElseIf RoomAmount = "-" Then
    Proceed = 0
	RCode   = 8
	RText   = "Please select the Number of beds."
	
  ElseIf Desc = "" Then
    Proceed = 0
	RCode   = 9
	RText   = "Please enter a description for your advert"
	
  ElseIf ByEmail = "0" AND ByPhone = "0" Then
    Proceed = 0
	RCode   = 9
	RText   = "Please select at least one contact method by the checkboxes provided"
	
  ElseIf ByPhone = "0" AND ByEmail = "0" Then
    Proceed = 0
	RCode   = 10
	RText   = "Please select at least one contact method by the checkboxes provided"
	
  ElseIf ByEmail = "1" And Email = "" Then
    Proceed = 0
	RCode   = 11
	RText   = "Please enter a valid contact email address"
	
  ElseIf ByEmail = "1" AND Instr( Email, "@" ) = "0" Then
    Proceed = 0
	RCode   = 11
	RText   = "Please enter a valid contact email address"

  ElseIf ByEmail = "1" AND Instr( Email, "." ) = "0" Then
    Proceed = 0
	RCode   = 11
	RText   = "Please enter a valid contact email address"
	
  ElseIf ByPhone = "1" AND Phone = "" OR ByPhone = "1" AND IsNumeric(Phone) = False Then
    Proceed = 0
	RCode   = 12
	RText   = "Please enter a valid contact telephone number. No spaces or special characters."
	
  Else
    Proceed = 1
	RCode   = 13
	RText   = "OK"
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Heading + Description
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
    If AdTitle > "" Then AdTitle = StringToHex( AdTitle ) End If
    If Desc > "" Then Desc = StringToHex( Desc ) End If
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Advert
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If AccAdStatus = "3" OR AccAdStatus = "4" Then
    AdStatus = AccAdStatus
  Else
    If NewStatus = "1" Then
	  AdStatus = NewStatus
	Else
	  AdStatus = NewStatus
    End If
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
 
   UdSQL = "UPDATE shortlets SET " & _
           "title='"          & AdTitle       & "', " & _
		   "nextday='"        & NextDay       & "', " & _
		   "nextmonth='"      & NextMonth     & "', " & _
		   "nextyear='"       & NextYear      & "', " & _
		   "rent='"           & Rent          & "', " & _
		   "period='"         & Period        & "', " & _
		   "incbills='"       & IncBills      & "', " & _
		   "postcode='"       & PostCode      & "', " & _
		   "location='"       & Location      & "', " & _
		   "propertytype='"   & ProType       & "', " & _
		   "roomamount='"     & RoomAmount    & "', " & _
		   "description='"    & Desc          & "', " & _
		   "byemail='"        & ByEmail       & "', " & _
		   "email='"          & Email         & "', " & _
		   "byphone='"        & ByPhone       & "', " & _
		   "phone='"          & Phone         & "', " & _
		   "contactname='"    & Contact       & "', " & _
		   "status='"         & AdStatus      & "'"   & _
           "WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
		   Call SaveRecord( UdSQL, UdRs, ConnTemp )
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSON = "{'rtext':'" & RText & "', 'rcode':'" & RCode & "', 'proceed':'" & Proceed & "'}"
  Response.Write JSON

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
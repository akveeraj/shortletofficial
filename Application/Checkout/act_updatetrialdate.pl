<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = Request.Form
  o_Query    = Replace( o_Query, "&", ";" )
  o_Query    = Replace( o_Query, ";", vbcrlf )
  ListingId  = ParseCircuit( "listingid", o_Query )
  UserId     = ParseCircuit( "userid", o_Query )
  AdvertId   = ParseCircuit( "advertid", o_Query )
  Duration   = ParseCircuit( "duration", o_Query )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Listing Id
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ListSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
              Call FetchData( ListSQL, ListRs, ConnTemp )
			
  ListCount = ListRs("NumberOfRecords")

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "" Or Var_LoggedIn = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that."
  ElseIf ListCount = "0" Then
    Proceed = 0
	RCode   = 2
	RText   = "The advert could not be found. It may be deleted or temporarily unavailable."
  Else
    Proceed = 1
	RCode   = 3
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Customer Details
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
    CustSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
                Call FetchData( CustSQL, CustRs, ConnTemp )
			
    CustCount = CustRs("NumberOfRecords")
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
    If CustCount > "0" Then
  
      CustSQL = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
                Call FetchData( CustSQL, CustRs, ConnTemp )
      Firstname         = CustRs("firstname")
      Surname           = CustRs("surname")
      Title             = CustRs("salutation")
      Telephone         = CustRs("telephone")
      Email             = CustRs("emailaddress")
      CustRef           = CustRs("payreference")
      CustomerId        = CustRs("customerid")
	  IsAdmin           = CustRs("administrator")
	  PaidUntilNoStamp  = CustRs("paiduntilnostamp")
	  PaidUntil         = CustRs("paiduntil")
	  NumDays           = CalcDaysPassed( PaidUntil )
	  NumDays           = Replace( NumDays, "-", "" )
    End If 
  End If  
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Update Advert to Trial
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND ListCount > "0" Then
  
	PaidDate      = Split( PaidUntil, "/" )
	NewAdDay      = PaidDate(0)
	NewAdMonth    = PaidDate(1)
	NewAdYear     = PaidDate(2)
	NewAdYear     = Left( NewAdYear,4 )
	NewAdYear     = Replace( NewAdYear, " ", "" )
	
	NewAdStamp    = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay & " " & Time
	NewAdNoStamp  = NewAdYear & "-" & NewAdMonth & "-" & NewAdDay
	
	UdSQL  = "UPDATE shortlets SET " & _
	         "status='1', " & _
			 "adexpires='" & NewAdStamp & "', " & _
			 "adexpiry='"  & NewAdNoStamp & "', " & _
			 "adduration='" & Duration & "', " & _
			 "advertpaid='1', " & _
			 "paymentdescription='Trial - " & Duration & " days', " & _
			 "featured='0' " & _
	         "WHERE listingid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
			 Call SaveRecord( UdSQL, UdRs, ConnTemp )

			
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSOn Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'listingid':'" & ListingId & "'}"
         Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
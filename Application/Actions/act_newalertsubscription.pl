<!--#include virtual="/includes.inc"-->


<%
// ------------------------------------------------------------------------------------------------------------------------

  o_Query      = Request.Form
  o_Query      = Replace( o_Query, "&", ";" )
  o_Query      = Replace( o_Query, ";", vbcrlf )
  Req          = ParseCircuit( "req", o_Query )
  City         = ParseCircuit( "city", o_Query )
  Email        = ParseCircuit( "email", o_Query )
  Method       = ParseCircuit( "method", o_Query )
  Duration     = ParseCircuit( "duration", o_Query )
  Total        = ParseCircuit( "total", o_Query )
  Desc         = ParseCircuit( "desc", o_Query )
  Mobile       = ParseCircuit( "mobilenumber", o_Query )
  CountryCode  = ParseCircuit( "countrycode", o_Query )
  
// ------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ------------------------------------------------------------------------------------------------------------------------

  If Req = "-" Then
    Proceed = 0
	RText   = "Please select what you are looking for."
	RCode   = "1"
  ElseIf City = "-" Then
    Proceed = 0
	RText   = "Please select a City."
	RCode   = "2"
  ElseIf Email = "" OR Instr( Email, "@" ) = 0 OR Instr( Email, "." ) = 0 Then
    Proceed = 0
	RText   = "Please enter a valid Email Address"
	RCode   = "3"
  ElseIf Method = "" Then
    Proceed = 0
	RText   = "Please select an Alert Method"
	RCode   = "4"
  ElseIf Duration = "" Then
    Proceed = 0
	RText   = "Please select an Alert Duration"
	RCode   = "5"
  ElseIf Method = "2" AND CountryCode = "" OR Method = "2" AND IsNumeric( CountryCode ) = 0 Then
    Proceed = 0
	RText   = "Please enter a valid Country Code for your Mobile Phone Number"
	RCode   = ""
  ElseIf Method = "2" AND Mobile = "" OR Method = "2" AND IsNumeric( Mobile ) = 0 Then
    Proceed = 0
	RText   = "Please enter a valid Mobile Phone Number"
	RCode   = "7"
  Else
    Proceed = 1
	RText   = "OK"
	RCode   = "8"
  End If
  
// ------------------------------------------------------------------------------------------------------------------------
  
  If Proceed = "1" Then
    TxId         = Sha1( Timer() & Rnd() )
    SubId        = Left( TxId, 10 )
    ExpDate      = DateAdd( "d", Duration, Date() )
    ExpDate      = Split( ExpDate, "/" )
    ExpDay       = ExpDate(0)
    ExpDay       = FixSingleDigits( ExpDay )
    ExpMonth     = ExpDate(1)
    ExpMonth     = FixSingleDigits( ExpMonth )
    ExpYear      = ExpDate(2)
    ExpTime      = Var_TimeStamp
    ExpDate      = ExpYear & "-" & ExpMonth & "-" & ExpDay
    ExpDateTime  = ExpDate & " " & ExpTime
  End If
  
// ------------------------------------------------------------------------------------------------------------------------
// ' Build Data Query
// ------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then

    Data = "req:" & Req & ";city:" & city & ";email:" & email & ";method:" & Method & _
           ";duration:" & Duration & ";total:" & Total & ";desc:" & Desc & _
		   ";mobile:" & Mobile & ";countrycode:" & CountryCode & ";" & _
		   "txid:" & TxId & ";subid:" & SubId & ";expirydate:" & ExpDate & ";expirydatetime:" & ExpDateTime
		 
    Data = StringToHex( Data )
  
  End If
  
// ------------------------------------------------------------------------------------------------------------------------
// ' Write JSON
// ------------------------------------------------------------------------------------------------------------------------

  JSON = "{'data':'" & Data & "', 'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "'}"
  Response.Write JSON

// ------------------------------------------------------------------------------------------------------------------------
%>
<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  o_Query       = fw_Query 
  o_Query       = UrlDecode( o_Query )
  CustomerId    = ParseCircuit( "customerid", o_Query ) 
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Customer Count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  CustSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & CustomerId & "'"
              Call FetchData( CustSQL, CustRs, ConnTemp )
			
  CustCount = CustRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If CustCount > "0" Then
  
    CustSQL = "SELECT * FROM members WHERE customerid='" & CustomerId & "'"
	          Call FetchData( CustSQL, CustRs, ConnTemp )
			  Firstname = CustRs("firstname")
  
    Data   = "firstname:" & Firstname & ";customerid:" & CustomerId & ";accountclosed:1"
	Data   = StringToHex( Data )
	RPath  = "/accountdeleted/doc/?data:" & Data 
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Advert Count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  AdSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & CustomerId & "'"
            Call FetchData( AdSQL, AdRs, ConnTemp )
		  
  AdCount = AdRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Photo Count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PhSQL      = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE customerid='" & CustomerId & "'"
               Call FetchData( PhSQL, PhRs, ConnTemp )
		  
  PhotoCount = PhRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Validate
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "" OR Var_LoggedIn = "0" Then
    Proceed = 0
	RCode   = 1
	RText   = "You need to be logged in to do that."
  ElseIf CustCount = "0" Then
    Proceed = 0
	RCode   = 2
	RText   = "The customer could not be found."
  Else
    Proceed = 1
	RCode   = 3
	RText   = "OK"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Functions
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  Sub DeleteAdvert( table, customerid )
    DelSQL = "DELETE FROM " & table & " WHERE customerid='" & CustomerId & "'"
	         Call SaveRecord( DelSQL, DelRs, ConnTemp )
  End Sub
  
  Sub DeleteGallery( customerid, advertid )
    DelSQL = "DELETE FROM galleryphotos WHERE customerid='" & CustomerId & "' AND photoid='" & AdvertId & "'"
	         Call SaveRecord( DelSQL, DelRs, ConnTemp )
  End Sub
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  Sub DeleteImage( Src ) 
    Src = "\uploads\src\" & Src
	
	If Instr( Src, "nopicsmall.png" ) = 0 Then
	  On Error Resume Next
	  
	  Set FS = Server.CreateObject("Scripting.FileSystemObject")
	    If Fs.FileExists( Src ) Then
		  Fs.DeleteFile( Src )
		End If
	  Set FS = Nothing
	  
	End If
	
  End Sub
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  Sub DeleteThumb( Src )
    Src = "\uploads\thumbs\" & Src
	
	If Instr( Src, "nopicsmall.png" ) = 0 Then
      On Error Resume Next
	  
	  Set FS = Server.CreateObject("Scripting.FileSystemObject")
	    If Fs.FileExists( Src ) Then
		  Fs.DeleteFile( Src )
		End If
	  Set FS = Nothing
	
	End If
  End Sub
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Advert and Primary Photo
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND AdCount > "0" Then
  
    AdSQL = "SELECT * FROM shortlets WHERE customerid='" & CustomerId & "'"
	         Call FetchData( AdSQL, AdRs, ConnTemp )
			 Photo = AdRs("photo")
			 
			 Do While Not AdRs.Eof
			   Call DeleteAdvert( "shortlets", CustomerId )
			   Call DeleteImage( Photo )
			   Call DeleteThumb( Photo )
			   
			 AdRs.MoveNext
			 Loop
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Gallery Photos
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" AND PhotoCount > "0" Then
    
	GalSQL = "SELECT * FROM galleryphotos WHERE customerid='" & CustomerId & "'"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
			 PhotoId = GalRs("photoid")
			 Photo   = GalRs("photo")
			 
	        Do While Not GalRs.Eof
			  Call DeleteImage( Photo )
			  Call DeleteThumb( Photo )
			  Call DeleteGallery( CustomerId, AdvertId )
			GalRs.MoveNext
			Loop
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Customer
// ---------------------------------------------------------------------------------------------------------------------------------------------------
    
	If  CustCount > "0" AND Proceed = "1" Then
	
	  DelSQL = "DELETE FROM members WHERE customerid='" & CustomerId & "'"
	           Call SaveRecord( DelSQL, DelRs, ConnTemp )
	
	End If
	
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Kill Session
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
  
  Response.Cookies("tandgshortlets")("token")      = ""
  Response.Cookies("tandgshortlets")("userid")     = ""
  Response.Cookies("tandgshortlets")("firstname")  = ""
  Response.Cookies("tandgshortlets")("surname")    = ""
  Response.Cookies("tandgshortlets")("email")      = ""
  Response.Cookies("tandgshortlets")("loggedin")   = ""
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & RCode & "', 'rtext':'" & RText & "', 'proceed':'" & Proceed & "', 'rpath':'" & RPath & "'}"
  Response.Write JSOn
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
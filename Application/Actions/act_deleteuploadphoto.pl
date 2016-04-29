<!--#include virtual="/includes.inc"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query = Request.Form
  o_Query = Replace( o_Query, "&", ";" )
  o_Query = Replace( o_Query, ";", vbcrlf )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  PhotoNumber    = ParseCircuit( "photonumber", o_Query )
  Holder         = ParseCircuit( "holder", o_Query )
  DeleteButton   = ParseCircuit( "deletebutton", o_Query )
  UploadFile     = ParseCircuit( "uploadfile", o_Query )
  ListingId      = ParseCircuit( "listingid", o_Query )
  Page           = ParseCircuit( "page", o_Query )
  FromEdit       = ParseCircuit( "fromedit", o_Query )
  Photo1Src      = ParseCircuit( "photo1src", o_Query )
  Photo2Src      = ParseCircuit( "photo2src", o_Query )
  Photo3Src      = ParseCircuit( "photo3src", o_Query )
  Photo4Src      = ParseCircuit( "photo4src", o_Query )
  Photo5Src      = ParseCircuit( "photo5src", o_Query )
  Photo6Src      = ParseCircuit( "photo6src", o_Query )
  PhotoId        = ParseCircuit( "photoid", o_Query )

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Page = "createadvert" AND FromEdit = "1" Then
    
	SourceFolder = "/uploads/src/"
	SourceFolder = Server.MapPath( SourceFolder )
	ThumbFolder  = "/uploads/thumbs/"
	ThumbFolder  = Server.MapPath( ThumbFolder )
	
	If PhotoNumber = "1" AND NOT Photo1Src = "nopicsmall.png" Then
	  
	  DeleteFile( SourceFolder & "\" & Photo1Src )
	  DeleteFile( ThumbFolder & "\" & Photo1Src )
	  Response.Cookies("tandgadform")("adphoto1")       = ""
	  Response.Cookies("tandgadform")("adphoto1isvert") = ""
	  Response.Cookies("tandgadform")("adphoto1width")  = ""
	  
	ElseIf PhotoNumber = "2" AND NOT Photo2Src = "nopicsmall.png" Then
	  
	  DeleteFile( SourceFolder & "\" & Photo2Src )
	  DeleteFile( ThumbFolder & "\" & Photo2Src )
	  Response.Cookies("tandgadform")("adphoto2")       = ""
	  Response.Cookies("tandgadform")("adphoto2isvert") = ""
	  Response.Cookies("tandgadform")("adphoto2width")  = ""
	  
	ElseIf PhotoNumber = "3" AND NOT Photo3Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo3Src )
	  DeleteFile( ThumbFolder & "\" & Photo3Src )
	  Response.Cookies("tandgadform")("adphoto3")       = ""
	  Response.Cookies("tandgadform")("adphoto3isvert") = ""
	  Response.Cookies("tandgadform")("adphoto3width")  = ""
	
	ElseIf PhotoNumber = "4" AND NOT Photo4Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo4Src )
	  DeleteFile( ThumbFolder & "\" & Photo4Src )
	  Response.Cookies("tandgadform")("adphoto4")       = ""
	  Response.Cookies("tandgadform")("adphoto4isvert") = ""
	  Response.Cookies("tandgadform")("adphoto4width")  = ""
	
	ElseIf PhotoNumber = "5" AND NOT Photo5Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo5Src )
	  DeleteFile( ThumbFolder & "\" & Photo5Src )
	  Response.Cookies("tandgadform")("adphoto5")       = ""
	  Response.Cookies("tandgadform")("adphoto5isvert") = ""
	  Response.Cookies("tandgadform")("adphoto5width")  = ""
	  
	ElseIf PhotoNumber = "6" AND NOT Photo6Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo6Src )
	  DeleteFile( ThumbFolder & "\" & Photo6Src )
	  Response.Cookies("tandgadform")("adphoto6")       = ""
	  Response.Cookies("tandgadform")("adphoto6isvert") = ""
	  Response.Cookies("tandgadform")("adphoto6width")  = ""
	
	End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Page = "createadvert" AND FromEdit = "" Then

	SourceFolder = "/uploads/src/"
	SourceFolder = Server.MapPath( SourceFolder )
	ThumbFolder  = "/uploads/thumbs/"
	ThumbFolder  = Server.MapPath( ThumbFolder )
	
	If PhotoNumber = "1" AND NOT Photo1Src = "nopicsmall.png" Then
	  DeleteFile( SourceFolder & "\" & Photo1Src )
	  DeleteFile( ThumbFolder & "\" & Photo1Src )
	  Response.Cookies("tandgadform")("adphoto1")       = ""
	  Response.Cookies("tandgadform")("adphoto1isvert") = ""
	  Response.Cookies("tandgadform")("adphoto1width")  = ""
	ElseIf PhotoNumber = "2" AND NOT Photo2Src = "nopicsmall.png" Then
	  DeleteFile( SourceFolder & "\" & Photo2Src )
	  DeleteFile( ThumbFolder & "\" & Photo2Src )
	  Response.Cookies("tandgadform")("adphoto2")       = ""
	  Response.Cookies("tandgadform")("adphoto2isvert") = ""
	  Response.Cookies("tandgadform")("adphoto2width")  = ""
	ElseIf PhotoNumber = "3" AND NOT Photo3Src = "nopicsmall.png" Then
	  DeleteFile( SourceFolder & "\" & Photo3Src )
	  DeleteFile( ThumbFolder & "\" & Photo3Src )
	  Response.Cookies("tandgadform")("adphoto3")       = ""
	  Response.Cookies("tandgadform")("adphoto3isvert") = ""
	  Response.Cookies("tandgadform")("adphoto3width")  = ""
	ElseIf PhotoNumber = "4" AND NOT Photo4Src = "nopicsmall.png" Then
	  DeleteFile( SourceFolder & "\" & Photo4Src )
	  DeleteFile( ThumbFolder & "\" & Photo4Src )
	  Response.Cookies("tandgadform")("adphoto4")       = ""
	  Response.Cookies("tandgadform")("adphoto4isvert") = ""
	  Response.Cookies("tandgadform")("adphoto4width")  = ""
	ElseIf PhotoNumber = "5" AND NOT Photo5Src = "nopicsmall.png" Then
	  DeleteFile( SourceFolder & "\" & Photo5Src )
	  DeleteFile( ThumbFolder & "\" & Photo5Src )
	  Response.Cookies("tandgadform")("adphoto5")       = ""
	  Response.Cookies("tandgadform")("adphoto5isvert") = ""
	  Response.Cookies("tandgadform")("adphoto5width")  = ""
	ElseIf PhotoNumber = "6" AND NOT Photo6Src = "nopicsmall.png" Then
	  DeleteFile( SourceFolder & "\" & Photo6Src )
	  DeleteFile( ThumbFolder & "\" & Photo6Src )
	  Response.Cookies("tandgadform")("adphoto6")       = ""
	  Response.Cookies("tandgadform")("adphoto6isvert") = ""
	  Response.Cookies("tandgadform")("adphoto6width")  = ""
	End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  
  If Page = "editadvert" AND FromEdit = "1" Then

	SourceFolder = "/uploads/src/"
	SourceFolder = Server.MapPath( SourceFolder )
	ThumbFolder  = "/uploads/thumbs/"
	ThumbFolder  = Server.MapPath( ThumbFolder )
	
	If PhotoNumber = "1" AND NOT Photo1Src = "nopicsmall.png" Then
	  
	  DeleteFile( SourceFolder & "\" & Photo1Src )
	  DeleteFile( ThumbFolder & "\" & Photo1Src )
	  Response.Cookies("tandgadform")("adphoto1")       = ""
	  Response.Cookies("tandgadform")("adphoto1isvert") = ""
	  Response.Cookies("tandgadform")("adphoto1width")  = ""
	
	ElseIf PhotoNumber = "2" AND NOT Photo2Src = "nopicsmall.png" Then
	  
	  DeleteFile( SourceFolder & "\" & Photo2Src )
	  DeleteFile( ThumbFolder & "\" & Photo2Src )
	  Response.Cookies("tandgadform")("adphoto2")       = ""
	  Response.Cookies("tandgadform")("adphoto2isvert") = ""
	  Response.Cookies("tandgadform")("adphoto2width")  = ""
	
	ElseIf PhotoNumber = "3" AND NOT Photo3Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo3Src )
	  DeleteFile( ThumbFolder & "\" & Photo3Src )
	  Response.Cookies("tandgadform")("adphoto3")       = ""
	  Response.Cookies("tandgadform")("adphoto3isvert") = ""
	  Response.Cookies("tandgadform")("adphoto3width")  = ""
	
	ElseIf PhotoNumber = "4" AND NOT Photo4Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo4Src )
	  DeleteFile( ThumbFolder & "\" & Photo4Src )
	  Response.Cookies("tandgadform")("adphoto4")       = ""
	  Response.Cookies("tandgadform")("adphoto4isvert") = ""
	  Response.Cookies("tandgadform")("adphoto4width")  = ""
	
	ElseIf PhotoNumber = "5" AND NOT Photo5Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo5Src )
	  DeleteFile( ThumbFolder & "\" & Photo5Src )
	  Response.Cookies("tandgadform")("adphoto5")       = ""
	  Response.Cookies("tandgadform")("adphoto5isvert") = ""
	  Response.Cookies("tandgadform")("adphoto5width")  = ""
	  
	ElseIf PhotoNumber = "6" AND NOT Photo6Src = "nopicsmall.png" Then
	
	  DeleteFile( SourceFolder & "\" & Photo6Src )
	  DeleteFile( ThumbFolder & "\" & Photo6Src )
	  Response.Cookies("tandgadform")("adphoto6")       = ""
	  Response.Cookies("tandgadform")("adphoto6isvert") = ""
	  Response.Cookies("tandgadform")("adphoto6width")  = ""
	  
	End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Page = "editadvert" AND FromEdit = "" Then
  
	SourceFolder = "/uploads/src/"
	SourceFolder = Server.MapPath( SourceFolder )
	ThumbFolder  = "/uploads/thumbs/"
	ThumbFolder  = Server.MapPath( ThumbFolder )
  
    GalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE photoid='" & PhotoId & "'"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
			 
	GalCount = GalRs("NumberOfRecords")
			   
	  If PhotoNumber = "1" AND NOT Photo1Src = "nopicsmall.png" Then
	    DeleteFile( SourceFolder & "\" & Photo1Src )
		DeleteFile( ThumbFolder  & "\" & Photo1Src )
		DelSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE listingid='" & ListingId & "'"
		         Call FetchData( DelSQL, DelRs, ConnTemp )
				 
	    DelCount = DelRs("NumberOfRecords")
		
		If DelCount > "0" Then
		
		  UpdSQL = "UPDATE shortlets SET " & _
		           "photo='NULL' " & _
				   "WHERE listingid='" & ListingId & "'"
				   Call SaveRecord( UpdSQL, UpdRs, ConnTemp )
		
		End If
				 
	  ElseIf PhotoNumber = "2" AND NOT Photo1Src = "nopicsmall.png" Then
	    DeleteFile( SourceFolder & "\" & Photo2Src )
		DeleteFile( ThumbFolder  & "\" & Photo2Src )
	    Response.Cookies("tandgadform")("adphoto2")       = ""
	    Response.Cookies("tandgadform")("adphoto2isvert") = ""
	    Response.Cookies("tandgadform")("adphoto2width")  = ""
	  ElseIf PhotoNumber = "3" AND NOT Photo3Src = "nopicsmall.png" Then
	    DeleteFile( SourceFolder & "\" & Photo3Src )
		DeleteFile( ThumbFolder  & "\" & Photo3Src )
	    Response.Cookies("tandgadform")("adphoto3")       = ""
	    Response.Cookies("tandgadform")("adphoto3isvert") = ""
	    Response.Cookies("tandgadform")("adphoto3width")  = ""
	  ElseIf PhotoNumber = "4" AND NOT Photo4Src = "nopicsmall.png" Then
	    DeleteFile( SourceFolder & "\" & Photo4Src )
		DeleteFile( ThumbFolder  & "\" & Photo4Src )
	    Response.Cookies("tandgadform")("adphoto4")       = ""
	    Response.Cookies("tandgadform")("adphoto4isvert") = ""
	    Response.Cookies("tandgadform")("adphoto4width")  = ""
	  ElseIf PhotoNumber = "5" AND NOT Photo5Src = "nopicsmall.png" Then
	    DeleteFile( SourceFolder & "\" & Photo5Src )
		DeleteFile( ThumbFolder  & "\" & Photo5Src )
	    Response.Cookies("tandgadform")("adphoto5")       = ""
	    Response.Cookies("tandgadform")("adphoto5isvert") = ""
	    Response.Cookies("tandgadform")("adphoto5width")  = ""
	  ElseIf PhotoNumber = "6" AND NOT Photo6Src = "nopicsmall.png" Then
	    DeleteFile( SourceFolder & "\" & Photo6Src )
		DeleteFile( ThumbFolder  & "\" & Photo6Src )
	    Response.Cookies("tandgadform")("adphoto6")       = ""
	    Response.Cookies("tandgadform")("adphoto6isvert") = ""
	    Response.Cookies("tandgadform")("adphoto6width")  = ""
	  End If
	  
   If GalCount > "0" Then
			   
      GalSQL = "DELETE FROM galleryphotos WHERE photoid='" & PhotoId & "' AND advertid='" & ListingId & "'"
	           Call FetchData( GalSQL, GalRs, ConnTemp )
			   
	End If
  
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Write JSOn Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'photonumber':'" & PhotoNumber & "', 'holder':'" & Holder & "', 'deletebutton':'" & DeleteButton & "', 'uploadfile':'" & UploadFile & "', 'listingid':'" & ListingId & "'}"
  Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
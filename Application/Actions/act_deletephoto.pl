<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = Request.Form
  o_Query    = UrlDecode( o_Query )
  o_Query    = Replace( o_Query, ";", vbcrlf )
  ListingId  = ParseCircuit( "listingid", o_Query )
  Object     = ParseCircuit( "object", o_Query )
  PhotoId    = ParseCircuit( "photoid", o_Query )
  PhotoSrc   = ParseCircuit( "photosrc", o_Query )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If Object = "photo1" Then
    SQLTable = "shortlets"
  Else
    SQLTable = "galleryphotos"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete Object
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Public Function DeleteImg(Src)
    On Error Resume Next
    Set FS = CreateObject("Scripting.FileSystemObject")
	  FS.DeleteFile Server.MapPath( Src )
	Set FS = Nothing
  End Function
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  DeleteImg("/uploads/thumbs/" & PhotoSrc )
  DeleteImg("/uploads/src/" & PhotoSrc )
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Select Case(Object)
    Case "photo1"
	
	DelSQL = "UPDATE shortlets SET " & _
	         "photo='NULL' WHERE listingid='" & ListingId & "'"
			 Call SaveRecord( DelSQL, DelRs, ConnTemp )
			 
	Case Else
	  
	  DelSQL = "DELETE FROM galleryphotos WHERE photoid='" & PhotoId & "'"
	           Call SaveRecord( DelSQL, DelRs, ConnTemp )
	  
  End Select
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
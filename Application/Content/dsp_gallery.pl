<!--#include virtual="/includes.inc"-->


<%
// --------------------------------------------------------------------------------------------------------------------------------------

  o_Query    = fw_Query
  o_Query    = UrlDecode( o_Query )
   
  Table      = ParseCircuit( "table", o_Query )
  ListingId  = ParseCircuit( "listingid", o_Query )
  ImgUrl     = ParseCircuit( "thumb", o_Query )
  
// --------------------------------------------------------------------------------------------------------------------------------------

  ImgSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM " & Table & " WHERE listingid='" & ListingId & "'"
	           Call FetchData( ImgSQL, ImgRs, ConnTemp )
					 
  ImgCount = ImgRs("NumberOfRecords")

// --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Initial Image
// --------------------------------------------------------------------------------------------------------------------------------------

  If ImgCount > "0" Then
    ImgSQL = "SELECT * FROM " & Table & " WHERE listingid='" & ListingId & "'"
             Call FetchData( ImgSQL, ImgRs, ConnTemp )
    ShortDescription = ImgRs("shortdescription")
  End If
  
  On Error Resume Next

// --------------------------------------------------------------------------------------------------------------------------------------
// ' Get Gallery Images
// --------------------------------------------------------------------------------------------------------------------------------------

  GalSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & ListingId & "'"
             Call FetchData( GalSQL, GalRs, ConnTemp )
  GalCount = GalRs("NumberOfRecords")
  
  GalImg = GalImg & "<span class='gallery_thumb'><a href='javascript://' onclick=""SwitchGallery('/uploads/src/" & ImgUrl & "', '" & DecodeText(ShortDescription) & "');""><img src='/uploads/src/" & ImgUrl & "'/></a></span>" & vbcrlf

// --------------------------------------------------------------------------------------------------------------------------------------

  If GalCount > "0" Then
  
    GalSQL = "SELECT * FROM galleryphotos WHERe advertid='" & ListingId & "' ORDER BY uIndex ASC"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
	
	ImgNumber = 1
	
	Do While Not GalRs.Eof
	  ImgNumber  = ImgNumber + 1
	  ImgName    = GalRs("photo")
	  ImgSrc     = "/uploads/thumbs/" & ImgName
	  OrigSrc    = "/uploads/src/" & ImgName 
	  GalImg     = GalImg & "<span class='gallery_thumb'><a href='javascript://' onclick=""SwitchGallery('" & OrigSrc & "', '" & DecodeText(ShortDescription) & "');""><img src='" & Imgsrc & "'/></a></span>" & vbcrlf
	GalRs.MoveNext
	Loop
  
  End If 
	
// --------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='gallery_header'><span class='gallery_description' id='smalldescription'><%=DecodeText(ShortDescription)%></span><span class='gallery_close'><a href='javascript://' onclick="CloseModalBox();" title='Close'></a></span></div>


<div class='gallery_holder'>

  <!-- left content -->
  
  <span class='gallery_cell' style='width:400px; overflow:hidden;'>
  
  <img src='/uploads/src/<%=ImgUrl%>' class='gallery_image' id='mainimg'/>
  
  </span>
  
  <!-- end left content -->
  
  
  
  
  <!-- right content -->
  
  <span class='gallery_cell' style='width:150px; text-align:center; background:#eeeeee;'>
  
    <%=GalImg%>
  
  </span>
  
  <!-- end right content -->

</div>
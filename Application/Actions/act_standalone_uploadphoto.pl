<!--#include virtual="/includes.inc"-->

<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Var_LoggedIn = "0" OR Var_LoggedIn = "" Then
    
	UploadFailed = 1
	ResponseCode = 1
	ResponseText = "You need to be logged in to upload photos. <a href=\""/login/doc/\"">Click here to Log In</a>"
	
  Else

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Variables
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Server.ScriptTimeout= 600

  ImagePath   = "/uploads/src/"
  ThumbPath   = "/uploads/thumbs/"
  TempBin     = "/uploads/tempbin/"
  
  ThumbCode   = Sha1(Timer()&Rnd())
  ThumbCode   = Left( ThumbCode, 12 )
  ThumbCode   = UCase( ThumbCode )
  MaxSize     = "6291456" ' 6 MB Max

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Do Primary Upload
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Set Upload = Server.CreateObject( "Persits.Upload.1" )
    Upload.OverwriteFiles = True
	Upload.SetMaxSize MaxSize
	Count = Upload.Save( Server.MapPath( TempBin ) )
	
	ListingId  = Upload.Form( "listingid" )
	PElement   = Upload.Form( "pelement" )
	PhotoId    = Upload.Form( "photoid" )
	
	Set File = Upload.Files(1)
	  UploadedFile    = File.FileName
	  UploadedSize    = File.OriginalSize
	  UploadedExt     = GetExtension(UploadedFile)
	  NewFileName     = Sha1( Timer()&Rnd() ) & "." & UploadedExt
	  OriginalPath    = File.OriginalPath
	  OriginalWidth   = File.ImageWidth
	  OriginalHeight  = File.ImageHeight
	  IsVertical      = (OriginalHeight>OriginalWidth)
	  IsEqual         = (OriginalHeight=OriginalWidth)
	  
	  If IsEqual = "True" Then IsEqual = "1" Else IsEqual = "0" End If
	  If IsVertical = "True" Then IsVertical = "1" Else IsVertical = "0" End If 
	  
	Set File = Nothing 
  
  Set Upload = Nothing

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Set Thumb Location
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ThumbPath = Server.MapPath( ThumbPath ) & "\" & NewFileName
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check File Types
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  CheckFileName = NewFileName
  FileExt       = UploadedExt
  FileExt       = LCase( FileExt )
  
  Select Case( FileExt )
    Case "jpg", "jpeg", "png", "gif"
	  FileOK = 1
	Case Else
	  FileOK = 0
  End Select

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check If file is vertical
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If IsVertical = "0" AND IsEqual = "0" Then
    DimensionsOK = 1
  Else
    DimensionsOK = 0
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Upload Max File Size
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If Int( UploadedSize ) > Int(MaxSize) Then
    MaxSizeOK = 0
  Else
    MaxSizeOK = 1
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Set Folder Location
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  FolderLocation   = TempBin
  DeleteFileSrc    = TempBin & NewFileName
  FileSrc          = TempBin & NewFileName
  IsValidFileName  = ValidateFileName(UploadedFile)
 
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Delete File Function
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Sub DeleteFile( Src )
    On Error Resume Next
    Set FS = CreateObject("Scripting.FileSystemObject")
	  FS.DeleteFile Server.MapPath( Src )
	Set FS = Nothing
  End Sub
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If FileOK = "0" Then
    UploadFailed = 1
	ResponseCode = 1
	ResponseText = "<b>Upload Failed</b><br/>The file you uploaded is not a valid photo format. Please upload .GIF, .PNG, .JPG, .JPEG files only!<br/>"
	Call DeleteFile( DeleteFileSrc )
	
  ElseIf IsValidFileName = "0" Then
    UploadFailed = 1
	ResponseCode = 2
	ResponseText = "<b>Upload Failed</b><br/>The file name contains special characters, please rename the file and try again."
	
  ElseIf MaxSizeOk = "0" Then
    UploadFailed = 1
	ResponseCode = 3
	ResponseText = "<b>Upload Failed</b><br/>The photo you are uploading is too large.<br/>The uploader has a 6 Megabytes limit"
	Call DeleteFile( DeleteFileSrc )
	
  ElseIf Err.Number <> "0" Then
    UploadFailed = 1
	ResponseCode = 4
	ResponseText = "<b>Upload Failed</b><br/>Sorry, Something went wrong. Please try again later."
	Call DeleteFile( DeleteFileSrc )
	
  Else
    UploadFailed = 0
	ResponseCode = 5
	ResponseText = "Upload Successful"
  End If
  
// --------------------------------------------------------------------------------------------------------------------------------------------------- 
// ' Rename and Move File
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If UploadFailed = "0" Then
 
    Set FS = CreateObject("Scripting.FileSystemObject")
      FS.MoveFile Server.MapPath( TempBin & UploadedFile ), Server.MapPath( TempBin & NewFileName )
    Set FS = Nothing
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Create Thumbnail
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If UploadFailed = "0" Then
    
	Set Thumb = Server.CreateObject( "Persits.Jpeg" )
	  Thumb.Open( Server.MapPath( TempBin ) & "\" & NewFileName )
	  OriginalWidth  = Thumb.OriginalWidth
	  OriginalHeight = Thumb.OriginalHeight
	  
	  If IsVertical = "1" Then NewWidth = 200 Else NewWidth = 200 End If
	  
	  Thumb.PreserveAspectRatio = True
	  Thumb.Width  = NewWidth
	  Thumb.Height = Thumb.OriginalWidth * NewWidth / Thumb.OriginalWidth
      Thumb.Save( ThumbPath )	  
	  
	Set Thumb = Nothing
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Resize Original + Move
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If UploadFailed = "0" Then
  
    Set Img = Server.CreateObject("Persits.Jpeg")
	  Img.Open( Server.MapPath( TempBin ) & "\" & NewFileName )
	  OriginalWidth  = Img.OriginalWidth
	  OriginalHeight = Img.OriginalHeight
	  
	  If IsVertial = "1" Then NewWidth = 250 Else NewWidth = 400 End If
	  
	  Img.PreserveAspectRatio = True
	  Img.Width  = NewWidth
	  Img.Height = Img.OriginalWidth * NewWidth / Img.OriginalWidth
      Img.Save( Server.MapPath( TempBin ) & "\" & NewFileName )	  
      	  
	Set Img = Nothing
	
	Set FS = CreateObject("Scripting.FileSystemObject")
	  FS.MoveFile Server.MapPath( TempBin & NewFileName ), Server.MapPath( ImagePath & NewFileName )
	Set FS = Nothing
  
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Save Image source to database
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  'If UploadFailed = "0" Then

    'ListSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets where listingid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
                'Call FetchData( ListSQL, ListRs, ConnTemp )
			
    'ListCount = ListRs("NumberOfRecords")
  
  'End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Check Photo Number Against Gallery
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  'If UploadFailed = "0" Then
    
'	GalSQL   = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE advertid='" & ListingId & "' AND photonumber='" & PhotoId & "' AND customerid='" & Var_UserId & "'"
   '          Call FetchData( GalSQL, GalRs, ConnTemp )
		   
   ' GalCount = GalRs("NumberOfRecords")
	
  'End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  If UploadFailed = "0" Then
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  If PhotoId = "1" Then
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
    'If ListCount > "0" Then
    '  SaveSQL = "UPDATE shortlets SET " & _
	'            "photo='" & NewFileName & "', isvertical='" & IsVertical & "'" & _
	'            "WHERE listingid='" & ListingId & "' AND customerid='" & Var_UserId & "'"
	 '           Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
    'End If
  
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  Else
// ---------------------------------------------------------------------------------------------------------------------------------------------------
    
	'PhotoCode = Sha1( Timer() & Rnd() )
	
	'If GalCount > "0" Then
	  
	'  SaveSQL = "UPDATE galleryphotos SET " & _
	'	        "photoid='" & PhotoCode & "', advertid='" & ListingId & "', photo='" & NewFileName & "', " & _
 	'			"photonumber='" & PhotoId & "', customerid='" & Var_UserId & "', isvertical='" & IsVertical & "'" & _
	'		    " WHERE advertid='" & ListingId & "' AND photonumber='" & PhotoId & "' AND customerid='" & Var_UserId & "'"
	'		    Call SaveRecord( SaveSQL, SaveRs, ConnTemp ) 
	
	'Else
	
	 ' SaveSQL = "INSERT INTO galleryphotos " & _
	'	        "( photoid, advertid, photo, photonumber, customerid, isvertical )" & _
	'	        " VALUES(" & _
	'	        "'" & PhotoCode & "',"     & _
	'	        "'" & ListingId & "',"     & _
	'	        "'" & NewFileName & "', "  & _
    '            "'" & PhotoId & "', "      & _
	'			"'" & Var_UserId & "', "   & _
	'			"'" & IsVertical & "'"     & _
	'	        ")"
	'	        Call SaveRecord( SaveSQL, SaveRs, ConnTemp )
	
	'End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
  End If
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  End If
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Close Objects
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Set File    = Nothing
  Set FS      = Nothing
  Set Upload  = Nothing
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  End If 
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Process Image Response
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  JSOn = "{'rcode':'" & ResponseCode & "', 'rtext':'" & ResponseText & "', 'failed':'" & UploadFailed & "', 'image':'" & NewFileName & "', 'pelement':'" & PElement & "', 'listingid':'" & ListingId & "', 'isvertical':'" & IsVertical & "', 'imagewidth':'" & NewWidth & "'}"
  Response.Write JSOn

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
  parent.window.ProcessUpload("<%=PElement%>", "<%=JSOn%>"); 
</script>

<form name='uploadresponse' id='uploadresponse'>
<input type='hidden' name='jsonresponse' id='jsonresponse' value="<%=JSOn%>" autocomplete='off'/>
</form>
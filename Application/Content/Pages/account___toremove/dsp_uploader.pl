<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
  ListingId    = ParseCircuit( "listingid", o_Query )

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Primary Photo
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ShortSQL    = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
                 Call FetchData( ShortSQL, ShortRs, ConnTemp )
			  
  DetailCount = ShortRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If DetailCount > "0" Then
  
	ShortSQL = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND listingid='" & ListingId & "'"
	           Call FetchData( ShortSQL, ShortRs, ConnTemp )
				
	ListingId      = ShortRs("listingid")
	AdvertId       = ShortRs("advertid")
	Photo          = ShortRs("photo")
	PrimaryPhoto   = Photo
	IsVertical     = ShortRs("isvertical")


    PrimaryPhoto    = PrimaryPhoto
    IsPrimaryEmpty  = Len(PrimaryPhoto)
  
  If Len( PrimaryPhoto ) < 10 Then
    PrimaryLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo1img'>"
	ShowDeletePrimary = 0
  Else
    PrimaryLocation   = "<a href='/uploads/src/" & PrimaryPhoto & "' target='_blank'><img src='/uploads/thumbs/" & PrimaryPhoto & "' id='photo1img'/></a>"
	ShowDeletePrimary = 1
  End If
  
  End If
 
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Second Gallery Photo
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  GalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='2' AND advertid='" & ListingId & "'"
           Call FetchData( GalSQL, GalRs, ConnTemp )
		   
  GalCount = GalRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If GalCount > "0" Then
  
    GalSQL = "SELECT * FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='2' AND advertid='" & ListingId & "'"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
			 TwoPhotoId      = GalRs("photoid")
			 TwoAdvertId     = GalRs("advertid")
			 TwoPhoto        = GalRs("photo")
			 TwoPhotoNumber  = GalRs("photonumber")
			 TwoIsVertical   = GalRs("isvertical")
			 TwoCustomerid   = GalRs("customerid")
			 
			 If Len(TwoPhoto) < 10 Then
			   PhotoTwoLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo2img'/>"
			   ShowDeletePhotoTwo = 0
             Else
               PhotoTwoLocation   = "<a href='/uploads/src/" & TwoPhoto & "' target='_blank'><img src='/uploads/thumbs/" & TwoPhoto & "' id='photo2img'/></a>"
			   ShowDeletePhotoTwo = 1 
             End If			 
			 
  Else
  
    PhotoTwoLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo2img'/>"
	ShowDeletePhotoTwo = 0

  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Third Gallery Photo
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  GalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='3' AND advertid='" & ListingId & "'"
           Call FetchData( GalSQL, GalRs, ConnTemp )
		   
  GalCount = GalRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If GalCount > "0" Then
  
    GalSQL = "SELECT * FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='3' AND advertid='" & ListingId & "'"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
			 ThreePhotoId      = GalRs("photoid")
			 ThreeAdvertId     = GalRs("advertid")
			 ThreePhoto        = GalRs("photo")
			 ThreePhotoNumber  = GalRs("photonumber")
			 ThreeIsVertical   = GalRs("isvertical")
			 ThreeCustomerid   = GalRs("customerid")
			 
			 If Len(ThreePhoto) < 10 Then
			   PhotoThreeLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo3img'/>"
			   ShowDeletePhotoThree = 0
             Else
               PhotoThreeLocation   = "<a href='/uploads/src/" & ThreePhoto & "' target='_blank'><img src='/uploads/thumbs/" & ThreePhoto & "' id='photo3img'/></a>"
			   ShowDeletePhotoThree = 1
             End If			 
			 
  Else
  
    PhotoThreeLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo3img'/>"
	ShowDeletePhotoThree = 0

  End If
  
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Fourth Gallery Photo
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  GalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='4' AND advertid='" & ListingId & "'"
           Call FetchData( GalSQL, GalRs, ConnTemp )
		   
  GalCount = GalRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If GalCount > "0" Then
  
    GalSQL = "SELECT * FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='4' AND advertid='" & ListingId & "'"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
			 FourPhotoId      = GalRs("photoid")
			 FourAdvertId     = GalRs("advertid")
			 FourPhoto        = GalRs("photo")
			 FourPhotoNumber  = GalRs("photonumber")
			 FourIsVertical   = GalRs("isvertical")
			 FourCustomerid   = GalRs("customerid")
			 
			 If Len(FourPhoto) < 10 Then
			   PhotoFourLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo4img'/>"
			   ShowDeletePhotoFour = 0
             Else
               PhotoFourLocation   = "<a href='/uploads/src/" & FourPhoto & "' target='_blank'><img src='/uploads/thumbs/" & FourPhoto & "' id='photo4img'/></a>"
			   ShowDeletePhotoFour = 1
             End If			 
			 
  Else
  
    PhotoFourLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo4img'/>"
	ShowDeletePhotoFour = 0

  End If
  
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Fifth Gallery Photo
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  GalSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='5' AND advertid='" & ListingId & "'"
           Call FetchData( GalSQL, GalRs, ConnTemp )
		   
  GalCount = GalRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If GalCount > "0" Then
  
    GalSQL = "SELECT * FROM galleryphotos WHERE customerid='" & Var_UserId & "' AND photonumber='5' AND advertid='" & ListingId & "'"
	         Call FetchData( GalSQL, GalRs, ConnTemp )
			 FifthPhotoId      = GalRs("photoid")
			 FifthAdvertId     = GalRs("advertid")
			 FifthPhoto        = GalRs("photo")
			 FifthPhotoNumber  = GalRs("photonumber")
			 FifthIsVertical   = GalRs("isvertical")
			 FifthCustomerid   = GalRs("customerid")
			 
			 If Len(FifthPhoto) < 10 Then
			   PhotoFifthLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo5img'/>"
			   ShowDeletePhotoFive = 0
             Else
               PhotoFiveLocation    = "<a href='/uploads/src/" & FourPhoto & "' target='_blank'><img src='/uploads/thumbs/" & FifthPhoto & "' id='photo5img'/></a>"
			   ShowDeletePhotoFifth = 1
             End If			 
			 
  Else
  
    PhotoFiveLocation   = "<img src='/application/library/media/notlet_nopic.png' id='photo5img'/>"
	ShowDeletePhotoFive= 0

  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
  function filechange(file){
    var file     = file;
    var uploader = document.getElementById(file + "file" );
	var button   = document.getElementById(file + "button" );
	button.style.display = "block";
  }
</script>

<div class='contentheader2'>Edit Advert - Upload Photos</div>
<div class='textblock' style='margin-bottom:30px;'>You can upload 5 photos on your advert. Please ensure you upload the primary photo first. Your photo must
 use `.gif`, `.jpg` and `.png` formats only. Your photo file size can not exceed 6 Megabytes in size.
</div>


<div class='createad_tabholder'>
  <span class='tabon'><a href='/editadvert/account/?listingid:<%=ListingId%>'>Advert Details</a></span>
  <span class='taboff'><a href='javascript://'>Photos</a></span> 
</div>

<div class='uploader_holder'>
<!-- form 1 -->


<form name='photo1form' id='photo1form' action='/uploadphoto/actions/?output:1' method='POST' target='photo1frame' enctype="multipart/form-data">

  <span class='uploadheader'><span style='float:left;'>Primary Photo</span><span class='delete' id='photo1delete' style='float:right;'><% If ShowDeletePrimary = "33" Then %><a href='javascript://' onclick="DeletePhoto('<%=ListingId%>', 'photo1', '', '<%=PrimaryPhoto%>' );" title='Delete Photo'>Delete Photo</a><% End If %></span></span>
  <span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='margin-top:5px;'><div id='photo1holder' class='photoholder'><%=PrimaryLocation%></div></span>
	
	<span class='uploadform' id='photo1uploader'>
	  <span class='uploadtext'>Click choose file or browse to upload a photo</span>
	  <span class='cell'><input type="file" id="photo1file" name="file" class='selectfile' autocomplete='off' onchange="filechange('photo1');";/></span>
	  <span class='cell'><span class='uploadbutton' id='photo1button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo1file', 'photo1');" title='Upload Primary Photo'>Upload Primary Photo</a></span></span>
	</span>
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo1' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='1' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo1frame' name='photo1frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 1 -->


<span class='lines'></span>

<!-- form 2 -->

<form name='photo2form' id='photo2form' action='/uploadphoto/actions/?output:1' method='POST' target='photo2frame' enctype="multipart/form-data">

  <span class='uploadheader'><span style='float:left;'>Photo 2</span><span class='delete' id='photo2delete' style='float:right;'><% If ShowDeletePhotoTwo = "33" Then %><a href='javascript://' onclick="DeletePhoto('<%=ListingId%>', 'photo2', '<%=TwoPhotoId%>', '<%=TwoPhoto%>'  );" title='Delete Photo'>Delete Photo</a><% End If %></span></span>
  <span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='margin-top:5px;'><div id='photo2holder' class='photoholder'><%=PhotoTwoLocation%></div></span>
	
	<span class='uploadform' id='photo2uploader'>
	  <span class='uploadtext'>Click choose file or browse to upload a photo</span>
	  <span class='cell'><input type="file" id="photo2file" name="file" class='selectfile' autocomplete='off' onchange="filechange('photo2');";/></span>
	  <span class='cell'><span class='uploadbutton' id='photo2button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo2file', 'photo2');" title='Upload Photo 2'>Upload Photo 2</a></span></span>
	</span>
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo2' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='2' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo2frame' name='photo2frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 2 -->


<span class='lines'></span>

<!-- form 3 -->

<form name='photo3form' id='photo3form' action='/uploadphoto/actions/?output:1' method='POST' target='photo3frame' enctype="multipart/form-data">

  <span class='uploadheader'><span style='float:left;'>Photo 3</span><span class='delete' id='photo3delete' style='float:right;'><% If ShowDeletePhotoThree = "33" Then %><a href='javascript://' onclick="DeletePhoto('<%=ListingId%>', 'photo3', '<%=ThreePhotoId%>', '<%=ThreePhoto%>' );" title='Delete Photo'>Delete Photo</a><% End If %></span></span>
  <span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='margin-top:5px;'><div id='photo3holder' class='photoholder'><%=PhotoThreeLocation%></div></span>
	
	<span class='uploadform' id='photo3uploader'>
	  <span class='uploadtext'>Click choose file or browse to upload a photo</span>
	  <span class='cell'><input type="file" id="photo3file" name="file" class='selectfile' autocomplete='off' onchange="filechange('photo3');";/></span>
	  <span class='cell'><span class='uploadbutton' id='photo3button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo3file', 'photo3');" title='Upload Photo 3'>Upload Photo 3</a></span></span>
	</span>
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo3' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='3' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo3frame' name='photo3frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form> 


<!-- end form 3 -->




<span class='lines'></span>

<!-- form 4 -->

<form name='photo4form' id='photo4form' action='/uploadphoto/actions/?output:1' method='POST' target='photo4frame' enctype="multipart/form-data">

  <span class='uploadheader'><span style='float:left;'>Photo 4</span><span class='delete' id='photo4delete' style='float:right;'><% If ShowDeletePhotoFour = "33" Then %><a href='javascript://' onclick="DeletePhoto('<%=ListingId%>', 'photo4', '<%=FourPhotoId%>', '<%=FourPhoto%>' );" title='Delete Photo'>Delete Photo</a><% End If %></span></span>
  <span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='margin-top:5px;'><div id='photo4holder' class='photoholder'><%=PhotoFourLocation%></div></span>
	
	<span class='uploadform' id='photo4uploader'>
	  <span class='uploadtext'>Click choose file or browse to upload a photo</span>
	  <span class='cell'><input type="file" id="photo4file" name="file" class='selectfile' autocomplete='off' onchange="filechange('photo4');";/></span>
	  <span class='cell'><span class='uploadbutton' id='photo4button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo4file', 'photo4');" title='Upload Photo 4'>Upload Photo 4</a></span></span>
	</span>
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo4' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='4' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo4frame' name='photo4frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form> 


<!-- end form 4 -->


<span class='lines'></span>

<!-- form 5 -->

<form name='photo5form' id='photo5form' action='/uploadphoto/actions/?output:1' method='POST' target='photo5frame' enctype="multipart/form-data">

  <span class='uploadheader'><span style='float:left;'>Photo 5</span><span class='delete' id='photo5delete' style='float:right;'><% If ShowDeletePhotoFive = "33" Then %><a href='javascript://' onclick="DeletePhoto('<%=ListingId%>', 'photo5', '<%=FivePhotoId%>', '<%=FivePhoto%>' );" title='Delete Photo'>Delete Photo</a><% End If %></span></span>
  <span class='spacer'></span>

  <div class='row'>
    <span class='cell' style='margin-top:5px;'><div id='photo5holder' class='photoholder'><%=PhotoFiveLocation%></div></span>
	
	<span class='uploadform' id='photo5uploader'>
	  <span class='uploadtext'>Click choose file or browse to upload a photo</span>
	  <span class='cell'><input type="file" id="photo5file" name="file" class='selectfile' autocomplete='off' onchange="filechange('photo5');";/></span>
	  <span class='cell'><span class='uploadbutton' id='photo5button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo5file', 'photo5');" title='Upload Photo 5'>Upload Photo 5</a></span></span>
	</span>
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo5' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='5' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo5frame' name='photo5frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>  


<!-- end form 5 -->






</div>

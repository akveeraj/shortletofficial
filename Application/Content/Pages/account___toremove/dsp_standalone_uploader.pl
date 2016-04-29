<!--#include virtual="/includes.inc"-->





<script type='text/javascript'>
  function filechange(photoid){
	var photoid   = photoid;
	var fileid    = "photo" + photoid + "file";
	var photonum  = "photo" + photoid; 
	CheckUpload( fileid, photonum );
	
	//CheckUpload('photo1file', 'photo1');
	
    //var file     = file;
	//var photoid  = photoid;
    //var uploader = document.getElementById(file + "file" );
	//CheckUpload('photo" + photoid + "file', 'photo" + photoid + "');
	
	//var button   = document.getElementById(file + "button" );
	//button.style.display = "block";
  }
</script>


<!-- form 1 -->


<form name='photo1form' id='photo1form' action='/standalone_uploadphoto/actions/?output:1' method='POST' target='photo1frame' enctype="multipart/form-data">

  <div class='uploadrow'>
  <span class='uploadcell' style='display:block; padding:5px; margin-top:20px; font-size:14px; width:60px; text-align:right;'><b>Photo 1</b></span>
    <span class='uploadcell'><span id='photo1holder' class='photoholder'></span></span>
	
	<span class='uploadform' id='photo1uploader' style='margin-top:20px;'>
	  <span class='uploadcell'><input type="file" id="photo1file" name="file" class='selectfile' autocomplete='off' onchange="filechange('1');";/></span>
	  <span class='uploadcell'><span class='uploadbutton' id='photo1button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo1file', 'photo1');" title='Upload Photo 1'>Upload Photo 1</a></span></span>
	</span>
	
	<span class='uploadcell' id='photo1wait' style='display:none;'>
	  <span class='uploadwait'><b>Uploading Photo 1...</b></span>
	</span>
	
	<span class='uploadcell' id='photo1error' style='display:none;'>
	  <span class='uploaderror'><b>Image 1 has failed to upload</b><br/>Please ensure your file is in either .jpeg, .jpg, .png, .gif format and does not exceed 6MB in size.<br/><a href='javascript://' onclick="ResetUpload('1');">Click here to try again</a></span>
	</span>
	
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo1' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='1' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo1frame' name='photo1frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 1 -->


<!-- form 2 -->


<form name='photo2form' id='photo2form' action='/standalone_uploadphoto/actions/?output:1' method='POST' target='photo2frame' enctype="multipart/form-data">

  <div class='uploadrow'>
    <span class='uploadcell' style='display:block; padding:5px; margin-top:20px; font-size:14px; width:60px; text-align:right;'><b>Photo 2</b></span>
    <span class='uploadcell'><span id='photo2holder' class='photoholder'></span></span>
	<span class='uploadform' id='photo2uploader' style='margin-top:20px;'>
	  <span class='uploadcell'><input type="file" id="photo2file" name="file" class='selectfile' autocomplete='off' onchange="filechange('2');";/></span>
	  <span class='uploadcell'><span class='uploadbutton' id='photo2button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo2file', 'photo2');" title='Upload Photo 2'>Upload Photo 2</a></span></span>
	</span>
	
    <span class='uploadcell' id='photo2wait' style='display:none;'>
	  <span class='uploadwait'><b>Uploading Photo 2...</b></span>
	</span>

	
	<span class='uploadcell' id='photo2error' style='display:none;'>
	  <span class='uploaderror'><b>Image 2 has failed to upload</b><br/>Please ensure your file is in either .jpeg, .jpg, .png, .gif format and does not exceed 6MB in size.<br/><a href='javascript://' onclick="ResetUpload('2');">Click here to try again</a></span>
	</span>
	
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo2' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='2' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo2frame' name='photo2frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 2 -->

<!-- form 3 -->


<form name='photo3form' id='photo3form' action='/standalone_uploadphoto/actions/?output:1' method='POST' target='photo3frame' enctype="multipart/form-data">

  <div class='uploadrow'>
    <span class='uploadcell' style='display:block; padding:5px; margin-top:20px; font-size:14px; width:60px; text-align:right;'><b>Photo 3</b></span>
    <span class='uploadcell'><span id='photo3holder' class='photoholder'></span></span>
	<span class='uploadform' id='photo3uploader' style='margin-top:20px;'>
	  <span class='uploadcell'><input type="file" id="photo3file" name="file" class='selectfile' autocomplete='off' onchange="filechange('3');";/></span>
	  <span class='uploadcell'><span class='uploadbutton' id='photo3button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo3file', 'photo3');" title='Upload Photo 3'>Upload Photo 3</a></span></span>
	</span>
	
	<span class='uploadcell' id='photo3wait' style='display:none;'>
	  <span class='uploadwait'><b>Uploading Photo 3...</b></span>
	</span>
	
	<span class='uploadcell' id='photo3error' style='display:none;'>
	  <span class='uploaderror'><b>Image 3 has failed to upload</b><br/>Please ensure your file is in either .jpeg, .jpg, .png, .gif format and does not exceed 6MB in size.<br/><a href='javascript://' onclick="ResetUpload('3');">Click here to try again</a></span>
	</span>
	
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo3' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='3' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo3frame' name='photo3frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 3 -->


<!-- form 4 -->


<form name='photo4form' id='photo4form' action='/standalone_uploadphoto/actions/?output:1' method='POST' target='photo4frame' enctype="multipart/form-data">

  <div class='uploadrow'>
    <span class='uploadcell' style='display:block; padding:5px; margin-top:20px; font-size:14px; width:60px; text-align:right;'><b>Photo 4</b></span>
    <span class='uploadcell'><span id='photo4holder' class='photoholder'></span></span>
	<span class='uploadform' id='photo4uploader' style='margin-top:20px;'>
	  <span class='uploadcell'><input type="file" id="photo4file" name="file" class='selectfile' autocomplete='off' onchange="filechange('4');";/></span>
	  <span class='uploadcell'><span class='uploadbutton' id='photo4button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo4file', 'photo4');" title='Upload Photo 4'>Upload Photo 4</a></span></span>
	</span>
	
	<span class='uploadcell' id='photo4wait' style='display:none;'>
	  <span class='uploadwait'><b>Uploading Photo 4...</b></span>
	</span>

	<span class='uploadcell' id='photo4error' style='display:none;'>
	  <span class='uploaderror'><b>Image 4 has failed to upload</b><br/>Please ensure your file is in either .jpeg, .jpg, .png, .gif format and does not exceed 6MB in size.<br/><a href='javascript://' onclick="ResetUpload('4');">Click here to try again</a></span>
	</span>
	
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo4' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='4' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo4frame' name='photo4frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 4 -->





<!-- form 5 -->


<form name='photo5form' id='photo5form' action='/standalone_uploadphoto/actions/?output:1' method='POST' target='photo5frame' enctype="multipart/form-data">

  <div class='uploadrow'>
    <span class='uploadcell' style='display:block; padding:5px; margin-top:20px; font-size:14px; width:60px; text-align:right;'><b>Photo 5</b></span>
    <span class='uploadcell'><span id='photo5holder' class='photoholder'></span></span>
	<span class='uploadform' id='photo5uploader' style='margin-top:20px;'>
	  <span class='uploadcell'><input type="file" id="photo5file" name="file" class='selectfile' autocomplete='off' onchange="filechange('5');";/></span>
	  <span class='uploadcell'><span class='uploadbutton' id='photo5button' style='display:none;'><a href='javascript://' onclick="CheckUpload('photo5file', 'photo5');" title='Upload Photo 5'>Upload Photo 5</a></span></span>
	</span>
	
	<span class='uploadcell' id='photo5wait' style='display:none;'>
	  <span class='uploadwait'><b>Uploading Photo 5...</b></span>
	</span>
	
	<span class='uploadcell' id='photo5error' style='display:none;'>
	  <span class='uploaderror'><b>Image 5 has failed to upload</b><br/>Please ensure your file is in either .jpeg, .jpg, .png, .gif format and does not exceed 6MB in size.<br/><a href='javascript://' onclick="ResetUpload('5');">Click here to try again</a></span>
	</span>
	
  </div>
  
  <input type='hidden' name='pelement' id='pelement' value='photo5' autocomplete='off'/>
  <input type='hidden' name='listingid' id='listingid' value='<%=ListingId%>' autocomplete='off'/>
  <input type='hidden' name='photoid' id='photoid' value='5' autocomplete='off'/>
  <input type='hidden' name='output' id='output' value='1' autocomplete='off'/>
  <iframe src="" style='display:block; float:left;' id='photo5frame' name='photo5frame' width='0' height='0' frameborder='no' style='background:#ffffff;'></iframe>
</form>


<!-- end form 5 -->
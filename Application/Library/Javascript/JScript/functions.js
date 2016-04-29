// Modalbox functions

function CheckInternetConnection(){
 //jQuery.ajaxSetup({async:false});
 //re="";
 //r=Math.round(Math.random() * 10000);
 //$j.get("http://townandgownshortlets.co.uk/application/library/media/splash_2_1_shadow.jpg",{subins:r},function(d){
  //re=true;
 //}).error(function(){
  //re=false;
 //});
 //return re;
}

function checkinternet(){
 //if (! window.jQuery) {
 //alert('No internet Connection !!');
 // }
 //else {
// alert( 'everything is ok !!!');
 //}
}

function OpenModalBox(){
  modalbox  = document.getElementById('modalbox');
  modalwrap = document.getElementById('modalwrap');
  modalbox.innerHTML = "";
  modalwrap.style.display = "block";
  modalbox.style.display  = "block";
  document.documentElement.style.overflow = 'hidden';
  modalbox.innerHTML = "<span class='modal_loadheader'><b>Please Wait...</b></span>" +
                       "<span class='modal_loadcontent'>" +
					   "<b>Processing your request<span class='modal_cancelrequest'><a href='javascript://' onclick=\"CloseModalBox();\">Cancel Request</a></span></b>" +
					   "</span>"
}

function CloseModalBox(){
  document.getElementById('modalbox').innerHTML = "";
  $j("#modalbox").hide();
  $j("#modalwrap").hide();
  document.documentElement.style.overflow = 'auto';
}

function FetchPage( url, target, method ) {
  var url    = url + ";cache:" + new Date().getTime();
  var target = target;
  var method = method;
  var params = "";
  new Ajax.Updater( target, url, { method: method, parameters: params, asynchronous:true });
}

function SendPost( url, target, params ) {
  var url     = url + ";cache:" + new Date().getTime();
  var target  = target;
  var params  = params;  
  new Ajax.Updater ( target, url, { method: 'POST', parameters: params, asynchronous:true });
}

function FetchPostPage( url, target, rtext, pagetitle ) {
  var url         = url + ";cache:" + new Date().getTime();
  var target      = target;
  var rtext       = rtext;
  var pagetitle   = pagetitle;
  var params      = "responsetext=" + rtext + "&pagetitle=" + pagetitle;
  new Ajax.Updater ( target, url, { method: 'POST', parameters: params, asynchronous:true });
}

function TransportError(responsecode, page){
	var responsecode = responsecode;
    var page = page;
	var url  = "/alert/alerts/?output:1;"
	var pars = "responsetext:There was a problem processing your request.<br/><br/><b>Code -</b> " + responsecode + "<br/><b>Page -</b> " + page + ";pagetitle:Transport Error;"
	var url  = url + pars;
	OpenModalBox();
	FetchPage( url, 'modalbox', 'GET');
}

function FetchImage(src, isvert, target){
  var wait    = document.getElementById('gallerywait');
  var src     = src;
  var isvert  = isvert;
  var target  = target;
  var target  = document.getElementById(target);
  var url     = "/fetchimage/actions/?output:1;src:" + src + ";isvertical:" + isvert;
  
  wait.style.display = "block";
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText; 
		
    if ( rstatus < 200 || rstatus > 200 ) {
      alert('image not found');
      wait.style.display   = "none";
    } else {
      target.innerHTML = rtext;
	  wait.style.display   = "none";
    }
  }});
}

function CloseRefresh(){
  var action = action;
  CloseModalBox();
  document.location.reload();
}

function CloseLocation(url){
  var url = url;
	document.location.href= url;
}

function CheckAccountStatus(){
  var url = "/checkaccountstatus/actions/?output:1;cache:" + new Date().getTime();
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText;
		
    if ( rstatus < 200 || rstatus > 200 ) {
      // Do Nothing
    } else {
      ProcessCheckAccountStatus(rtext);
    }
  }});
  
}

function ProcessCheckAccountStatus(rtext){
  var rtext = rtext;
  var json  = eval("(" + rtext + ")");
  var accstatus = json.accstatus;
  var loggedin  = json.loggedin;
  
  if ( accstatus == "0" && loggedin == "1" ) {
    document.location.href = "/accountdeleted/doc/"
  }
}

function reportad( listingid, rpath ) {
  var listingid = listingid;
  var rpath     = rpath;
  var wait      = document.getElementById('advwait');
  var button    = document.getElementById('advbutton');
  var details   = document.getElementById('details');
  var eurl      = "/alert/alerts/?output:1;";
  var url       = "/reportad/actions/?output:1;"
  var reason    = $j('input[name="reason"]:checked').val();
  var params    = "listingid:" + listingid + ";rpath:" + rpath + ";reason:" + reason;
  
  wait.style.display = "block";
  button.style.display = "none";
  $j('#createadform :input').attr('disabled', true);
  
  reasonchecked = $j("[name=reason]:checked").length > 0;
  
  
  if ( reasonchecked == false ) {
    eurl = eurl + "responsetext:Please select a reason for reporting this advert;pagetitle:Submission Error";
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    wait.style.display = "none";
    button.style.display = "block";
    $j('#createadform :input').attr('disabled', false);
  } else if ( details.value == "" ) {
    eurl = eurl + "responsetext:Please enter more details about this advert;pagetitle:Submission Error";
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    wait.style.display = "none";
    button.style.display = "block";
    $j('#createadform :input').attr('disabled', false);
  } else {
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
      wait.style.display = "none";
      button.style.display = "block";
      $j('#createadform :input').attr('disabled', false);
	} else {
	  ProcessReportAd(rtext); 
	}
  }});
  
  }
}

function ProcessReportAd(rtext) {
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rtext    = rtext;
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var rpath    = json.rpath;
  var eurl     = "/alert/alerts/?output:1;";
  var url      = "/notifynobutton/alerts/?output:1;responsetext:<b>Your report has been received.</b><br/>We will review it shortly.;pagetitle:Report Received";
  var wait     = document.getElementById('advwait');
  var button   = document.getElementById('advbutton');
  
  if ( rcode < 2 ) {
    eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error";
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
	wait.style.display   = "none";
	button.style.display = "block";
	$j('#createadform :input').attr('disabled', false);
  } else {
    OpenModalBox();
	FetchPage( url, "modalbox", "GET" )
    setTimeout(function() { CloseLocation(rpath); }, 4000);
  }
}


function DoDeleteAccount(userid, endpoint) {
  var userid     = userid;
  var endpoint   = endpoint;
  var url        = "/deleteaccount/actions/?output:1;customerid:" + userid;
  var button     = document.getElementById('modalaction');
  var wait       = document.getElementById('modalwait');
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText;
		
    if ( rstatus < 200 || rstatus > 200 ) {
      TransportError( rstatus, url );
      button.style.display = "block";
      wait.style.display   = "none";
    } else {
      ProcessDeleteAccount(rtext);
    }
  }});
  
  
}

function ProcessDeleteAccount(rtext) {
  var rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rtext    = rtext;
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var rpath    = json.rpath;
  var eurl     = "/alert/alerts/?output:1;responsetext:" + rtext + ";pagetitle:Deletion Error;";
  
  if ( rcode < 3 ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET' );
  } else {
    document.location.href = rpath;
  }
}

// open gallery 

function FetchPicture(thumb, listingid, table){
  modalbox      = document.getElementById('modalbox');
  var thumb     = thumb;
  var listingid = listingid;
  var table     = table;
  var url       = "/gallery/doc/?output:1;thumb:" + thumb + ";listingid:" + listingid + ";table:" + table;
  
  OpenModalBox();
  FetchPage( url, 'modalbox', 'GET' )
}

function SwitchGallery(sourcefile, shortdesc){
  var sourcefile = sourcefile;
  var mainimg    = document.getElementById('mainimg');
  var shortdesc  = shortdesc;
  var desc       = document.getElementById('smalldescription');
  
  desc.innerHTML = shortdesc;
  mainimg.src    = sourcefile;
}

function validatelogin(){
  var username = document.getElementById('username').value;
  var password = document.getElementById('password').value;
  var eurl     = "/alert/alerts/?output:1;";
  
  if ( username == "" ) {
	OpenModalBox();
	var eurl = eurl + "responsetext:Please enter your registered Email Address to continue.;pagetitle:Log in Error";
	FetchPage( eurl, 'modalbox', 'GET' );
  } else if ( password == "" ) {
	OpenModalBox();
	var eurl = eurl + "responsetext:Please enter your Password to continue.;pagetitle:Login Error";
	FetchPage( eurl, 'modalbox', 'GET' );
  } else {
    dologin( username, password );
  }
}

function SavePreviewAdvert( id, completepath, saveaction, tempid ) {

  var saveaction     = saveaction;
  var tempid         = tempid;
  var completepath   = completepath;
  var cpath          = completepath;
  var id             = id;
  var wait           = document.getElementById('previewwait' + id );
  var button         = document.getElementById('previewbutton' + id );
  
  if ( saveaction == "1" ) {
    var url = "/saveadvertfrompreview/actions/?output:1;tempid:" + tempid + ";cache:" + new Date().getTime();
  } else if ( saveaction == "2" ) {
    var url = "/updatead/checkout/?output:1;tempid:" + tempid + ";rpath:" + completepath + ";id:" + id + ";cache:" + new Date().getTime();
  }
  
 wait.style.display   = "block";
 button.style.display = "none";

  
 new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText;
		
    if ( rstatus < 200 || rstatus > 200 ) {
      TransportError( rstatus, url );
      button.style.display = "block";
      wait.style.display   = "none";
   } else {
      DoSavePreviewAdvert(rtext);
    }
  }});
  
  
}

function DoSavePreviewAdvert(rtext) {
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rtext    = rtext;
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var rpath    = json.rpath;
  var id       = json.id;
  var wait     = document.getElementById("previewwait" + id );
  var button   = document.getElementById("previewbutton" + id );
  var eurl     = "/alert/alerts/?output:1;responsetext:" + rtext + ";pagetitle:Submission Error";
  
  if ( rcode < 3 ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET' );
  } else {
    document.location.href = rpath;
  }
  
}





function dologin( username, password ) {
  var username = username;
  var password = password;
  var button   = document.getElementById('loginbutton');
  var wait     = document.getElementById('loginwait');
  var page     = document.getElementById('page').value;
  var url      = "/checklogin/actions/?output:1;username:" + username + ";password:" + password + ";page:" + page;
  
  button.style.display = "none";
  wait.style.display   = "block";
  $j('#loginform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText;
		
    if ( rstatus < 200 || rstatus > 200 ) {
      TransportError( rstatus, url );
      button.style.display = "block";
      wait.style.display   = "none";
	  $j('#loginform :input').attr('disabled', false);
    } else {
      processlogin(rtext);
    }
  }});
}

function processlogin(rtext) {
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rtext    = rtext;
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var rpath    = json.rpath;
  var eurl     = "/alert/alerts/?output:1;";
  var button   = document.getElementById('loginbutton');
  var wait     = document.getElementById('loginwait');
  
  if ( rcode < 5 ) {
    eurl = eurl + ";responsetext:" + rtext + ";pagetitle:Login Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
	button.style.display = "block";
	wait.style.display   = "none";
	$j('#loginform :input').attr('disabled', false);
  } else {
    document.location.href = rpath;
  }
}

function updateregistration() {
  var title      = document.getElementById('title');
  var title      = title.options[title.selectedIndex].value; 
  var title      = encodeURIComponent(title);
  var firstname  = document.getElementById('firstname').value;
  var firstname  = encodeURIComponent(firstname);
  var surname    = document.getElementById('surname').value;
  var surname    = encodeURIComponent(surname );
  var email      = document.getElementById('email').value;
  var email      = encodeURIComponent(email);
  var telephone  = document.getElementById('telephone').value;
  var telephone  = encodeURIComponent(telephone);
  var password   = document.getElementById('password').value;
  var password   = encodeURIComponent(password);
  var password2  = document.getElementById('password2').value;
  var password2  = encodeURIComponent(password2);
  var wait       = document.getElementById('regwait');
  var button     = document.getElementById('regbutton');
  
  var url        = "/updateregistration/actions/?output:1;" 
  var pars       = "title:" + title + ";firstname:" + firstname + ";surname:" + surname + ";email:" + email + ";telephone:" + telephone + ";";
  var pars2      = "password:" + password + ";password2:" + password2;
  var url        = url + pars + pars2;
  
  button.style.display = "none";
  wait.style.display   = "block";
  $j('#regform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText; 
		
    if ( rstatus < 200 || rstatus > 200 ) {
      TransportError( rstatus, url );
      button.style.display = "block";
      wait.style.display   = "none";
	  $j('#regform :input').attr('disabled', false);
    } else {
      processupdateregistration(rtext);
    }
  }});
}

function processupdateregistration(rtext){
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rtext    = rtext;
  var rtext    = unescape( rtext );
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var eurl     = "/alert/alerts/?output:1;"
  var wait     = document.getElementById('regwait');
  var button   = document.getElementById('regbutton');
  var surl     = "/notifynobutton/alerts/?output:1;responsetext:<b>Your personal details were updated sucessfully</b>;pagetitle:Details Updated";
  
  if ( rcode < 10 ) {
    var eurl = eurl + "responsetext:" + rtext + ";pagetitle:Update Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
    $j('#regform :input').attr('disabled', false);
  } else {
    OpenModalBox();
	FetchPage( surl, "modalbox", "GET" );
	//setTimeout(function() { CloseModalBox(); }, 4000); 
	setTimeout(function() { CloseLocation("/dashboard/account/"); }, 3000);
    button.style.display = "block";
    wait.style.display   = "none";
    $j('#regform :input').attr('disabled', false);
  }
}

function checkregistration(){
  var title      = document.getElementById('title');
  var title      = title.options[title.selectedIndex].value; 
  var title      = encodeURIComponent(title);
  var firstname  = document.getElementById('firstname').value;
  var firstname  = encodeURIComponent(firstname);
  var surname    = document.getElementById('surname').value;
  var surname    = encodeURIComponent(surname );
  var email      = document.getElementById('email').value;
  var email      = encodeURIComponent(email);
  var telephone  = document.getElementById('telephone').value;
  var telephone  = encodeURIComponent(telephone);
  var password   = document.getElementById('password').value;
  var password   = encodeURIComponent(password);
  var password2  = document.getElementById('password2').value;
  var password2  = encodeURIComponent(password2);
  var wait       = document.getElementById('regwait');
  var button     = document.getElementById('regbutton');
  var page       = document.getElementById('page').value;
  var trial      = document.getElementById('trial').value;
  
  var url        = "/checkregistration/actions/?output:1;" 
  var pars       = "trial:" + trial + ";title:" + title + ";firstname:" + firstname + ";surname:" + surname + ";email:" + email + ";telephone:" + telephone + ";";
  var pars2      = "password:" + password + ";password2:" + password2 + ";page:" + page;
  var url        = url + pars + pars2;

  button.style.display = "none";
  wait.style.display   = "block";
  $j('#regform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText; 
		
    if ( rstatus < 200 || rstatus > 200 ) {
      TransportError( rstatus, url );
      button.style.display = "block";
      wait.style.display   = "none";
	  $j('#regform :input').attr('disabled', false);
    } else {
      processregistration(rtext);
    }
  }});
  
}

function processregistration(rtext){
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rtext    = rtext;
  var rtext    = unescape( rtext );
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var rpath    = json.rpath;
  var eurl     = "/alert/alerts/?output:1;"
  var wait     = document.getElementById('regwait');
  var button   = document.getElementById('regbutton');
  
  if ( rcode < 9 ) {
    var eurl = eurl + "responsetext:" + rtext + ";pagetitle:Registration Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
    $j('#regform :input').attr('disabled', false);
  } else {
    document.location.href = rpath;
  }
}

function displaybankdetails( payref, amount ) {
  var payref = payref;
  var amount = amount;
  var url    = "/bankdetails/alerts/?output:1;payref:" + payref + ";amount:" + amount;
  OpenModalBox();
  FetchPage( url, "modalbox", "GET" );
}

function previewadvert() {
  var title        = document.getElementById('title').value;
  var title        = encodeURIComponent(title);
  var nextday      = document.getElementById('nextday');
  var nextday      = nextday.options[nextday.selectedIndex].value;
  var nextday      = encodeURIComponent(nextday);
  var nextmonth    = document.getElementById('nextmonth');
  var nextmonth    = nextmonth.options[nextmonth.selectedIndex].value;
  var nextmonth    = encodeURIComponent(nextmonth);
  var nextyear     = document.getElementById('nextyear');
  var nextyear     = nextyear.options[nextyear.selectedIndex].value;
  var nextyear     = encodeURIComponent(nextyear);
  var rent         = document.getElementById('rent').value;
  var rent         = encodeURIComponent(rent);
  var period       = document.getElementById('period');
  var period       = period.options[period.selectedIndex].value;
  var period       = encodeURIComponent(period);
  //var incbills     = document.getElementById('incbills');
  var postcode     = document.getElementById('postcode').value;
  var postcode     = encodeURIComponent(postcode);
  var location     = document.getElementById('location');
  var location     = location.options[location.selectedIndex].value;
  var location     = encodeURIComponent(location);
  var protype      = document.getElementById('propertytype');
  var protype      = protype.options[protype.selectedIndex].value;
  var protype      = encodeURIComponent(protype);
  var roomamount   = document.getElementById('roomamount');
  var roomamount   = roomamount.options[roomamount.selectedIndex].value;
  var roomamount   = encodeURIComponent(roomamount);
  var desc         = document.getElementById('description').value;
  var desc         = encodeURIComponent(desc);
  var references   = document.getElementById('references').value;
  var references   = encodeURIComponent(references);
  var byemail      = document.getElementById('byemail');
  var email        = document.getElementById('email').value;
  var email        = encodeURIComponent(email);
  var byphone      = document.getElementById('byphone');
  var phone        = document.getElementById('telephone').value;
  var phone        = encodeURIComponent(phone);
  var contact      = document.getElementById('contactname').value;
  
  var photo1value  = document.getElementById('photo1value').value;
  var photo2value  = document.getElementById('photo2value').value;
  var photo3value  = document.getElementById('photo3value').value;
  var photo4value  = document.getElementById('photo4value').value;
  var photo5value  = document.getElementById('photo5value').value;
  var photo6value  = document.getElementById('photo6value').value;
  
  var photo1vert   = document.getElementById('photo1isvert').value;
  var photo2vert   = document.getElementById('photo2isvert').value;
  var photo3vert   = document.getElementById('photo3isvert').value;
  var photo4vert   = document.getElementById('photo4isvert').value;
  var photo5vert   = document.getElementById('photo5isvert').value;
  var photo6vert   = document.getElementById('photo6isvert').value;
  
  var photo1width  = document.getElementById('photo1width').value;
  var photo2width  = document.getElementById('photo2width').value;
  var photo3width  = document.getElementById('photo3width').value;
  var photo4width  = document.getElementById('photo4width').value;
  var photo5width  = document.getElementById('photo5width').value;
  var photo6width  = document.getElementById('photo6width').value;
  
  var rpath        = document.getElementById('rpath').value;
  var button       = document.getElementById('advbutton');
  var wait         = document.getElementById('advwait');
  var saveaction   = document.getElementById('saveaction');
  var listingid    = document.getElementById('listingid');
  var advertid     = document.getElementById('advertid');
  var fromlive     = document.getElementById('fromlive').value;
  var fromsaved    = document.getElementById('fromsaved').value;
  var fromexpired  = document.getElementById('fromexpired').value;
  var fromdeleted  = document.getElementById('fromdeleted').value;
  
  incbillschecked  = $j("[name=incbills]:checked").length > 0;
  incbillsvalue    = $j("input[name='incbills']:checked").val();
  
  if ( byemail.checked ) {
    var byemail = 1;
  } else {
    var byemail = 0;
  }
  
  if ( byphone.checked ) {
    var byphone = 1;
  } else {
    var byphone = 0;
  }
  
  var url     = "/savepreviewadvert/actions/?output:1;cache:" + new Date().getTime();
  var pars1   = "advertid:" + advertid.value + ";listingid:" + listingid.value + ";saveaction:" + saveaction.value + ";rpath:" + rpath + ";title:" + title + ";nextday:" + nextday + ";nextmonth:" + nextmonth + ";nextyear:" + nextyear + ";";
  var pars2   = "rent:" + rent + ";period:" + period + ";incbills:" + incbillsvalue + ";postcode:" + postcode + ";location:" + location + ";";
  var pars3   = "protype:" + protype + ";roomamount:" + roomamount + ";desc:" + desc + ";references:" + references + ";byemail:" + byemail + ";email:" + email + ";";
  var pars4   = "byphone:" + byphone + ";phone:" + phone + ";contact:" + contact + ";cache:" + new Date().getTime() + ";";
  var pars5   = "photo1value:" + photo1value + ";photo2value:" + photo2value + ";photo3value:" + photo3value + ";photo4value:" + photo4value + ";photo5value:" + photo5value + ";photo6value:" + photo6value + ";";
  var pars6   = "photo1isvert: "+ photo1vert + ";photo2isvert: " + photo2vert + ";photo3isvert:" + photo3vert + ";photo4isvert:" + photo4vert + ";photo5isvert:" + photo5vert + ";photo6isvert:" + photo6vert + ";";
  var pars7   = "photo1width:" + photo1width + ";photo2width:" + photo2width + ";photo3width:" + photo3width + ";photo4width:" + photo4width + ";photo5width:" + photo5width + ";photo6width:" + photo6width + ";";
  var pars8   = "fromlive:" + fromlive + ";fromsaved:" + fromsaved + ";fromexpired:" + fromexpired + ";fromdeleted:" + fromdeleted;
  var params  = pars1 + pars2 + pars3 + pars4 + pars5 + pars6 + pars7 + pars8;
  
  wait.style.display    = "block";
  button.style.display  = "none"; 
  $j('#createadform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	  $j('#createadform :input').attr('disabled', false);
	} else {
	  processpreviewadvert(rtext); 
	}
  }});
}

function processpreviewadvert(rtext) {
  var rtext       = rtext;
  var json        = eval("(" + rtext + ")");
  var rtext       = json.rtext;
  var rcode       = json.rcode;
  var adtext      = json.adresponse;
  var proceed     = json.proceed;
  var rpath       = json.rpath;
  var listingid   = json.listingid;
  var saveaction  = json.saveaction;
  var fromlive    = json.fromlive;
  var fromsaved   = json.fromsaved;
  var fromexpired = json.fromexpired;
  var fromdeleted = json.fromdeleted;
  var tempid      = json.tempid;
  
  var eurl      = "/alert/alerts/?output:1;";
  var surl      = "/notifynobutton/alerts/?output:1;responsetext:" + adtext + ";pagetitle:Advert Created";
  var button    = document.getElementById('advbutton');
  var wait      = document.getElementById('advwait');
  
  if ( rcode < 17 ) {
    var eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error"
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
	$j('#createadform :input').attr('disabled', false);
	
  } else {
  
    if ( saveaction == "1" ) {
	 
	 document.location.href = "/previewadvert/account/?tempid:" + tempid + ";rpath:" + rpath;
	
	} else if ( saveaction == "2" ) {
	  
	  if ( fromlive == "1" ) {
	    document.location.href = "/previeweditadvert/account/?tempid:" + tempid + ";listingid:" + listingid + ";rpath:" + rpath + ";fromlive:" + fromlive;
	  } else if ( fromsaved == "1" ) {
	    document.location.href = "/previeweditadvert/account/?tempid:" + tempid + ";listingid:" + listingid + ";rpath:" + rpath + ";fromsaved:" + fromsaved;
	  } else if ( fromexpired == "1" ) {
	    document.location.href = "/previeweditadvert/account/?tempid:" + tempid + ";listingid:" + listingid + ";rpath:" + rpath + ";fromexpired:" + fromexpired;
	  } else if ( fromdeleted == "1" ) {
	    document.location.href = "/previeweditadvert/account/?tempid:" + tempid + ";listingid:" + listingid + ";rpath:" + rpath + ";fromdeleted:" + fromdeleted;
	  } else {
	    document.location.href = "/previeweditadvert/account/?tempid:" + tempid + ";listingid:" + listingid + ";rpath:" + rpath;
	  }
	  
	}
	
  }
}


function checkadvertisement() {
  var title        = document.getElementById('title').value;
  var title        = encodeURIComponent(title);
  var nextday      = document.getElementById('nextday');
  var nextday      = nextday.options[nextday.selectedIndex].value;
  var nextday      = encodeURIComponent(nextday);
  var nextmonth    = document.getElementById('nextmonth');
  var nextmonth    = nextmonth.options[nextmonth.selectedIndex].value;
  var nextmonth    = encodeURIComponent(nextmonth);
  var nextyear     = document.getElementById('nextyear');
  var nextyear     = nextyear.options[nextyear.selectedIndex].value;
  var nextyear     = encodeURIComponent(nextyear);
  var rent         = document.getElementById('rent').value;
  var rent         = encodeURIComponent(rent);
  var period       = document.getElementById('period');
  var period       = period.options[period.selectedIndex].value;
  var period       = encodeURIComponent(period);
  var incbills     = document.getElementById('incbills');
  var postcode     = document.getElementById('postcode').value;
  var postcode     = encodeURIComponent(postcode);
  var location     = document.getElementById('location');
  var location     = location.options[location.selectedIndex].value;
  var location     = encodeURIComponent(location);
  var protype      = document.getElementById('propertytype');
  var protype      = protype.options[protype.selectedIndex].value;
  var protype      = encodeURIComponent(protype);
  var roomamount   = document.getElementById('roomamount');
  var roomamount   = roomamount.options[roomamount.selectedIndex].value;
  var roomamount   = encodeURIComponent(roomamount);
  var desc         = document.getElementById('description').value;
  var desc         = encodeURIComponent( desc );
  var byemail      = document.getElementById('byemail');
  var email        = document.getElementById('email').value;
  var email        = encodeURIComponent(email);
  var byphone      = document.getElementById('byphone');
  var phone        = document.getElementById('telephone').value;
  var phone        = encodeURIComponent(phone);
  var contact      = document.getElementById('contactname').value;
  var button       = document.getElementById('advbutton');
  var wait         = document.getElementById('advwait');
  
  if ( incbills.checked ) {
    var incbills = 1;
  } else {
    var incbills = 0;
  }
  
  if ( byemail.checked ) {
    var byemail = 1;
  } else {
    var byemail = 0;
  }
  
  if ( byphone.checked ) {
    var byphone = 1;
  } else {
    var byphone = 0;
  }
  
  var url     = "/savenewadvert/actions/?output:1;";
  var pars1   = "title:" + title + ";nextday:" + nextday + ";nextmonth:" + nextmonth + ";nextyear:" + nextyear + ";";
  var pars2   = "rent:" + rent + ";period:" + period + ";incbills:" + incbills + ";postcode:" + postcode + ";location:" + location + ";";
  var pars3   = "protype:" + protype + ";roomamount:" + roomamount + ";desc:" + desc + ";byemail:" + byemail + ";email:" + email + ";";
  var pars4   = "byphone:" + byphone + ";phone:" + phone + ";contact:" + contact + ";cache:" + new Date().getTime();
  var params  = pars1 + pars2 + pars3 + pars4;
  
  wait.style.display    = "block";
  button.style.display  = "none"; 
  $j('#createadform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	  $j('#createadform :input').attr('disabled', false);
	} else {
	  processcheckadvertisement(rtext); 
	}
  }});

}

function processcheckadvertisement(rtext) {
  var rtext     = rtext;
  var json      = eval("(" + rtext + ")");
  var rtext     = json.rtext;
  var rcode     = json.rcode;
  var adtext    = json.adresponse;
  var proceed   = json.proceed;
  var rpath     = json.rpath;
  
  var eurl      = "/alert/alerts/?output:1;";
  var surl      = "/notifynobutton/alerts/?output:1;responsetext:" + adtext + ";pagetitle:Advert Created";
  var button    = document.getElementById('advbutton');
  var wait      = document.getElementById('advwait');
  
  if ( rcode < 16 ) {
    var eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error"
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
	$j('#createadform :input').attr('disabled', false);
	
  } else {
    OpenModalBox(); 
	FetchPage( surl, "modalbox", "GET" );
	setTimeout(function() { CloseLocation(rpath); }, 4000); 
  }
}


function ToggleToLet(){ 
  var markaslet = document.getElementById('letstatus');
  var nextavailabledate = document.getElementById('nextavailabledate');
	
	if ( markaslet.checked == true ){
	  nextavailabledate.style.display = "table";
	} else {
	  nextavailabledate.style.display = "none";
	}
}

function updateadvert(){
  var title        = document.getElementById('title').value;
  var title        = encodeURIComponent(title);
  var nextday      = document.getElementById('nextday');
  var nextday      = nextday.options[nextday.selectedIndex].value;
  var nextday      = encodeURIComponent(nextday);
  var nextmonth    = document.getElementById('nextmonth');
  var nextmonth    = nextmonth.options[nextmonth.selectedIndex].value;
  var nextmonth    = encodeURIComponent(nextmonth);
  var nextyear     = document.getElementById('nextyear');
  var nextyear     = nextyear.options[nextyear.selectedIndex].value;
  var nextyear     = encodeURIComponent(nextyear);
  var rent         = document.getElementById('rent').value;
  var rent         = encodeURIComponent(rent);
  var period       = document.getElementById('period');
  var period       = period.options[period.selectedIndex].value;
  var period       = encodeURIComponent(period);
  var incbills     = document.getElementById('incbills');
  var postcode     = document.getElementById('postcode').value;
  var postcode     = encodeURIComponent(postcode);
  var location     = document.getElementById('location').value;
  var location     = encodeURIComponent(location);
  var protype      = document.getElementById('propertytype');
  var protype      = protype.options[protype.selectedIndex].value;
  var protype      = encodeURIComponent(protype);
  var roomamount   = document.getElementById('roomamount');
  var roomamount   = roomamount.options[roomamount.selectedIndex].value;
  var roomamount   = encodeURIComponent(roomamount);
  var desc         = document.getElementById('description').value;
  var desc         = encodeURIComponent( desc );
  var byemail      = document.getElementById('byemail');
  var email        = document.getElementById('email').value;
  var email        = encodeURIComponent(email);
  var byphone      = document.getElementById('byphone');
  var phone        = document.getElementById('telephone').value;
  var phone        = encodeURIComponent(phone);
  var contact      = document.getElementById('contactname').value;
  var listingid    = document.getElementById('listingid').value;
  var button       = document.getElementById('advbutton');
  var wait         = document.getElementById('advwait');
  
  if ( incbills.checked ) {
    var incbills = 1;
  } else {
    var incbills = 0;
  }
  
  if ( byemail.checked ) {
    var byemail = 1;
  } else {
    var byemail = 0;
  }
  
  if ( byphone.checked ) {
    var byphone = 1;
  } else {
    var byphone = 0;
  }
  
  var url     = "/saveeditadvert/actions/?output:1;cache:" + new Date().getTime();
  var pars1   = "title:" + title + ";nextday:" + nextday + ";nextmonth:" + nextmonth + ";nextyear:" + nextyear + ";";
  var pars2   = "rent:" + rent + ";period:" + period + ";incbills:" + incbills + ";postcode:" + postcode + ";location:" + location + ";";
  var pars3   = "protype:" + protype + ";roomamount:" + roomamount + ";desc:" + desc + ";byemail:" + byemail + ";email:" + email + ";";
  var pars4   = "byphone:" + byphone + ";phone:" + phone + ";contact:" + contact + ";listingid:" + listingid + ";cache:" + new Date().getTime();
  var params  = pars1 + pars2 + pars3 + pars4;
  
  wait.style.display    = "block";
  button.style.display  = "none"; 
  $j('#createadform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	  $j('#createadform :input').attr('disabled', false);
	} else {
	  processupdateadvert(rtext);
	}
  }});
}


function processupdateadvert(rtext) {
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var eurl     = "/alert/alerts/?output:1;";
  var surl     = "/notifynobutton/alerts/?output:1;responsetext:Your advert was saved successfully.;pagetitle:Advert Saved";
  var button   = document.getElementById('advbutton');
  var wait     = document.getElementById('advwait');
  
  if ( rcode < 13 ) {
    eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error;"
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
	$j('#createadform :input').attr('disabled', false);
  } else {
    button.style.display = "block";
    wait.style.display   = "none";
	$j('#createadform :input').attr('disabled', false);
	OpenModalBox();
	FetchPage( surl, "modalbox", "GET" );
	setTimeout(function() { CloseModalBox(); }, 4000);  
  }
}

function CheckUpload(filename, photo) {
  var filename = filename;
  var photo    = photo;
  var file     = document.getElementById(filename).value;
  var eurl     = "/alert/alerts/?output:1;";
  
  UploadPhoto(photo);
}

function ResetUpload(upnumber) {
  var upnumber = upnumber;
  var uperror  = document.getElementById("photo" + upnumber + "error");
  var uploader = document.getElementById("photo" + upnumber + "uploader");
  uploader.style.display = "block";
  uperror.style.display  = "none";
}

function UploadPhoto(photo) {
  var photo     = photo;
  var frm       = document.getElementById( photo + "form" );
  var uploader  = document.getElementById( photo + "uploader" );
  var photowait = document.getElementById( photo + "wait" );
  var img       = document.getElementById( photo + "img" );
  var url       = "/uploading/alerts/?output:1";
  var eurl      = "/alert/alerts/?output:1";
  
  img.style.opacity = "0.2";
  uploader.style.display = "none";
  photowait.style.display = "block";
  frm.submit();
  
  ///OpenModalBox();
  ///FetchPage( url, 'modalbox', 'GET' );
  ///frm.submit();
}

function ProcessUpload(pelement, json) {
  var pelement     = pelement;
  var rtext        = json;
  var json         = eval("(" + rtext + ")");
  var rcode        = json.rcode;
  var rtext        = json.rtext;
  var rtext        = encodeURIComponent(rtext);
  var ufailed      = json.failed;
  var image        = json.image;
  var pelement     = json.pelement;
  var listingid    = json.listingid;
  var isvertical   = json.isvertical;
  var imagewidth   = json.imagewidth;
  var file         = document.getElementById( pelement + "file" );
  var img          = document.getElementById( pelement + "img" );
  var remove       = document.getElementById( pelement + "delete" ); 
  var button       = document.getElementById( pelement + "button" );
  var url          = "/notifynobutton/alerts/?output:1;pagetitle:Upload Complete;responsetext:<b>Your upload was successful</b>.";
  var eurl         = "/alert/alerts/?output:1;pagetitle:Upload Error;responsetext:" + rtext;
  var photosrc     = document.getElementById( pelement + "value");
  var photoisvert  = document.getElementById( pelement + "isvert");
  var photosize    = document.getElementById( pelement + "width");
  var uploader     = document.getElementById( pelement + "uploader");
  var photowait    = document.getElementById( pelement + "wait");
  var uploaderror  = document.getElementById( pelement + "error");
  var uploadtext   = document.getElementById( pelement + "message");
  var removephoto  = document.getElementById( pelement + "delete" );
  
  if ( ufailed == "1" ) {
    uploader.style.display    = "none";
	photowait.style.display   = "none";
	uploaderror.style.display = "block";
	img.style.opacity = "0.9";
	uploadtext.innerHTML = unescape(rtext);
	file.value = "";
	removephoto.style.display = "none";
  } else {
    uploader.style.display    = "block";
	photowait.style.display   = "none";
	uploaderror.style.display = "none";
	file.value = "";
	file.style.display = "none";
	img.src = "/uploads/thumbs/" + image;
	img.style.opacity = "0.9";
    photosrc.value    = image;
    photoisvert.value = isvertical;
    photosize.value   = imagewidth;
	removephoto.style.display = "block";
  }
}

function DeletePhoto( listingid, deleteobject, photoid, photosrc ){

  var url           = "/deletephoto/actions/?output:1"
  var listingid     = listingid;
  var deleteobject  = deleteobject;
  var photoid       = photoid;
  var photosrc      = photosrc;
  var params        = "photoid:" + photoid + ";listingid:" + listingid + ";object:" + deleteobject + ";photosrc:" + photosrc;
  var link          = document.getElementById(deleteobject + "delete" );
  var holder        = document.getElementById(deleteobject + "holder");
  var imgsrc        = document.getElementById(deleteobject + "img" );
  holder.innerHTML = "<img src='/application/library/media/notlet_nopic.png' id='" + deleteobject + "img'/>";
  link.innerHTML   = "";
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	} else {
	}
  }});
  
}

function DeleteUploadPhoto(photoid, photonumber, holder, deletebutton, uploadfile, listingid, page, fromedit ){
  var photoid       = photoid;
  var photonumber   = photonumber;
  var holder        = holder;
  var deletebutton  = deletebutton;
  var uploadfile    = uploadfile;
  var listingid     = listingid;
  var page          = page;
  var fromedit      = fromedit;
  var photo1src     = document.getElementById('photo1value').value;
  var photo2src     = document.getElementById('photo2value').value;
  var photo3src     = document.getElementById('photo3value').value;
  var photo4src     = document.getElementById('photo4value').value;
  var photo5src     = document.getElementById('photo5value').value;
  var photo6src     = document.getElementById('photo6value').value;
  var url           = "/deleteuploadphoto/actions/?output:1;cache:" + new Date().getTime();
  
  var params        = "photoid:" + photoid + ";photo1src:" + photo1src + ";photo2src:" + photo2src + ";photo3src:" + photo3src + ";photo4src:" + photo4src + ";photo5src:" + photo5src + ";photo6src:" + photo6src + ";" +
                      "photonumber:" + photonumber + ";holder:" + holder + ";deletebutton:" + deletebutton + ";uploadfile:" + uploadfile + ";listingid:" + listingid + ";page:" + page + ";fromedit:" + fromedit;
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	} else {
	  ProcessDeleteUploadPhoto(rtext);
	}
  }});
  
}

function ProcessDeleteUploadPhoto(rtext) {
  var rtext = rtext;
  var json  = eval("(" + rtext + ")");
  var photonumber   = json.photonumber;
  var holder        = json.holder;
  var deletebutton  = json.deletebutton;
  var uploadfile    = json.uploadfile;
  var holder        = document.getElementById(holder);
  var deletebutton  = document.getElementById(deletebutton);
  var uploadfile    = document.getElementById(uploadfile);
  var photo1value   = document.getElementById("photo1value");
  var photo2value   = document.getElementById("photo2value");
  var photo3value   = document.getElementById("photo3value");
  var photo4value   = document.getElementById("photo4value");
  var photo5value   = document.getElementById("photo5value");
  var photo6value   = document.getElementById("photo6value");
  
  var photo1isvert  = document.getElementById("photo1isvert");
  var photo2isvert  = document.getElementById("photo2isvert");
  var photo3isvert  = document.getElementById("photo3isvert");
  var photo4isvert  = document.getElementById("photo4isvert");
  var photo5isvert  = document.getElementById("photo5isvert");
  var photo6isvert  = document.getElementById("photo6isvert");
  
  var photo1width   = document.getElementById("photo1width");
  var photo2width   = document.getElementById("photo2width");
  var photo3width   = document.getElementById("photo3width");
  var photo4width   = document.getElementById("photo4width");
  var photo5width   = document.getElementById("photo5width");
  var photo6width   = document.getElementById("photo6width");
  
  holder.src = "/application/library/media/nopicsmall.png";
  deletebutton.style.display = "none";
  uploadfile.style.display   = "block";
  
  if ( photonumber == "1" ) {
    photo1value.value  = "";
	photo1isvert.value = "";
	photo1width.value  = "";
  } else if ( photonumber == "2" ) {
    photo2value.value  = "";
	photo2isvert.value = "";
	photo2width.value  = "";
  } else if ( photonumber == "3" ) {
    photo3value.value  = "";
	photo3isvert.value = "";
	photo3width.value  = "";
  } else if ( photonumber == "4" ) {
    photo4value.value  = "";
	photo4isvert.value = "";
	photo4width.value  = "";
  } else if ( photonumber == "5" ) {
    photo5value.value  = "";
	photo5isvert.value = "";
	photo5width.value  = "";
  } else if ( photonumber == "6" ) {
    photo6value.value  = "";
	photo6isvert.value = "";
	photo6width.value  = "";
  }
}
  
function contactadvertiser(rpath, listingid, customerid) {
  var rpath      = rpath;
  var listingid  = listingid;
  var customerid = customerid;
  var email      = document.getElementById('email').value;
  var email      = encodeURIComponent(email);
  var phone      = document.getElementById('phone').value;
  var phone      = encodeURIComponent(phone);
  var name       = document.getElementById('name').value;
  var name       = encodeURIComponent(name);
  var subject    = document.getElementById('subject').value;
  var subject    = encodeURIComponent(subject)
  var message    = document.getElementById('message').value;
  var message    = encodeURIComponent(message);
  var params     = "email:" + email + ";phone:" + phone + ";name:" + name + ";subject:" + subject + ";message:" + message + ";rpath:" + rpath + ";listingid:" + listingid + ";customerid:" + customerid;
  var url        = "/contactadvertiser/actions/?output:1;cache:" + new Date().getTime();
  var button     = document.getElementById('advbutton');
  var wait       = document.getElementById('advwait');
  
  wait.style.display    = "block";
  button.style.display  = "none"; 
  $j('#createadform :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	  $j('#createadform :input').attr('disabled', false);
	} else {
	  processcontactadvertiser(rtext);
	}
  }});
}

function processcontactadvertiser(rtext) {
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rtext    = json.rtext;
  var rcode    = json.rcode;
  var proceed  = json.proceed;
  var rpath    = json.rpath;
  var eurl     = "/alert/alerts/?output:1;";
  var surl     = "/notifynobutton/alerts/?output:1;responsetext:Your message was sent successfully.;pagetitle:Message Sent";
  var button   = document.getElementById('advbutton');
  var wait     = document.getElementById('advwait');
  
  if ( rcode < 9 ) {
    eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error;"
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
	$j('#createadform :input').attr('disabled', false);
  } else {
    button.style.display = "block";
    wait.style.display   = "none";
	$j('#createadform :input').attr('disabled', false);
	OpenModalBox();
	FetchPage( surl, "modalbox", "GET" );
	setTimeout(function() { CloseLocation(rpath); }, 4000);  
  }
}

function registerpayment(subnumber, desc, payref, userid){
  var subnum   = subnumber;
  var desc     = desc;
  var payref   = payref;
  var userid   = userid;
  var form     = document.getElementById("sub" + subnumber);
  var url      = "/registerpayment/actions/?output:1;"
  var button   = document.getElementById('paypalbutton' + subnumber);
  var wait     = document.getElementById('paypalwait' + subnumber);
  var params   = "subnumber:" + subnumber + ";desc:" + desc + ";payref:" + payref + ";customerid:" + userid;
  
  button.style.display = "none";
  wait.style.display   = "block";

  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  processregisterpayment(rtext);
	}
  }}); 
}

function processregisterpayment(rtext) {
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var rtext      = json.rtext;
  var rcode      = json.rcode;
  var proceed    = json.proceed;
  var subnumber  = json.subid;
  var requestid  = json.requestid;
  var button     = document.getElementById('paypalbutton' + subnumber);
  var wait       = document.getElementById('paypalwait' + subnumber);
  var retel      = document.getElementById('return' + subnumber)
  var ppreturn   = retel.value;
  var form       = document.getElementById('sub' + subnumber);
 
  if ( rcode < 5 ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET');
	button.style.display = "block";
	wait.style.display   = "none";
  } else {
     retel.value  = ppreturn + ";requestid:" + requestid;
	 form.submit();
  }
}

function PromptDelete( actionurl, prompttext, prompttitle, cmdtype ){
  var actionurl   = actionurl;
  var prompttext  = prompttext;
  var prompttext  = encodeURIComponent( prompttext );
  var prompttitle = prompttitle;
  var prompttitle = encodeURIComponent( prompttitle );
  var cmdtype     = cmdtype;
  var url         = "/prompt/alerts/?output:1;actionurl:" + actionurl + ";responsetext:" + prompttext + ";pagetitle:" + prompttitle + ";cmdtype:" + cmdtype;
  var button      = document.getElementById('modalaction');
  var wait        = document.getElementById('modalwait');
  
  OpenModalBox();
  FetchPage( url, 'modalbox', 'GET' );
}

function DoPermDeleteAdvert(listingid, returnurl) {
  var listingid  = listingid;
  var returnurl  = returnurl;
  var button     = document.getElementById('modalaction');
  var wait       = document.getElementById('modalwait');
  var url        = "/permdeleteadvert/actions/?output:1;"
  var params     = "listingid:" + listingid + ";returnurl:" + returnurl;
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  ProcessPermDeleteAdvert(rtext); 
	}
  }}); 
}

function ProcessPermDeleteAdvert(rtext) {
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var rtext      = json.rtext;
  var rcode      = json.rcode;
  var proceed    = json.proceed;
  var rpath      = json.rpath;
  var eurl       = "/alert/alerts/?output:1;responsetext:" + rtext + ";pagetitle:Deleting Failed!;";
  var surl       = "/notifynobutton/alerts/?output:1;responsetext:<b>Your advert was permanently deleted</b>;pagetitle:Advert Deleted;"
  if ( rcode < 4 ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET' );
  } else {
    OpenModalBox();
	FetchPage( surl, 'modalbox', 'GET' );
	setTimeout(function() { CloseLocation(rpath); }, 2000);  
  }
}

function DoRestoreAdvert(listingid, returnurl) {
  var listingid  = listingid;
  var returnurl  = returnurl;
  var button     = document.getElementById('modalaction');
  var wait       = document.getElementById('modalwait');
  var url        = "/restoreadvert/actions/?output:1;"
  var params     = "listingid:" + listingid + ";returnurl:" + returnurl;
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  ProcessRestoreAdvert(rtext); 
	}
  }}); 
}

function ProcessRestoreAdvert(rtext) {
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var rtext      = json.rtext;
  var rcode      = json.rcode;
  var proceed    = json.proceed;
  var rpath      = json.rpath;
  var eurl       = "/alert/alerts/?output:1;responsetext:" + rtext + ";pagetitle:Deleting Failed!;";
  var surl       = "/notifynobutton/alerts/?output:1;responsetext:<b>Your advert was restored successfully</b>;pagetitle:Advert Restored;"
  if ( rcode < 4 ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET' );
  } else {
    OpenModalBox();
	FetchPage( surl, 'modalbox', 'GET' );
	setTimeout(function() { CloseLocation(rpath); }, 2000);  
  }
}

function DoDeleteAdvert(listingid, returnurl){
  var listingid  = listingid;
  var returnurl  = returnurl;
  var button     = document.getElementById('modalaction');
  var wait       = document.getElementById('modalwait');
  var url        = "/deleteadvert/actions/?output:1;"
  var params     = "listingid:" + listingid + ";returnurl:" + returnurl;
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  ProcessDoDeleteAdvert(rtext); 
	}
  }}); 
}

function ProcessDoDeleteAdvert(rtext){
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var rtext      = json.rtext;
  var rcode      = json.rcode;
  var proceed    = json.proceed;
  var rpath      = json.rpath;
  var eurl       = "/alert/alerts/?output:1;responsetext:" + rtext + ";pagetitle:Deleting Failed!;";
  
  if ( rcode < 4 ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET' );
  } else {
    setTimeout(function() { CloseLocation(rpath); }, 2000);  
  }
}

function resetpassword(){
  var user    = document.getElementById('username');
  var rpath   = document.getElementById('returnpath');
  var button  = document.getElementById('loginbutton');
  var wait    = document.getElementById('loginwait');
  var eurl    = "/alert/alerts/?output:1;responsetext:Please enter your registered email address;pagetitle:Submission Error";
  var url     = "/resetpassword/actions/?output:1"
  var params  = "username:" + user.value + ";rpath:" + rpath.value + ";user:" + user.value;
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  if ( user.value == "" ) {
    OpenModalBox();
	FetchPage( eurl, 'modalbox', 'GET' );
	button.style.display = "block";
	wait.style.display   = "none";
  } else {
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  ProcessResetPassword(rtext); 
	}
  }}); 
  
  }
}

function ProcessResetPassword(rtext) {
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var rtext      = json.rtext;
  var rcode      = json.rcode;
  var proceed    = json.proceed;
  var rpath      = json.rpath;
  var eurl       = "/alert/alerts/?output:1;"
  var surl       = "/notifynobutton/alerts/?output:1;responsetext:Your password has been sent.;pagetitle:Reminder Sent";
  
  var button  = document.getElementById('loginbutton');
  var wait    = document.getElementById('loginwait');
  
  if ( rcode < 2 ) {
    eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error;"
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    button.style.display = "block";
    wait.style.display   = "none";
  } else {
    button.style.display = "block";
	wait.style.display   = "none";
	OpenModalBox();
	FetchPage( surl, "modalbox", "GET" );
	setTimeout(function() { CloseLocation(rpath); }, 3000);  
  }
}

function togglereportad(id) {
  var element = document.getElementById(id);
  var button  = document.getElementById('reportadbutton');
  
  if (element) {
    var display = element.style.display;
	
	if (display == "none") {
	  element.style.display = "block";
	  button.className = "reportad_on";
	} else {
	  element.style.display = "none";
	  button.className = "reportad";
	}
  }
}

function openuklist(){
  var element = document.getElementById('menu2');

  if (element) {
    var display = element.style.display;
    if (display == "none") {
      element.style.display = "block";
    } else {
    element.style.display = "none";
    }
}
  
/*
  var url       = "/uklist/actions/?output:1"
  var modalbox  = document.getElementById('modalbox');
  OpenModalBox();
  FetchPage( url, 'modalbox', 'GET' );
  modalbox.className = "modal_box_large";
*/
}

function SwapCity() {
  var dropselarea = document.getElementById('dropselarea');
  var city        = document.getElementById('uklocation');
  var city        = city.options[city.selectedIndex].value;
  
  dropselarea.innerHTML = "<b>" + city + " Properties</b>";
}

function SetCity( city ) {
  var city    = city;
  var url     = "/setcity/actions/?output:1;"
  var params  = "uklocation:" + city;
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  ProcessSetCity(rtext); 
	}
  }}); 
}

function ProcessSetCity(rtext) {
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var location   = json.location;
  var norooms    = json.norooms;
  var proceed    = json.proceed;
  
  if ( proceed < 1 ) {
  } else {
    document.location.href = "/ukshortlets/doc/?city=" + location + "&bypassfilter=1&showdrop=1"
  }
}

function SelectCity(norooms) {
  var norooms      = norooms;
  var uklocation   = document.getElementById('uklocation').value;
  var url          = "/setcity/actions/?output:1"
  var params       = "uklocation:" + uklocation + ";uknorooms:" + norooms;
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  button.style.display = "block";
	  wait.style.display   = "none";
	} else {
	  ProcessSelectCity(rtext); 
	}
  }}); 
}

function ProcessSelectCity(rtext) {
  var rtext      = rtext;
  var json       = eval("(" + rtext + ")");
  var location   = json.location;
  var norooms    = json.norooms;
  var proceed    = json.proceed;
  
  if ( proceed < 1 ) {
  } else {
    document.location.href = "/ukshortlets/doc/?city:" + location + ";rooms:" + norooms;
  }
}

function DisableHref(linkid) {
  var linkid = linkid;
  var hlink  = document.getElementById(linkid);
  
  if(!hlink)
  return;
  hlink.href = "javascript://";
}


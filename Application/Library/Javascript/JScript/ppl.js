
function updatetrialad(listingid, duration){
  var listingid = listingid;
  var duration  = duration;
  var button    = document.getElementById('placead');
  var wait      = document.getElementById('previewwait');
  var edit      = document.getElementById('previewedit');
  
  button.style.display = "none";
  wait.style.display   = "block";
  edit.style.display   = "none";
  
  var url = "/updatetrialdate/checkout/?output:1;cache:" + new Date().getTime() + ";";
  var params = "listingid:" + listingid + ";duration:" + duration;
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
      wait.style.display    = "none";
      button.style.display  = "block";
      edit.style.display    = "block";
	  $j('#adoptions :input').attr('disabled', false);
	} else {
	  ProcessUpdateTrialAd(rtext); 
	}
  }});
  
}

function ProcessUpdateTrialAd(rtext) {
  var rtext = rtext;
  alert( rtext );
}

function fetchadprices(adtype, bypasstrial){
  var bypasstrial    = bypasstrial;
  var adtype         = adtype;
  var url            = "/getadprice/actions/?output:1;adtype:" + adtype + ";bypasstrial:" + bypasstrial + ";cache:" + new Date().getTime();
  var wait           = document.getElementById('adoptions_wait');
  var target         = document.getElementById('adduration');
  var adprice        = document.getElementById('adprice');
  var adoptions      = document.getElementById('selectoptions');
  var adoptionswait  = document.getElementById('selectoptionswait'); 
  var adoptionsedit  = document.getElementById('selectoptionsedit');
  
  target.style.display         = "none";
  wait.style.display           = "block";
  adoptions.style.display      = "none";
  adoptionswait.style.display  = "none";
  adoptionsedit.style.display  = "none";
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText; 
		
    if ( rstatus < 200 || rstatus > 200 ) {
	  target.style.display = "block";
	  target.innerHTML     = rtext;
      wait.style.display   = "none";
    } else {
	  target.style.display = "block";
	  wait.style.display   = "none";
	  target.innerHTML     = rtext;
    }
  }});
}

function setppcheckout(adtype, bypasstrial){
  var adtype         = adtype;
  var bypasstrial    = bypasstrial;
  var duration       = document.getElementById('duration');
  var duration       = duration.options[duration.selectedIndex].value;
  var ppldesc        = document.getElementById('ppldescription');
  var pplamount      = document.getElementById('pplamount');
  var pplduration    = document.getElementById('pplduration');
  var url            = "/setpaypalvalues/actions/?output:1;cache:" + new Date().getTime() + ";";
  var url            = url + "adtype:" + adtype + ";duration:" + duration + ";bypasstrial:" + bypasstrial;
  var adoptions      = document.getElementById('selectoptions');
  var adoptionswait  = document.getElementById('selectoptionswait'); 
  var adoptionsedit  = document.getElementById('selectoptionsedit');
  
  adoptionswait.style.display = "block";
  
  if ( duration > "-" ) {
  
    adoptionsedit.style.display = "none";
  
  new Ajax.Request( url, { method: 'GET', onComplete: function ( transport ) {
    var rstatus  = transport.status;
    var rtext    = transport.responseText; 
		
    if ( rstatus < 200 || rstatus > 200 ) {
      TransportError( rstatus, url );
    } else {
	  ProcessSetPPCheckout(rtext );
    }
  }});
  
  } else {
    ppldesc.value      = "";
	pplamount.value    = "";
	pplduration.value  = "";
	adoptionswait.style.display = "none";
	adoptions.style.display     = "none";
	adoptionsedit.style.display = "block";
  }
}

function ProcessSetPPCheckout(rtext) {

  var rtext          = rtext;
  var json           = eval("(" + rtext + ")");
  var price          = json.price;
  var desc           = json.desc;
  var duration       = json.duration;
  var trial          = json.trialexpired;  
  var adtype         = json.adtype;
  
  var ppldesc        = document.getElementById('ppldescription');
  var pplamount      = document.getElementById('pplamount');
  var pplduration    = document.getElementById('pplduration');
  var ppladtype      = document.getElementById('ppladtype');
  var adoptions      = document.getElementById('selectoptions');
  var adoptionswait  = document.getElementById('selectoptionswait'); 
  
  ppldesc.value      = desc;
  pplduration.value  = duration;
  pplamount.value    = price;
  ppladtype.value    = adtype;
  adoptions.style.display     = "block";
  adoptionswait.style.display = "none";
  
}

function CreateNewAd(comppath, istrialexpired, tempid){

  var comppath       = comppath;
  var istrialexpired = istrialexpired;
  var ppldesc        = document.getElementById('ppldescription');
  var pplamount      = document.getElementById('pplamount');
  var pplduration    = document.getElementById('pplduration'); 
  var ppladtype      = document.getElementById('ppladtype');
  var adtype         = document.getElementById('featured');
  var tempid         = tempid;
  
  if ( adtype == "0" || istrialexpired == "0" ) {
    duration = document.getElementById('falseduration');
  } else {
    duration = document.getElementById('duration');
  }

  var eurl           = "/alert/alerts/?output:1;"
  var surl           = "/createnewad/checkout/?output:1";
  var wait           = document.getElementById('previewwait');
  var button         = document.getElementById('previewsave');
  var edit           = document.getElementById('previewedit');
  var form           = document.getElementById('optionsform');
  
  var params         = "tempid:" + tempid + ";rpath:" + comppath + ";ppldesc:" + ppldesc.value + ";pplamount:" + pplamount.value + ";pplduration:" + pplduration.value + ";adtype:" + ppladtype.value + ";";
  
  wait.style.display    = "block";
  button.style.display  = "none";
  edit.style.display    = "none";
  
  adtypechecked = $j("[name=featured]:checked").length > 0;
  
  if ( adtypechecked == false ) {
    var eurl = eurl + "responsetext:Please select an Advert Type;pagetitle:Submission Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    wait.style.display    = "none";
    button.style.display  = "block";
    edit.style.display    = "block";
	$j('#adoptions :input').attr('disabled', false);
  } else if ( duration.value == "" || duration.value == "-" ) {
    var eurl = eurl + "responsetext:Please select your Advert Duration;pagetitle:Submission Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    wait.style.display    = "none";
    button.style.display  = "block";
    edit.style.display    = "block";
	$j('#adoptions :input').attr('disabled', false);
  } else {
    
	
  new Ajax.Request( surl, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, surl );
      wait.style.display    = "none";
      button.style.display  = "block";
      edit.style.display    = "block";
	  $j('#adoptions :input').attr('disabled', false);
	} else {
	  ProcessCreateAd(rtext); 
	}
  }});
	
  }
  
}

function ProcessCreateAd(rtext) {
  rtext     = rtext;
  json      = eval("(" + rtext + ")");
  rcode     = json.rcode;
  rtext     = json.rtext;
  proceed   = json.proceed;
  endpoint  = json.endpoint;
  eurl      = "/alert/alerts/?responsetext:" + rtext + ";pagetitle:Submission Error";
  
  if ( rcode < 2 ) {
    OpenModalBox();
	FetchData( eurl, "modalbox", "GET" );
  } else {
    document.location.href = endpoint;
  }
}

function PayNow(listingid, customerid, advertid) {
  var listingid      = listingid;
  var customerid     = customerid;
  var advertid       = advertid;
  var ppldesc        = document.getElementById('ppldescription');
  var pplamount      = document.getElementById('pplamount');
  var pplduration    = document.getElementById('pplduration'); 
  var ppladtype      = document.getElementById('ppladtype');
  var adtype         = document.getElementById('featured');
  var duration       = document.getElementById('duration');
  var eurl           = "/alert/alerts/?output:1;"
  var surl           = "/buildcheckout/checkout/?output:1";
  var wait           = document.getElementById('previewwait');
  var button         = document.getElementById('previewsave');
  var edit           = document.getElementById('previewedit');
  var form           = document.getElementById('optionsform');
  var fromupgrade    = document.getElementById('fromupgrade').value;
  var tab            = document.getElementById('tab').value; 
  var params         = "tab:" + tab + ";fromupgrade:" + fromupgrade + ";advertid:" + advertid + ";customerid:" + customerid + ";listingid:" + listingid + ";ppldesc:" + ppldesc.value + ";pplamount:" + pplamount.value + ";pplduration:" + pplduration.value + ";adtype:" + ppladtype.value + ";";
  
  wait.style.display    = "block";
  button.style.display  = "none";
  edit.style.display    = "none";
  $j('#adoptions :input').attr('disabled', true);
  
  
  adtypechecked = $j("[name=featured]:checked").length > 0;
  
  if ( adtypechecked == false ) {
    var eurl = eurl + "responsetext:Please select an Advert Type;pagetitle:Submission Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    wait.style.display    = "none";
    button.style.display  = "block";
    edit.style.display    = "block";
	$j('#adoptions :input').attr('disabled', false);
  } else if ( duration.value == "" || duration.value == "-" ) {
    var eurl = eurl + "responsetext:Please select your Advert Duration;pagetitle:Submission Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
    wait.style.display    = "none";
    button.style.display  = "block";
    edit.style.display    = "block";
	$j('#adoptions :input').attr('disabled', false);
  } else {

  new Ajax.Request( surl, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, surl );
      wait.style.display    = "none";
      button.style.display  = "block";
      edit.style.display    = "block";
	  $j('#adoptions :input').attr('disabled', false);
	} else {
      ProcessPayNow(rtext);	  
	}
  }});
	
  }
}

function ProcessPayNow(rtext) {
  rtext        = rtext;
  json         = eval("(" + rtext + ")");
  endpoint     = json.endpoint;
  
  var wait     = document.getElementById('previewwait');
  var button   = document.getElementById('previewsave');
  var edit     = document.getElementById('previewedit');
  
  document.location.href = endpoint;
}

function PlaceTrialAd( listingid, userid, advertid, duration ) {
  
  var listingid  = listingid;
  var userid     = userid;
  var advertid   = advertid;
  var duration   = duration;
  var url        = "/updatetrialdate/checkout/?output:1;cache:" + new Date().getTime() + ";";
  var params     = "listingid:" + listingid + ";userid:" + userid + ";advertid:" + advertid + ";duration:" + duration;
  var wait       = document.getElementById('previewwait');
  var back       = document.getElementById('previewback');
  var place      = document.getElementById('previewplace');
  
  wait.style.display  = "block";
  back.style.display  = "none";
  place.style.display = "none";
  $j('#adoptions :input').attr('disabled', true);
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
      wait.style.display  = "none";
      back.style.display  = "block";
      place.style.display = "block";
	  $j('#adoptions :input').attr('disabled', false);
	} else {
      ProcessPlaceTrialAd( rtext );	  
	}
  }});
  
}

function ProcessPlaceTrialAd( rtext ) {

  var rtext = rtext;
  var json  = eval("(" + rtext + ")");
  var rcode = json.rcode;
  var rtext = json.rtext;
  var proceed = json.proceed;
  var listingid = json.listingid;
  var eurl      = "/alert/alerts/?output:1;"
  
  if ( rcode < 3 ) {
    eurl = eurl + ";responsetext:" + rtext + ";pagetitle:Submission Error";
    OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
  } else {
    document.location.href = "/dashboard/account/?advertsaved:1;listingid:" + listingid;
  }
  
}

/* alert services javascript */

function SelectAlertType(alerttype) {
  var alerttype     = alerttype;
  var mobile        = document.getElementById('mobile');
  var durationarea  = document.getElementById('durationarea');
  var selectmethod  = document.getElementById('selectmethod');
  var price1        = document.getElementById('price1');
  var price2        = document.getElementById('price2');
  var price3        = document.getElementById('price3');
  var price4        = document.getElementById('price4');
  var alertmethod   = document.getElementById('duration');
  
  durationarea.style.display = "block";
  selectmethod.value  = alerttype;
  alertmethod.checked = false;
  
  if ( alerttype == "1" ) {
    mobile.style.display = "none";
	price1.innerHTML = "";
	price2.innerHTML = "";
	price3.innerHTML = "";
	price4.innerHTML = "";
  } else {
    mobile.style.display = "block";
	price1.innerHTML = "<span class='plus_sign'></span><span class='alertlabel'>&pound;1.00 per Day</span>";
	price2.innerHTML = "<span class='plus_sign'></span><span class='alertlabel'>&pound;1.00 per Day</span>";
	price3.innerHTML = "<span class='plus_sign'></span><span class='alertlabel'>&pound;1.00 per Day</span>";
	price4.innerHTML = "<span class='plus_sign'></span><span class='alertlabel'>&pound;1.00 per Day</span>";
  }
}

function SelectAlertDuration(duration) {
	var duration         = duration;
	var selectduration   = document.getElementById('selectduration');
	selectduration.value = duration;
}

function SwitchAlertDisclaimer() {
	var option           = document.getElementById('selectmethod').value;
	var alertdisclaimer  = document.getElementById('alertdisclaimer');
	
	if ( option == "1" ) {
		alertdisclaimer.innerHTML = "<b>Note:</b> We will Alert you of Short Let Properties we already have on our site or which may become available on a weekly email basis.";
	} else {
		alertdisclaimer.innerHTML = "<b>Note:</b> We will Alert you of Short Let Properties we already have on our site or which may become available on a weekly email and daily text basis.";
	}

}

function UpdateAlertPricing() {
  var selectduration  = document.getElementById('selectduration').value;
  var selectmethod    = document.getElementById('selectmethod').value;
  var url             = "/getalertprice/actions/?output:1;";
  var params          = "selectduration:" + selectduration + ";selectmethod:" + selectmethod;
  var wait            = document.getElementById('alertwait');
  var alerttotalarea  = document.getElementById('alerttotalarea');
  var formwait        = document.getElementById('formwait');
  var button          = document.getElementById('processbutton');
  
  wait.style.display           = "block";
  alerttotalarea.style.display = "none";
  formwait.style.display       = "none";
  button.style.display         = "block";
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
	  wait.style.display = "none";
	} else {
     ProcessUpdateAlertPricing(rtext);  
	}
  }});
}

function ProcessUpdateAlertPricing(rtext) {
  var rtext           = rtext;
  var json            = eval("(" + rtext + ")");
  var newprice        = json.newprice;
  var showprice       = json.showprice;
  var selectdesc      = json.selectdesc;
  var totallabel      = document.getElementById('totallabel');
  var alerttotal      = document.getElementById('alerttotal');
  var alerttotalarea  = document.getElementById('alerttotalarea');
  var alertdesc       = document.getElementById('alertdesc');
  var wait            = document.getElementById('alertwait');
  var disctext        = document.getElementById('alertdisclaimer');
  
  if ( showprice == "1" ) {
    alerttotalarea.style.display = "block";
	wait.style.display = "none";
  } else {
	alerttotalarea.style.display = "none";
	wait.style.display = "none";
  }
  
  alerttotal.value      = newprice;
  //totallabel.innerHTML  = "Total:&nbsp;&nbsp;&pound;" + newprice + "<br/><span class='alert_smalltext'><b>YOUR SELECTION:</b><br/>" + selectdesc + "</span>"; 
  totallabel.innerHTML  = "<span class='alert_smalltext'><b>YOUR SELECTION:</b><br/>" + selectdesc + "</span>Total:&nbsp;&nbsp;&pound;" + newprice;
  alertdesc.value       = selectdesc;
}

function ProcessAlertPayment() {
  var formwait      = document.getElementById('formwait');
  var button        = document.getElementById('processbutton');
  var total         = document.getElementById('alerttotal').value;
  var requirement   = document.getElementById('requirement').value;
  var city          = document.getElementById('city').value;
  var email         = document.getElementById('email').value;
  var method        = document.getElementById('selectmethod').value;
  var duration      = document.getElementById('selectduration').value;
  var alerttotal    = document.getElementById('alerttotal').value;
  var desc          = document.getElementById('alertdesc').value;
  var countrycode   = document.getElementById('countrycode').value;
  var mobilenumber  = document.getElementById('mobilenumber').value;
  var eurl          = "/alert/alerts/?output:1;";
  var url           = "/newalertsubscription/actions/?output:1;";
  var params        = "req:" + requirement + ";city:" + city + ";email:" + email + ";method:" + method + ";duration:" + duration + ";total:" + total + ";desc:" + desc + ";countrycode:" + countrycode + ";mobilenumber:" + mobilenumber;
  
  button.style.display   = "none";
  formwait.style.display = "block";
  
  if ( requirement == "-" ) {
	  var eurl = eurl + "responsetext:Please select what you are looking for;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( city == "-" ) {
	  var eurl = eurl + "responsetext:Please select a City;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( email == "" ) {
	  var eurl = eurl + "responsetext:Please enter a valid Email Address;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( method == "" ) {
	  var eurl = eurl + "responsetext:Please select an Alert Method;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( method == "2" && countrycode == "" ) {
	  var eurl = eurl + "responsetext:Please enter your Mobile Phone Number's Country Code;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( method == "2" && mobilenumber == "" ) {
	  var eurl = eurl + "responsetext:Please enter a valid Mobile Phone Number;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( duration == "" ) {
	  var eurl = eurl + "responsetext:Please select an Alert Duration;pagetitle:Submission Error;";
	  button.style.display = "block";
	  formwait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else {
	  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
    button.style.display   = "block";
    formwait.style.display = "none";
	} else {
      BuildAlertsUrl(rtext);  
	}
  }}); 
	  
  }
}

function BuildAlertsUrl(rtext) {
  var rtext     = rtext;
  var json      = eval("(" + rtext + ")");
  var data      = json.data;
  var rcode     = json.rcode;
  var rtext     = json.rtext;
  var proceed   = json.proceed;
  var eurl      = "/alert/alerts/?output:1;";
  var formwait  = document.getElementById('formwait');
  var button    = document.getElementById('processbutton');
  
  if ( rcode < 8 ) {
    var eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
	formwait.style.display = "none";
	button.style.display   = "block";
  } else {
    document.location.href = "/alertserviceppl/checkout/?data:" + data;
  }
}

function paypalformsubmit(){
  var paypalform = document.getElementById('paypalform')
  paypalform.submit();
}

function UpdateSubscription() {
  var req     = document.getElementById('requirement');
  var city    = document.getElementById('city');
  var email   = document.getElementById('email');
  var ccode   = document.getElementById('countrycode');  
  var mobile  = document.getElementById('mobile');
  var subid   = document.getElementById('subid');
  var txid    = document.getElementById('txid');
  var method  = document.getElementById('method');
  var button  = document.getElementById('processbutton');
  var wait    = document.getElementById('formwait');
  var eurl    = "/alert/alerts/?output:1;";
  var url     = "/updatesubscription/actions/?output:1;";
  var params  = "req:" + req.value + ";city:" + city.value + ";ccode:" + ccode.value + ";email:" + email.value + ";mobile:" + mobile.value + ";subid:" + subid.value + ";txid:" + txid.value + ";method:" + method.value;
  
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  if ( req.value == "-" ) {
	  eurl = eurl + "responsetext:Please select what you are looking for.;pagetitle:Submission Error;";
	  button.style.display = "block";
	  wait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( city.value == "-" ) {
	  eurl = eurl + "responsetext:Please select a City.;pagetitle:Submission Error;";
	  button.style.display = "block";
	  wait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( email.value == "" ) {
	  eurl = eurl + "responsetext:Please enter a valid Email Address.;pagetitle:Submission Error;";
	  button.style.display = "block";
	  wait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( method.value == "2" && ccode.value == "" ) {
	  eurl = eurl + "responsetext:Please enter your Mobile Phone Country Code.;pagetitle:Submission Error;";
	  button.style.display = "block";
	  wait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else if ( method.value == "2" && mobile.value == "" ) {
	  eurl = eurl + "responsetext:Please enter your Mobile Phone Number.;pagetitle:Submission Error;";
	  button.style.display = "block";
	  wait.style.display = "none";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
  } else {
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
      button.style.display = "block";
      wait.style.display   = "none";
	} else {
      ProcessUpdateSubscription( rtext );	  
	}
  }});
  }
  
}

function ProcessUpdateSubscription(rtext) {
  var button   = document.getElementById('processbutton');
  var wait     = document.getElementById('formwait');
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rcode    = json.rcode;
  var rtext    = json.rtext;
  var proceed  = json.proceed;
  var subid    = json.subid;
  var txid     = json.txid;
  var data     = json.data;
  var eurl     = "/alert/alerts/?output:1;";
  
  if ( rcode < 7 ) {
	  button.style.display = "block";
	  wait.style.display   = "none";
	  eurl = eurl + "responsetext:" + rtext + ";pagetitle:Submission Error;";
	  OpenModalBox();
	  FetchPage( eurl, "modalbox", "GET" );
	  
  } else {
	  // everything is okay
	  document.location.href = "/updated/subscriptions/?data:" + data
  }
}


function CancelSubscription() {
  var button   = document.getElementById('formbutton');
  var wait     = document.getElementById('formwait');
  var subid    = document.getElementById('subid');
  var txid     = document.getElementById('txid');
  var email    = document.getElementById('email');
  var url      = "/cancelsubscription/actions/?output:1;";
  var params   = "subid:" + subid.value + ";txid:" + txid.value + ";email:" + email.value; 
  
  button.style.display = "none";
  wait.style.display   = "block";
  
  new Ajax.Request( url, { method: 'POST', parameters: params, asynchronous:true, onComplete: function ( transport ) {
    var rstatus = transport.status;
	var rtext   = transport.responseText;
	 
	if ( rstatus < 200 || rstatus > 200 ) {
	  TransportError( rstatus, url );
      button.style.display  = "block";
      wait.style.display    = "none";
	} else {
      ProcessCancelSubscription(rtext);
	}
  }}); 
  
  
}

function ProcessCancelSubscription(rtext) {
  var rtext    = rtext;
  var json     = eval("(" + rtext + ")");
  var rcode    = json.rcode;
  var rtext    = json.rtext;
  var proceed  = json.proceed;
  var subid    = json.subid;
  var txid     = json.txid;
  var data     = json.data;
  var eurl     = "/alert/alerts/?output:1;";
  
  if ( rcode < 2 ) {
	button.style.display = "block";
	wait.style.display   = "none";
	eurl = eurl + "responsetext:" + rtext + ";pagetitle:Cancellation Error;";
	OpenModalBox();
	FetchPage( eurl, "modalbox", "GET" );
  } else {
	document.location.href = "/cancelled/subscriptions/?data:" + data;
  }
}



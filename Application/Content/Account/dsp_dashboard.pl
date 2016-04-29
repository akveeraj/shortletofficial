<!--#include virtual="/includes.inc"-->
<!--#include virtual="/application/controls/ctrl_checksession_standalone.pl"-->


<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  o_Query          = fw_Query
  o_Query          = UrlDecode( o_Query )
  o_Page           = ParseCircuit( "page", o_Query )
  FromReg          = ParseCircuit( "fromregister", o_Query )
  AccExpired       = IsAccountExpired( Var_UserId, ConnTemp )
  Deleted          = ParseCircuit( "deleted", o_Query )
  TabSelect        = ParseCircuit( "tab", o_Query )
  PrimaryDays      = Var_TrialLength
  IsTrialExpired   = IsAccountExpired( Var_UserId, ConnTemp )
  
  AdvertSaved      = ParseCircuit( "advertsaved", o_Query )
  Saved            = ParseCircuit( "saved", o_Query )
  FromCreate       = ParseCircuit( "fromcreate", o_Query )
  ListingId        = ParseCircuit( "listingid", o_Query )
  AdvertId         = ParseCircuit( "advertid", o_Query )
  PaymentCancelled = ParseCircuit( "paymentcancelled", o_Query )
  PaymentSuccess   = ParseCircuit( "paymentsuccess", o_Query )
  AdvertUpdated    = ParseCircuit( "advertupdated", o_Query )
  PayError         = ParseCircuit( "payerror", o_Query )
  PayErrorText     = ParseCircuit( "errortext", O_Query )
  FromUpgrade      = ParseCircuit( "fromupgrade", o_Query )
  FromLive         = ParseCircuit( "fromlive", o_Query )
  FromSaved        = ParseCircuit( "fromsaved", o_Query )
  FromExpired      = ParseCircuit( "fromexpired", o_Query )
  FromDeleted      = ParseCircuit( "fromdeleted", o_Query )
  RTab             = ParseCircuit( "rtab", o_Query )
  
  If IsEmpty( o_Page ) Then
    o_Page    = 1
  Else
    o_Page    = o_Page
  End If
  
  If IsEmpty( TabSelect ) Then
    TabSelect = 1
  Else
    TabSelect = TabSelect
  End If
  
  CurrentPage = o_Page
  PageSize    = 10
	
  Limit1      = ( o_Page - 1 ) * PageSize
  Limit2      = PageSize
  
  If FromCreate > "" Then
    SavedText = "<b>Your ad is now live. View it  <a href='/details/doc/?listingid:" & ListingId & "' target='_blank'>here</a></b>"
  Else
    SavedText = "<b>Your ad is now live. View it <a href='/details/doc/?listingid:" & ListingId & "' target='_blank'>here</a></b>"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Expired advert count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ExpSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND NOT status='0' AND adexpires < CURRENT_TIMESTAMP() "
           Call FetchData( ExpSQL, ExpRs, ConnTemp )
		   
  ExpCount = ExpRs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Account Status
// ---------------------------------------------------------------------------------------------------------------------------------------------------


  AccSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM members WHERE customerid='" & Var_UserId & "'"
           Call FetchData( AccSQL, AccRs, ConnTemp )
		   
  AccCount = AccRs("NumberOfRecords")
  
  If AccCount > "0" Then
  
    AccSQL = "SELECT * FROM members WHERE customerid='" & Var_UserId & "'"
	         Call FetchData( AccSQL, AccRs, ConnTemp )
			 ExpiryDate    = AccRs("paiduntilnostamp")
			 ExpiryDate    = Replace( ExpiryDate, "/", "-" )
			 nExpiryDate   = AccRs("paiduntilnostamp")
			 SubDesc       = AccRs("subdescription")
			 SubDesc       = UrlDecode( SubDesc )
			 IsAdmin       = AccRs("administrator")
			 MemEmail      = AccRs("emailaddress")
			 
			 If nExpiryDate > "" Then
			 DaysRemaining  = TrialRemainingCount( Var_UserId, ConnTemp )
			 End If
			  
			 If ExpiryDate > "" Then ExpiryDate = FormatDateTime( ExpiryDate, 1 ) End If 
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  'If AccExpired = "1" AND IsAdmin = "0" Then
  '  AccStatus  = "<span style='display:block; color:red; font-size:14px;'><b>EXPIRED</b></span><a href='/updatesub/account/'>Renew Subscription</a>"
  'Else
  '  AccStatus  = "<span style='display:block; color:green; font-size:14px;'><b>ACTIVE</b></span>"
  'End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Select Tabs
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Select Case(TabSelect)
    
	Case(1)
	  TabCss1      = "taboff"
	  TabCss2      = "tabon"
	  TabCss3      = "tabon"
	  TabCss4      = "tabon"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() ORDER BY DATETIMESTAMP DESC LIMIT " & Limit1 & ", " & Limit2
	  StatusLabel  = "ACTIVE"
	  StatusClass  = "active"
    
	Case(2)
	  TabCss1      = "tabon"
	  TabCss2      = "taboff"
	  TabCss3      = "tabon"
	  TabCss4      = "tabon"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='0' "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='0' ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
      StatusLabel  = "DELETED"
      StatusClass  = "deleted"	  
   
   Case(3)
	  TabCss1      = "tabon"
	  TabCss2      = "tabon"
	  TabCss3      = "taboff"
	  TabCss4      = "tabon"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "'  AND NOT status='0' AND adexpires < CURRENT_TIMESTAMP() "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "'  AND NOT status='0' AND adexpires < CURRENT_TIMESTAMP() ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
      StatusLabel  = "EXPIRED" 
	  StatusClass  = "expired"
	
	Case(4)
	  TabCss1      = "tabon"
	  TabCss2      = "tabon"
	  TabCss3      = "tabon"
	  TabCss4      = "taboff"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND advertpaid='0' AND NOT status='0'"
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND advertpaid='0' AND NOT status='0' ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
      StatusLabel  = "UNPAID" 
	  StatusClass  = "expired"
	
	Case Else
	  TabCss1      = "taboff"
	  TabCss2      = "tabon"
	  TabCss3      = "tabon"
	  TabCss4      = "tabon"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() ORDER BY DATETIMESTAMP DESC LIMIT " & Limit1 & ", " & Limit2
	  StatusLabel  = "ACTIVE"
	  StatusClass  = "active"
	  
  End Select
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Tab Counts
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  Tab1SQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP()"
              Call FetchData( Tab1SQL, Tab1Rs, ConnTemp )
  Tab1Count = Tab1Rs("NumberOfRecords")
  
  Tab2SQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='0'"
              Call FetchData( Tab2SQL, Tab2Rs, ConnTemp )
  Tab2Count = Tab2Rs("NumberOfRecords")
  
  Tab3SQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND NOT status='0' AND adexpires < CURRENT_TIMESTAMP()"
              Call FetchData( Tab3SQL, Tab3Rs, ConnTemp )
  Tab3Count = Tab3Rs("NumberOfRecords")
  
  Tab4SQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND advertpaid='0' AND NOT status='0'"
              Call FetchData( Tab4SQL, Tab4Rs, ConnTemp )
  Tab4Count = Tab4Rs("NumberOfRecords")
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  ShortSQL  = TabCountSQL
              Call FetchData( ShortSQL, ShortRs, ConnTemp )
			 
  AdCount   = ShortRs("NumberOfRecords")
  PageCount = CountPages( CLng( AdCount ) / CLng( PageSize ))
  
  If AdCount > "0" Then
    ShortSQL = TabSQL
	           Call FetchData( ShortSQL, ShortRs, ConnTemp )
  End If 

// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Define Messages
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  If PaymentSuccess > "" Then
    StatusMessage = "<b>Your payment was successful and your advert is live.</b> View it  <a href='/details/doc/?listingid:" & ListingId & "' target='_blank'>here</a>"
	ShowMessage   = 1
  
  ElseIf PaymentCancelled > "" Then
    If FromUpgrade = "1" Then
      
	  StatusMessage = "<b>Your payment was cancelled.</b><br/>You can try your payment again by clicking the Feature Advert button next to your advert."
      ShowMessage   = 1
	
	Else
	
	  If RTab = "3" Then
	    StatusMessage = "<b>Your payment was cancelled.</b><br/>You can try your payment again by clicking on the Re-Post Advert button next to your advert."
		ShowMessage   = 1
	  ElseIf RTab = "4" Then
	    StatusMessage = "<b>Your payment was cancelled.</b><br/>Your advert has been <a href='/dashboard/account/?tab:4'>saved here</a>"
		ShowMessage   = 1
	  Else
        StatusMessage = "<b>Your payment was cancelled.</b>"
        ShowMessage   = 1
	  End If
	  
	End If
	
  ElseIf AdvertSaved > "" AND IsTrialExpired = "0" Then
    StatusMessage = "<b>Congratulations, your ad is now live</b> and your trial has begun. View your advert <a href='/details/doc/?listingid:" & ListingId & "'>here</a> "
    ShowMessage   = 1
  ElseIf AdvertSaved > "" AND IsTrialExpired = "1" Then
    StatusMessage = "<b>Congratulations, your ad is now live.</b> View it <a href='/details/doc/?listingid:" & ListingId & "'>here</a> "
    ShowMessage   = 1
  ElseIf AdvertUpdated > "" Then
    
	If FromLive = "1" Then
      StatusMessage = "<b>Your advert has been updated.</b><br/>View it <a href='/details/doc/?listingid:" & ListingId & "'>here</a>"
      ShowMessage   = 1
	ElseIf FromSaved = "1" Then
      StatusMessage = "<b>Your advert has been updated.</b><br/>This advert can be found in the <a href='/dashboard/account/?tab:4'>Saved Ads</a> tab"
      ShowMessage   = 1
    ElseIf FromExpired = "1" Then
      StatusMessage = "<b>Your advert has been updated.</b><br/>This advert can be found in the <a href='/dashboard/account/?tab:3'>Expired Ads</a> tab"
      ShowMessage   = 1
    ElseIf FromDeleted = "1" Then
      StatusMessage = "<b>Your advert has been updated.</b><br/>This advert can be found in the <a href='/dashboard/account/?tab:2'>Deleted Ads</a> tab"
      ShowMessage   = 1
    Else 
      StatusMessage = "<b>Your advert has been updated.</b> View it <a href='/details/doc/?listingid:" & ListingId & "'>here</a>"
      ShowMessage   = 1
    End If	
	
  ElseIf FromReg > "" Then
    StatusMessage = "<b>Thank you for registering</b><br/>Your account is now active. You can now start adding your first advert."
    ShowMessage   = 1
  
  ElseIf PayError > "" Then
    StatusMessage = "<b>Sorry, something went wrong</b><br/>" & PayErrorText
	ShowMessage   = 1
 
 Else
    StatusMessage = ""
	ShowMessage   = 0
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "My Adverts ~ Town and Gown Shortlets UK";
 <% If Deleted > "" Then %>
 OpenModalBox();
 FetchPage( '/notifynobutton/alerts/?output:1;responsetext:<b>The advert was deleted successfully</b>;pagetitle:Advert Deleted;', 'modalbox', 'GET' );
 setTimeout(function() { CloseModalBox(); }, 4000 ); 
 <% End If %> 
});
</script>

<div class='contentheader2' style='margin-bottom:20px;'>My Adverts</div>

<% If IsTrialExpired = "0" Then %>

<div class='dash_subscriptionholder' style='margin-top:10px;'>
  <span class='row'>
    <span class='cell' style='width:440px; line-height:1.3em;'><span class='statusmessage'><%=StatusMessage%></span></span>
	<span class='cell' style='float:right; width:130px; padding-left:15px; border-left:solid 2px #e2d4b2;'><span class='daysremaining'><%=DaysRemaining%><span style='font-weight:normal; font-size:9pt;'><br/>days remaining</span></span></span>
	<span class='cell' style='float:right; width:200px; padding-left:15px; border-left:solid 2px #e2d4b2;'><span class='bigtext'><b><%=Var_TrialLength%> Day Free Trial</b><br/><span style='font-size:9pt; font-weight:normal;'>Expires: <%=ExpiryDate%></span></span></span>
  </span>
</div>

<% End If %>

<% If IsTrialExpired = "1" AND ShowMessage = "1" Then %>

<div class='dash_subscriptionholder' style='margin-top:10px;'>
  <span class='row'>
    <span class='cell' style='width:750px;'><span class='statusmessage'><%=StatusMessage%></span></span>
  </span>
</div>
  
<% End If %>

<% If ExpCount > "0" Then %>
  <span class='createad_adexpired'><b>One or more of your adverts have expired</b><br/><a href='/dashboard/account/?tab:3'>Click here</a> to view your expired adverts.</span>
<% End If %>

<div class='dash_tabholder'>
  <span class='<%=TabCss1%>'><a href='/dashboard/account/?tab:1'>Active Ads (<%=Tab1Count%>)</a></span>
  <span class='<%=TabCss2%>'><a href='/dashboard/account/?tab:2'>Deleted Ads (<%=Tab2Count%>)</a></span>
  <span class='<%=TabCss3%>'><a href='/dashboard/account/?tab:3'>Expired Ads (<%=Tab3Count%>)</a></span>
  <span class='<%=TabCss4%>'><a href='/dashboard/account/?tab:4'>Saved Ads (<%=Tab4Count%>)</a></span>
  <% If AdCount > "0" Then %><span class='placeanad'><a href='/createadvert/account/'>+ Place an Ad</a></span><% End If %>
</div>

<div class='dash_adholder'>
  
<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  AdNumber = CInt(0)
  
  If AdCount > "0" Then
    Do While NOT ShortRs.Eof
      AdNumber = AdNumber + 1
	  NewAdNumber = AdNumber
	  
      ListingId      = ShortRs("listingid")
      AdvertId       = ShortRs("advertid")
      Photo          = ShortRs("photo")
      LenPhoto       = Len(Photo)
      IsVertical     = ShortRs("isvertical")
      AdTitle        = ShortRs("title")
      NextDay        = ShortRs("nextday")
      NextMonth      = ShortRs("nextmonth")
      NextYear       = ShortRs("nextyear")
      Rent           = ShortRs("rent")
      Period         = ShortRs("period")
      IncBills       = ShortRs("incbills")
      PostCode       = ShortRs("postcode")
      Location       = ShortRs("location")
      ProType        = ShortRs("propertytype")
      RoomAmount     = ShortRs("roomamount")
      Desc           = ShortRs("description")
	  References     = ShortRs("refs")
      ByEmail        = ShortRs("byemail")
      Email          = ShortRs("email")
      ByPhone        = ShortRs("byphone")
      Phone          = ShortRs("phone")
      Contact        = ShortRs("contactname")
      DateTimeStamp  = ShortRs("datetimestamp")
      DateStamp      = ShortRs("datestamp")
	  Data           = ShortRs("checkoutdata")
	  Featured       = ShortRs("featured")
	  
	  AdDescTrunc    = HexToString( Desc )
	  AdDescTrunc    = UrlDecode( AdDescTrunc )
	  
	  If Len( AdDescTrunc ) > 360 Then
	    AdDescTrunc  = Left( AdDescTrunc, 360 ) & "...<a href='javascript://' onclick=""ShowMore('" & AdNumber & "');"">Show More</a>"
	  Else
	  
	  End If
	  
	  If Featured = "1" Then
	    FeaturedLabel = "<span class='adfeaturedtext'>FEATURED AD</span>"
      Else
	    FeaturedLabel = ""
	  End If
	  

	  
	  AdDescFull    = HexToString( Desc )
	  AdDescFull    = Replace( AdDescFull, "%0A", "<br/>" )
	  AdRefsFull    = HexToString( References )
	  AdRefsFull    = Replace( AdRefsFull, "%0A", "<br/>" )
	  If References > "" Then
	  AdDescFull    = UrlDecode( AdDescFull ) & "<br/><br/><b>Feedback</b><br/><br/>" & UrlDecode( AdRefsFull ) & "...<br/><br/>" & "<a href='javascript://' onclick=""ShowLess('" & AdNumber & "');"">Show Less</a>"
	  Else
      AdDescFull    = UrlDecode( AdDescFull ) & "....<br/><br/><a href='javascript://' onclick=""ShowLess('" & AdNumber & "');"">Show Less</a>"
	  End If
	  
	  
	  If DateStamp > "" Then
	    DateStamp = DoFormatDate(DateStamp)
	  End If
	  
      Status         = ShortRs("status")
      IsFeatured     = ShortRs("featured")
	  ExpiryDate     = ShortRs("adexpires")
	  PageViews      = ShortRs("pageviews")
	  
	  If ExpiryDate > "" Then
	    ExpiryDate = DoFormatDate(ExpiryDate)
	  Else
	    ExpiryDate = "N/A"
	  End If
	  
	  'If Len( ExpiryDate > 8 ) Then  ExpiryDate = Left( ExpiryDate, 10 ) End If
	
				
	  If RoomAmount = "Studio" Then RoomLabel = "" Else RoomAmount = RoomAmount & " Rooms" End If 
	  If LenPhoto < 10 Then ShowThumb = 0 Else ShowThumb = 1 End If
	  If IsVertical = "1" Then ImageWidth = "80" Else ImageWidth = "150" End If
	  If Desc > "" Then Desc = HexToString( Desc ) End If
      '''If Desc > "" Then Desc = Replace( Desc, "%0A", "<br/>" )
	  If Desc > "" Then Desc = UrlDecode( Desc ) End If
      If AdTitle > "" Then AdTitle = HexTostring( AdTitle ) End If
	  If AdTitle > "" Then AdTitle = UrlDecode( AdTitle ) End If
	  
	  MainThumb  = GetMyAdvertImg( Photo, NewAdNumber, ShowThumb, "0" )
	  
	  If Period = "Weekly" Then
	    Periodlabel = "pw"
	  ElseIf FeatPeriod = "Monthly" Then
	    Periodlabel = "pm"
	  Else
	    Periodlabel = ""
	  End If
	  
	  If IncBills = "1" Then
	    BillLabel = "including bills"
	  Else
	    BillLabel = "excluding bills"
	  End If
	
    ListCSS =  "<style type='text/css'>" & vbcrlf & _
                          ".img_" & AdNumber & " img {" & vbcrlf & _
						  "display:block;" & vbcrlf & _
						  "margin-left:auto;" & vbcrlf & _
						  "margin-right:auto;" & vbcrlf & _
						  "width:" & ImageWidth & "px;" & vbcrlf & _
						  "z-index:800;"& vbcrlf & _
						  "}" & vbcrlf & _
						  "</style>"
						  
    Response.Write ListCss & vbcrlf & vbcrlf & vbcrlf 
	
	If TabSelect = "" Then
	  TabSelect = "1"
	Else
	  TabSelect = TabSelect
	End If

    DeleteReturnUrl       = "/dashboard/account/?deleted:1;tab:" & TabSelect & ";page:" & CurrentPage
    DeleteReturnUrl       = StringToHex( DeleteReturnUrl )
    DeleteActionUrl       = "DoDeleteAdvert('" & ListingId & "', '" & DeleteReturnUrl & "');"
    DeleteActionUrl       = StringToHex( DeleteActionUrl )
    DeletePromptText      = "<b>Are you sure you want to delete this advert?</b><br/><br/>This will take your advert offline and place it into the DELETED ADVERTS section."
    DeletePromptTitle     = "Delete Advert?"
	
	PermDeleteReturnUrl   = "/dashboard/account/?tab:" & TabSelect & ";page:" & CurrentPage
	PermDeleteReturnUrl   = StringToHex( PermDeleteReturnUrl )
	PermDeleteActionUrl   = "DoPermDeleteAdvert('" & ListingId & "', '" & PermDeleteReturnUrl & "');"
	PermDeleteActionUrl   = StringToHex( PermDeleteActionUrl )
	PermDeletePromptText  = "<b>Are you sure you want to PERMANENTLY delete this advert?</b><br/><br/>This action is irreversible. Click YES to proceed"
	PermDeletePromptTitle = "Permanently Delete Advert?"
	
	RestoreReturnUrl      = "/dashboard/account/?restored:1;tab:2;page:" & CurrentPage
	RestoreReturnUrl      = StringToHex( RestoreReturnUrl )
	RestoreActionUrl      = "DoRestoreAdvert('" & ListingId & "', '" & RestoreReturnUrl & "');"
	RestoreActionUrl      = StringToHex( RestoreActionUrl )
	RestorePromptText     = "<b>Are you sure you want to restore the selected advert?</b><br/><br/>Click YES to proceed"
	RestorePromptTitle    = "Restore this Advert?"
	
	UpdatePaymentUrl      = "/getdata/checkout/?withoptions:1;tab:" & TabSelect & ";listingid:" & Listingid & ";advertid:" & AdvertId
	RenewPaymentUrl       = "/getdata/checkout/?withoptions:1;tab:" & TabSelect & ";listingid:" & Listingid & ";advertid:" & AdvertId
	
	UpgradeAdvertUrl      = "/upgradeadvert/checkout/?data:" 
	UpgradeAdvertParams   = "tab:" & TabSelect & ";listingid:" & ListingId & ";advertid:" & AdvertId
	UpgradeAdvertParams   = StringToHex( UpgradeAdvertParams )
	UpgradeAdvertUrl      = UpgradeAdvertUrl & UpgradeAdvertParams
	
	RepostAdvertUrl       = "/getdata/checkout/?repost:1;withoptions:1;tab:" & TabSelect & ";listingid:" & ListingId & ";advertid:" & AdvertId
	
	
	Select Case( TabSelect )
	  Case(1)
	    AdvertMenu = "<span class='edit'><a href='/editadvert/account/?fromlive:1;listingid:" & ListingId & "'>Edit Advert</a></span>"
					 
	    If IsFeatured = "0" Then
		  AdvertMenu = AdvertMenu & "<span class='purchase'><a href='" & UpgradeAdvertUrl & "'>Feature Advert</a></span>"
		End If
		
		AdvertMenu   = AdvertMenu & "<span class='restore' style=''><a href='" & RepostAdvertUrl & "'>Repost Advert</a></span>"
		
		AdvertMenu = AdvertMenu & "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>"
		
	  
	  Case(2)
	    AdvertMenu = "<span class='edit'><a href='/editadvert/account/?fromdeleted:1;listingid:" & ListingId & "'>Edit Advert</a></span>" & _
		             "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & PermDeleteActionUrl & "', '" & PermDeletePromptText & "', '" & PermDeletePromptTitle & "', '2');"">Delete Advert</a></span>" & _
		             "<span class='restore'><a href='javascript://' onclick=""PromptDelete('" & RestoreActionUrl & "', '" & RestorePromptText & "', '" & RestorePromptTitle & "', '2');"">Restore Advert</a></span>"
	  Case(3)
	    AdvertMenu = "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>" & _
					 "<span class='purchase'><a href='" & RepostAdvertUrl & "'>Repost Advert</a></span>"
					 
	  Case(4)
	    AdvertMenu = "<span class='edit'><a href='/editadvert/account/?fromsaved:1;listingid:" & ListingId & "'>Edit Advert</a></span>" & _
					 "<span class='purchase'><a href='" & UpdatePaymentUrl & "'>Place your Ad</a></span>" & _
					 "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>"
	  Case Else
	    
		AdvertMenu = "<span class='edit'><a href='/editadvert/account/?fromlive:1;listingid:" & ListingId & "'>Edit Advert</a></span>"
					 
	    If IsFeatured = "0" Then
		  AdvertMenu = AdvertMenu & "<span class='purchase'><a href='" & UpgradeAdvertUrl & "'>Feature Advert</a></span>"
		End If
		
		AdvertMenu   = AdvertMenu & "<span class='restore' style=''><a href='" & RepostAdvertUrl & "'>Repost Advert</a></span>"
		
		AdvertMenu = AdvertMenu & "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>"
		
    End Select
	  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<script>
  function ShowMore(id){
    var id    = id;
	var short = document.getElementById('adtextshort_' + id);
	var long  = document.getElementById('adtextlong_' + id);
	short.style.display = "none";
	long.style.display  = "block";
	focusline = document.getElementById('adline_' + id );
	$j( focusline ).focus();
  }
  
  function ShowLess(id) {
    var id    = id;
	var short = document.getElementById('adtextshort_' + id);
	var long  = document.getElementById('adtextlong_' + id);
	short.style.display = "block";
	long.style.display  = "none";
	focusline = document.getElementById('adline_' + id );
	$j( focusline ).focus();
  }

</script>

<div class='row' id='adline_<%=AdNumber%>'>
  <span class='cell' style='width:165px; text-align:center;'>
    <span class='img'><%=MainThumb%></span><%=FeaturedLabel%>
  
  </span>
  
  
  <span class='cell' style='width:500px;'>
    <span class='adtitle'><b><%=AdTitle%></b><br/><span style='display:block; margin-top:8px; float:left;'><%=Location%> - <b>&pound;<%=Rent & Periodlabel%></b></span></span>
	<span class='adtext' id='adtextshort_<%=AdNumber%>'><%=AdDescTrunc%></span>
	<span class='adtext' id='adtextlong_<%=AdNumber%>' style='display:none;'><%=AdDescFull%></span>
	
  
  </span>
  
  
  
  
  <span class='cell' style='width:183px; float:right; margin-right:10px;'>
    <%=AdvertMenu%>
  </span>

</div>

<div class='statusrow'>
  <span class='cell' style='width:100px;'><span class='<%=StatusClass%>'><%=StatusLabel%></span></span>
  <% If TabSelect <> 4 OR TabSelect <> 2 Then %>
  <span class='cell' style='width:180px;'><b>Last Posted:</b> <%=DateStamp%></span>
  <span class='cell' style='width:140px;'><b>Expires:</b> <span style='color:#cc0000;'><%=ExpiryDate%></span></span>
  <% End If %>
  <span class='cell' style='width:155px;'><b>Ad ID: </b><%=AdvertID%></span>
  <%'<span class='cell' style='padding-right:10px;'><b>Page Views: </b>PageViews</span>%>
</div>

<% 
// ---------------------------------------------------------------------------------------------------------------------------------------------------

    ShortRs.MoveNext
    Loop
		
  Else
    Response.Write "<span class='norecord'>" & _
	               "<b>-- There are no adverts to display --</b><br/>"  & _
	               "<span class='placead'><a href='/createadvert/account/'>+ Place an Ad</a></span>" & _ 
	               "</span>"
  End If

// ---------------------------------------------------------------------------------------------------------------------------------------------------

  PageNumber = 0

  For Ni = 1 to PageCount
    PageNumber = PageNumber + 1
	PageUrl    = "/dashboard/account/?page:" & Ni & ";tab:" & TabSelect
	
	If Ni < CInt( CurrentPage ) Then
	  PageLinks = PageLinks & "<span class='pagingon'><a href='" & PageUrl & "' title='Go to page " & Ni & "'>" & Ni & "</a></span>"
    ElseIf Ni > CInt( CurrentPage ) Then
	  PageLinks = PageLinks & "<span class='pagingon' title='Go to page " & Ni & "'><a href='" & PageUrl & "'>" & Ni & "</a></span>"
	Else
	  PageLinks = PageLinks & "<span class='pagingoff'>" & Ni & "</span>"
	End If
	 
  Next
  
  PageLinks = PageLinks
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
</div>


<% If PageCount > "1" Then %>

<div class='list_pagingholder'>
<%=PageLinks%>
</div>

<% End If %>
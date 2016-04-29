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
  
  If IsEmpty( o_Page ) Then
    o_Page    = 1
  Else
    o_Page    = o_Page
  End If
  
  CurrentPage = o_Page
  PageSize    = 50
	
  Limit1      = ( o_Page - 1 ) * PageSize
  Limit2      = PageSize
  
  If FromCreate > "" Then
    SavedText = "<b>Your ad is now live. View it  <a href='/details/doc/?listingid:" & ListingId & "' target='_blank'>here</a></b>"
  Else
    SavedText = "<b>Your advert has been saved. You can view it <a href='/details/doc/?listingid:" & ListingId & "' target='_blank'>here</a></b>"
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
// ' Get Expired advert count
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  ExpSQL = "SELECT COUNT(uIndex) As NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND adexpires < CURRENT_TIMESTAMP() "
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
			 
			 If nExpiryDate > "" Then
			 DaysRemaining = CalcDaysPassed( nExpiryDate )
			 DaysRemaining = Replace( DaysRemaining, "-", "" )
			 DaysRemaining = CInt( DaysRemaining )
			 End If
			  
			 If ExpiryDate > "" Then ExpiryDate = FormatDateTime( ExpiryDate, 1 ) End If 
			 
			 If IsAdmin = "1" Then
			   ExpiryDate = "Never"
			 End If
  
  End If
  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
  
  If AccExpired = "1" AND IsAdmin = "0" Then
    AccStatus  = "<span style='display:block; color:red; font-size:14px;'><b>EXPIRED</b></span><a href='/updatesub/account/'>Renew Subscription</a>"
  Else
    AccStatus  = "<span style='display:block; color:green; font-size:14px;'><b>ACTIVE</b></span>"
  End If
  
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
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() ORDER BY DATETIMESTAMP DESC "
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
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND adexpires < CURRENT_TIMESTAMP() "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND adexpires < CURRENT_TIMESTAMP() ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
      StatusLabel  = "EXPIRED" 
	  StatusClass  = "expired"
	
	Case(4)
	  TabCss1      = "tabon"
	  TabCss2      = "tabon"
	  TabCss3      = "tabon"
	  TabCss4      = "taboff"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND advertpaid='0' "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND advertpaid='0' ORDER BY datetimestamp DESC LIMIT " & Limit1 & ", " & Limit2
      StatusLabel  = "UNPAID" 
	  StatusClass  = "expired"
	
	Case Else
	  TabCss1      = "taboff"
	  TabCss2      = "tabon"
	  TabCss3      = "tabon"
	  TabCss4      = "tabon"
	  TabCountSQL  = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() "
	  TabSQL       = "SELECT * FROM shortlets WHERE customerid='" & Var_UserId & "' AND status='1' AND adexpires > CURRENT_TIMESTAMP() ORDER BY DATETIMESTAMP DESC "
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
  
  Tab3SQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND adexpires < CURRENT_TIMESTAMP()"
              Call FetchData( Tab3SQL, Tab3Rs, ConnTemp )
  Tab3Count = Tab3Rs("NumberOfRecords")
  
  Tab4SQL   = "SELECT COUNT(uIndex) AS NumberOfRecords FROM shortlets WHERE customerid='" & Var_UserId & "' AND advertpaid='0'"
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
%>

<script type='text/javascript'>
document.observe("dom:loaded", function() {
 document.title = "My Adverts ~ Town and Gown Shortlets. Oxford";
 <% If Deleted > "" Then %>
 OpenModalBox();
 FetchPage( '/notifynobutton/alerts/?output:1;responsetext:<b>The advert was deleted successfully</b>;pagetitle:Advert Deleted;', 'modalbox', 'GET' );
 setTimeout(function() { CloseModalBox(); }, 4000 ); 
 <% End If %> 
});
</script>

<% If FromReg = "1" Then %>
<div class='createad_justregistered'>
  <span class='bigtext'><b>Registration Complete</b><br/></span>
  Thank you for registering, your account is now active and you can start adding your first advert.
  <br/>A confirmation email has been sent to <b><%=AccEmail%></b> containing
   your log in details.
</div>
<% End If %>

<div class='contentheader2' style='margin-bottom:20px;'>My Adverts</div>

<% If IsTrialExpired = "0" Then %>

<div class='dash_subscriptionholder' style='margin-top:10px;'>
  <span class='row'>
    <span class='cell'><span class='bigtext'><b>1 Month Trial</b></span><br/>Expires: <%=ExpiryDate%></span>
	<span class='cell' style='padding-left:10px; width:180px; margin-left:20px; text-align:center; border-left:solid 2px #e2d4b2;'><span class='daysremaining' style='font-size:16px;'><%=DaysRemaining%></span><span class='smalltext'>days remaining</span></span>
  </span>
</div>

<% End If %>

<% If ExpCount > "0" Then %>
  <span class='createad_adexpired'><b>One or more of your adverts have expired</b><br/><a href='/dashboard/account/?tab:3'>Click here</a> to view your expired adverts.</span>
<% End If %>

<% If PaymentSuccess = "1" Then %>
  <span class='createad_justregistered'><b>Your payment was successful and your advert is live.</b> View it  <a href='/details/doc/?listingid:<%=ListingId%>' target='_blank'>here</a></span>
<% End If %>

<% If PaymentCancelled = "1" Then %>
  <span class='createad_justregistered'><b>Your payment was cancelled.</b><br/>Try your payment again by <a href='/makepayment/account/?listingid:<%=ListingId%>;advertid:<%=AdvertId%>'>clicking here</a></span>
<% End If %>

<% If AdvertSaved = "1" OR Saved = "1" Then %>

  <span class='createad_justregistered'><%=SavedText%><br/>You can edit it by clicking on the EDIT ADVERT button next to the advert.</span>

<% End If %>

<div class='dash_tabholder'>
  <span class='<%=TabCss1%>'><a href='/dashboard/account/?tab:1'>Active Ads (<%=Tab1Count%>)</a></span>
  <span class='<%=TabCss2%>'><a href='/dashboard/account/?tab:2'>Deleted Ads (<%=Tab2Count%>)</a></span>
  <span class='<%=TabCss3%>'><a href='/dashboard/account/?tab:3'>Expired Ads (<%=Tab3Count%>)</a></span>
  <span class='<%=TabCss4%>'><a href='/dashboard/account/?tab:4'>Unpaid Ads (<%=Tab4Count%>)</a></span>
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
      ByEmail        = ShortRs("byemail")
      Email          = ShortRs("email")
      ByPhone        = ShortRs("byphone")
      Phone          = ShortRs("phone")
      Contact        = ShortRs("contactname")
      DateTimeStamp  = ShortRs("datetimestamp")
      DateStamp      = ShortRs("datestamp")
	  
	  If DateStamp > "" Then
	    DateStamp = DoFormatDate(DateStamp)
	  End If
	  
      Status         = ShortRs("status")
      IsFeatured     = ShortRs("featured")
	  ExpiryDate     = ShortRs("adexpires")
	  PageViews      = ShortRs("pageviews")
	  
	  If ExpiryDate > "" Then
	    ExpiryDate = DoFormatDate(ExpiryDate)
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
	  
	  MainThumb  = GetMyAdvertImg( Photo, NewAdNumber, ShowThumb, IsFeatured )
	  
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

    DeleteReturnUrl       = "/dashboard/account/?deleted:1;tab:1;page:" & CurrentPage
    DeleteReturnUrl       = StringToHex( DeleteReturnUrl )
    DeleteActionUrl       = "DoDeleteAdvert('" & ListingId & "', '" & DeleteReturnUrl & "');"
    DeleteActionUrl       = StringToHex( DeleteActionUrl )
    DeletePromptText      = "<b>Are you sure you want to delete this advert?</b><br/><br/>This will take your advert offline and place it into the DELETED ADVERTS section."
    DeletePromptTitle     = "Delete Advert?"
	
	PermDeleteReturnUrl   = "/dashboard/account/?tab:1;page:" & CurrentPage
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
	
	UpdatePaymentUrl      = "/makepayment/account/?listingid:" & Listingid & ";advertid:" & AdvertId
	
	Select Case( TabSelect )
	  Case(1)
	    AdvertMenu = "<span class='edit'><a href='/editadvert/account/?listingid:" & ListingId & "'>Edit Advert</a></span>" & _
		             "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>"
	  Case(2)
	    AdvertMenu = "<span class='edit'><a href='/editadvert/account/?listingid:" & ListingId & "'>Edit Advert</a></span>" & _
		             "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & PermDeleteActionUrl & "', '" & PermDeletePromptText & "', '" & PermDeletePromptTitle & "', '2');"">Delete Advert</a></span>" & _
		             "<span class='restore'><a href='javascript://' onclick=""PromptDelete('" & RestoreActionUrl & "', '" & RestorePromptText & "', '" & RestorePromptTitle & "', '2');"">Restore Advert</a></span>"
	  Case(3)
	    AdvertMenu = "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>" & _
					 "<span class='purchase'><a href='" & UpdatePaymentUrl & "'>Pay for your advert</a></span>"
					 
	  Case(4)
	    AdvertMenu = "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>" & _
					 "<span class='purchase'><a href='" & UpdatePaymentUrl & "'>Make Payment</a></span>"
	  Case Else
	    AdvertMenu = "<span class='edit'><a href='/editadvert/account/?listingid:" & ListingId & "'>Edit Advert</a></span>" & _
		             "<span class='delete'><a href='javascript://' onclick=""PromptDelete('" & DeleteActionUrl & "', '" & DeletePromptText & "', '" & DeletePromptTitle & "', '2');"">Delete Advert</a></span>"
    End Select
	  
// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>

<div class='row' id='adline_<%=AdNumber%>'>
  <span class='cell' style='width:165px; text-align:center;'>
    <span class='img'><%=MainThumb%></span>
  
  </span>
  
  
  <span class='cell' style='width:400px;'>
    <span class='adtitle'><b><%=AdTitle%></b><br/><br/><%=Location%><br/><b>&pound;<%=Rent & Periodlabel%></b></span>
	
  
  </span>
  
  
  
  
  <span class='cell' style='width:183px;'>
    <%=AdvertMenu%>
  </span>

</div>

<div class='statusrow'>
  <span class='cell' style='width:100px;'><span class='<%=StatusClass%>'><%=StatusLabel%></span></span>
  <span class='cell' style='width:180px;'><b>Last Posted:</b> <%=DateStamp%></span>
  <span class='cell' style='width:140px;'><b>Expires:</b> <%=ExpiryDate%></span>
  <span class='cell' style='width:140px;'><b>Ad ID: </b><%=AdvertID%></span>
  <span class='cell' style='width:100px; border-right:0px;'><b>Views: </b><%=PageViews%></span>
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
%>
  
  
  
  
  
  
  
</div>
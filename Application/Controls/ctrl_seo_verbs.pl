<%
// ---------------------------------------------------------------------------------------------------------------------------------------------------

  SeoPage = fw_Source
  City    = ParseCircuit( "city", o_Query )
  
  Select Case( SeoPage )
    Case "accountdeleted"
	  SEOPageTitle   = "Account Closed | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = ""
	Case "adcost"
	  SEOPageTitle   = "Ad Cost | Town and Gown Shortlets UK"
	  SEOIndex       = "index, follow"
	  SEODescription = "Advertise your Short Let for as little as £7.50 per week."
	Case "contact"
	  SEOPageTitle   = "Contact Us | Town and Gown Shortlets UK"
	  SEOIndex       = "index, follow"
	  SEODescription = "Contact Town and Gown Shortlets UK. Short Term accommodation in the UK"
	Case "cookies"
	  SEOPageTitle   = "Cookie Policy | Town and Gown Shortlets UK"
	  SEOIndex       = "index, follow"
	  SEODescription = "We use cookies to ensure that we give you the best experience on our website."
	Case "details"
	  SEOPageTitle   = "Advert Details | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = ""
	Case "emailadvertiser"
	  SEOPageTitle   = "Email Advertiser | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = ""
	Case "freetrial"
	  SEOPageTitle   = Var_TrialLength & " Day Free Trial | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = "Create an Account to advertise your Short Let Property"
	Case "index"
	  SEOPageTitle   = "UK Short Let Accommodation | Town and Gown Shortlets"
	  SEOIndex       = "index, follow"
	  SEODescription = "Town and Gown Shortlets UK is a new `Bespoke` introductory platform for anyone seeking short let accommodation in the UK. Deal with Property owners directly." 
	Case "login"
	  SEOPageTitle   = "Place or Manage your Ads | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = "" 
	Case "passreset"
	  SEOPageTitle   = "Reset your Password | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = "" 
	Case "regcomplete"
	  SEOPageTitle   = "Confirm Registration | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = "" 
	Case "register"
	  SEOPageTitle   = "Create an Account | Town and Gown Shortlets UK"
	  SEOIndex       = "index, follow"
	  SEODescription = "To place your Short Let Advert, you will need to create an account." 
	Case "reportad"
	  SEOPageTitle   = "Report this Advert | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = ""
	Case "shortlets"
	  SEOPageTitle   = "Oxford Shortlets | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow"
	  SEODescription = ""
	Case "terms"
	  SEOPageTitle   = "Terms and Conditions | Town and Gown Shortlets UK"
	  SEOIndex       = "index, follow"
	  SEODescription = "View our website Terms and Conditions"
	Case "ukshortlets"
	  SEOPageTitle   = City & " Shortlets | Short Term Lets and Accommodation in " & City & " | Town and Gown Shortlets UK"
	  SEOIndex       = "noindex, nofollow" 
	  SEODescription = "View our list of Short Lets in " & City 

Case "Aberdeen", "aberdeen", "ABERDEEN" 
	  SEOPageTitle = "Aberdeen Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Aberdeen"

	Case "Abingdon", "abingdon", "ABINGDON" 
	  SEOPageTitle = "Abingdon Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Abingdon"

	Case "Bath", "bath", "BATH" 
	  SEOPageTitle = "Bath Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Bath"

	Case "Belfast", "belfast", "BELFAST" 
	  SEOPageTitle = "Belfast Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Belfast"

	Case "Birmingham", "birmingham", "BIRMINGHAM" 
	  SEOPageTitle = "Birmingham Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Birmingham"

	Case "Bournemouth", "bournemouth", "BOURNEMOUTH" 
	  SEOPageTitle = "Bournemouth Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Bournemouth"

	Case "Bradford", "bradford", "BRADFORD" 
	  SEOPageTitle = "Bradford Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Bradford"

	Case "Brighton", "brighton", "BRIGHTON" 
	  SEOPageTitle = "Brighton Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Brighton"

	Case "Bristol", "bristol", "BRISTOL" 
	  SEOPageTitle = "Bristol Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Bristol"

	Case "Cambridge", "cambridge", "CAMBRIDGE" 
	  SEOPageTitle = "Cambridge Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Cambridge"

	Case "Canterbury", "canterbury", "CANTERBURY" 
	  SEOPageTitle = "Canterbury Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Canterbury"

	Case "Cardiff", "cardiff", "CARDIFF" 
	  SEOPageTitle = "Cardiff Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Cardiff"

	Case "Carlisle", "carlisle", "CARLISLE" 
	  SEOPageTitle = "Carlisle Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Carlisle"

	Case "Chester", "chester", "CHESTER" 
	  SEOPageTitle = "Chester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Chester"

	Case "Cheltenham", "cheltenham", "CHELTENHAM" 
	  SEOPageTitle = "Cheltenham Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Cheltenham"

	Case "Chichester", "chichester", "CHICHESTER" 
	  SEOPageTitle = "Chichester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Chichester"

	Case "Coventry", "coventry", "COVENTRY" 
	  SEOPageTitle = "Coventry Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Coventry"

	Case "Derby", "derby", "DERBY" 
	  SEOPageTitle = "Derby Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Derby"

	Case "Dundee", "dundee", "DUNDEE" 
	  SEOPageTitle = "Dundee Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Dundee"

	Case "Durham", "durham", "DURHAM" 
	  SEOPageTitle = "Durham Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Durham"

	Case "Edinburgh", "edinburgh", "EDINBURGH" 
	  SEOPageTitle = "Edinburgh Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Edinburgh"

	Case "Exeter", "exeter", "EXETER" 
	  SEOPageTitle = "Exeter Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Exeter"

	Case "Glasgow", "glasgow", "GLASGOW" 
	  SEOPageTitle = "Glasgow Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Glasgow"

	Case "Gloucester", "gloucester", "GLOUCESTER" 
	  SEOPageTitle = "Gloucester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Gloucester"

	Case "Hereford", "hereford", "HEREFORD" 
	  SEOPageTitle = "Hereford Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Hereford"

	Case "Inverness", "inverness", "INVERNESS" 
	  SEOPageTitle = "Inverness Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Inverness"

	Case "Kingston", "kingston", "KINGSTON" 
	  SEOPageTitle = "Kingston Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Kingston"

	Case "Lancaster", "lancaster", "LANCASTER" 
	  SEOPageTitle = "Lancaster Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Lancaster"

	Case "Leeds", "leeds", "LEEDS" 
	  SEOPageTitle = "Leeds Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Leeds"

	Case "Leicester", "leicester", "LEICESTER" 
	  SEOPageTitle = "Leicester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Leicester"

	Case "Lincoln", "lincoln", "LINCOLN" 
	  SEOPageTitle = "Lincoln Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Lincoln"

	Case "Liverpool", "liverpool", "LIVERPOOL" 
	  SEOPageTitle = "Liverpool Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Liverpool"

	Case "London", "london", "LONDON" 
	  SEOPageTitle = "London Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in London"

	Case "Luton", "luton", "LUTON" 
	  SEOPageTitle = "Luton Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Luton"

	Case "Manchester", "manchester", "MANCHESTER" 
	  SEOPageTitle = "Manchester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Manchester"

	Case "Newcastle", "newcastle", "NEWCASTLE" 
	  SEOPageTitle = "Newcastle Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Newcastle"

	Case "Newport", "newport", "NEWPORT" 
	  SEOPageTitle = "Newport Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Newport"

	Case "Northampton", "northampton", "NORTHAMPTON" 
	  SEOPageTitle = "Northampton Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Northampton"

	Case "Norwich", "norwich", "NORWICH" 
	  SEOPageTitle = "Norwich Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Norwich"

	Case "Nottingham", "nottingham", "NOTTINGHAM" 
	  SEOPageTitle = "Nottingham Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Nottingham"

	Case "Oxford", "oxford", "OXFORD" 
	  SEOPageTitle = "Oxford Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Oxford"

	Case "Peterborough", "peterborough", "PETERBOROUGH" 
	  SEOPageTitle = "Peterborough Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Peterborough"

	Case "Plymouth", "plymouth", "PLYMOUTH" 
	  SEOPageTitle = "Plymouth Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Plymouth"

	Case "Poole", "poole", "POOLE" 
	  SEOPageTitle = "Poole Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Poole"

	Case "Portsmouth", "portsmouth", "PORTSMOUTH" 
	  SEOPageTitle = "Portsmouth Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Portsmouth"

	Case "Preston", "preston", "PRESTON" 
	  SEOPageTitle = "Preston Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Preston"

	Case "Reading", "reading", "READING" 
	  SEOPageTitle = "Reading Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Reading"

	Case "Rugby", "rugby", "RUGBY" 
	  SEOPageTitle = "Rugby Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Rugby"

	Case "Salisbury", "salisbury", "SALISBURY" 
	  SEOPageTitle = "Salisbury Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Salisbury"

	Case "Sheffield", "sheffield", "SHEFFIELD" 
	  SEOPageTitle = "Sheffield Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Sheffield"

	Case "Southampton", "southampton", "SOUTHAMPTON" 
	  SEOPageTitle = "Southampton Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Southampton"

	Case "St_Albans", "st_albans", "ST_ALBANS" 
	  SEOPageTitle = "St Albans Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in St Albans"

	Case "St_Andrews", "st_andrews", "ST_ANDREWS" 
	  SEOPageTitle = "St. Andrews Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in St. Andrews"

	Case "Stirling", "stirling", "STIRLING" 
	  SEOPageTitle = "Stirling Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Stirling"

	Case "Stoke-on-Trent", "stoke-on-trent", "STOKE-ON-TRENT" 
	  SEOPageTitle = "Stoke-on-Trent Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Stoke-on-Trent"

	Case "Sunderland", "sunderland", "SUNDERLAND" 
	  SEOPageTitle = "Sunderland Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Sunderland"

	Case "Swansea", "swansea", "SWANSEA" 
	  SEOPageTitle = "Swansea Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Swansea"

	Case "Truro", "truro", "TRURO" 
	  SEOPageTitle = "Truro Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Truro"

	Case "Winchester", "winchester", "WINCHESTER" 
	  SEOPageTitle = "Winchester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Winchester"

	Case "Windermere", "windermere", "WINDERMERE" 
	  SEOPageTitle = "Windermere Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Windermere"

	Case "Wolverhampton", "wolverhampton", "WOLVERHAMPTON" 
	  SEOPageTitle = "Wolverhampton Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Wolverhampton"

	Case "Worcester", "worcester", "WORCESTER" 
	  SEOPageTitle = "Worcester Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in Worcester"

	Case "York", "york", "YORK" 
	  SEOPageTitle = "York Short Lets | Town and Gown Shortlets UK"
	  SEOIndex="index, follow"
      SEODescription="View our list of Short Let properties in York"




	Case Else
	  SEOPageTitle   = "UK Short Let Accommodation | Town and Gown Shortlets"
	  SEOIndex       = "index, follow"
	  SEODescription = "Town and Gown Shortlets UK is a new `Bespoke` introductory platform for anyone seeking short let accommodation in the UK. Deal with Property owners directly." 
  End Select

// ---------------------------------------------------------------------------------------------------------------------------------------------------
%>
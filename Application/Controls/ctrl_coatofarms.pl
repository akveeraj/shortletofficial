<%
// -----------------------------------------------------------------------------------------------------------------------
// ' Build Coat of Arms List
// -----------------------------------------------------------------------------------------------------------------------
  
  o_Query  = fw_Query
  Location = ParseCircuit( "city", o_Query )
  Location = UrlDecode( Location )

  Select Case(Location)
 
 Case("Aberdeen")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/aberdeen_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/aberdeen_shield2.png'/></span>"
    ShowShield = 1
  Case("Abingdon")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/abingdon_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Bath")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/bath_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Belfast")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/belfast_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Birmingham")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/birmingham_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/birmingham_shield2.png'/></span>"
    ShowShield = 1
  Case("Bournemouth")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/bornemouth_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Bradford")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/bradford_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Brighton")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/brighton_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Bristol")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/bristol_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Cambridge")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/cambridge_shield2.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/cambridge_shield1.png'/></span>"
    ShowShield = 1
  Case("Canterbury")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/canterbury_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Cardiff")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/cardiff_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Carlisle")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/carlisle_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Chester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/chester_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Cheltenham")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/cheltenham_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Chichester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/chichester_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Coventry")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/coventry_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Derby")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/derby_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Dundee")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/dundee_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Durham")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/durham_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Edinburgh")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/edinburgh_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/edinburgh_shield2.png'/></span>"
    ShowShield = 1
  Case("Exeter")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/exeter_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Glasgow")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/glasgow_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Gloucester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/gloucester_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Hereford")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/hereford_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Inverness")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/inverness_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Kingston")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/kingston_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Lancaster")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/lancaster_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Leeds")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/leeds_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Leicester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/leicester_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Lincoln")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/lincoln_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Liverpool")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/liverpool_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("London")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/london_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Luton")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/luton_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Manchester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/manchester_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/manchester_shield2.png'/></span>"
    ShowShield = 1
  Case("Newcastle")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/newcastle_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/newcastle_shield2.png'/></span>"
    ShowShield = 1
  Case("Newport")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/newport_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Northampton")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/northampton_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Norwich")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/norwich_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Nottingham")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/nottingham_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/nottingham_shield2.png'/></span>"
    ShowShield = 1
  Case("Oxford")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/oxford_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/oxford_shield2.png'/></span>"
    ShowShield = 1
  Case("Peterborough")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/peterborough_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Plymouth")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/plymouth_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/plymouth_shield2.png'/></span>"
    ShowShield = 1
  Case("Poole")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/poole_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Portsmouth")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/portsmouth_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Preston")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/preston_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Reading")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/reading_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Rugby")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/rugby_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Salisbury")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/salisbury_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Sheffield")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/sheffield_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Southampton")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/southampton_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/southampton_shield2.png'/></span>"
    ShowShield = 1
  Case("St Albans")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/stalbans_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("St. Andrews")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/standrews_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/standrews_shield2.png'/></span>"
    ShowShield = 1
  Case("Stirling")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/stirling_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/stirling_shield2.png'/></span>"
    ShowShield = 1
  Case("Stoke-on-Trent")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/stoke_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Sunderland")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/sunderland_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Swansea")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/swansea_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/swansea_shield2.png'/></span>"
    ShowShield = 1
  Case("Truro")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/truro_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Winchester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/winchester_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/winchester_shield2.png'/></span>"
    ShowShield = 1
  Case("Windermere")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/windermere_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Wolverhampton")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/wolverhampton_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("Worcester")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/worcester_shield1.png'/></span>"
    Shield2    = ""
    ShowShield = 1
  Case("York")
    Shield1    = "<span class='coatright'><img src='/application/library/media/coatofarms/york_shield1.png'/></span>"
    Shield2    = "<span class='coatright'><img src='/application/library/media/coatofarms/york_shield2.png'/></span>"
    ShowShield = 1

	
  Case Else
    Shield1    = ""
	Shield2    = ""
	ShowShield = 0
  End Select

// -----------------------------------------------------------------------------------------------------------------------
%>
<!--#include virtual="/includes.inc"-->

<%

  Location  = "/application/content/permalink/"
  Location  = Server.Mappath( Location )

  SQL = "SELECT * FROM uk_cities"
  Call FetchData( SQL, RsTemp, ConnTemp )
  
  
  Do While Not RsTemp.Eof
    City       = RsTemp("city")
	nCity      = City
	nCity      = Replace( nCity, ".", "" )
	nCity      = Replace( nCity, " ", "_" )
	Link       = "http://www.townandgownshortlets.uk/ukshortlets/doc/?city:" & City & ";bypassfilter:1;showdrop:1"
    Set Fs     = Server.CreateObject("Scripting.FileSystemObject")
	Set TFile  = Fs.CreateTextFile( Location & "\link_" & nCity & ".pl" )
	TFile.WriteLine("<html>")
	TFile.WriteLine("<head>")
	TFile.WriteLine("<title>" & City & " Shortlets | Town and Gown Shortlets UK</title>")
	TFile.WriteLine("<script>")
	TFile.WriteLine("document.location.href='" & Link & "';")
	TFile.WriteLine("</script>")
	TFile.WriteLine("<meta name=""keywords""    content=""Short Let, Short Lets, Shortlet, Shortlets, Short Let flats and houses, Shortlet flats and houses, Short term property rental, Short term property rentals, Short let accommodation, Short stay accommodation, Short stay private accommodation rental, Self catering accommodation, Self catering apartments, Holiday lets, Holiday lettings, Holiday Rentals, UK Short lets, UK Shortlets, UK Holiday lets, UK Short term property rentals"">")
	TFile.WriteLine("<meta name=""description"" content=""Town and Gown Shortlets is a new 'bespoke' introductory platform for anyone seeking affordable shortlet accommodation within the UK. We enable those seeking temporary holiday or shortlet accommodation to contact shortlet Owners directly via their personal advertisement who endeavour to offer a far more economical, versatile and private solution to hotel accommodation."">")
	TFile.WriteLine("</head>")
	TFile.WriteLine("<body><h1 style='padding:20px; text-align:center;'>Please Wait...<span style='display:block; clear:both; font-size:10pt; font-weight:bold;'>Redirecting you to " & City & " Shortlets...</span></h1></body>")
	TFile.WriteLine("</html>")
	TFile.Close
	Set TFile = Nothing
	Set FS    = Nothing
  
  RsTemp.MoveNext
  Loop
  

  
  
  
  
'  dim fs,tfile
'set fs=Server.CreateObject("Scripting.FileSystemObject")
'set tfile=fs.CreateTextFile("c:\somefile.txt")
'tfile.WriteLine("Hello World!")
'tfile.close
'set tfile=nothing
'set fs=nothing
  
  

%>
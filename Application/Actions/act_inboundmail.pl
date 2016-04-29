<!--#include virtual="/includes.inc"-->
<!--#include virtual="/framework/extensions/json/json.parser.plugin"-->

<%
// ------------------------------------------------------------------------------------------------------------------------------------------

  DoCurl       = 1
  DebugParams  = 1
  o_Query      = fw_Query
  o_Query      = UrlDecode( o_Query )
  IsJSON       = ParseCircuit( "json", o_Query )

// ------------------------------------------------------------------------------------------------------------------------------------------

   Tot_Bytes = Request.TotalBytes
   
   If Tot_Bytes > "0" Then
     Proceed = 1
   Else
     Proceed = 0
   End If
   
   If Proceed = "1" Then
    With Server.CreateObject("Adodb.Stream")
        .Charset = "utf-8" 'specify the request encoding
        .Type = 1 'adTypeBinary, a binary stream
        .Open
        .Write Request.BinaryRead(tot_bytes) 'Write bytes
        .Position = 0 ' set position to the start
        .Type = 2 ' adTypeText, stream type is text now
        postData = .ReadText 'read all text
        .Close
    End With
   End If
  
// ------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
    Response.Write PostData
  Else
    Response.Write "NO DATA RECEIVED"
  End If
  
  'If PostData > "" Then postData = StringToHex(PostData) End If
  
// ------------------------------------------------------------------------------------------------------------------------------------------

  If Proceed = "1" Then
    MySQL = "INSERT INTO tmpmail " & _
            "(json, isjson, lineid)" & vbcrlf & _
		    " VALUES('" & PostData & "', '" & IsJSON & "', '" & Sha1(timer()&rnd()) & "')"
		    Call SaveRecord( MySQL, MyRs, ConnTemp )
		  
  End If
  


	
// ------------------------------------------------------------------------------------------------------------------------------------------

  'DoCurl       = 1 ' Set to `0` For Debugging!
	'DebugParams  = 1 ' Set to `1` For Debugging!
	
// ------------------------------------------------------------------------------------------------------------------------------------------

  'If DoCurl = 1 AND Proceed = 1 Then
	
// ------------------------------------------------------------------------------------------------------------------------------------------
	  
		'Set Node = New JSONParser
		  'Node.parseJSON(postData)
			
			'On Error Resume Next ' Ignore Basic Errors
			
			'Created        = Node.Data("created")
			'LiveMode       = Node.Data("livemode")
			'Id             = Node.Data("id")
			'EventType      = Node.Data("type")
			'Object         = Node.Data("object")
			'Request        = Node.Data("request")
			'DataId         = Node.Data("data").Item("object").Item("id")
			'DataObject     = Node.Data("data").Item("object").Item("object")
			'DataCreated    = Node.Data("data").Item("object").Item("created")
			'DataLiveMode   = Node.Data("data").Item("object").Item("livemode")
			'DataPaid       = Node.Data("data").Item("object").Item("paid")
			'DataAmount     = Node.Data("data").Item("object").Item("amount")
			'DataCurrency   = Node.Data("data").Item("object").Item("currency")
			'DataRefunded   = Node.Data("data").Item("object").Item("refunded")
			'CardId         = Node.Data("data").Item("object").Item("card").Item("id")
			'CardObject     = Node.Data("data").Item("object").Item("card").Item("object")
			'CardLastFour   = Node.Data("data").Item("object").Item("card").Item("last4")
			'CardType       = Node.Data("data").Item("object").Item("card").Item("type")
			'CardExpMonth   = Node.Data("data").Item("object").Item("card").Item("exp_month")
			'CardExpYear    = Node.Data("data").Item("object").Item("card").Item("exp_year")
			'Fingerprint    = Node.Data("data").Item("object").Item("card").Item("fingerprint")
			'Customer       = Node.Data("data").Item("object").Item("card").Item("customer")
			'Country        = Node.Data("data").Item("object").Item("card").Item("country")
			
			
			'Response.Write Country
			
// ------------------------------------------------------------------------------------------------------------------------------------------
// ' Select Event Type
// ------------------------------------------------------------------------------------------------------------------------------------------
			
			'Select Case( EventType )
			  'Case "balance.available"
				  
				'Case "charge.succeeded"
				'Case "charge.failed"
				'Case "charge.refunded"
				'Case "charge.captured"
				'Case "charge.updated"
				'Case "charge.dispute.created"
				'Case "charge.dispute.updated"
				'Case "charge.dispute.closed"
				'Case "transfer.created"
				'Case "transfer.updated"
				'Case "transfer.paid"
				'Case "transfer.failed"
				'Case "ping"
				'Case Else
				'// ' DO NOTHING
			'End Select
			
// ------------------------------------------------------------------------------------------------------------------------------------------
		
	'End If

// ------------------------------------------------------------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------------------------------------------------------------
%>


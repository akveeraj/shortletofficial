

  Call LogEntry()

  Sub LogEntry()
  
    'On Error Resume Next

    TaskName   = "Alert Expiry"
    Domain     = "www.townandgownshortlets.uk"
    Url        = "http://" & Domain & "/subscriptionexpired/scheduledtasks/?output:1;tasklabel:" & TaskName

    Set ObjRequest = CreateObject("Microsoft.XMLHTTP")
      ObjRequest.Open "GET", URL, false
      ObjRequest.Send
    Set ObjRequest = Nothing

  End Sub
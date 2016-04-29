Call LogEntry()

Sub LogEntry()

'On Error Resume Next

TaskName = "Email Alerts"
Domain   = "townandgownshortlets.uk"
Url = "http://test.townandgownshortlets.uk/emailalerts/scheduledtasks/?output:1;tasklabel:Property Email Alerts"

Set ObjRequest = CreateObject("Microsoft.XMLHTTP")

ObjRequest.Open "GET", URL, false
ObjRequest.Send

Set ObjRequest = Nothing

'x=msgbox("The task `" & TaskName & "` for " & Domain & " was completed successfully." & vbcrlf & vbcrlf & Now() ,0, "Automated Task Complete")

End Sub
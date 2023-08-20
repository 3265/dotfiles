Attribute VB_Name = "ModuleMyTimestamp"
Function MyTimestamp(Reference As Range)
    If Reference.Value <> "" Then
            MyTimestamp = Format(Now, "yyyy-mm-dd hh:mm")
        If Application.Caller.Text <> "" Then
            MyTimestamp = Application.Caller.Text
        End If
    Else
        MyTimestamp = ""
    End If
End Function


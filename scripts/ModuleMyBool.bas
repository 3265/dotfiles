Attribute VB_Name = "ModuleMyBool"
Function MyBool(Reference As Range)
    If Reference.Value <> "" Then
            MyBool = False
        If Application.Caller.Text <> "" Then
            MyBool = CBool(Application.Caller.Text)
        End If
    Else
        MyBool = ""
    End If
End Function

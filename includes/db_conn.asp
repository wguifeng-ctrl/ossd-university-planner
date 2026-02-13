<%
'========================================
' OSSD University Planner - Database Connection
'========================================

Dim conn

Sub OpenConnection()
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\wwwroot\OUP\db\oup_data.mdb;"
End Sub

Sub CloseConnection()
    If Not conn Is Nothing Then
        If conn.State = 1 Then conn.Close
        Set conn = Nothing
    End If
End Sub
%>

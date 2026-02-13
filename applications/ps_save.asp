<%
'========================================
' OSSD University Planner - Personal Statement Save
' Save PS content with versioning
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<%
Dim appID, section, content
appID = Request("appID")
section = SafeSQL(Request("section"))
content = Request("content")

If appID = "" Then Response.Redirect "dashboard.asp"

Call OpenConnection()

' Get current max version
Dim rsVer, maxVersion
Set rsVer = conn.Execute("SELECT MAX(Version) FROM PersonalStatements WHERE ApplicationID=" & appID & " AND SectionName='" & section & "'")
If IsNull(rsVer(0)) Then
    maxVersion = 1
Else
    maxVersion = rsVer(0) + 1
End If
rsVer.Close
Set rsVer = Nothing

' Insert new version
Dim sql
sql = "INSERT INTO PersonalStatements (ApplicationID, SectionName, Content, Version, IsFinal, LastModified) VALUES (" & _
      appID & ", '" & section & "', '" & SafeSQL(content) & "', " & maxVersion & ", 0, Now())"
conn.Execute sql

Call CloseConnection()

' Determine redirect
Dim nextPage
nextPage = Request("next")
If nextPage <> "" Then
    Response.Redirect nextPage
Else
    Response.Redirect "ps_editor.asp?app=" & appID & "&section=" & section & "&saved=1"
End If
%>

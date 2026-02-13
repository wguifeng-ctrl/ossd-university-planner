<%@ Language=VBScript %>
<%
'========================================
' Create Blank Access Database (.mdb format)
' Compatible with Access 2007 via Jet 4.0
'========================================

Dim dbPath, dbEngine

dbPath = Server.MapPath("/db/oup_data.mdb")

Response.Write "<link rel='stylesheet' href='css/main.css'>"
Response.Write "<div class='container'>"
Response.Write "<h2>Create Database File</h2>"
Response.Write "<div class='card'>"

On Error Resume Next

' Method 1: Try ADOX (most reliable)
Dim cat
Set cat = Server.CreateObject("ADOX.Catalog")

cat.Create "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbPath & ";"

If Err.Number = 0 Then
    Response.Write "<div class='alert alert-success'>✓ Blank database created successfully at:<br>" & dbPath & "</div>"
Else
    Response.Write "<div class='alert alert-danger'>"
    Response.Write "<h4>Failed to create database automatically</h4>"
    Response.Write "<p>Error: " & Err.Description & "</p>"
    Response.Write "<h4>Manual Solution:</h4>"
    Response.Write "<ol>"
    Response.Write "<li>Open Microsoft Access 2007</li>"
    Response.Write "<li>File → New → Blank Database</li>"
    Response.Write "<li>Save as: oup_data.mdb (choose Access 2002-2003 format)</li>"
    Response.Write "<li>Save to: " & Server.MapPath("/db/") & "</li>"
    Response.Write "<li>Close Access</li>"
    Response.Write "<li>Return here and click 'Setup Tables' below</li>"
    Response.Write "</ol>"
    Response.Write "</div>"
    Err.Clear
End If

On Error GoTo 0

Response.Write "<hr>"
Response.Write "<div style='text-align:center;'>"
Response.Write "<a href='create_database.asp' class='btn btn-primary btn-lg'>Setup Tables →</a>"
Response.Write "<br><br>"
Response.Write "<a href='db/oup_data.mdb' download class='btn btn-warning'>Download Empty .mdb (if created)</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
%>

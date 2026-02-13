<%
'========================================
' OSSD University Planner - URL Connectivity Test Proxy
'========================================

Response.CodePage = 65001
Response.CharSet = "UTF-8"

Dim testUrl, httpObj

testUrl = Request.QueryString("url")

If testUrl = "" Then
    Response.Write "Error: Missing URL parameter"
    Response.End
End If

' Security: Only allow http/https
If Not (Left(testUrl, 7) = "http://" Or Left(testUrl, 8) = "https://") Then
    Response.Write "Error: Invalid URL protocol"
    Response.End
End If

On Error Resume Next

Set httpObj = Server.CreateObject("MSXML2.ServerXMLHTTP")
If Err.Number <> 0 Then
    Set httpObj = Server.CreateObject("MSXML2.XMLHTTP")
End If
If Err.Number <> 0 Then
    Set httpObj = Server.CreateObject("Microsoft.XMLHTTP")
End If

If httpObj Is Nothing Then
    Response.Write "Error: Cannot create HTTP object"
    Response.End
End If

httpObj.Open "HEAD", testUrl, False
httpObj.setRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
httpObj.Send

If Err.Number <> 0 Then
    Response.Write "Error: " & Err.Description
    Set httpObj = Nothing
    Response.End
End If

If httpObj.Status >= 200 And httpObj.Status < 400 Then
    Response.Write "OK - Accessible (HTTP " & httpObj.Status & ")"
Else
    Response.Write "Error HTTP " & httpObj.Status & " " & Replace(httpObj.statusText, "<", "")
End If

Set httpObj = Nothing
On Error GoTo 0
%>

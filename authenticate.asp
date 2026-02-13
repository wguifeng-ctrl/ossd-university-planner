<%
'========================================
' OSSD University Planner - Authentication
' Process login form and set session
'========================================

'"--
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<%
' Get form data
Dim email, password, hashedPassword
email = Trim(Request.Form("email"))
password = Trim(Request.Form("password"))

' Simple password hashing (SHA256 would be better in production)
hashedPassword = MD5Hash(password)

' Open database connection
Call OpenConnection()

' Verify credentials
Dim rs
Set rs = conn.Execute("SELECT StudentID, FullName, Email, GradeLevel, TargetYear FROM Students WHERE Email='" & SafeSQL(email) & "' AND PasswordHash='" & SafeSQL(hashedPassword) & "'")

If rs.EOF Then
    ' Invalid credentials
    rs.Close
    Set rs = Nothing
    Call CloseConnection()
    Response.Redirect "login.asp?error=1"
Else
    ' Valid credentials - set session variables
    Session("StudentID") = rs("StudentID")
    Session("StudentName") = rs("FullName")
    Session("Email") = rs("Email")
    Session("GradeLevel") = rs("GradeLevel")
    Session("TargetYear") = rs("TargetYear")
    Session("LoggedIn") = True
    
    rs.Close
    Set rs = Nothing
    Call CloseConnection()
    
    ' Redirect to dashboard
    Response.Redirect "default.asp"
End If

'========================================
' Simple MD5 Hash Function for Passwords
'========================================
Function MD5Hash(s)
    Dim enc, bytes, hash, i, hexStr
    Set enc = Server.CreateObject("System.Security.Cryptography.MD5CryptoServiceProvider")
    bytes = StringToBytes(s)
    bytes = enc.ComputeHash(bytes)
    
    hexStr = ""
    For i = 0 To UBound(bytes)
        hexStr = hexStr & Right("00" & Hex(bytes(i)), 2)
    Next
    
    MD5Hash = LCase(hexStr)
    Set enc = Nothing
End Function

Function StringToBytes(s)
    Dim stream
    Set stream = Server.CreateObject("ADODB.Stream")
    stream.Charset = "UTF-8"
    stream.Mode = 3
    stream.Open
    stream.WriteText s
    stream.Position = 0
    stream.Charset = "UTF-8"
    StringToBytes = stream.Read
    stream.Close
    Set stream = Nothing
End Function
%>

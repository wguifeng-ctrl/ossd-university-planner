<%
'========================================
' OSSD University Planner - Account Creation
' Process registration form with password hashing
'========================================

'"--
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<%
' Get form data
Dim fullname, email, grade, targetYear, password, password2, hashedPassword

fullname = Trim(Request.Form("fullname"))
email = Trim(Request.Form("email"))
grade = Request.Form("grade")
targetYear = Request.Form("target_year")
password = Request.Form("password")
password2 = Request.Form("password2")

' Validation
If password <> password2 Then
    Response.Redirect "register.asp?error=password"
End If

' Open database connection
Call OpenConnection()

' Check if email already exists
Dim checkRS
Set checkRS = conn.Execute("SELECT COUNT(*) FROM Students WHERE Email='" & SafeSQL(email) & "'")

If checkRS(0) > 0 Then
    checkRS.Close
    Set checkRS = Nothing
    Call CloseConnection()
    Response.Redirect "register.asp?error=email"
End If

checkRS.Close
Set checkRS = Nothing

' Hash the password
hashedPassword = MD5Hash(password)

' Insert new student
Dim sql
sql = "INSERT INTO Students (FullName, Email, PasswordHash, GradeLevel, TargetYear, CreatedDate) VALUES (" & _
      "'" & SafeSQL(fullname) & "', " & _
      "'" & SafeSQL(email) & "', " & _
      "'" & SafeSQL(hashedPassword) & "', " & _
      "'" & SafeSQL(grade) & "', " & _
      targetYear & ", " & _
      "#" & Date() & "#)"

On Error Resume Next
conn.Execute sql

If Err.Number <> 0 Then
    Response.Write "<div class='alert alert-danger'>Error creating account: " & Err.Description & "</div>"
    Response.Write "<p><a href='register.asp'>Go back</a></p>"
    On Error GoTo 0
    Call CloseConnection()
    Response.End
End If

On Error GoTo 0
Call CloseConnection()

' Redirect to login with success message
Response.Redirect "login.asp?msg=registered"

'========================================
' Simple MD5 Hash Function for Passwords
'========================================
Function MD5Hash(s)
    Dim enc, bytes, hash, i, hexStr
    On Error Resume Next
    Set enc = Server.CreateObject("System.Security.Cryptography.MD5CryptoServiceProvider")
    
    If Err.Number <> 0 Then
        ' Fallback if crypto provider not available
        MD5Hash = Base64Encode(s & "salt")
        Err.Clear
        Exit Function
    End If
    
    bytes = StringToBytes(s)
    bytes = enc.ComputeHash(bytes)
    
    hexStr = ""
    For i = 0 To UBound(bytes)
        hexStr = hexStr & Right("00" & Hex(bytes(i)), 2)
    Next
    
    MD5Hash = LCase(hexStr)
    Set enc = Nothing
End Function

Function Base64Encode(s)
    Dim bytes, dm
    Set dm = Server.CreateObject("Microsoft.XMLDOM")
    Set bytes = dm.createElement("tmp")
    bytes.DataType = "bin.base64"
    bytes.NodeTypedValue = StringToBytes(s)
    Base64Encode = bytes.Text
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

<%@ Language=VBScript %>
<!--#include file="includes/db_conn.asp"-->
<%
'========================================
' OSSD University Planner - Database Setup
' Compatible with Access 2007 (Jet 4.0)
'========================================

Response.Write "<link rel='stylesheet' href='css/main.css'>"
Response.Write "<div class='container'>"
Response.Write "<h2>Database Setup</h2>"
Response.Write "<div class='card'>"
Response.Write "<pre style='font-family:monospace;'>"

On Error Resume Next

Call OpenConnection()

Dim rs

' Function to check if table exists
Function TableExists(tableName)
    On Error Resume Next
    Set rs = conn.OpenSchema(20, Array(Empty, Empty, tableName)) ' 20 = adSchemaTables
    TableExists = Not rs.EOF
    rs.Close
    Set rs = Nothing
    On Error GoTo 0
End Function

' 1. Create Students table
If Not TableExists("Students") Then
    conn.Execute "CREATE TABLE Students ([ID] AUTOINCREMENT CONSTRAINT PK_Students PRIMARY KEY, [FullName] TEXT(100), [Email] TEXT(100), [Grade] TEXT(10), [TargetYear] TEXT(4), [Password] TEXT(100), [CreatedDate] DATE, [LastLogin] DATE)"
    If Err.Number = 0 Then
        Response.Write "+ Students table created" & vbCrLf
    Else
        Response.Write "- Students: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* Students already exists" & vbCrLf
End If

' 2. Create Courses table
If Not TableExists("Courses") Then
    conn.Execute "CREATE TABLE Courses ([ID] AUTOINCREMENT CONSTRAINT PK_Courses PRIMARY KEY, [StudentID] INTEGER, [CourseName] TEXT(100), [CourseCode] TEXT(20), [Category] TEXT(10), [CourseType] TEXT(5), [Grade] INTEGER, [Credits] DOUBLE, [Status] TEXT(20), [Term] TEXT(20), [Year] INTEGER)"
    If Err.Number = 0 Then
        Response.Write "+ Courses table created" & vbCrLf
    Else
        Response.Write "- Courses: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* Courses already exists" & vbCrLf
End If

' 3. Create Universities table
If Not TableExists("Universities") Then
    conn.Execute "CREATE TABLE Universities ([ID] AUTOINCREMENT CONSTRAINT PK_Universities PRIMARY KEY, [Name] TEXT(100), [OUACCode] TEXT(10), [Location] TEXT(100), [Website] TEXT(200), [MinGPA] DOUBLE, [CompetitiveGPA] DOUBLE, [RequiresENG4U] YESNO, [RequiresCalculus] YESNO, [ApplicationDeadline] DATE, [PopularPrograms] MEMO, [Ranking] INTEGER, [AdmissionLink] TEXT(200))"
    If Err.Number = 0 Then
        Response.Write "+ Universities table created" & vbCrLf
    Else
        Response.Write "- Universities: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* Universities already exists" & vbCrLf
End If

' 4. Create Programs table
If Not TableExists("Programs") Then
    conn.Execute "CREATE TABLE Programs ([ID] AUTOINCREMENT CONSTRAINT PK_Programs PRIMARY KEY, [UniID] INTEGER, [ProgramName] TEXT(100), [ProgramCode] TEXT(20), [Description] MEMO, [Duration] TEXT(50), [MinGPA] DOUBLE, [RequiredCourses] MEMO, [ApplicationDeadline] DATE, [Tuition] TEXT(50))"
    If Err.Number = 0 Then
        Response.Write "+ Programs table created" & vbCrLf
    Else
        Response.Write "- Programs: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* Programs already exists" & vbCrLf
End If

' 5. Create Applications table
If Not TableExists("Applications") Then
    conn.Execute "CREATE TABLE Applications ([ID] AUTOINCREMENT CONSTRAINT PK_Applications PRIMARY KEY, [StudentID] INTEGER, [UniID] INTEGER, [ProgramID] INTEGER, [Status] TEXT(20), [ApplicationDate] DATE, [OUACReference] TEXT(50), [Notes] MEMO, [CreatedDate] DATE)"
    If Err.Number = 0 Then
        Response.Write "+ Applications table created" & vbCrLf
    Else
        Response.Write "- Applications: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* Applications already exists" & vbCrLf
End If

' 6. Create PersonalStatements table
If Not TableExists("PersonalStatements") Then
    conn.Execute "CREATE TABLE PersonalStatements ([ID] AUTOINCREMENT CONSTRAINT PK_PersonalStatements PRIMARY KEY, [ApplicationID] INTEGER, [SectionName] TEXT(50), [Content] MEMO, [Version] INTEGER, [IsFinal] YESNO, [LastModified] DATE)"
    If Err.Number = 0 Then
        Response.Write "+ PersonalStatements table created" & vbCrLf
    Else
        Response.Write "- PersonalStatements: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* PersonalStatements already exists" & vbCrLf
End If

' 7. Create Recommendations table
If Not TableExists("Recommendations") Then
    conn.Execute "CREATE TABLE Recommendations ([ID] AUTOINCREMENT CONSTRAINT PK_Recommendations PRIMARY KEY, [StudentID] INTEGER, [RefereeName] TEXT(100), [RefereeEmail] TEXT(100), [RefereeTitle] TEXT(100), [Status] TEXT(20), [RequestDate] DATE, [SubmitDate] DATE, [Notes] MEMO)"
    If Err.Number = 0 Then
        Response.Write "+ Recommendations table created" & vbCrLf
    Else
        Response.Write "- Recommendations: " & Err.Description & vbCrLf
        Err.Clear
    End If
Else
    Response.Write "* Recommendations already exists" & vbCrLf
End If

On Error GoTo 0

CloseConnection()

Response.Write "</pre>"
Response.Write "</div>"

Response.Write "<div style='text-align:center; margin-top:20px;'>"
Response.Write "<a href='universities/init_universities.asp' class='btn btn-primary btn-lg'>Next: Load University Data &#8594;</a>"
Response.Write "<br><br>"
Response.Write "<a href='login.asp' class='btn btn-success'>Go to Login</a>"
Response.Write "</div>"
Response.Write "</div>"
%>

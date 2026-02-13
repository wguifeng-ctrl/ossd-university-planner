<%
'========================================
' OSSD University Planner - Course Save/Delete
' Process course add/edit/delete operations
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<% Call CheckLogin()

Dim studentID, action, id
studentID = Session("StudentID")
action = Request("action")
id = Request("id")
If id = "" Then id = Request("courseid")

Call OpenConnection()

If action = "delete" AND id <> "" Then
    ' Delete course
    On Error Resume Next
    conn.Execute "DELETE FROM Courses WHERE ID=" & id & " AND StudentID=" & studentID
    
    If Err.Number = 0 Then
        Response.Redirect "courses.asp?msg=deleted"
    Else
        Response.Redirect "courses.asp?error=delete"
    End If
    On Error GoTo 0
Else
    ' Add or Edit course
    Dim courseCode, courseName, category, courseType, credits, grade, status, term
    
    courseCode = Trim(Request.Form("coursecode"))
    courseName = Trim(Request.Form("coursename"))
    category = Request.Form("category")
    courseType = Request.Form("coursetype")
    credits = Request.Form("credits")
    If credits = "" Then credits = 1
    grade = Request.Form("grade")
    If grade = "" Then grade = "NULL" Else grade = grade
    status = Request.Form("status")
    If status = "" Then status = "Planned"
    term = Trim(Request.Form("term"))
    
    ' Validate required fields
    If courseCode = "" OR courseName = "" OR category = "" Then
        Response.Redirect "courses.asp?error=required"
    End If
    
    Dim sql
    
    If id <> "" Then
        ' Update existing course
        sql = "UPDATE Courses SET " & _
              "CourseCode='" & SafeSQL(courseCode) & "', " & _
              "CourseName='" & SafeSQL(courseName) & "', " & _
              "Category='" & SafeSQL(category) & "', " & _
              "CourseType='" & SafeSQL(courseType) & "', " & _
              "Credits=" & credits & ", "
        
        If grade = "NULL" Then
            sql = sql & "Grade=NULL, "
        Else
            sql = sql & "Grade=" & grade & ", "
        End If
        
        sql = sql & "Status='" & SafeSQL(status) & "', " & _
              "Term='" & SafeSQL(term) & "' " & _
              "WHERE ID=" & id & " AND StudentID=" & studentID
    Else
        ' Insert new course
        Dim gradeVal
        If grade = "NULL" Then
            gradeVal = "NULL"
        Else
            gradeVal = grade
        End If
        
        sql = "INSERT INTO Courses (StudentID, CourseCode, CourseName, Category, CourseType, Credits, Grade, Status, Term) " & _
              "VALUES (" & studentID & ", " & _
              "'" & SafeSQL(courseCode) & "', " & _
              "'" & SafeSQL(courseName) & "', " & _
              "'" & SafeSQL(category) & "', " & _
              "'" & SafeSQL(courseType) & "', " & _
              credits & ", " & _
              gradeVal & ", " & _
              "'" & SafeSQL(status) & "', " & _
              "'" & SafeSQL(term) & "')"
    End If
    
    On Error Resume Next
    conn.Execute sql
    
    If Err.Number = 0 Then
        If id <> "" Then
            Response.Redirect "courses.asp?msg=updated"
        Else
            Response.Redirect "courses.asp?msg=added"
        End If
    Else
        Response.Write "<div class='alert alert-danger'>Error saving course: " & Err.Description & "</div>"
        Response.Write "<p><a href='courses.asp'>Go back</a></p>"
        On Error GoTo 0
        Call CloseConnection()
        Response.End
    End If
    On Error GoTo 0
End If

Call CloseConnection()
%>

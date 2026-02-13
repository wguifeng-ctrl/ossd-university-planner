<%@ Language=VBScript %>
<!--#include file="../includes/db_conn.asp"-->
<!--#include file="../includes/functions.asp"-->
<%
Dim studentID, action, id
studentID = Session("StudentID")
action = Request("action")
id = Request("id")

Call OpenConnection()

If action = "delete" And id <> "" Then
    conn.Execute "DELETE FROM Applications WHERE ID=" & id & " AND StudentID=" & studentID
    CloseConnection()
    Response.Redirect "dashboard.asp"
ElseIf action = "add" Then
    Dim uni, prog, status, notes
    uni = Request("university")
    prog = Request("program")
    status = SafeSQL(Request("status"))
    notes = SafeSQL(Request("notes"))
    
    Dim sql, progValue
    If prog = "" Then
        progValue = "NULL"
    Else
        progValue = prog
    End If
    sql = "INSERT INTO Applications (StudentID, UniID, ProgramID, Status, Notes, CreatedDate) VALUES (" & _
          studentID & ", " & uni & ", " & progValue & ", '" & status & "', '" & notes & "', Now())"
    
    conn.Execute sql
    CloseConnection()
    Response.Redirect "dashboard.asp"
End If

CloseConnection()
%>

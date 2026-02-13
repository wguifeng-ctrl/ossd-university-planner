<%
'========================================
' OSSD University Planner - Recommendation Save
' Add new referee tracking
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<%
Dim studentID, name, title, email
studentID = Session("StudentID")
name = SafeSQL(Request("name"))
title = SafeSQL(Request("title"))
email = SafeSQL(Request("email"))

If name = "" Or email = "" Then Response.Redirect "dashboard.asp"

Call OpenConnection()

Dim sql
sql = "INSERT INTO Recommendations (StudentID, RefereeName, RefereeTitle, RefereeEmail, Status, RequestDate) VALUES (" & _
      studentID & ", '" & name & "', '" & title & "', '" & email & "', 'Pending', Now())"

conn.Execute sql
Call CloseConnection()

Response.Redirect "/oup/applications/dashboard.asp"
%>

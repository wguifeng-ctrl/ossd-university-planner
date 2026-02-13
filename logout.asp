<%
'========================================
' OSSD University Planner - Logout
' Clear all session variables
'========================================

' Clear all session variables
Session.Contents.RemoveAll()

' Abandon the session
Session.Abandon()

' Redirect to login page
Response.Redirect "login.asp"
%>

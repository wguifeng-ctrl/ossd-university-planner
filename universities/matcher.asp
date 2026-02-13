<%@ Language=VBScript %>
<!--#include file="../includes/db_conn.asp"-->
<!--#include file="../includes/functions.asp"-->
<% CheckLogin() %>
<!--#include file="../includes/header.asp"-->

<%
Dim studentID, gpa
dim filterGPA
studentID = Session("StudentID")
filterGPA = Request("gpa_filter")
If filterGPA = "" Then filterGPA = "all"

Call OpenConnection()
gpa = CalculateOSSDGPA(studentID)
%>

<!--#include file="../disclaimer.asp"-->

<div class="card">
    <h2>🎯 Smart University Matcher</h2>
    <p>Your current GPA: <strong><%=FormatNumber(gpa,2)%></strong>. Filter by admission category:</p>
    
    <div style="text-align:center; margin:20px 0;">
        <a href="/oup/universities/matcher.asp?gpa_filter=all" class="btn btn-sm <% If filterGPA="all" Then Response.Write "btn-primary" Else Response.Write "btn-outline" %>">All</a>
        <a href="/oup/universities/matcher.asp?gpa_filter=safe" class="btn btn-sm <% If filterGPA="safe" Then Response.Write "btn-success" Else Response.Write "btn-outline" %>">Safe</a>
        <a href="/oup/universities/matcher.asp?gpa_filter=target" class="btn btn-sm <% If filterGPA="target" Then Response.Write "btn-primary" Else Response.Write "btn-outline" %>">Target</a>
        <a href="/oup/universities/matcher.asp?gpa_filter=reach" class="btn btn-sm <% If filterGPA="reach" Then Response.Write "btn-warning" Else Response.Write "btn-outline" %>">Reach</a>
    </div>
</div>

<div class="dashboard-grid">
<%
Dim sql, rs
sql = "SELECT * FROM Universities WHERE 1=1"

Select Case filterGPA
    Case "safe"
        sql = sql & " AND MinGPA <= " & (gpa - 0.5)
    Case "target"
        sql = sql & " AND MinGPA > " & (gpa - 0.5) & " AND MinGPA <= " & (gpa + 0.2)
    Case "reach"
        sql = sql & " AND MinGPA > " & (gpa + 0.2)
End Select

sql = sql & " ORDER BY MinGPA DESC"

Set rs = conn.Execute(sql)

If rs.EOF Then
    Response.Write "<p style='text-align:center;'>No universities match your filter. Try 'All' to see all options.</p>"
Else
    Do While Not rs.EOF
        Dim diff, matchClass
        diff = gpa - rs("MinGPA")
        
        If diff >= 0.3 Then
            matchClass = "match-high"
        ElseIf diff >= 0 Then
            matchClass = "match-good"
        ElseIf diff >= -0.3 Then
            matchClass = "match-maybe"
        Else
            matchClass = "match-low"
        End If
%>
    <div class="uni-card">
        <div style="display:flex; justify-content:space-between; align-items:start;">
            <h3><%=rs("Name")%></h3>
            <span class="<%=matchClass%>"><%=GetMatchScore(gpa, rs("MinGPA"))%>% Match</span>
        </div>
        
        <div class="uni-stats">
            <div class="uni-stat">
                <div class="value"><%=FormatNumber(rs("MinGPA"),2)%></div>
                <div class="label">Min GPA</div>
            </div>
            <div class="uni-stat">
                <div class="value"><%=FormatNumber(rs("CompetitiveGPA"),2)%></div>
                <div class="label">Competitive</div>
            </div>
            <div class="uni-stat">
                <div class="value">#<%=rs("Ranking")%></div>
                <div class="label">Rank</div>
            </div>
        </div>
        
        <p><%=PredictAdmission(gpa, rs("MinGPA"))%></p>
        
        <div style="text-align:center;">
            <a href="/oup/universities/detail.asp?id=<%=rs("ID")%>" class="btn btn-sm btn-primary">Details</a>
            <a href="/oup/applications/add.asp?uni=<%=rs("ID")%>" class="btn btn-sm btn-success">Apply</a>
        </div>
    </div>
<%
        rs.MoveNext
    Loop
End If
rs.Close
CloseConnection()
%>
</div>

<!--#include file="../includes/footer.asp"-->

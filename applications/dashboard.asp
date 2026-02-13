<%@ Language=VBScript %>
<!--#include file="../includes/db_conn.asp"-->
<!--#include file="../includes/functions.asp"-->
<% CheckLogin() %>
<!--#include file="../includes/header.asp"-->

<%
Dim studentID
dim gpa
studentID = Session("StudentID")

Call OpenConnection()
gpa = CalculateOSSDGPA(studentID)
%>

<div class="card">
    <h2>📝 My Applications</h2>
    <p>Track your OUAC applications and their status. <strong>Your GPA:</strong> <%=FormatNumber(gpa,2)%></p>
    
    <div style="text-align:center; margin:20px 0;">
        <a href="/oup/applications/add.asp" class="btn btn-success">+ Add New Application</a>
    </div>
</div>

<div class="card">
    <h2>📊 Application Status Overview</h2>
    
    <table class="data-table">
        <thead>
            <tr>
                <th>University</th>
                <th>Program</th>
                <th>Status</th>
                <th>Deadline</th>
                <th>PS Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
        Dim rsApps
        Set rsApps = conn.Execute("SELECT a.ID, a.Status, a.ApplicationDate, u.Name, p.ProgramName, p.ApplicationDeadline " & _
            "FROM (Applications a LEFT JOIN Universities u ON a.UniID = u.ID) " & _
            "LEFT JOIN Programs p ON a.ProgramID = p.ID " & _
            "WHERE a.StudentID=" & studentID & " ORDER BY a.Status, p.ApplicationDeadline")
        
        If rsApps.EOF Then
            Response.Write "<tr><td colspan='6' style='text-align:center;'>No applications yet. <a href='/oup/applications/add.asp'>Add your first application</a></td></tr>"
        Else
            Do While Not rsApps.EOF
                Dim psStatus, psCount
                Set psCount = conn.Execute("SELECT COUNT(*) FROM PersonalStatements WHERE ApplicationID=" & rsApps("ID"))
                If psCount(0) > 0 Then
                    psStatus = "<span class='badge badge-success'>✓ Started</span>"
                Else
                    psStatus = "<span class='badge badge-warning'>Not Started</span>"
                End If
                psCount.Close
        %>
            <tr>
                <td><strong><%=rsApps("Name")%></strong></td>
                <td><%=rsApps("ProgramName")%></td>
                <td>
                    <% If rsApps("Status") = "Submitted" Then %>
                        <span class="badge badge-success">Submitted</span>
                    <% ElseIf rsApps("Status") = "Draft" Then %>
                        <span class="badge badge-warning">Draft</span>
                    <% ElseIf rsApps("Status") = "Accepted" Then %>
                        <span class="badge badge-success" style="background:#28a745;">Accepted 🎉</span>
                    <% ElseIf rsApps("Status") = "Rejected" Then %>
                        <span class="badge badge-danger">Rejected</span>
                    <% End If %>
                </td>
                <td>
                    <% On Error Resume Next
                       If Not IsNull(rsApps("ApplicationDeadline")) And Not IsEmpty(rsApps("ApplicationDeadline")) Then 
                           Response.Write FormatDeadlineBadge(rsApps("ApplicationDeadline"))
                       Else
                           Response.Write "-"
                       End If
                       On Error GoTo 0
                    %>
                </td>
                <td><%=psStatus%></td>
                <td>
                    <a href="/oup/applications/ps_editor.asp?app=<%=rsApps("ID")%>" class="btn btn-sm btn-primary">Edit PS</a>
                    <a href="/oup/applications/save.asp?action=delete&id=<%=rsApps("ID")%>" class="btn btn-sm btn-danger" onclick="return confirm('Remove this application?')">Remove</a>
                </td>
            </tr>
        <% 
                rsApps.MoveNext
            Loop
        End If
        rsApps.Close
        %>
        </tbody>
    </table>
</div>

<!-- Recommendations Section -->
<div class="card">
    <h2>📨 Letter of Recommendation Tracking</h2>
    
    <table class="data-table">
        <thead>
            <tr>
                <th>Referee</th>
                <th>Title/Role</th>
                <th>Email</th>
                <th>Status</th>
                <th>Requested</th>
                <th>Submitted</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
        Dim rsRecs
        Set rsRecs = conn.Execute("SELECT * FROM Recommendations WHERE StudentID=" & studentID & " ORDER BY RequestDate DESC")
        
        If rsRecs.EOF Then
            Response.Write "<tr><td colspan='7' style='text-align:center;'>No recommendation requests. Add referees to track their submissions.</td></tr>"
        Else
            Do While Not rsRecs.EOF
        %>
            <tr>
                <td><strong><%=rsRecs("RefereeName")%></strong></td>
                <td><%=rsRecs("RefereeTitle")%></td>
                <td><%=rsRecs("RefereeEmail")%></td>
                <td>
                    <% If rsRecs("Status") = "Submitted" Then %>
                        <span class="badge badge-success">Submitted</span>
                    <% ElseIf rsRecs("Status") = "Waived" Then %>
                        <span class="badge badge-info">Waived</span>
                    <% Else %>
                        <span class="badge badge-warning">Pending</span>
                    <% End If %>
                </td>
                <td><% If Not IsNull(rsRecs("RequestDate")) Then Response.Write FormatDateTime(rsRecs("RequestDate"), 2) Else Response.Write "-" %></td>
                <td><% If Not IsNull(rsRecs("SubmitDate")) Then Response.Write FormatDateTime(rsRecs("SubmitDate"), 2) Else Response.Write "-" %></td>
                <td>
                    <a href="/oup/applications/rec_action.asp?id=<%=rsRecs("ID")%>&action=submitted" class="btn btn-sm btn-success">Mark Submitted</a>
                </td>
            </tr>
        <% 
                rsRecs.MoveNext
            Loop
        End If
        rsRecs.Close
        %>
        </tbody>
    </table>
    
    <div style="text-align:center; margin-top:20px;">
        <a href="#" onclick="document.getElementById('addRecForm').style.display='block'; return false;" class="btn btn-primary">+ Add Referee</a>
    </div>
    
    <div id="addRecForm" style="display:none; margin-top:20px; padding:20px; background:#f8f9fa; border-radius:8px;">
        <form method="post" action="rec_save.asp">
            <div class="form-group">
                <label>Referee Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Title/Role (e.g., "Grade 11 Physics Teacher")</label>
                <input type="text" name="title" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Add Referee</button>
            <button type="button" onclick="document.getElementById('addRecForm').style.display='none';" class="btn btn-warning">Cancel</button>
        </form>
    </div>
</div>

<% CloseConnection() %>
<!--#include file="../includes/footer.asp"-->

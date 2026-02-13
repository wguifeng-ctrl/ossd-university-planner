<%
'========================================
' OSSD University Planner - University Details
' Detailed university information page
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<% Call CheckLogin() %>

<!-- #include file="../includes/header.asp" -->

<div class="container">
    <!--#include file="../disclaimer.asp"-->
    
    <% 
        Dim uniID, studentID, studentGPA
        uniID = Request("id")
        studentID = Session("StudentID")
        
        If uniID = "" Then
            Response.Redirect "list.asp"
        End If
        
        Call OpenConnection()
        studentGPA = CalculateTop6GPA(studentID)
        
        ' Get university details
        Dim uniRS
        Set uniRS = conn.Execute("SELECT * FROM Universities WHERE ID=" & uniID)
        
        If uniRS.EOF Then
            uniRS.Close
            Set uniRS = Nothing
            Call CloseConnection()
            Response.Redirect "list.asp"
        End If
    %>
    
    <div>
        <a href="/oup/universities/list.asp" style="color:var(--primary);">Back to Universities List</a>
    </div>
    
    <!-- University Header -->
    <div class="card" style="margin-top:20px;">
        <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:20px;">
            <div>
                <h2 style="color:var(--primary);"><%=uniRS("Name")%></h2>
                <p style="font-size:1.1rem; color:#6c757d;">
                    📍 <%=uniRS("Location")%><br>
                    🌐 <a href="<%=uniRS("Website")%>" target="_blank"><%=uniRS("Website")%></a>
                </p>
            </div>
            <div style="text-align:right;">
                <a href="/oup/applications/add.asp?uni=<%=uniRS("ID")%>" class="btn btn-success" style="display:block; margin-bottom:10px;">Apply to This University</a>
                <span class="badge badge-primary"><a href="detail.asp?id=<%=uniRS("ID")%>" style="color:var(--primary); text-decoration:none;">View Details</a></span>
            </div>
        </div>
    </div>
    
    <!-- Stats and Match -->
    <div class="dashboard-grid">
        <div class="card">
            <h3>Admission Statistics</h3>
            <div class="uni-stats" style="justify-content:space-around;">
                <div class="uni-stat">
                    <div class="value"><%=uniRS("MinGPA")%></div>
                    <div class="label">Min GPA</div>
                </div>
                <div class="uni-stat">
                    <div class="value"><%=uniRS("CompetitiveGPA")%></div>
                    <div class="label">Competitive GPA</div>
                </div>
                <div class="uni-stat">
                    <div class="value"><%=uniRS("Ranking")%></div>
                    <div class="label">Ranking</div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <h3>Your Match</h3>
            <div class="gpa-display" style="padding:20px;">
                <div style="display:flex; justify-content:space-around; align-items:center;">
                    <div style="text-align:center;">
                        <div style="font-size:3rem; font-weight:bold;"><%=studentGPA%></div>
                        <div>Your GPA</div>
                    </div>
                    <div style="font-size:2rem;">VS</div>
                    <div style="text-align:center;">
                        <div style="font-size:3rem; font-weight:bold;"><%=uniRS("MinGPA")%></div>
                        <div>Min Required</div>
                    </div>
                </div>
                <hr style="margin:20px 0; border-color:rgba(255,255,255,0.3);">
                <div style="font-size:1.2rem;">
                    Admission Prediction: <%=PredictAdmission(studentGPA, uniRS("MinGPA"))%>
                </div>
            </div>
        </div>
    </div>
    
    <div class="dashboard-grid">
        <!-- Admission Requirements -->
        <div class="card">
            <h3>📋 Admission Requirements</h3>
            <table class="data-table">
                <tr>
                    <td>Minimum GPA</td>
                    <td style="text-align:right; font-weight:bold;"><%=uniRS("MinGPA")%></td>
                </tr>
                <tr>
                    <td>Competitive GPA</td>
                    <td style="text-align:right; font-weight:bold;"><%=uniRS("CompetitiveGPA")%></td>
                </tr>
                <tr>
                    <td>Requires ENG4U</td>
                    <td style="text-align:right; font-weight:bold;"><% If uniRS("RequiresENG4U") Then Response.Write "Yes" Else Response.Write "No" %></td>
                </tr>
                <tr>
                    <td>Requires Calculus</td>
                    <td style="text-align:right; font-weight:bold;"><% If uniRS("RequiresCalculus") Then Response.Write "Yes" Else Response.Write "No" %></td>
                </tr>
            </table>
        </div>
        
        <!-- Important Dates -->
        <div class="card">
            <h3>📅 Important Dates</h3>
            <table class="data-table">
                <tr>
                    <td>Application Deadline</td>
                    <td style="text-align:right; font-weight:bold; color:var(--danger);">
                        <% If Not IsNull(uniRS("ApplicationDeadline")) Then %>
                            <%=FormatDateTime(uniRS("ApplicationDeadline"), 2)%>
                        <% Else %>
                            January 15, 2026
                        <% End If %>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <!-- Popular Programs -->
    <div class="card">
        <h3>Popular Programs</h3>
        <p><% If Not IsNull(uniRS("PopularPrograms")) Then Response.Write uniRS("PopularPrograms") Else Response.Write "No program information available." %></p>
    </div>
    
    <!-- Programs Section -->
    <div class="card">
        <h3>Popular Programs</h3>
        <% 
            Dim progRS
            Set progRS = conn.Execute("SELECT * FROM Programs WHERE UniID=" & uniID & " ORDER BY ProgramName")
            
            If progRS.EOF Then
        %>
            <div class="alert alert-info">
                Program information not available. Visit the university website for complete program listings.
            </div>
        <% Else %>
            <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap:15px;">
                <% Do While Not progRS.EOF %>
                <div style="padding:15px; background:#f8f9fa; border-radius:8px; border-left:4px solid var(--primary);">
                    <div style="font-weight:600; color:var(--primary);"><%=progRS("ProgramName")%></div>
                    <div style="font-size:0.85rem; color:#6c757d; margin-top:5px;">
                        Min GPA: <%=progRS("MinGPA")%>
                    </div>
                </div>
                <% progRS.MoveNext: Loop %>
            </div>
        <% 
            End If
            progRS.Close
            Set progRS = Nothing
        %>
    </div>
    
    <!-- My Application Status -->
    <div class="card">
        <h3>My Application</h3>
        <% 
            Dim myAppRS
            Set myAppRS = conn.Execute("SELECT * FROM Applications WHERE StudentID=" & studentID & " AND UniID=" & uniID)
            
            If myAppRS.EOF Then
        %>
            <div class="alert alert-info">
                You have not yet applied to this university. 
                <a href="/oup/applications/add.asp?uni=<%=uniID%>" class="btn btn-primary btn-sm" style="margin-left:10px;">Start Application</a>
            </div>
        <% Else %>
            <table class="data-table">
                <tr>
                    <td><strong>Application Status</strong></td>
                    <td><span class="badge <%=GetAppStatusBadge(myAppRS("Status"))%>"><%=myAppRS("Status")%></span></td>
                </tr>
                <tr>
                    <td><strong>Program</strong></td>
                    <td>
                        <% If Not IsNull(myAppRS("ProgramID")) Then
                            Dim pRS
                            Set pRS = conn.Execute("SELECT ProgramName FROM Programs WHERE ID=" & myAppRS("ProgramID"))
                            If Not pRS.EOF Then Response.Write pRS("ProgramName")
                            pRS.Close
                            Set pRS = Nothing
                        Else
                            Response.Write "Not specified"
                        End If %>
                    </td>
                </tr>
                <tr>
                    <td><strong>Notes</strong></td>
                    <td><%=myAppRS("Notes")%></td>
                </tr>
            </table>
            <div style="margin-top:15px;">
                <a href="/oup/applications/dashboard.asp" class="btn btn-primary btn-sm">View All Applications</a>
            </div>
        <% 
            End If
            myAppRS.Close
            Set myAppRS = Nothing
        %>
    </div>
    
    <% 
        uniRS.Close
        Set uniRS = Nothing
        Call CloseConnection()
    %>

</div>

<%
    Function GetAppStatusBadge(status)
        Select Case status
            Case "Applied": GetAppStatusBadge = "badge-info"
            Case "Documents Pending": GetAppStatusBadge = "badge-warning"
            Case "Under Review": GetAppStatusBadge = "badge-primary"
            Case "Accepted": GetAppStatusBadge = "badge-success"
            Case "Rejected": GetAppStatusBadge = "badge-danger"
            Case "Waitlisted": GetAppStatusBadge = "badge-warning"
            Case Else: GetAppStatusBadge = "badge-primary"
        End Select
    End Function
%>

<!-- #include file="../includes/footer.asp" -->

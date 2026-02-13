<%
'========================================
' OSSD University Planner - Main Dashboard
' Credit progress, upcoming deadlines, quick stats
'========================================

'"--
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<% Call CheckLogin() %>

<!-- #include file="includes/header.asp" -->

<!--#include file="disclaimer.asp"-->

<div class="dashboard-grid">
<%
    Dim studentID, totalCredits, ossdGPA, top6GPA, reqStatus, reqMissing
    studentID = Session("StudentID")
    
    Call OpenConnection()
    
    ' Get credit statistics
    totalCredits = GetTotalCredits(studentID)
    ossdGPA = CalculateOSSDGPA(studentID)
    top6GPA = CalculateTop6GPA(studentID)
    
    ' Check OSSD requirements
    Dim reqCheck
    reqCheck = CheckOSSDRequirements(studentID)
    reqStatus = reqCheck(0)
    reqMissing = reqCheck(1)
%>
    
    <!-- Credit Progress Card -->
    <div class="card">
        <h2>Credit Progress</h2>
        
        <div class="progress-container">
            <div class="progress-label">
                <span>Total Credits</span>
                <span><%=totalCredits%>/30</span>
            </div>
            <div class="progress-bar">
                <div class="progress-fill <%=GetProgressClass(totalCredits, 30)%>" style="width:<%=(totalCredits/30)*100%>%">
                    <%=Round((totalCredits/30)*100, 0)%>%
                </div>
            </div>
        </div>
        
        <div class="credit-categories">
            <div class="credit-category <%=GetCategoryClass("ENG", studentID, 4)%>">
                <h4>English</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "ENG")%>/4</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("MTH", studentID, 3)%>">
                <h4>Math</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "MTH")%>/3</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("SCI", studentID, 2)%>">
                <h4>Science</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "SCI")%>/2</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("CGC", studentID, 1)%>">
                <h4>Cdn. Geo/Hist</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "CGC")%>/1</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("ART", studentID, 1)%>">
                <h4>Arts</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "ART")%>/1</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("PED", studentID, 1)%>">
                <h4>Phys Ed</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "PED")%>/1</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("FRE", studentID, 1)%>">
                <h4>French</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "FRE")%>/1</div>
            </div>
            <div class="credit-category <%=GetCategoryClass("CIV", studentID, 1)%>">
                <h4>Civics/Careers</h4>
                <div class="count"><%=CountCreditsByCategory(studentID, "CIV")%>/1</div>
            </div>
        </div>
        
        <p style="margin-top:15px;">
            <a href="/oup/ossd/credits.asp" class="btn btn-primary btn-sm">View Full Details</a>
            <a href="/oup/ossd/courses.asp" class="btn btn-success btn-sm">Add Course</a>
        </p>
    </div>
    
    <!-- GPA Summary Card -->
    <div class="card">
        <h2>GPA Summary</h2>
        
        <div class="gpa-display">
            <div class="gpa-value"><%=ossdGPA%></div>
            <div class="gpa-label">Overall GPA (4.0 Scale)</div>
        </div>
        
        <div style="text-align:center; margin-top:15px;">
            <p><strong>Top 6 U/M GPA:</strong> <%=top6GPA%></p>
            <p style="font-size:0.9rem; color:#6c757d;">Based on your highest U/M level courses</p>
        </div>
        
        <% If reqStatus Then %>
            <div class="alert alert-success mt-20">
                OK - OSSD Requirements Met! Ready for graduation.
            </div>
        <% Else %>
            <div class="alert alert-warning mt-20">
                <strong>! Requirements Incomplete</strong><br><br>
                <%=reqMissing%>
            </div>
        <% End If %>
    </div>
    
    <!-- Applications Card -->
    <div class="card">
        <h2>My Applications</h2>
        
        <%
            Dim appRS
            Set appRS = conn.Execute("SELECT TOP 5 * FROM Applications WHERE StudentID = " & studentID & " ORDER BY ID DESC")
            
            If appRS.EOF Then
        %>
            <div class="alert alert-info">
                No applications yet. <a href="/oup/applications/add.asp">Add your first application</a>.
            </div>
        <%
            Else
                Do While Not appRS.EOF
        %>
            <div style="padding:12px; border-bottom:1px solid #dee2e6;">
                <div style="font-weight:600;">Application #<%=appRS("ID")%></div>
                <div style="font-size:0.9rem; color:#6c757d;">
                    Status: <span class="badge badge-info"><%=appRS("Status")%></span>
                </div>
            </div>
        <%
                    appRS.MoveNext
                Loop
            End If
            appRS.Close
            Set appRS = Nothing
        %>
        
        <p style="margin-top:15px;">
            <a href="/oup/applications/dashboard.asp" class="btn btn-primary btn-sm">View All Applications</a>
        </p>
    </div>
    
    <!-- Quick Stats Card -->
    <div class="card">
        <h2>Quick Stats</h2>
        
        <div class="uni-stats" style="justify-content:space-around;">
            <div class="uni-stat">
                <div class="value">
                    <%
                        Dim appCountRS
                        Set appCountRS = conn.Execute("SELECT COUNT(*) FROM Applications WHERE StudentID = " & studentID)
                        Response.Write appCountRS(0)
                        appCountRS.Close
                        Set appCountRS = Nothing
                    %>
                </div>
                <div class="label">Applications</div>
            </div>
            <div class="uni-stat">
                <div class="value">
                    <%
                        Dim courseCountRS
                        Set courseCountRS = conn.Execute("SELECT COUNT(*) FROM Courses WHERE StudentID = " & studentID)
                        Response.Write courseCountRS(0)
                        courseCountRS.Close
                        Set courseCountRS = Nothing
                    %>
                </div>
                <div class="label">Courses</div>
            </div>
            <div class="uni-stat">
                <div class="value"><%=30 - totalCredits%></div>
                <div class="label">Credits Needed</div>
            </div>
            <div class="uni-stat">
                <div class="value">2026</div>
                <div class="label">Target Year</div>
            </div>
        </div>
        
        <div style="margin-top:20px; text-align:center;">
            <p><strong>Admission Chances Summary:</strong></p>
            <p style="font-size:0.9rem;">
                <span class="match-high">* High/Safe</span> 
                <span class="match-good">* Target</span> 
                <span class="match-maybe">* Reach</span>
            </p>
        </div>
    </div>

</div>

<%
    Call CloseConnection()
    
    ' Helper functions for dashboard
    Function GetProgressClass(current, max)
        Dim pct
        pct = (current / max) * 100
        If pct >= 80 Then
            GetProgressClass = "success"
        ElseIf pct >= 50 Then
            GetProgressClass = "warning"
        Else
            GetProgressClass = "danger"
        End If
    End Function
    
    Function GetCategoryClass(category, studentID, required)
        Dim current
        current = CountCreditsByCategory(studentID, category)
        If current >= required Then
            GetCategoryClass = "required"
        ElseIf current > 0 Then
            GetCategoryClass = "incomplete"
        Else
            GetCategoryClass = "missing"
        End If
    End Function
%>

<!-- #include file="includes/footer.asp" -->

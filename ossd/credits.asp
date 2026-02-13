<%
'========================================
' OSSD University Planner - Full Credit Tracker
' OSSD Requirements Checklist
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<% Call CheckLogin() %>

<!-- #include file="../includes/header.asp" -->

<div class="container">
    <h2 style="color:var(--primary); margin-bottom:20px;">OSSD Credit Tracker</h2>
    
    <% 
        Dim studentID, totalCredits, ossdGPA, reqStatus, reqMissing
        Dim engCredits, mathCredits, sciCredits, cgcCredits
        Dim artCredits, pedCredits, freCredits, civCredits
        Dim engClass, mathClass, sciClass, cgcClass
        Dim artClass, pedClass, freClass, civClass, totalClass
        
        studentID = Session("StudentID")
        
        Call OpenConnection()
        
        totalCredits = GetTotalCredits(studentID)
        ossdGPA = CalculateOSSDGPA(studentID)
        
        Dim reqCheck
        reqCheck = CheckOSSDRequirements(studentID)
        reqStatus = reqCheck(0)
        reqMissing = reqCheck(1)
        
        ' Calculate credits
        engCredits = CountCreditsByCategory(studentID, "ENG")
        mathCredits = CountCreditsByCategory(studentID, "MTH")
        sciCredits = CountCreditsByCategory(studentID, "SCI")
        cgcCredits = CountCreditsByCategory(studentID, "CGC")
        artCredits = CountCreditsByCategory(studentID, "ART")
        pedCredits = CountCreditsByCategory(studentID, "PED")
        freCredits = CountCreditsByCategory(studentID, "FRE")
        civCredits = CountCreditsByCategory(studentID, "CIV")
        
        ' Determine CSS classes
        If engCredits >= 4 Then engClass = "complete" Else engClass = "incomplete"
        If mathCredits >= 3 Then mathClass = "complete" Else mathClass = "incomplete"
        If sciCredits >= 2 Then sciClass = "complete" Else sciClass = "incomplete"
        If cgcCredits >= 1 Then cgcClass = "complete" Else cgcClass = "incomplete"
        If artCredits >= 1 Then artClass = "complete" Else artClass = "incomplete"
        If pedCredits >= 1 Then pedClass = "complete" Else pedClass = "incomplete"
        If freCredits >= 1 Then freClass = "complete" Else freClass = "incomplete"
        If civCredits >= 1 Then civClass = "complete" Else civClass = "incomplete"
        If totalCredits >= 30 Then totalClass = "complete" Else totalClass = "incomplete"
    %>
    
    <!-- Overall Progress -->
    <div class="card">
        <h3>Overall Progress</h3>
        <div class="progress-container">
            <div class="progress-label">
                <span>Total Credits Earned</span>
                <span style="font-size:1.5rem; font-weight:bold;"><%=totalCredits%>/30</span>
            </div>
            <div class="progress-bar">
                <div class="progress-fill <%=GetProgressClass(totalCredits, 30)%>" style="width:<%=(totalCredits/30)*100%>%">
                    <%=Round((totalCredits/30)*100, 0)%>% Complete
                </div>
            </div>
        </div>
        
        <div class="gpa-display" style="margin-top:20px; max-width:300px;">
            <div class="gpa-value" style="font-size:3rem;"><%=ossdGPA%></div>
            <div class="gpa-label">Current GPA (4.0 Scale)</div>
        </div>
    </div>
    
    <!-- OSSD Requirements Checklist -->
    <div class="card">
        <h3>OSSD Requirements Checklist</h3>
        <p style="margin-bottom:20px; color:#6c757d;">Complete all of the following requirements to earn your Ontario Secondary School Diploma:</p>
        
        <div style="display:grid; gap:15px;">
            
            <!-- 4 English Credits -->
            <div class="req-item <%=engClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If engCredits >= 4 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If engCredits >= 4 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">English (4 Credits)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">Mandatory for all students</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If engCredits >= 4 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=engCredits%>/4 Credits
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 3 Math Credits -->
            <div class="req-item <%=mathClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If mathCredits >= 3 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If mathCredits >= 3 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Mathematics (3 Credits)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">At least 1 U-level course for university track</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If mathCredits >= 3 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=mathCredits%>/3 Credits
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 2 Science Credits -->
            <div class="req-item <%=sciClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If sciCredits >= 2 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If sciCredits >= 2 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Science (2 Credits)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">Biology, Chemistry, Physics, etc.</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If sciCredits >= 2 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=sciCredits%>/2 Credits
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 1 Canadian Geography/History -->
            <div class="req-item <%=cgcClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If cgcCredits >= 1 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If cgcCredits >= 1 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Canadian Geography OR History (1 Credit)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">CGC1D, CHC2D, CHC2P, etc.</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If cgcCredits >= 1 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=cgcCredits%>/1 Credit
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 1 Arts Credit -->
            <div class="req-item <%=artClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If artCredits >= 1 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If artCredits >= 1 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Arts (1 Credit)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">Drama, Music, Visual Arts, Dance</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If artCredits >= 1 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=artCredits%>/1 Credit
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 1 Physical Education -->
            <div class="req-item <%=pedClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If pedCredits >= 1 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If pedCredits >= 1 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Physical Education (1 Credit)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">PPL1O, PPL2O, etc.</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If pedCredits >= 1 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=pedCredits%>/1 Credit
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 1 French Credit -->
            <div class="req-item <%=freClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If freCredits >= 1 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If freCredits >= 1 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">French (1 Credit)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">FSF1D, FSF1P (exemptions possible)</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If freCredits >= 1 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=freCredits%>/1 Credit
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Career Studies & Civics -->
            <div class="req-item <%=civClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If civCredits >= 1 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If civCredits >= 1 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Civics & Career Studies (1 Credit)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">CHV2O (0.5) + GLC2O (0.5) = 1 credit</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If civCredits >= 1 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=civCredits%>/1 Credit
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Total 30 Credits -->
            <div class="req-item <%=totalClass%>">
                <div style="display:flex; align-items:center; gap:15px; padding:15px; background:#f8f9fa; border-radius:8px; border-left:5px solid <% If totalCredits >= 30 Then Response.Write "#28a745" Else Response.Write "#ffc107" %>;">
                    <div style="font-size:2rem;"><% If totalCredits >= 30 Then Response.Write "OK" Else Response.Write "..." %></div>
                    <div style="flex:1;">
                        <div style="font-weight:600; font-size:1.1rem;">Total Credits (30 Required)</div>
                        <div style="color:#6c757d; font-size:0.9rem;">Includes 18 compulsory + 12 elective credits</div>
                        <div style="margin-top:5px;">
                            <span class="badge <% If totalCredits >= 30 Then Response.Write "badge-success" Else Response.Write "badge-warning" %>">
                                <%=totalCredits%>/30 Credits
                            </span>
                            <% If totalCredits < 30 Then %>
                                <span style="color:#dc3545; margin-left:10px;">(Need <%=30 - totalCredits%> more)</span>
                            <% End If %>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    
    <!-- Elective Credits Breakdown -->
    <div class="card">
        <h3>Elective Credits Breakdown</h3>
        <p>After completing compulsory requirements, you need 12 elective credits. Electives include all courses beyond the compulsory requirements.</p>
        
        <div style="margin-top:20px;">
            <a href="/oup/ossd/courses.asp" class="btn btn-primary">View All My Courses</a>
            <a href="/oup/ossd/courses.asp?action=add" class="btn btn-success">Add New Course</a>
        </div>
    </div>
    
    <% Call CloseConnection() %>

</div>

<%
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
%>

<!-- #include file="../includes/footer.asp" -->

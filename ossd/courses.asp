<%
'========================================
' OSSD University Planner - Courses Management
' Add/Edit courses form + list current courses
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<% Call CheckLogin() %>

<!-- #include file="../includes/header.asp" -->

<div class="container">
    <h2 style="color:var(--primary); margin-bottom:20px;">My Courses</h2>
    
    <% 
        Dim studentID, action, editID
        Dim isEditing, editCourseCode, editCourseName, editCategory
        Dim editCourseType, editCredits, editGrade, editStatus, editTerm
        
        studentID = Session("StudentID")
        action = Request("action")
        editID = Request("editid")
        
        ' Initialize edit variables
        isEditing = False
        editID = ""
        editCourseCode = ""
        editCourseName = ""
        editCategory = ""
        editCourseType = "U"
        editCredits = "1"
        editGrade = ""
        editStatus = "In Progress"
        editTerm = ""
        
        Call OpenConnection()
        
        ' Load edit data if editing
        If action = "edit" AND editID <> "" Then
            Dim editRS
            Set editRS = conn.Execute("SELECT * FROM Courses WHERE ID=" & editID & " AND StudentID=" & studentID)
            If Not editRS.EOF Then
                isEditing = True
                editID = editRS("ID")
                editCourseCode = editRS("CourseCode")
                editCourseName = editRS("CourseName")
                editCategory = editRS("Category")
                editCourseType = editRS("CourseType")
                editCredits = editRS("Credits")
                If Not IsNull(editRS("Grade")) Then editGrade = editRS("Grade")
                editStatus = editRS("Status")
                If Not IsNull(editRS("Term")) Then editTerm = editRS("Term")
            End If
            editRS.Close
        End If
    %>
    
    <!-- Add/Edit Form -->
    <div class="card">
        <h3><% If isEditing Then Response.Write "Edit Course" Else Response.Write "Add New Course" %></h3>
        
        <form method="post" action="course_save.asp">
            <input type="hidden" name="id" value="<%=editID%>">
            
            <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap:20px;">
                <div class="form-group">
                    <label>Course Code *</label>
                    <input type="text" name="coursecode" class="form-control" 
                           value="<%=editCourseCode%>" 
                           placeholder="e.g., ENG4U, MHF4U" required>
                </div>
                
                <div class="form-group">
                    <label>Course Name *</label>
                    <input type="text" name="coursename" class="form-control" 
                           value="<%=editCourseName%>" 
                           placeholder="e.g., English, Grade 12, University" required>
                </div>
                
                <div class="form-group">
                    <label>Category *</label>
                    <select name="category" class="form-control" required>
                        <option value="">Select Category</option>
                        <option value="ENG" <% If editCategory="ENG" Then Response.Write "selected" %>>English</option>
                        <option value="MTH" <% If editCategory="MTH" Then Response.Write "selected" %>>Mathematics</option>
                        <option value="SCI" <% If editCategory="SCI" Then Response.Write "selected" %>>Science</option>
                        <option value="CGC" <% If editCategory="CGC" Then Response.Write "selected" %>>Canadian Geo/History</option>
                        <option value="ART" <% If editCategory="ART" Then Response.Write "selected" %>>Arts</option>
                        <option value="PED" <% If editCategory="PED" Then Response.Write "selected" %>>Physical Education</option>
                        <option value="FRE" <% If editCategory="FRE" Then Response.Write "selected" %>>French</option>
                        <option value="CIV" <% If editCategory="CIV" Then Response.Write "selected" %>>Civics/Careers</option>
                        <option value="ELE" <% If editCategory="ELE" Then Response.Write "selected" %>>Elective</option>
                        <option value="BUS" <% If editCategory="BUS" Then Response.Write "selected" %>>Business</option>
                        <option value="SOC" <% If editCategory="SOC" Then Response.Write "selected" %>>Social Sciences</option>
                        <option value="TEC" <% If editCategory="TEC" Then Response.Write "selected" %>>Technology</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Course Type</label>
                    <select name="coursetype" class="form-control">
                        <option value="D" <% If editCourseType="D" Then Response.Write "selected" %>>D - Academic</option>
                        <option value="P" <% If editCourseType="P" Then Response.Write "selected" %>>P - Applied</option>
                        <option value="U" <% If editCourseType="U" Then Response.Write "selected" %>>U - University</option>
                        <option value="C" <% If editCourseType="C" Then Response.Write "selected" %>>C - College</option>
                        <option value="M" <% If editCourseType="M" Then Response.Write "selected" %>>M - University/College</option>
                        <option value="O" <% If editCourseType="O" Then Response.Write "selected" %>>O - Open</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Grade/Credits</label>
                    <input type="number" name="credits" class="form-control" min="0.5" max="2" step="0.5" 
                           value="<%=editCredits%>">
                </div>
                
                <div class="form-group">
                    <label>Current Mark (%)</label>
                    <input type="number" name="grade" class="form-control" min="0" max="100" 
                           value="<%=editGrade%>" 
                           placeholder="Leave blank if not completed">
                </div>
                
                <div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="In Progress" <% If editStatus="In Progress" Then Response.Write "selected" %>>In Progress</option>
                        <option value="Completed" <% If editStatus="Completed" Then Response.Write "selected" %>>Completed</option>
                        <option value="Planned" <% If editStatus="Planned" Then Response.Write "selected" %>>Planned</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Term/Semester</label>
                    <input type="text" name="term" class="form-control" 
                           value="<%=editTerm%>" 
                           placeholder="e.g., Fall 2025">
                </div>
            </div>
            
            <div class="form-group" style="margin-top:20px;">
                <button type="submit" class="btn btn-primary">
                    <% If isEditing Then Response.Write "Update Course" Else Response.Write "Add Course" %>
                </button>
                <a href="/oup/ossd/courses.asp" class="btn btn-warning">Cancel</a>
            </div>
        </form>
    </div>
    
    <!-- Course List -->
    <div class="card">
        <h3>My Course List</h3>
        
        <% 
            Dim courseRS
            Set courseRS = conn.Execute("SELECT * FROM Courses WHERE StudentID=" & studentID & " ORDER BY Year DESC, Term, CourseCode")
            
            If courseRS.EOF Then
        %>
            <div class="alert alert-info">
                <p>No courses added yet. Use the form above to add your first course.</p>
                <p style="margin-top:10px;"><strong>Popular Grade 12 Courses:</strong></p>
                <ul style="margin-left:20px; margin-top:5px;">
                    <li>ENG4U - English, Grade 12, University</li>
                    <li>MHF4U - Advanced Functions</li>
                    <li>MCV4U - Calculus & Vectors</li>
                    <li>SBI4U - Biology</li>
                    <li>SCH4U - Chemistry</li>
                    <li>SPH4U - Physics</li>
                </ul>
            </div>
        <% Else %>
            <div style="overflow-x:auto;">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Course</th>
                            <th>Category</th>
                            <th>Type</th>
                            <th>Credits</th>
                            <th>Grade</th>
                            <th>Status</th>
                            <th>Term</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% Do While Not courseRS.EOF %>
                        <tr>
                            <td>
                                <strong><%=courseRS("CourseCode")%></strong><br>
                                <small><%=courseRS("CourseName")%></small>
                            </td>
                            <td><span class="badge badge-info"><%=GetCategoryName(courseRS("Category"))%></span></td>
                            <td><%=courseRS("CourseType")%> - <%=GetTypeName(courseRS("CourseType"))%></td>
                            <td><%=courseRS("Credits")%></td>
                            <td>
                                <% If Not IsNull(courseRS("Grade")) Then %>
                                    <strong><%=courseRS("Grade")%>%</strong>
                                <% Else %>
                                    <em>-</em>
                                <% End If %>
                            </td>
                            <td>
                                <span class="badge <%=GetStatusBadge(courseRS("Status"))%>">
                                    <%=courseRS("Status")%>
                                </span>
                            </td>
                            <td><% If Not IsNull(courseRS("Term")) Then Response.Write courseRS("Term") Else Response.Write "-" %></td>
                            <td>
                                <a href="/oup/ossd/courses.asp?action=edit&editid=<%=courseRS("ID")%>" class="btn btn-sm btn-primary">Edit</a>
                                <a href="/oup/ossd/course_save.asp?action=delete&id=<%=courseRS("ID")%>" 
                                   class="btn btn-sm btn-danger" 
                                   onclick="return confirm('Are you sure you want to delete this course?')">Delete</a>
                            </td>
                        </tr>
                        <% courseRS.MoveNext: Loop %>
                    </tbody>
                </table>
            </div>
        <% 
            End If
            courseRS.Close
            Set courseRS = Nothing
        %>
    </div>
    
    <% Call CloseConnection() %>

</div>

<%
    Function GetCategoryName(cat)
        Select Case cat
            Case "ENG": GetCategoryName = "English"
            Case "MTH": GetCategoryName = "Math"
            Case "SCI": GetCategoryName = "Science"
            Case "CGC": GetCategoryName = "Cdn. Geo/Hist"
            Case "ART": GetCategoryName = "Arts"
            Case "PED": GetCategoryName = "Phys Ed"
            Case "FRE": GetCategoryName = "French"
            Case "CIV": GetCategoryName = "Civics/Careers"
            Case "ELE": GetCategoryName = "Elective"
            Case "BUS": GetCategoryName = "Business"
            Case "SOC": GetCategoryName = "Social Science"
            Case "TEC": GetCategoryName = "Technology"
            Case Else: GetCategoryName = cat
        End Select
    End Function
    
    Function GetTypeName(t)
        Select Case t
            Case "D": GetTypeName = "Academic"
            Case "P": GetTypeName = "Applied"
            Case "U": GetTypeName = "University"
            Case "C": GetTypeName = "College"
            Case "M": GetTypeName = "University/College"
            Case "O": GetTypeName = "Open"
            Case Else: GetTypeName = t
        End Select
    End Function
    
    Function GetStatusBadge(s)
        Select Case s
            Case "Completed": GetStatusBadge = "badge-success"
            Case "In Progress": GetStatusBadge = "badge-warning"
            Case "Planned": GetStatusBadge = "badge-info"
            Case Else: GetStatusBadge = "badge-primary"
        End Select
    End Function
%>

<!-- #include file="../includes/footer.asp" -->

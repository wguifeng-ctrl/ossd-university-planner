<%
'========================================
' OSSD University Planner - Universities List
' Search and filter 22 Ontario universities
'========================================

'"--
%>
<!-- #include file="../includes/db_conn.asp" -->
<!-- #include file="../includes/functions.asp" -->
<% Call CheckLogin() %>

<!-- #include file="../includes/header.asp" -->

<div class="container">
    <!--#include file="../disclaimer.asp"-->
    
    <h2 style="color:var(--primary); margin-bottom:20px;">Ontario Universities</h2>
    
    <% 
        ' Pre-calculate selected states
        Dim locSelectedToronto, locSelectedHamilton, locSelectedOttawa, locSelectedLondon
        Dim locSelectedWaterloo, locSelectedKingston, locSelectedWindsor, locSelectedGuelph
        Dim gpaSelected38, gpaSelected35, gpaSelected30, gpaSelected27
        
        If Request("location") = "Toronto" Then locSelectedToronto = "selected" 
        If Request("location") = "Hamilton" Then locSelectedHamilton = "selected"
        If Request("location") = "Ottawa" Then locSelectedOttawa = "selected"
        If Request("location") = "London" Then locSelectedLondon = "selected"
        If Request("location") = "Waterloo" Then locSelectedWaterloo = "selected"
        If Request("location") = "Kingston" Then locSelectedKingston = "selected"
        If Request("location") = "Windsor" Then locSelectedWindsor = "selected"
        If Request("location") = "Guelph" Then locSelectedGuelph = "selected"
        
        If Request("mingpa") = "3.8" Then gpaSelected38 = "selected"
        If Request("mingpa") = "3.5" Then gpaSelected35 = "selected"
        If Request("mingpa") = "3.0" Then gpaSelected30 = "selected"
        If Request("mingpa") = "2.7" Then gpaSelected27 = "selected"
    %>
    
    <!-- Search/Filter Section -->
    <div class="card">
        <form method="get" action="/oup/universities/list.asp" style="display:flex; gap:15px; flex-wrap:wrap; align-items:flex-end;">
            <div class="form-group" style="flex:1; min-width:200px;">
                <label>Search</label>
                <input type="text" name="search" class="form-control" 
                       value="<%=Request("search")%>" 
                       placeholder="University name or city...">
            </div>
            <div class="form-group" style="min-width:150px;">
                <label>Location</label>
                <select name="location" class="form-control">
                    <option value="">All Ontario</option>
                    <option value="Toronto" <%=locSelectedToronto%>>Toronto</option>
                    <option value="Hamilton" <%=locSelectedHamilton%>>Hamilton</option>
                    <option value="Ottawa" <%=locSelectedOttawa%>>Ottawa</option>
                    <option value="London" <%=locSelectedLondon%>>London</option>
                    <option value="Waterloo" <%=locSelectedWaterloo%>>Waterloo</option>
                    <option value="Kingston" <%=locSelectedKingston%>>Kingston</option>
                    <option value="Windsor" <%=locSelectedWindsor%>>Windsor</option>
                    <option value="Guelph" <%=locSelectedGuelph%>>Guelph</option>
                </select>
            </div>
            <div class="form-group" style="min-width:150px;">
                <label>Min GPA</label>
                <select name="mingpa" class="form-control">
                    <option value="">Any</option>
                    <option value="3.8" <%=gpaSelected38%>>3.8+ (Elite)</option>
                    <option value="3.5" <%=gpaSelected35%>>3.5+</option>
                    <option value="3.0" <%=gpaSelected30%>>3.0+</option>
                    <option value="2.7" <%=gpaSelected27%>>2.7+</option>
                </select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Filter</button>
                <a href="/oup/universities/list.asp" class="btn btn-warning">Clear</a>
            </div>
        </form>
    </div>
    
    <% 
        Dim studentID, studentGPA
        studentID = Session("StudentID")
        
        Call OpenConnection()
        studentGPA = CalculateTop6GPA(studentID)
    %>
    
    <!-- My GPA Display -->
    <div class="card" style="background:linear-gradient(135deg, #003366 0%, #004d99 100%); color:white;">
        <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:20px;">
            <div>
                <h3 style="color:white; margin:0;">Your Profile</h3>
                <p style="margin:5px 0 0 0; opacity:0.9;">Top 6 U/M GPA: <strong><%=studentGPA%></strong></p>
            </div>
            <div style="text-align:right;">
                <span class="badge" style="background:rgba(255,255,255,0.2); color:white;">Applications: 
                    <% 
                        Dim appCountRS
                        Set appCountRS = conn.Execute("SELECT COUNT(*) FROM Applications WHERE StudentID=" & studentID)
                        Response.Write appCountRS(0)
                        appCountRS.Close
                        Set appCountRS = Nothing
                    %>
                </span>
            </div>
        </div>
    </div>
    
    <!-- Universities Grid -->
    <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap:20px; margin-top:20px;">
        <% 
            ' Build query with filters
            Dim sql, whereClause
            sql = "SELECT * FROM Universities"
            whereClause = ""
            
            If Request("search") <> "" Then
                whereClause = whereClause & " AND (Name LIKE '%" & SafeSQL(Request("search")) & "%' OR Location LIKE '%" & SafeSQL(Request("search")) & "%')"
            End If
            
            If Request("location") <> "" Then
                whereClause = whereClause & " AND Location LIKE '%" & SafeSQL(Request("location")) & "%'"
            End If
            
            If Request("mingpa") <> "" Then
                whereClause = whereClause & " AND MinGPA >= " & Request("mingpa")
            End If
            
            If whereClause <> "" Then
                sql = sql & " WHERE " & Mid(whereClause, 6)
            End If
            
            sql = sql & " ORDER BY Name"
            
            Dim uniRS
            Set uniRS = conn.Execute(sql)
            
            If uniRS.EOF Then
        %>
            <div class="card" style="grid-column:1/-1;">
                <div class="alert alert-info">
                    No universities found matching your criteria. 
                    <a href="/oup/universities/init_universities.asp">Initialize university database</a> if no data exists.
                </div>
            </div>
        <% Else
            Do While Not uniRS.EOF
                Dim matchScore, matchText
                matchScore = GetMatchScore(studentGPA, uniRS("MinGPA"))
                matchText = PredictAdmission(studentGPA, uniRS("MinGPA"))
        %>
            <div class="uni-card">
                <h3><a href="/oup/universities/detail.asp?id=<%=uniRS("ID")%>" style="color:var(--primary); text-decoration:none;"><%=uniRS("Name")%></a></h3>
                <p style="color:#6c757d; margin-bottom:10px;">
                    <%=uniRS("Location")%>
                </p>
                
                <div class="uni-stats">
                    <div class="uni-stat">
                        <div class="value"><%=uniRS("MinGPA")%></div>
                        <div class="label">Min GPA</div>
                    </div>
                    <div class="uni-stat">
                        <div class="value"><%=uniRS("CompetitiveGPA")%></div>
                        <div class="label">Competitive</div>
                    </div>
                    <div class="uni-stat">
                        <div class="value"><%=uniRS("Ranking")%></div>
                        <div class="label">Ranking</div>
                    </div>
                    <div class="uni-stat">
                        <div class="value" style="font-size:1.2rem;"><%=matchScore%>%</div>
                        <div class="label">Match</div>
                    </div>
                </div>
                
                <div style="margin-top:15px;">
                    <span style="font-size:0.9rem;">Admission Chance: <%=matchText%></span>
                </div>
                
                <div style="margin-top:15px;">
                    <a href="/oup/universities/detail.asp?id=<%=uniRS("ID")%>" class="btn btn-primary btn-sm">View Details</a>
                    <a href="/oup/applications/add.asp?uni=<%=uniRS("ID")%>" class="btn btn-success btn-sm">Apply</a>
                </div>
            </div>
        <% 
                uniRS.MoveNext
            Loop
           End If
           uniRS.Close
           Set uniRS = Nothing
        %>
    </div>
    
    <div style="text-align:center; margin-top:30px;">
        <a href="/oup/universities/init_universities.asp" class="btn btn-warning">Refresh University Data</a>
    </div>
    
    <% Call CloseConnection() %>

</div>

<!-- #include file="../includes/footer.asp" -->

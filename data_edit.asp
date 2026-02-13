<%
'========================================
' OSSD University Planner - Quick Data Editor
'========================================
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<!-- #include file="includes/header.asp" -->

<div class="container">
    <h1 style="color:var(--primary); margin-bottom:20px;">Edit University Data</h1>
    
    <% 
    Dim editUniID, editRS
    editUniID = Request("id")
    
    If editUniID = "" Then
        Response.Redirect "/oup/universities/list.asp"
    End If
    
    Call OpenConnection()
    
    ' Handle POST
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        ' Build checkbox values using native If/Then (IIf not supported in VBScript)
        Dim eng4uVal, calcVal
        If Request.Form("req_eng4u") = "on" Then
            eng4uVal = "-1"
        Else
            eng4uVal = "0"
        End If
        If Request.Form("req_calc") = "on" Then
            calcVal = "-1"
        Else
            calcVal = "0"
        End If
        
        Dim sqlUpdate
        sqlUpdate = "UPDATE Universities SET MinGPA=" & Request.Form("min_gpa")
        sqlUpdate = sqlUpdate & ", CompetitiveGPA=" & Request.Form("comp_gpa")
        sqlUpdate = sqlUpdate & ", ApplicationDeadline=#" & Request.Form("deadline") & "#"
        sqlUpdate = sqlUpdate & ", RequiresENG4U=" & eng4uVal
        sqlUpdate = sqlUpdate & ", RequiresCalculus=" & calcVal
        sqlUpdate = sqlUpdate & ", PopularPrograms='" & SafeSQL(Request.Form("popular_programs")) & "'"
        sqlUpdate = sqlUpdate & " WHERE ID=" & editUniID
        
        On Error Resume Next
        conn.Execute sqlUpdate
        If Err.Number = 0 Then
            Response.Write "<div class='alert alert-success'>OK: Data saved at " & Now() & "</div>"
        Else
            Response.Write "<div class='alert alert-danger'>Error: " & Err.Description & "</div>"
        End If
        On Error GoTo 0
    End If
    
    Set editRS = conn.Execute("SELECT * FROM Universities WHERE ID=" & editUniID)
    
    If editRS.EOF Then
        editRS.Close
        Call CloseConnection()
        Response.Redirect "/oup/universities/list.asp"
    End If
    %>
    
    <div class="card" style="background: #fff3cd; border-left: 5px solid #ffc107; margin-bottom: 20px;">
        Please verify data from official university website before updating.
    </div>

    <form method="post" action="data_edit.asp?id=<%=editUniID%>">
        <div class="card">
            <h3><%=editRS("Name")%></h3>
            <p>OUAC: <%=editRS("OUACCode")%></p>
            <a href="<%=editRS("Website")%>" target="_blank" class="btn btn-sm btn-primary">Official Website</a>
        </div>

        <div class="card">
            <div class="form-group">
                <label>Minimum GPA</label>
                <input type="number" name="min_gpa" class="form-control" step="0.1" min="0" max="4" 
                       value="<%=editRS("MinGPA")%>">
            </div>
            <div class="form-group">
                <label>Competitive GPA</label>
                <input type="number" name="comp_gpa" class="form-control" step="0.1" min="0" max="4" 
                       value="<%=editRS("CompetitiveGPA")%>">
            </div>
            <div class="form-group">
                <label>Deadline</label>
                <input type="date" name="deadline" class="form-control" 
                       value="<%=FormatDateTime(editRS("ApplicationDeadline"), 2)%>">
            </div>
            <div class="form-group">
                <label><input type="checkbox" name="req_eng4u" <% If editRS("RequiresENG4U") Then Response.Write "checked" %>> Requires ENG4U</label>
            </div>
            <div class="form-group">
                <label><input type="checkbox" name="req_calc" <% If editRS("RequiresCalculus") Then Response.Write "checked" %>> Requires Calculus</label>
            </div>
            <div class="form-group">
                <label>Popular Programs</label>
                <textarea name="popular_programs" class="form-control" rows="3"><% If Not IsNull(editRS("PopularPrograms")) Then Response.Write editRS("PopularPrograms") %></textarea>
            </div>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <button type="submit" class="btn btn-success btn-lg">Save</button>
            <a href="/oup/universities/detail.asp?id=<%=editUniID%>" class="btn btn-primary btn-lg">View</a>
        </div>
    </form>
    
    <% 
    editRS.Close
    Set editRS = Nothing
    Call CloseConnection()
    %>
</div>

<!-- #include file="includes/footer.asp" -->

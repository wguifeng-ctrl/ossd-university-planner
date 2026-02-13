<%@ Language=VBScript %>
<!--#include file="../includes/db_conn.asp"-->
<!--#include file="../includes/functions.asp"-->
<% CheckLogin() %>
<!--#include file="../includes/header.asp"-->

<%
Dim studentID, uniID, progID
dim gpa
studentID = Session("StudentID")
uniID = Request("uni")
progID = Request("prog")

Call OpenConnection()
gpa = CalculateOSSDGPA(studentID)
%>

<div class="card">
    <h2>➕ Add New Application</h2>
    
    <form method="post" action="save.asp">
        <input type="hidden" name="action" value="add">
        
        <div class="form-group">
            <label>University</label>
            <select name="university" class="form-control" required onchange="loadPrograms(this.value)">
                <option value="">Select University</option>
                <% 
                Dim rsUnis
                Set rsUnis = conn.Execute("SELECT * FROM Universities ORDER BY Name")
                Do While Not rsUnis.EOF
                    Dim selected : selected = ""
                    If CStr(rsUnis("ID")) = CStr(uniID) Then selected = "selected"
                %>
                    <option value="<%=rsUnis("ID")%>" <%=selected%>><%=rsUnis("Name")%></option>
                <% rsUnis.MoveNext : Loop
                rsUnis.Close
                %>
            </select>
        </div>
        
        <div class="form-group">
            <label>Program</label>
            <select name="program" id="programSelect" class="form-control">
                <option value="">Select or Type Custom Program</option>
                <% If uniID <> "" Then
                    Dim rsProgs
                    Set rsProgs = conn.Execute("SELECT * FROM Programs WHERE UniID=" & uniID & " ORDER BY ProgramName")
                    Do While Not rsProgs.EOF
                        Dim pselected : pselected = ""
                        If CStr(rsProgs("ID")) = CStr(progID) Then pselected = "selected"
                %>
                    <option value="<%=rsProgs("ID")%>" <%=pselected%>><%=rsProgs("ProgramName")%></option>
                <% rsProgs.MoveNext : Loop
                    rsProgs.Close
                End If %>
            </select>
        </div>
        
        <div class="form-group">
            <label>Status</label>
            <select name="status" class="form-control">
                <option value="Draft">Draft</option>
                <option value="In Progress">In Progress</option>
                <option value="Ready to Submit">Ready to Submit</option>
                <option value="Submitted">Submitted</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Notes</label>
            <textarea name="notes" class="form-control" rows="3" placeholder="Any special notes about this application..."></textarea>
        </div>
        
        <div class="form-group" style="text-align:center;">
            <button type="submit" class="btn btn-success">Add Application</button>
            <a href="/oup/applications/dashboard.asp" class="btn btn-warning">Cancel</a>
        </div>
    </form>
</div>

<div class="card">
    <h2>💡 Quick University Matcher</h2>
    <p>Based on your GPA (<%=FormatNumber(gpa,2)%>), here are your best matches:</p>
    
    <div class="dashboard-grid">
    <% 
    Dim rsMatch
    Set rsMatch = conn.Execute("SELECT TOP 5 * FROM Universities ORDER BY Abs(MinGPA - " & gpa & ")")
    Do While Not rsMatch.EOF
    %>
        <div class="uni-card" style="padding:15px;">
            <h4><%=rsMatch("Name")%></h4>
            <p>Min GPA: <%=rsMatch("MinGPA")%></p>
            <p><%=PredictAdmission(gpa, rsMatch("MinGPA"))%></p>
            <a href="/oup/applications/add.asp?uni=<%=rsMatch("ID")%>" class="btn btn-sm btn-primary">Select</a>
        </div>
    <% rsMatch.MoveNext : Loop
    rsMatch.Close
    CloseConnection()
    %>
    </div>
</div>

<script>
function loadPrograms(uniID) {
    if (!uniID) return;
    // Simple reload to populated programs - in production would use AJAX
    window.location.href = '/oup/applications/add.asp?uni=' + uniID;
}
</script>

<!--#include file="../includes/footer.asp"-->

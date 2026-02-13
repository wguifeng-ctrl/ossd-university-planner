<%@ Language=VBScript %>
<!--#include file="../includes/db_conn.asp"-->
<!--#include file="../includes/functions.asp"-->
<% CheckLogin() %>
<!--#include file="../includes/header.asp"-->

<%
Dim studentID, appID, section, sections(5), sectionNames(5), prompts(5)
studentID = Session("StudentID")
appID = Request("app")
section = Request("section")

If appID = "" Then Response.Redirect "/oup/applications/dashboard.asp"

sections(0) = "hook"
sectionNames(0) = "1. Opening Hook"
prompts(0) = "Use an engaging opening to capture the admission officer's attention. This could be a personal story, a challenge, a moment of insight, or an experience related to your chosen field." & vbCrLf & vbCrLf & "Tips: " & vbCrLf & "- Avoid cliches (I always wanted to be a doctor since childhood)" & vbCrLf & "- Show rather than tell - use specific details" & vbCrLf & "- Target 100-150 words"

sections(1) = "academic"
sectionNames(1) = "2. Academic Interest"
prompts(1) = "Explain how your academic interest in the chosen field developed. Describe relevant learning experiences, books read, projects or research participated in." & vbCrLf & vbCrLf & "Tips: " & vbCrLf & "- Connect to specific courses or teachers who influenced you" & vbCrLf & "- Demonstrate deep understanding of the field" & vbCrLf & "- Mention relevant OSSD courses (ENG4U, MHF4U, etc.)" & vbCrLf & "- Target 200-250 words"

sections(2) = "experience"
sectionNames(2) = "3. Relevant Experience"
prompts(2) = "Describe experiences that support your application: volunteering, internships, clubs, competitions, projects. Emphasize skills learned and personal growth." & vbCrLf & vbCrLf & "Tips: " & vbCrLf & "- Use STAR method: Situation-Task-Action-Result" & vbCrLf & "- Quantify achievements (organized 50-person event, raised $2000)" & vbCrLf & "- Highlight leadership and initiative" & vbCrLf & "- Target 200-250 words"

sections(3) = "career"
sectionNames(3) = "4. Career Goals"
prompts(3) = "How will this degree help you achieve short-term and long-term career goals? What impact do you want to make on society?" & vbCrLf & vbCrLf & "Tips: " & vbCrLf & "- Be specific rather than vague (avoid make the world better)" & vbCrLf & "- Connect to university resources (programs, labs, professors)" & vbCrLf & "- Show understanding of the industry" & vbCrLf & "- Target 150-200 words"

sections(4) = "conclusion"
sectionNames(4) = "5. Conclusion"
prompts(4) = "Leave a lasting impression on the admission officer. Summarize your core message and reaffirm why you are a good fit for this program." & vbCrLf & vbCrLf & "Tips: " & vbCrLf & "- Return to opening theme to create connection" & vbCrLf & "- Look to the future with confidence" & vbCrLf & "- Be confident but not arrogant" & vbCrLf & "- Target around 100 words"

sections(5) = "final"
sectionNames(5) = "6. Final Review"
prompts(5) = "Review the complete personal statement for coherence and word count. Recommended total length: 800-1000 words."

If section = "" Then section = "hook"

Call OpenConnection()

Dim rsApp
Set rsApp = conn.Execute("SELECT a.*, u.Name AS UniName, p.ProgramName FROM (Applications a LEFT JOIN Universities u ON a.UniID = u.ID) LEFT JOIN Programs p ON a.ProgramID = p.ID WHERE a.ID=" & appID & " AND a.StudentID=" & studentID)

If rsApp.EOF Then
    rsApp.Close
    CloseConnection()
    Response.Redirect "/oup/applications/dashboard.asp"
End If

Dim currentContent
currentContent = GetSectionContent(appID, section)

Function GetSectionContent(aid, sec)
    Dim rs
    Set rs = conn.Execute("SELECT Content FROM PersonalStatements WHERE ApplicationID=" & aid & " AND SectionName='" & sec & "' ORDER BY Version DESC")
    If Not rs.EOF Then
        GetSectionContent = rs("Content")
    Else
        GetSectionContent = ""
    End If
    rs.Close
    Set rs = Nothing
End Function
%>

<script>
function wordCount(str) {
    return str.trim().split(/\s+/).filter(function(n) { return n !== '' }).length;
}
function updateCount() {
    var text = document.getElementById('psContent').value;
    var count = wordCount(text);
    document.getElementById('wordCount').innerText = count + ' words';
    if (count < 50) {
        document.getElementById('wordCount').style.color = '#dc3545';
    } else if (count > 300) {
        document.getElementById('wordCount').style.color = '#ffc107';
    } else {
        document.getElementById('wordCount').style.color = '#28a745';
    }
}
</script>

<div class="card">
    <h2>Personal Statement Editor</h2>
    <p><strong>Application:</strong> <%=rsApp("UniName")%> - <%=rsApp("ProgramName")%><br>
    <strong>Status:</strong> <%=rsApp("Status")%></p>
</div>

<div class="ps-wizard">
    <div class="step-nav">
        <% For i = 0 To 5 %>
            <a href="?app=<%=appID%>&section=<%=sections(i)%>" class="<% If sections(i) = section Then Response.Write "active" %>">
                <%=i+1%>. <%=sectionNames(i)%>
            </a>
        <% Next %>
    </div>
    
    <% If section = "final" Then %>
        <div class="card">
            <h3>Complete Personal Statement</h3>
            <div style="background:#f8f9fa; padding:25px; border-radius:8px; line-height:1.8; font-family:Georgia,serif;">
                <% For i = 0 To 4 %>
                    <div style="margin-bottom:30px; border-left:3px solid #003366; padding-left:15px;">
                        <h4 style="color:#003366; margin-bottom:10px;"><%=sectionNames(i)%></h4>
                        <div><%=Replace(GetSectionContent(appID, sections(i)), vbCrLf, "<br>")%></div>
                    </div>
                <% Next %>
            </div>
            <div style="text-align:center; margin-top:20px;">
                <a href="/oup/applications/ps_save.asp?app=<%=appID%>&action=finalize" class="btn btn-success" onclick="return confirm('Mark this PS as final version?')">Mark as Final</a>
                <a href="/oup/applications/dashboard.asp" class="btn btn-primary">Back to Dashboard</a>
            </div>
        </div>
    <% Else %>
        <div class="card">
            <h3><%=sectionNames(GetSectionIndex(section))%></h3>
            <div class="alert alert-info" style="margin-bottom:20px;">
                <strong>Writing Guide:</strong><br>
                <pre style="background:none; margin:0; white-space:pre-wrap; font-family:inherit;"><%=prompts(GetSectionIndex(section))%></pre>
            </div>
            <form method="post" action="/oup/applications/ps_save.asp">
                <input type="hidden" name="appID" value="<%=appID%>">
                <input type="hidden" name="section" value="<%=section%>">
                <div class="form-group">
                    <label>Your Writing <span id="wordCount" style="float:right; font-weight:bold;">0 words</span></label>
                    <textarea name="content" id="psContent" class="form-control ps-textarea" onkeyup="updateCount()" placeholder="Start writing here..."><%=Server.HTMLEncode(currentContent)%></textarea>
                </div>
                <div style="display:flex; gap:10px; justify-content:center;">
                    <button type="submit" class="btn btn-primary">Save Draft</button>
                    <% Dim prevSec, nextSec
                    prevSec = GetPrevSection(section)
                    nextSec = GetNextSection(section)
                    If prevSec <> "" Then %>
                        <a href="?app=<%=appID%>&section=<%=prevSec%>" class="btn btn-warning">Previous</a>
                    <% End If
                    If nextSec <> "" Then %>
                        <a href="?app=<%=appID%>&section=<%=nextSec%>" class="btn btn-success">Next</a>
                    <% End If %>
                </div>
            </form>
        </div>
        <div class="card">
            <h4>Version History for This Section</h4>
            <table class="data-table">
                <thead>
                    <tr><th>Version</th><th>Date</th><th>Preview</th></tr>
                </thead>
                <tbody>
                <%
                Dim rsVersions
                Set rsVersions = conn.Execute("SELECT * FROM PersonalStatements WHERE ApplicationID=" & appID & " AND SectionName='" & section & "' ORDER BY Version DESC")
                If rsVersions.EOF Then
                    Response.Write "<tr><td colspan='3' style='text-align:center;'>No saved versions yet.</td></tr>"
                Else
                    Do While Not rsVersions.EOF
                %>
                    <tr>
                        <td>v<%=rsVersions("Version")%></td>
                        <td><%=FormatDateTime(rsVersions("LastModified"), 2)%></td>
                        <td><%=Truncate(rsVersions("Content"), 80)%></td>
                    </tr>
                <% 
                        rsVersions.MoveNext
                    Loop
                End If
                rsVersions.Close
                %>
                </tbody>
            </table>
        </div>
    <% End If %>
</div>

<%
Function GetSectionIndex(sec)
    For i = 0 To 5
        If sections(i) = sec Then
            GetSectionIndex = i
            Exit Function
        End If
    Next
    GetSectionIndex = 0
End Function

Function GetNextSection(sec)
    For i = 0 To 4
        If sections(i) = sec Then
            GetNextSection = sections(i+1)
            Exit Function
        End If
    Next
    GetNextSection = ""
End Function

Function GetPrevSection(sec)
    For i = 1 To 5
        If sections(i) = sec Then
            GetPrevSection = sections(i-1)
            Exit Function
        End If
    Next
    GetPrevSection = ""
End Function

rsApp.Close
CloseConnection()
%>

<script>updateCount();</script>

<!--#include file="../includes/footer.asp"-->

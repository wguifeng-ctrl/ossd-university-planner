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

' Section definitions
sections(0) = "hook": sectionNames(0) = "1. Opening Hook (引言)"
prompts(0) = "用一个吸引人的开场抓住招生官的注意力。可以是一个个人故事、一个挑战、一个顿悟时刻，或者一个与你选择专业相关的经历。" & vbCrLf & vbCrLf & _
             "💡 Tips: " & vbCrLf & _
             "• 避免陈词滥调（从小就想当医生）" & vbCrLf & _
             "• 展示而非告知 - 用具体细节" & vbCrLf & _
             "• 100-150词为宜"

sections(1) = "academic": sectionNames(1) = "2. Academic Interest (学术兴趣)"
prompts(1) = "阐述你对所选专业的学术兴趣是如何产生的。描述相关的学习经历、读过的书、参加的项目或研究。" & vbCrLf & vbCrLf & _
             "💡 Tips: " & vbCrLf & _
             "• 连接具体课程或老师的影响" & vbCrLf & _
             "• 展示你对领域的深入理解" & vbCrLf & _
             "• 提及OSSD相关课程（如ENG4U、MHF4U等）" & vbCrLf & _
             "• 200-250词"

sections(2) = "experience": sectionNames(2) = "3. Relevant Experience (相关经历)"
prompts(2) = "描述支持申请的经历：义工、实习、社团、竞赛、项目等。强调你学到的技能和成长。" & vbCrLf & vbCrLf & _
             "💡 Tips: " & vbCrLf & _
             "• 使用STAR法则：情境-任务-行动-结果" & vbCrLf & _
             "• 量化成果（组织了50人活动，筹款$2000）" & vbCrLf & _
             "• 突出领导力和主动性" & vbCrLf & _
             "• 200-250词"

sections(3) = "career": sectionNames(3) = "4. Career Goals (职业目标)"
prompts(3) = "这个学位如何帮助你实现短期和长期职业目标？你想为社会带来什么影响？" & vbCrLf & vbCrLf & _
             "💡 Tips: " & vbCrLf & _
             "• 具体而非笼统（不说'让世界更好'）" & vbCrLf & _
             "• 连接大学资源（特定项目、实验室、教授）" & vbCrLf & _
             "• 展示对行业的了解" & vbCrLf & _
             "• 150-200词"

sections(4) = "conclusion": sectionNames(4) = "5. Conclusion (结尾)"
prompts(4) = "给招生官留下深刻印象的收尾。总结你的核心观点，重申你为什么适合这个项目。" & vbCrLf & vbCrLf & _
             "💡 Tips: " & vbCrLf & _
             "• 回到开头的主题，形成呼应" & vbCrLf & _
             "• 展望未来，表达期待" & vbCrLf & _
             "• 坚定而有信心，但不傲慢" & vbCrLf & _
             "• 100词左右"

sections(5) = "final": sectionNames(5) = "6. Final Review (完整预览)"
prompts(5) = "查看完整的个人陈述，检查连贯性和字数。建议总字数控制在800-1000词。"

If section = "" Then section = "hook"

Call OpenConnection()

' Verify application belongs to student
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
    <h2>✍️ Personal Statement Editor</h2>
    <p><strong>Application:</strong> <%=rsApp("UniName")%> - <%=rsApp("ProgramName")%><br>
    <strong>Status:</strong> <%=rsApp("Status")%></p>
</div>

<div class="ps-wizard">
    <!-- Section Navigation -->
    <div class="step-nav">
        <% For i = 0 To 5 %>
            <a href="?app=<%=appID%>&section=<%=sections(i)%>" class="<% If sections(i) = section Then Response.Write "active" %>">
                <%=i+1%>. <%=sectionNames(i)%>
            </a>
        <% Next %>
    </div>
    
    <% If section = "final" Then %>
        <!-- Final Review -->
        <div class="card">
            <h3>📄 Complete Personal Statement</h3>
            <div style="background:#f8f9fa; padding:25px; border-radius:8px; line-height:1.8; font-family:Georgia,serif;">
                <% For i = 0 To 4 %>
                    <div style="margin-bottom:30px; border-left:3px solid #003366; padding-left:15px;">
                        <h4 style="color:#003366; margin-bottom:10px;"><%=sectionNames(i)%></h4>
                        <div><%=Replace(GetSectionContent(appID, sections(i)), vbCrLf, "<br>")%></div>
                    </div>
                <% Next %>
            </div>
            
            <div style="text-align:center; margin-top:20px;">
                <a href="/oup/applications/ps_save.asp?app=<%=appID%>&action=finalize" class="btn btn-success" onclick="return confirm('Mark this PS as final version?')">✓ Mark as Final</a>
                <a href="/oup/applications/dashboard.asp" class="btn btn-primary">Back to Dashboard</a>
            </div>
        </div>
    <% Else %>
        <!-- Section Editor -->
        <div class="card">
            <h3><%=sectionNames(GetSectionIndex(section))%></h3>
            
            <div class="alert alert-info" style="margin-bottom:20px;">
                <strong>💡 Writing Guide:</strong><br>
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
                    <button type="submit" class="btn btn-primary">💾 Save Draft</button>
                    
                    <% Dim prevSec, nextSec
                    prevSec = GetPrevSection(section)
                    nextSec = GetNextSection(section)
                    If prevSec <> "" Then %>
                        <a href="?app=<%=appID%>&section=<%=prevSec%>" class="btn btn-warning">← Previous</a>
                    <% End If
                    If nextSec <> "" Then %>
                        <a href="?app=<%=appID%>&section=<%=nextSec%>" class="btn btn-success">Next →</a>
                    <% End If %>
                </div>
            </form>
        </div>
        
        <!-- Version History -->
        <div class="card">
            <h4>📝 Version History for This Section</h4>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Version</th>
                        <th>Date</th>
                        <th>Preview</th>
                    </tr>
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

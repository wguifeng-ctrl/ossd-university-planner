<%
'========================================
' OSSD University Planner - Data Verification Tool
'========================================
%>
<!-- #include file="includes/db_conn.asp" -->
<!-- #include file="includes/functions.asp" -->
<!-- #include file="includes/header.asp" -->

<div class="container">
    <h1 style="color:var(--primary); margin-bottom:20px;">University Data Verification Tool</h1>
    
    <div class="card" style="background: #f8d7da; border-left: 5px solid #dc3545;">
        <h3 style="color: #721c24;">Technical Limitations</h3>
        <p style="color: #721c24; line-height: 1.8;">
            <strong>Challenges for automatic real-time updates:</strong><br>
            1. University admission data is usually embedded in HTML pages without standardized API<br>
            2. OUAC official data requires special authorization<br>
            3. Admission standards vary by major<br>
            4. Website structure changes would break scraping rules<br><br>
            <strong>This tool provides semi-automatic verification</strong>
        </p>
    </div>

    <% 
    Call OpenConnection()
    
    ' Handle POST update
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        Dim uniIdToUpdate, fieldToUpdate, newValue, updateSQL
        uniIdToUpdate = Request.Form("uni_id")
        fieldToUpdate = Request.Form("field")
        newValue = Request.Form("value")
        
        If uniIdToUpdate <> "" And fieldToUpdate <> "" Then
            ' Build checkbox values using native If (IIf not supported in VBScript)
            Dim checkboxValue
            If fieldToUpdate = "eng4u" Or fieldToUpdate = "calc" Then
                If newValue = "1" Then
                    checkboxValue = "-1"
                Else
                    checkboxValue = "0"
                End If
            End If
            
            Select Case fieldToUpdate
                Case "mingpa"
                    updateSQL = "UPDATE Universities SET MinGPA=" & newValue & " WHERE ID=" & uniIdToUpdate
                Case "compgpa"
                    updateSQL = "UPDATE Universities SET CompetitiveGPA=" & newValue & " WHERE ID=" & uniIdToUpdate
                Case "deadline"
                    updateSQL = "UPDATE Universities SET ApplicationDeadline=#" & newValue & "# WHERE ID=" & uniIdToUpdate
                Case "eng4u"
                    updateSQL = "UPDATE Universities SET RequiresENG4U=" & checkboxValue & " WHERE ID=" & uniIdToUpdate
                Case "calc"
                    updateSQL = "UPDATE Universities SET RequiresCalculus=" & checkboxValue & " WHERE ID=" & uniIdToUpdate
            End Select
            
            If updateSQL <> "" Then
                On Error Resume Next
                conn.Execute updateSQL
                If Err.Number = 0 Then
                    Response.Write "<div class='alert alert-success'>OK Update successful at " & Now() & "</div>"
                Else
                    Response.Write "<div class='alert alert-danger'>Error: " & Err.Description & "</div>"
                End If
                On Error GoTo 0
            End If
        End If
    End If
    %>

    <div class="card">
        <h3>Quick Link Status Check</h3>
        
        <table class="data-table">
            <thead>
                <tr>
                    <th>University</th>
                    <th>Min GPA</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% 
            Dim uniListRS, uid, uname, uurl, umgpa
            Set uniListRS = conn.Execute("SELECT ID, Name, MinGPA, Website FROM Universities ORDER BY ID")
            
            Do While Not uniListRS.EOF
                uid = uniListRS("ID")
                uname = uniListRS("Name")
                uurl = uniListRS("Website")
                umgpa = uniListRS("MinGPA")
            %>
                <tr>
                    <td><strong><%=uname%></strong></td>
                    <td><%=umgpa%></td>
                    <td id="status<%=uid%>">
                        <button class="btn btn-sm btn-info" type="button" data-url="<%=uurl%>" data-id="<%=uid%>">Test</button>
                    </td>
                    <td>
                        <a href="<%=uurl%>" target="_blank" class="btn btn-sm btn-primary">Website</a>
                        <a href="/oup/data_edit.asp?id=<%=uid%>" class="btn btn-sm btn-success">Edit</a>
                    </td>
                </tr>
            <% 
                uniListRS.MoveNext
            Loop
            uniListRS.Close
            Call CloseConnection()
            %>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h3>Verification Workflow</h3>
        <ol>
            <li>Visit <a href="https://www.ouac.on.ca" target="_blank">OUAC</a> for official deadlines</li>
            <li>Click "Test" button above to check website connectivity</li>
            <li>Click "Website" to open official site</li>
            <li>Navigate to Admissions page and record requirements</li>
            <li>Click "Edit" to update this system</li>
        </ol>
    </div>

    <div style="text-align: center; margin-top: 30px;">
        <a href="/oup/universities/list.asp" class="btn btn-primary btn-lg">Back to List</a>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var buttons = document.querySelectorAll('button[data-url]');
    buttons.forEach(function(btn) {
        btn.addEventListener('click', function() {
            var url = this.getAttribute('data-url');
            var id = this.getAttribute('data-id');
            var statusDiv = document.getElementById('status' + id);
            statusDiv.innerHTML = '<span style="color:#ffc107;">Checking...</span>';
            
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/oup/test_url_proxy.asp?url=' + encodeURIComponent(url), true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        var result = xhr.responseText;
                        if (result.indexOf('OK') >= 0) {
                            statusDiv.innerHTML = '<span style="color:#28a745;font-weight:bold;">OK</span>';
                        } else if (result.indexOf('Error') >= 0) {
                            statusDiv.innerHTML = '<span style="color:#dc3545;">' + escapeHtml(result) + '</span>';
                        } else {
                            statusDiv.innerHTML = escapeHtml(result);
                        }
                    } else {
                        statusDiv.innerHTML = '<span style="color:#dc3545;">Failed</span>';
                    }
                }
            };
            xhr.onerror = function() {
                statusDiv.innerHTML = '<span style="color:#856404;">Check manually</span>';
            };
            xhr.send();
        });
    });
});

function escapeHtml(text) {
    var div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}
</script>

<!-- #include file="includes/footer.asp" -->

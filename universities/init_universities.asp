<%@ Language=VBScript %>
<html>
<head>
    <title>Load 22 Ontario Universities</title>
    <style>
        body { font-family: Arial; margin: 50px; background: #f5f5f5; }
        .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; }
        h2 { color: #333; border-bottom: 2px solid #28a745; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; font-size: 14px; }
        th { background: #28a745; color: white; padding: 10px; text-align: left; }
        td { padding: 8px; border-bottom: 1px solid #ddd; }
        .ok { color: green; }
        .err { color: red; }
        .result { background: #d4edda; padding: 20px; border-radius: 5px; margin: 20px 0; }
        .btn { padding: 12px 30px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .btn:hover { background: #218838; }
    </style>
</head>
<body>
<div class="container">
<h2>🏫 Ontario Universities Database</h2>

<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    Dim conn, connStr, sql, i
    Dim uniName(22), uniCode(22), uniLoc(22), uniWeb(22)
    Dim uniMin(22), uniComp(22), uniEng(22), uniCalc(22), uniPop(22)
    Dim added, errors
    added = 0
    errors = ""
    
    ' Define all universities
    uniName(0) = "University of Toronto": uniCode(0) = "TOT": uniLoc(0) = "Toronto, ON": uniWeb(0) = "https://www.utoronto.ca": uniMin(0) = 3.8: uniComp(0) = 3.9: uniEng(0) = -1: uniCalc(0) = -1: uniPop(0) = "Computer Science, Engineering, Life Sciences, Commerce"
    uniName(1) = "University of Waterloo": uniCode(1) = "WAT": uniLoc(1) = "Waterloo, ON": uniWeb(1) = "https://uwaterloo.ca": uniMin(1) = 3.85: uniComp(1) = 3.9: uniEng(1) = -1: uniCalc(1) = -1: uniPop(1) = "Software Engineering, Computer Science, Mathematics"
    uniName(2) = "McMaster University": uniCode(2) = "MCM": uniLoc(2) = "Hamilton, ON": uniWeb(2) = "https://www.mcmaster.ca": uniMin(2) = 3.7: uniComp(2) = 3.8: uniEng(2) = -1: uniCalc(2) = 0: uniPop(2) = "Health Sciences, Engineering, Life Sciences"
    uniName(3) = "Western University": uniCode(3) = "WES": uniLoc(3) = "London, ON": uniWeb(3) = "https://www.uwo.ca": uniMin(3) = 3.6: uniComp(3) = 3.7: uniEng(3) = -1: uniCalc(3) = 0: uniPop(3) = "Ivey Business, Medical Sciences, Engineering"
    uniName(4) = "Queen''s University": uniCode(4) = "QUN": uniLoc(4) = "Kingston, ON": uniWeb(4) = "https://www.queensu.ca": uniMin(4) = 3.7: uniComp(4) = 3.8: uniEng(4) = -1: uniCalc(4) = -1: uniPop(4) = "Commerce, Engineering, Life Sciences"
    uniName(5) = "York University": uniCode(5) = "YRK": uniLoc(5) = "Toronto, ON": uniWeb(5) = "https://www.yorku.ca": uniMin(5) = 3.0: uniComp(5) = 3.3: uniEng(5) = -1: uniCalc(5) = 0: uniPop(5) = "Schulich Business, Law, Arts, Science"
    uniName(6) = "University of Guelph": uniCode(6) = "GUE": uniLoc(6) = "Guelph, ON": uniWeb(6) = "https://www.uoguelph.ca": uniMin(6) = 3.0: uniComp(6) = 3.3: uniEng(6) = -1: uniCalc(6) = 0: uniPop(6) = "Agriculture, Veterinary Medicine, Environmental Sciences"
    uniName(7) = "University of Ottawa": uniCode(7) = "OTT": uniLoc(7) = "Ottawa, ON": uniWeb(7) = "https://www.uottawa.ca": uniMin(7) = 3.0: uniComp(7) = 3.3: uniEng(7) = -1: uniCalc(7) = 0: uniPop(7) = "Law, Medicine, Engineering, Social Sciences"
    uniName(8) = "Carleton University": uniCode(8) = "CAR": uniLoc(8) = "Ottawa, ON": uniWeb(8) = "https://carleton.ca": uniMin(8) = 2.9: uniComp(8) = 3.2: uniEng(8) = -1: uniCalc(8) = 0: uniPop(8) = "Engineering, Journalism, Public Affairs, Architecture"
    uniName(9) = "Wilfrid Laurier University": uniCode(9) = "WLU": uniLoc(9) = "Waterloo, ON": uniWeb(9) = "https://www.wlu.ca": uniMin(9) = 2.8: uniComp(9) = 3.1: uniEng(9) = -1: uniCalc(9) = 0: uniPop(9) = "Lazaridis Business, Music, Social Work, Science"
    uniName(10) = "Toronto Metropolitan University": uniCode(10) = "TMU": uniLoc(10) = "Toronto, ON": uniWeb(10) = "https://www.torontomu.ca": uniMin(10) = 2.9: uniComp(10) = 3.2: uniEng(10) = -1: uniCalc(10) = 0: uniPop(10) = "Media, Engineering, Business, Arts"
    uniName(11) = "University of Windsor": uniCode(11) = "WIN": uniLoc(11) = "Windsor, ON": uniWeb(11) = "https://www.uwindsor.ca": uniMin(11) = 2.7: uniComp(11) = 3.0: uniEng(11) = -1: uniCalc(11) = 0: uniPop(11) = "Engineering, Law, Business, Nursing"
    uniName(12) = "Brock University": uniCode(12) = "BRK": uniLoc(12) = "St Catharines, ON": uniWeb(12) = "https://brocku.ca": uniMin(12) = 2.7: uniComp(12) = 3.0: uniEng(12) = -1: uniCalc(12) = 0: uniPop(12) = "Education, Nursing, Business, Sports Management"
    uniName(13) = "Trent University": uniCode(13) = "TRN": uniLoc(13) = "Peterborough, ON": uniWeb(13) = "https://www.trentu.ca": uniMin(13) = 2.7: uniComp(13) = 3.0: uniEng(13) = -1: uniCalc(13) = 0: uniPop(13) = "Environmental Studies, Indigenous Programs, Liberal Arts"
    uniName(14) = "Ontario Tech University": uniCode(14) = "ONT": uniLoc(14) = "Oshawa, ON": uniWeb(14) = "https://ontariotechu.ca": uniMin(14) = 2.8: uniComp(14) = 3.1: uniEng(14) = -1: uniCalc(14) = -1: uniPop(14) = "Engineering, IT, Health Sciences, Business"
    uniName(15) = "Lakehead University": uniCode(15) = "LKH": uniLoc(15) = "Thunder Bay, ON": uniWeb(15) = "https://www.lakeheadu.ca": uniMin(15) = 2.5: uniComp(15) = 2.8: uniEng(15) = -1: uniCalc(15) = 0: uniPop(15) = "Natural Resource Management, Law, Education, Engineering"
    uniName(16) = "Nipissing University": uniCode(16) = "NIP": uniLoc(16) = "North Bay, ON": uniWeb(16) = "https://www.nipissingu.ca": uniMin(16) = 2.5: uniComp(16) = 2.8: uniEng(16) = -1: uniCalc(16) = 0: uniPop(16) = "Teacher Education, Liberal Arts, Social Work, Science"  
    uniName(17) = "Laurentian University": uniCode(17) = "LAU": uniLoc(17) = "Sudbury, ON": uniWeb(17) = "https://laurentian.ca": uniMin(17) = 2.5: uniComp(17) = 2.8: uniEng(17) = -1: uniCalc(17) = 0: uniPop(17) = "Mining Engineering, Sports Administration, Science, Arts"
    uniName(18) = "University of Ontario French": uniCode(18) = "UOF": uniLoc(18) = "Toronto, ON": uniWeb(18) = "https://www.uoif.ca": uniMin(18) = 2.5: uniComp(18) = 2.8: uniEng(18) = -1: uniCalc(18) = 0: uniPop(18) = "French language programs"
    uniName(19) = "Algoma University": uniCode(19) = "ALG": uniLoc(19) = "Sault Ste Marie, ON": uniWeb(19) = "https://algomau.ca": uniMin(19) = 2.3: uniComp(19) = 2.6: uniEng(19) = -1: uniCalc(19) = 0: uniPop(19) = "Liberal Arts, Anishinaabe Studies, Social Work, Business"
    uniName(20) = "OCAD University": uniCode(20) = "OCA": uniLoc(20) = "Toronto, ON": uniWeb(20) = "https://www.ocadu.ca": uniMin(20) = 2.8: uniComp(20) = 3.1: uniEng(20) = 0: uniCalc(20) = 0: uniPop(20) = "Visual Arts, Design, Digital Media, Illustration"
    uniName(21) = "Royal Military College": uniCode(21) = "RMC": uniLoc(21) = "Kingston, ON": uniWeb(21) = "https://www.rmc-cmr.ca": uniMin(21) = 3.0: uniComp(21) = 3.3: uniEng(21) = -1: uniCalc(21) = -1: uniPop(21) = "Engineering, Arts, Science, Military Training"
    
    ' Connect
    Set conn = Server.CreateObject("ADODB.Connection")
    connStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\inetpub\wwwroot\OUP\db\oup_data.mdb;"
    conn.Open connStr
    
    ' Clear existing
    conn.Execute "DELETE FROM Programs"
    conn.Execute "DELETE FROM Universities"
    
    Response.Write "<table><tr><th>#</th><th>University</th><th>Code</th><th>Min GPA</th><th>Status</th></tr>"
    
    ' Insert all 22
    For i = 0 To 21
        Err.Clear
        sql = "INSERT INTO Universities (ID, Name, OUACCode, Location, Website, MinGPA, CompetitiveGPA, RequiresENG4U, RequiresCalculus, ApplicationDeadline, PopularPrograms, Ranking) VALUES (" & _
            (i+1) & ", '" & uniName(i) & "', '" & uniCode(i) & "', '" & uniLoc(i) & "', '" & uniWeb(i) & "', " & _
            uniMin(i) & ", " & uniComp(i) & ", " & uniEng(i) & ", " & uniCalc(i) & ", #2026-01-15#, '" & uniPop(i) & "', " & (i+1) & ")"
        
        conn.Execute sql
        
        If Err.Number = 0 Then
            Response.Write "<tr><td>" & (i+1) & "</td><td>" & uniName(i) & "</td><td>" & uniCode(i) & "</td><td>" & uniMin(i) & "</td><td class='ok'>✓ OK</td></tr>"
            added = added + 1
        Else
            Response.Write "<tr><td>" & (i+1) & "</td><td>" & uniName(i) & "</td><td>" & uniCode(i) & "</td><td>" & uniMin(i) & "</td><td class='err'>✗ " & Err.Description & "</td></tr>"
            errors = errors & uniName(i) & "; "
        End If
    Next
    
    Response.Write "</table>"
    
    conn.Close
    Set conn = Nothing
%>

<div class="result">
    <h3>✅ Complete!</h3>
    <p><strong>Added: <%=added%> / 22 universities</strong></p>
    <% If errors <> "" Then %>
        <p class="err">Failed: <%=errors%></p>
    <% End If %>
</div>

<p>
    <a href="list.asp"><button class="btn">View Universities</button></a>
    <a href="../default.asp" style="margin-left: 15px;">Dashboard</a>
</p>

<% Else %>
<p>This will load all 22 Ontario universities into the database.</p>

<table>
<tr><th>#</th><th>University</th><th>Location</th></tr>
<tr><td>1</td><td>University of Toronto</td><td>Toronto</td></tr>
<tr><td>2</td><td>University of Waterloo</td><td>Waterloo</td></tr>
<tr><td>3</td><td>McMaster University</td><td>Hamilton</td></tr>
<tr><td colspan="3" style="text-align:center;color:#666;">... and 19 more universities</td></tr>
</table>

<form method="post">
    <input type="submit" class="btn" value="Load All 22 Universities" style="margin-top: 20px;">
</form>
<% End If %>

</div>
</body>
</html>

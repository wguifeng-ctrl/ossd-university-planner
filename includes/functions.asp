<%
'========================================
' OSSD University Planner - Core Functions
'========================================

'----------------------------------------
' GPA Calculation (OSSD to 4.0 scale)
'----------------------------------------
Function GetGradePoints(grade)
    If grade >= 80 Then
        GetGradePoints = 4.0
    ElseIf grade >= 75 Then
        GetGradePoints = 3.7
    ElseIf grade >= 70 Then
        GetGradePoints = 3.0
    ElseIf grade >= 65 Then
        GetGradePoints = 2.3
    ElseIf grade >= 60 Then
        GetGradePoints = 2.0
    ElseIf grade >= 55 Then
        GetGradePoints = 1.7
    ElseIf grade >= 50 Then
        GetGradePoints = 1.0
    Else
        GetGradePoints = 0.0
    End If
End Function

Function CalculateOSSDGPA(studentID)
    Dim rs, totalPoints, totalCredits, gpa
    Set rs = conn.Execute("SELECT Grade, Credits FROM Courses WHERE StudentID=" & studentID & " AND Status='Completed'")
    
    totalPoints = 0
    totalCredits = 0
    
    Do While Not rs.EOF
        totalPoints = totalPoints + (GetGradePoints(rs("Grade")) * rs("Credits"))
        totalCredits = totalCredits + rs("Credits")
        rs.MoveNext
    Loop
    rs.Close
    Set rs = Nothing
    
    If totalCredits > 0 Then
        gpa = Round(totalPoints / totalCredits, 2)
    Else
        gpa = 0.00
    End If
    
    CalculateOSSDGPA = gpa
End Function

Function CalculateTop6GPA(studentID)
    ' Top 6 U/M courses calculation (common for Ontario universities)
    Dim rs, courses(5), i, totalPoints, gpa
    Set rs = conn.Execute("SELECT TOP 6 Grade, Credits FROM Courses WHERE StudentID=" & studentID & " AND Status='Completed' AND CourseType IN ('U','M','mixed') ORDER BY Grade DESC")
    
    totalPoints = 0
    i = 0
    Do While Not rs.EOF
        courses(i) = rs("Grade")
        totalPoints = totalPoints + (GetGradePoints(rs("Grade")) * rs("Credits"))
        i = i + 1
        rs.MoveNext
    Loop
    rs.Close
    Set rs = Nothing
    
    If i > 0 Then
        gpa = Round(totalPoints / i, 2)
    Else
        gpa = 0.00
    End If
    
    CalculateTop6GPA = gpa
End Function

'----------------------------------------
' University Admission Prediction
'----------------------------------------
Function PredictAdmission(studentGPA, uniMinGPA)
    Dim diff
    diff = studentGPA - uniMinGPA
    
    If diff >= 0.5 Then
        PredictAdmission = "<span class='match-high'>High Chance (Safe)</span>"
    ElseIf diff >= 0.2 Then
        PredictAdmission = "<span class='match-good'>Good Chance (Target)</span>"
    ElseIf diff >= -0.2 Then
        PredictAdmission = "<span class='match-maybe'>Possible (Reach)</span>"
    Else
        PredictAdmission = "<span class='match-low'>Low Chance (Hard Reach)</span>"
    End If
End Function

Function GetMatchScore(studentGPA, uniMinGPA)
    ' Returns percentage match
    Dim score
    score = 100 + ((studentGPA - uniMinGPA) / uniMinGPA) * 100
    If score > 100 Then score = 100
    If score < 0 Then score = 0
    GetMatchScore = Round(score, 0)
End Function

'----------------------------------------
' Credit Calculations
'----------------------------------------
Function CountCreditsByCategory(studentID, category)
    Dim rs, total
    Set rs = conn.Execute("SELECT SUM(Credits) FROM Courses WHERE StudentID=" & studentID & " AND Category='" & category & "' AND Status='Completed'")
    If IsNull(rs(0)) Then
        total = 0
    Else
        total = rs(0)
    End If
    rs.Close
    Set rs = Nothing
    CountCreditsByCategory = total
End Function

Function GetTotalCredits(studentID)
    Dim rs, total
    Set rs = conn.Execute("SELECT SUM(Credits) FROM Courses WHERE StudentID=" & studentID & " AND Status='Completed'")
    If IsNull(rs(0)) Then
        total = 0
    Else
        total = rs(0)
    End If
    rs.Close
    Set rs = Nothing
    GetTotalCredits = total
End Function

Function CheckOSSDRequirements(studentID)
    ' Returns array: [isComplete, missingItems]
    Dim completed, missing
    completed = True
    missing = ""
    
    ' 4 English credits
    If CountCreditsByCategory(studentID, "ENG") < 4 Then
        completed = False
        missing = missing & "- English: need " & (4 - CountCreditsByCategory(studentID, "ENG")) & " more credits<br>"
    End If
    
    ' 3 Math credits (at least 1 U level)
    If CountCreditsByCategory(studentID, "MTH") < 3 Then
        completed = False
        missing = missing & "- Math: need " & (3 - CountCreditsByCategory(studentID, "MTH")) & " more credits<br>"
    End If
    
    ' 2 Science credits
    If CountCreditsByCategory(studentID, "SCI") < 2 Then
        completed = False
        missing = missing & "- Science: need " & (2 - CountCreditsByCategory(studentID, "SCI")) & " more credits<br>"
    End If
    
    ' 1 Canadian geography/history
    If CountCreditsByCategory(studentID, "CGC") < 1 Then
        completed = False
        missing = missing & "- Canadian Geography/History<br>"
    End If
    
    ' 1 Arts credit
    If CountCreditsByCategory(studentID, "ART") < 1 Then
        completed = False
        missing = missing & "- Arts (Drama/Music/Visual)<br>"
    End If
    
    ' 1 Phys Ed
    If CountCreditsByCategory(studentID, "PED") < 1 Then
        completed = False
        missing = missing & "- Physical Education<br>"
    End If
    
    ' 1 French (if not exempt)
    If CountCreditsByCategory(studentID, "FRE") < 1 Then
        completed = False
        missing = missing & "- French<br>"
    End If
    
    ' 1/2 Career Studies + 1/2 Civics
    If CountCreditsByCategory(studentID, "CIV") < 1 Then
        completed = False
        missing = missing & "- Career Studies / Civics<br>"
    End If
    
    ' Total 30 credits
    If GetTotalCredits(studentID) < 30 Then
        completed = False
        missing = missing & "- Total: need " & (30 - GetTotalCredits(studentID)) & " more credits<br>"
    End If
    
    CheckOSSDRequirements = Array(completed, missing)
End Function

'----------------------------------------
' Date/Deadline Helpers
'----------------------------------------
Function DaysUntil(dateStr)
    Dim target, today
    target = CDate(dateStr)
    today = Date()
    DaysUntil = DateDiff("d", today, target)
End Function

Function FormatDeadlineBadge(deadline)
    Dim days, badgeClass, badgeText
    days = DaysUntil(deadline)
    
    If days < 0 Then
        badgeClass = "deadline-overdue"
        badgeText = "OVERDUE by " & Abs(days) & " days"
    ElseIf days <= 3 Then
        badgeClass = "deadline-urgent"
        badgeText = days & " days LEFT"
    ElseIf days <= 14 Then
        badgeClass = "deadline-warning"
        badgeText = days & " days left"
    Else
        badgeClass = "deadline-normal"
        badgeText = days & " days"
    End If
    
    FormatDeadlineBadge = "<span class='deadline-badge " & badgeClass & "'>" & badgeText & "</span>"
End Function

'----------------------------------------
' User Session Management
'----------------------------------------
Function CheckLogin()
    If Session("StudentID") = "" Or IsNull(Session("StudentID")) Then
        Response.Redirect "login.asp"
    End If
End Function

Function GetStudentName()
    GetStudentName = Session("StudentName")
End Function

'----------------------------------------
' String Utilities
'----------------------------------------
Function SafeSQL(str)
    If IsNull(str) Then
        SafeSQL = ""
    Else
        SafeSQL = Replace(Replace(str, "'", "''"), "--", "")
    End If
End Function

Function Truncate(str, length)
    If Len(str) > length Then
        Truncate = Left(str, length) & "..."
    Else
        Truncate = str
    End If
End Function
%>

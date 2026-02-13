<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OSSD University Planner</title>
    <link rel="stylesheet" href="/oup/css/main.css">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="/oup/default.asp" class="navbar-brand">
                <span>OSSD University Planner</span>
            </a>
            
            <button type="button" class="navbar-toggle" onclick="document.body.classList.toggle('nav-open')">
                <span></span>
                <span></span>
                <span></span>
            </button>
            
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a href="/oup/default.asp" class="nav-link <%If InStr(Request.ServerVariables("URL"),"default.asp")>0 Then Response.Write "active"%>">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a href="/oup/ossd/credits.asp" class="nav-link <%If InStr(Request.ServerVariables("URL"),"credits.asp")>0 Then Response.Write "active"%>">My Credits</a>
                </li>
                <li class="nav-item">
                    <a href="/oup/universities/list.asp" class="nav-link <%If InStr(Request.ServerVariables("URL"),"universities")>0 Then Response.Write "active"%>">Universities</a>
                </li>
                <li class="nav-item">
                    <a href="/oup/applications/dashboard.asp" class="nav-link <%If InStr(Request.ServerVariables("URL"),"applications")>0 Then Response.Write "active"%>">Applications</a>
                </li>
                <li class="nav-item">
                    <a href="/oup/logout.asp" class="nav-link">Logout (<%=Session("StudentName")%>)</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <main class="main-content">

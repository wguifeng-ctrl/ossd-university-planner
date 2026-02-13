<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - OSSD University Planner</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<div class="login-container">
    <h2>🎓 OSSD University Planner</h2>
    
    <% If Request("error") = "1" Then %>
        <div class="alert alert-danger">Invalid email or password. Please try again.</div>
    <% End If %>
    
    <% If Request("msg") = "registered" Then %>
        <div class="alert alert-success">Account created successfully! Please login.</div>
    <% End If %>
    
    <form method="post" action="authenticate.asp">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        
        <div class="form-group" style="text-align:center;">
            <button type="submit" class="btn btn-primary" style="width:100%;">Login</button>
        </div>
    </form>
    
    <p style="text-align:center; margin-top:20px;">
        Don't have an account? <a href="register.asp">Register here</a>
    </p>
</div>

</body>
</html>

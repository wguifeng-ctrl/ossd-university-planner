<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - OSSD University Planner</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<div class="login-container">
    <h2>Create Your Account</h2>
    
    <% If Request("error") = "email" Then %>
        <div class="alert alert-danger">Email already registered.</div>
    <% End If %>
    
    <% If Request("error") = "password" Then %>
        <div class="alert alert-danger">Passwords do not match.</div>
    <% End If %>
    
    <form method="post" action="create_account.asp">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullname" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>Current Grade</label>
            <select name="grade" class="form-control" required>
                <option value="">Select Grade</option>
                <option value="10">Grade 10</option>
                <option value="11">Grade 11</option>
                <option value="12">Grade 12</option>
                <option value="12+">Gap Year / Other</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Target University Year</label>
            <select name="target_year" class="form-control" required>
                <option value="">Select Year</option>
                <option value="2026">2026</option>
                <option value="2027">2027</option>
                <option value="2028">2028</option>
                <option value="2029">2029</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        
        <div class="form-group">
            <label>Confirm Password</label>
            <input type="password" name="password2" class="form-control" required>
        </div>
        
        <div class="form-group" style="text-align:center;">
            <button type="submit" class="btn btn-primary" style="width:100%;">Create Account</button>
        </div>
    </form>
    
    <p style="text-align:center; margin-top:20px;">
        Already have an account? <a href="login.asp">Login here</a>
    </p>
</div>

</body>
</html>

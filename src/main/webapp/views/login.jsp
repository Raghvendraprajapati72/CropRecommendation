<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            background: linear-gradient(135deg, #1d2b64, #27ae60);
        }

        .header {
            text-align: center;
            padding: 20px;
            color: white;
            font-size: 22px;
            font-weight: bold;
        }

        .login-container {
            width: 360px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            padding: 13px;
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        button:hover {
            background: #27ae60;
        }

        /* ALERTS */
        .alert {
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 10px;
            text-align: center;
            font-size: 14px;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .register-text {
            text-align: center;
            margin-top: 10px;
        }

        .register-text a {
            color: #27ae60;
            font-weight: bold;
        }

    </style>

</head>

<body>

<!-- HEADER -->
<div class="header">
    🌱 Smart Agriculture System
</div>

<!-- LOGIN BOX -->
<div class="login-container">

    <h2>Login</h2>

    <!-- ✅ SUCCESS (Logout / Help) -->
    <%
        String success = request.getParameter("success");
        String logout = request.getParameter("logout");

        if(success != null){
    %>
        <div class="alert success">
            ✅ Query submitted successfully!
        </div>
    <%
        } else if(logout != null){
    %>
        <div class="alert success">
            ✅ Logged out successfully!
        </div>
    <%
        }
    %>

    <!-- ❌ ERROR -->
    <%
        String error = request.getParameter("error");
        if(error != null){
    %>
        <div class="alert error">
            ❌ Invalid Username or Password
        </div>
    <%
        }
    %>

    <!-- LOGIN FORM -->
    <form action="${pageContext.request.contextPath}/login" method="post">

        <input type="text" name="username" placeholder="Enter Username" required>

        <input type="password" name="password" placeholder="Enter Password" required>

        <button type="submit">Login</button>

    </form>

    <!-- REGISTER -->
    <p class="register-text">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/views/register.jsp">Register</a>
    </p>

</div>

</body>
</html>
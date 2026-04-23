<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">

    <style>
        .register-container {
            width: 350px;
            margin: 100px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .register-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .register-container input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .register-container button {
            width: 100%;
            padding: 12px;
            background: #2ecc71;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }

        .register-container button:hover {
            background: #27ae60;
        }

        .msg {
            text-align: center;
            margin-bottom: 10px;
        }

        .error { color: red; }
        .success { color: green; }
    </style>

</head>

<body>

<!-- Header -->
<div class="header">
    <h2>🌱 Smart Agriculture System</h2>
</div>

<!-- Register Box -->
<div class="register-container">

    <h2>Create Account</h2>

    <!-- Messages -->
    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if ("empty".equals(error)) {
    %>
        <p class="msg error">All fields are required!</p>
    <%
        } else if ("exists".equals(error)) {
    %>
        <p class="msg error">Username already exists!</p>
    <%
        } else if ("server".equals(error)) {
    %>
        <p class="msg error">Server error! Try again</p>
    <%
        } else if ("1".equals(success)) {
    %>
        <p class="msg success">Registration successful! Login now</p>
    <%
        }
    %>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/register" method="post">

        <input type="text" name="username" placeholder="Enter Username" required>

        <input type="password" name="password" placeholder="Enter Password" required>

        <button type="submit">Register</button>

    </form>

    <!-- Login Link -->
    <p style="text-align:center; margin-top:10px;">
        Already have an account?
        <a href="${pageContext.request.contextPath}/views/login.jsp">Login</a>
    </p>

</div>

</body>
</html>
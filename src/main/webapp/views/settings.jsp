<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Settings</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1d2b64, #27ae60);
        }

        .container {
            width: 500px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            margin-top: 15px;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: #27ae60;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background: #219150;
        }

        .success {
            color: green;
            text-align: center;
            margin-top: 10px;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .toggle {
            margin-top: 15px;
        }

        .back {
            text-align: center;
            margin-top: 15px;
        }

        .back a {
            text-decoration: none;
            color: #27ae60;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>⚙️ Account Settings</h2>

    <%
        String user = (String) session.getAttribute("user");

        if(user == null){
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    %>

    <label>Username</label>
    <input type="text" value="<%= user %>" readonly>

    <!-- CHANGE PASSWORD -->
    <form action="<%= request.getContextPath() %>/change-password" method="post">

        <label>Current Password</label>
        <input type="password" name="currentPassword" required>

        <label>New Password</label>
        <input type="password" name="newPassword" required>

        <button type="submit">Update Password</button>
    </form>

    <!-- ✅ SUCCESS MESSAGE -->
    <%
        String msg = (String) session.getAttribute("msg");
        if(msg != null){
    %>
        <div class="success"><%= msg %></div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <!-- ❌ ERROR MESSAGE -->
    <%
        String error = (String) session.getAttribute("error");
        if(error != null){
    %>
        <div class="error"><%= error %></div>
    <%
            session.removeAttribute("error");
        }
    %>

    <!-- SETTINGS -->
    <div class="toggle">
        <label>
            <input type="checkbox"> Enable Notifications
        </label>

        <label>
            <input type="checkbox"> Dark Mode
        </label>
    </div>

    <!-- BACK -->
    <div class="back">
        <a href="<%= request.getContextPath() %>/views/FarmerDashboard.jsp">
            ⬅ Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
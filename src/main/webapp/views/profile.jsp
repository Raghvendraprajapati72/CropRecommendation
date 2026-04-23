<%@ page import="java.sql.*, com.crop.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1d2b64, #27ae60);
        }

        /* HEADER */
        .header {
            padding: 20px;
            color: white;
            font-size: 22px;
            text-align: center;
        }

        /* CONTAINER */
        .profile-container {
            width: 400px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
        }

        /* AVATAR */
        .avatar {
            width: 80px;
            height: 80px;
            background: #27ae60;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin: 0 auto 15px;
        }

        /* INFO */
        .info {
            margin: 10px 0;
            font-size: 16px;
        }

        /* BUTTON */
        .btn {
            margin-top: 15px;
            padding: 10px;
            width: 100%;
            border: none;
            background: #27ae60;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn:hover {
            background: #219150;
        }

        /* BACK */
        .back {
            margin-top: 10px;
            display: inline-block;
            color: #555;
            text-decoration: none;
        }
    </style>
</head>

<body>
<div class="top-right">
   <a href="${pageContext.request.contextPath}/views/profile.jsp">Profile</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
</div>
<div class="header">
     User Profile
</div>

<div class="profile-container">

<%
String username = (String) session.getAttribute("user");

String email = "Not Available";

if(username != null){
    Connection con = DBConnection.getConnection();

    if(con != null){
        PreparedStatement ps = con.prepareStatement(
            "SELECT email FROM users WHERE username=?"
        );
        ps.setString(1, username);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            email = rs.getString("email");
        }
    }
}
%>

    <!-- AVATAR -->
    <div class="avatar">
        <%= username != null ? username.charAt(0) : "G" %>
    </div>

    <!-- INFO -->
    <div class="info"><b>Username:</b> <%= username %></div>
    <div class="info"><b>Email:</b> <%= email %></div>
    <div class="info"><b>Role:</b> Farmer</div>

    <!-- ACTION -->
    <form action="${pageContext.request.contextPath}/logout" method="post">
    <button type="submit">Logout</button>
</form>

    <a href="FarmerDashboard.jsp" class="back"> Back to Dashboard</a>

</div>

</body>
</html>
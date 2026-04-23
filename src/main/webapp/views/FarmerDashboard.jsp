<%@ page import="java.sql.*, com.crop.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String user = (String) session.getAttribute("user");

if(user == null){
    response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    return;
}

Connection con = DBConnection.getConnection();

// 🔥 Last Prediction
String lastCrop = "N/A";
PreparedStatement ps1 = con.prepareStatement(
    "SELECT crop FROM predictions WHERE username=? ORDER BY id DESC LIMIT 1"
);
ps1.setString(1, user);
ResultSet rs1 = ps1.executeQuery();
if(rs1.next()){
    lastCrop = rs1.getString("crop");
}

// 🔥 Help Requests Count
int helpCount = 0;
PreparedStatement ps2 = con.prepareStatement(
    "SELECT COUNT(*) FROM help_requests WHERE username=?"
);
ps2.setString(1, user);
ResultSet rs2 = ps2.executeQuery();
if(rs2.next()){
    helpCount = rs2.getInt(1);
}

// 🔥 Total Predictions
int totalPredictions = 0;
PreparedStatement ps3 = con.prepareStatement(
    "SELECT COUNT(*) FROM predictions WHERE username=?"
);
ps3.setString(1, user);
ResultSet rs3 = ps3.executeQuery();
if(rs3.next()){
    totalPredictions = rs3.getInt(1);
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Smart Farmer Dashboard</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/FarmerDashbaord.css">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .quick-actions button {
            padding: 12px 20px;
            margin: 10px;
            border: none;
            background: #2ecc71;
            color: white;
            border-radius: 6px;
            cursor: pointer;
        }

        .quick-actions button:hover {
            background: #27ae60;
        }
    </style>
</head>

<body>

<!-- HEADER -->
<div class="header d-flex justify-content-between p-3 bg-dark text-white">
    <div>
        <span onclick="toggleMenu()" style="cursor:pointer;">☰</span>
        <b class="ms-2">Smart Agriculture</b>
    </div>

    <div>
        👤 <%= user %>
        <a href="${pageContext.request.contextPath}/logout" class="text-white ms-3">Logout</a>
    </div>
</div>

<!-- SIDEBAR -->
<div id="sidebar" class="sidebar">
    <h3>Menu</h3>

    <a href="${pageContext.request.contextPath}/views/FarmerDashboard.jsp">🏠 Dashboard</a>
    <a href="${pageContext.request.contextPath}/views/predict.jsp">🌾 Predict Crop</a>

    <!-- ✅ FIXED -->
    <a href="${pageContext.request.contextPath}/history">📜 Prediction History</a>

    <a href="${pageContext.request.contextPath}/views/help.jsp">📩 Help Requests</a>

    <a href="${pageContext.request.contextPath}/views/reports.jsp">📊 Reports</a>

    <a href="${pageContext.request.contextPath}/views/analytics.jsp">📈 Analytics</a>

    <a href="${pageContext.request.contextPath}/views/profile.jsp">👤 Profile</a>

    <a href="${pageContext.request.contextPath}/views/settings.jsp">⚙️ Settings</a>
</div>

<!-- MAIN -->
<div class="main p-4">

    <!-- RESULT SHOW (🔥 NEW FEATURE) -->
    <%
    String result = (String) request.getAttribute("result");
    if(result != null){
    %>
        <div class="alert alert-success">
            🌾 Predicted Crop: <b><%= result %></b>
        </div>
    <%
    }
    %>

    <!-- Welcome -->
    <div class="welcome">
        <h2>Welcome, <%= user %></h2>
        <p>Your smart farming assistant</p>
    </div>

    <!-- CARDS -->
    <div class="row mt-4">

        <div class="col-md-3">
            <div class="card p-3 text-center bg-success text-white">
                <h5>🌾 Last Crop</h5>
                <h2><%= lastCrop %></h2>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>📊 Predictions</h5>
                <h2><%= totalPredictions %></h2>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>📩 Help</h5>
                <h2><%= helpCount %></h2>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>🌡 Temp</h5>
                <h2>25°C</h2>
            </div>
        </div>

    </div>

    <!-- QUICK ACTIONS -->
    <div class="quick-actions text-center mt-4">

        <a href="${pageContext.request.contextPath}/views/predict.jsp">
            <button>🌱 New Prediction</button>
        </a>

        <!-- ✅ FIXED -->
        <a href="${pageContext.request.contextPath}/history">
            <button>📜 View History</button>
        </a>

    </div>

</div>

<script>
function toggleMenu() {
    document.getElementById("sidebar").classList.toggle("active");
}
</script>

</body>
</html>
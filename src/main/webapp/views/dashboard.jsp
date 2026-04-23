<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Farmer Dashboard</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard-pro.css">
</head>

<body>
<!-- HEADER -->
<div class="header">
    <div class="logo">
        🌱 Smart Agriculture
    </div>

    <div class="nav">
        <span class="user">👤 ${sessionScope.user}</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
    </div>
</div>

<!-- MAIN -->
<div class="container">

    <!-- WELCOME -->
    <div class="welcome">
        <h1>Welcome, ${sessionScope.user} 👋</h1>
        <p>Your AI-powered smart farming assistant</p>
    </div>

    <!-- CARDS -->
    <div class="cards">

        <div class="card highlight">
            <h3>🌾 Recommended Crop</h3>
            <h1>${result}</h1>
        </div>

        <div class="card">
            <h3>🌡 Temperature</h3>
            <h1>25°C</h1>
        </div>

        <div class="card">
            <h3>💧 Humidity</h3>
            <h1>60%</h1>
        </div>

        <div class="card">
            <h3>🧪 Soil Status</h3>
            <h1>Good</h1>
        </div>

    </div>

    <!-- ACTION -->
    <div class="action">
        <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn">
            🔍 Predict Again
        </a>
    </div>

</div>

</body>
</html>
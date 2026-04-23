<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prediction Result</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/result.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>

<div class="container">

    <h2 class="title">🌱 Smart Prediction Result</h2>

    <!-- ✅ RESULT -->
    <h1 class="result">
        <%= request.getAttribute("result") != null ? request.getAttribute("result") : "No Result" %>
    </h1>

    <!-- 🌦 WEATHER -->
    <div class="grid">
        <div class="card">
            <h3>🌦 Weather</h3>

            <p>
                Temperature:
                <b>
                    <%= request.getAttribute("weatherTemp") != null 
                        ? request.getAttribute("weatherTemp") 
                        : request.getAttribute("temp") %> °C
                </b>
            </p>

            <p>
                Humidity:
                <b>
                    <%= request.getAttribute("weatherHumidity") != null 
                        ? request.getAttribute("weatherHumidity") 
                        : request.getAttribute("humidity") %> %
                </b>
            </p>
        </div>

        <div class="card">
            <h3>🌾 Soil Summary</h3>
            <p>N: <%= request.getAttribute("n") != null ? request.getAttribute("n") : 0 %></p>
            <p>P: <%= request.getAttribute("p") != null ? request.getAttribute("p") : 0 %></p>
            <p>K: <%= request.getAttribute("k") != null ? request.getAttribute("k") : 0 %></p>
        </div>
    </div>

    <!-- 📊 CHART -->
    <div class="chart-box">
        <canvas id="chart"></canvas>
    </div>

    <script>
        const n = <%= request.getAttribute("n") != null ? request.getAttribute("n") : 0 %>;
        const p = <%= request.getAttribute("p") != null ? request.getAttribute("p") : 0 %>;
        const k = <%= request.getAttribute("k") != null ? request.getAttribute("k") : 0 %>;
        const temp = <%= request.getAttribute("temp") != null ? request.getAttribute("temp") : 0 %>;
        const humidity = <%= request.getAttribute("humidity") != null ? request.getAttribute("humidity") : 0 %>;
        const ph = <%= request.getAttribute("ph") != null ? request.getAttribute("ph") : 0 %>;
        const rain = <%= request.getAttribute("rain") != null ? request.getAttribute("rain") : 0 %>;

        new Chart(document.getElementById("chart"), {
            type: 'bar',
            data: {
                labels: ['N','P','K','Temp','Humidity','pH','Rain'],
                datasets: [{
                    label: 'Soil Analysis',
                    data: [n, p, k, temp, humidity, ph, rain]
                }]
            }
        });
    </script>

    <!-- 🗺 MAP -->
    <div class="map">
        <h3>📍 Location</h3>
        <iframe src="https://maps.google.com/maps?q=bhopal&output=embed"></iframe>
    </div>

    <!-- BUTTONS -->
    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn">Try Again</a>
        <a href="${pageContext.request.contextPath}/views/FarmerDashboard.jsp" class="btn">Dashboard</a>
    </div>

</div>

</body>
</html>
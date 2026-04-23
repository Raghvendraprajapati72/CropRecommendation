<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Analytics Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1d2b64, #27ae60);
            color: white;
        }

        .container {
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        /* CARDS */
        .cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .card {
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
        }

        .card h3 {
            margin: 0;
            font-size: 18px;
        }

        .card p {
            font-size: 22px;
            font-weight: bold;
        }

        /* CHARTS */
        .charts {
            margin-top: 30px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .chart-box {
            background: white;
            color: black;
            padding: 20px;
            border-radius: 12px;
        }

        /* TABLE */
        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background: white;
            color: black;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #27ae60;
            color: white;
        }

        .back {
            text-align: center;
            margin-top: 20px;
        }

        .back a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>📊 Analytics Dashboard</h2>

    <!-- CARDS -->
    <div class="cards">
        <div class="card">
            <h3>Total Users</h3>
            <p>120</p>
        </div>

        <div class="card">
            <h3>Predictions</h3>
            <p>350</p>
        </div>

        <div class="card">
            <h3>Help Requests</h3>
            <p>25</p>
        </div>

        <div class="card">
            <h3>Active Users</h3>
            <p>15</p>
        </div>
    </div>

    <!-- CHARTS -->
    <div class="charts">

        <div class="chart-box">
            <h3>🌾 Crop Distribution</h3>
            <p>(Chart Placeholder)</p>
        </div>

        <div class="chart-box">
            <h3>📈 Monthly Activity</h3>
            <p>(Chart Placeholder)</p>
        </div>

    </div>

    <!-- TABLE -->
    <table>
        <tr>
            <th>User</th>
            <th>Crop</th>
            <th>Date</th>
        </tr>

        <tr>
            <td>farmer1</td>
            <td>Rice</td>
            <td>2026-01-01</td>
        </tr>

        <tr>
            <td>user2</td>
            <td>Wheat</td>
            <td>2026-01-02</td>
        </tr>
    </table>

    <!-- BACK -->
    <div class="back">
        <a href="${pageContext.request.contextPath}/views/FarmerDashboard.jsp">
            ⬅ Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
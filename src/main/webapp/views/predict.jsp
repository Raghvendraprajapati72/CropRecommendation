<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Predict Crop</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1d2b64, #27ae60);
        }

        .container {
            width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        label { font-weight: bold; }

        input {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover { background: #219150; }

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

    <h2>🌱 Crop Prediction</h2>

    <!-- ✅ FIXED FORM -->
    <form action="${pageContext.request.contextPath}/predict" method="post">

        <div class="grid">

            <div>
                <label>Nitrogen (N)</label>
                <input type="number" name="n" required>
            </div>

            <div>
                <label>Phosphorus (P)</label>
                <input type="number" name="p" required>
            </div>

            <div>
                <label>Potassium (K)</label>
                <input type="number" name="k" required>
            </div>

            <div>
                <label>Temperature (°C)</label>
                <!-- ✅ NAME FIX -->
                <input type="number" step="0.1" name="temp" required>
            </div>

            <div>
                <label>Humidity (%)</label>
                <input type="number" step="0.1" name="humidity" required>
            </div>

            <div>
                <label>pH Level</label>
                <input type="number" step="0.1" name="ph" required>
            </div>

            <div style="grid-column: span 2;">
                <label>Rainfall (mm)</label>
                <!-- ✅ NAME FIX -->
                <input type="number" step="0.1" name="rain" required>
            </div>

        </div>

        <button type="submit">🚀 Predict Crop</button>

    </form>

    <!-- BACK -->
    <div class="back">
        <a href="${pageContext.request.contextPath}/views/FarmerDashboard.jsp">
            ⬅ Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
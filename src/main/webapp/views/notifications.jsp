<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Notifications</title>

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
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .notification {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
            background: #f1f1f1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .unread {
            border-left: 5px solid #27ae60;
            background: #eafaf1;
        }

        .read {
            opacity: 0.7;
        }

        .msg {
            font-size: 14px;
        }

        .time {
            font-size: 12px;
            color: gray;
        }

        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
        }

        .mark-read {
            background: #27ae60;
            color: white;
        }

        .clear-all {
            width: 100%;
            margin-top: 15px;
            padding: 10px;
            background: red;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
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

    <h2>🔔 Notifications</h2>

    <!-- SAMPLE NOTIFICATIONS -->
    <div class="notification unread">
        <div>
            <div class="msg">🌱 Your crop prediction is ready</div>
            <div class="time">2 mins ago</div>
        </div>
        <button class="btn mark-read">Mark Read</button>
    </div>

    <div class="notification read">
        <div>
            <div class="msg">📩 New help request response received</div>
            <div class="time">1 hour ago</div>
        </div>
        <button class="btn mark-read">Mark Read</button>
    </div>

    <div class="notification unread">
        <div>
            <div class="msg">⚙️ Settings updated successfully</div>
            <div class="time">Yesterday</div>
        </div>
        <button class="btn mark-read">Mark Read</button>
    </div>

    <!-- CLEAR BUTTON -->
    <button class="clear-all">🧹 Clear All Notifications</button>

    <!-- BACK -->
    <div class="back">
        <a href="${pageContext.request.contextPath}/views/FarmerDashboard.jsp">
            ⬅ Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
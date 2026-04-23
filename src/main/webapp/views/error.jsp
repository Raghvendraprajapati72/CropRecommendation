<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: linear-gradient(to right, #2c3e50, #27ae60);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .box {
            background: white;
            color: #333;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            width: 400px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .box h1 {
            color: #e74c3c;
            margin-bottom: 10px;
        }

        .box p {
            margin: 15px 0;
        }

        .btn {
            display: inline-block;
            padding: 12px 20px;
            background: #2ecc71;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .btn:hover {
            background: #27ae60;
        }
    </style>
</head>

<body>

<div class="box">
    <h1>⚠ Something went wrong</h1>

    <p>Sorry! An unexpected error occurred.</p>

    <p>Please try again or go back to dashboard.</p>

    <a href="${pageContext.request.contextPath}/views/dashboard.jsp" class="btn">
        Go to Dashboard
    </a>
</div>

</body>
</html>
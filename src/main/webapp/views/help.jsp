<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Help Requests</title>

    <style>
        body {
            font-family: 'Segoe UI';
            background: #f4f6f9;
            padding: 30px;
        }

        .box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            width: 500px;
            margin: auto;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            margin-top: 15px;
            padding: 10px;
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 6px;
            width: 100%;
        }

        button:hover {
            background: #219150;
        }

        /* ✅ SUCCESS MESSAGE */
        .success {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: bold;
        }

        /* ❌ ERROR MESSAGE */
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="box">

    <h2>📩 Submit Help Request</h2>

    <!-- ✅ MESSAGE SHOW -->
    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
    %>

    <% if ("1".equals(success)) { %>
        <div class="success">
            ✅ Successfully submitted your problem. It will be resolved very soon!
        </div>
    <% } %>

    <% if ("1".equals(error)) { %>
        <div class="error">
            ❌ Something went wrong. Please try again!
        </div>
    <% } %>

    <!-- FORM -->
    <form action="${pageContext.request.contextPath}/submit-help" method="post">

        <label>Your Query:</label>
        <textarea name="query" required></textarea>

        <button type="submit">Submit</button>

    </form>

</div>

</body>
</html>
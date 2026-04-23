<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Crop Recommendation</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>

<body>

<div class="container">

    <h2 class="title" style="color:red;">🌱 Crop Recommendation</h2>

    <form action="${pageContext.request.contextPath}/predict" method="post">

        <input type="number" name="n" placeholder="Nitrogen" required>
        <input type="number" name="p" placeholder="Phosphorus" required>
        <input type="number" name="k" placeholder="Potassium" required>
        <input type="number" name="temp" placeholder="Temperature" required>
        <input type="number" name="humidity" placeholder="Humidity" required>
        <input type="number" name="ph" placeholder="pH Value" required>
        <input type="number" name="rain" placeholder="Rainfall" required>

        <button type="submit">🔍 Predict Crop</button>

    </form>

</div>

</body>
</html>
<%@ page import="java.sql.*, com.crop.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reports Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
        }

        /* HEADER */
        .header {
            background: linear-gradient(45deg, #1d2b64, #27ae60);
            color: white;
            padding: 20px;
            font-size: 22px;
            text-align: center;
        }

        /* CONTAINER */
        .container {
            width: 90%;
            margin: 30px auto;
        }

        /* CARDS */
        .cards {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            flex: 1;
            min-width: 220px;
            padding: 25px;
            border-radius: 12px;
            color: white;
            font-size: 18px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .card h3 {
            margin: 0;
            font-size: 16px;
            opacity: 0.9;
        }

        .card p {
            font-size: 28px;
            margin-top: 10px;
            font-weight: bold;
        }

        .green { background: #27ae60; }
        .blue { background: #3498db; }
        .orange { background: #f39c12; }
        .red { background: #e74c3c; }

        /* TABLE */
        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th {
            background: #2ecc71;
            color: white;
            padding: 12px;
        }

        td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f1f1f1;
        }
    </style>
</head>

<body>

<div class="header">
     Smart Agriculture Reports
</div>

<div class="container">

<%
Connection con = DBConnection.getConnection();

int total = 0;
int resolved = 0;
int pending = 0;

if(con != null){

    Statement st = con.createStatement();

    ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM help_requests");
    if(rs1.next()) total = rs1.getInt(1);

    ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM help_requests WHERE status='Resolved'");
    if(rs2.next()) resolved = rs2.getInt(1);

    ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM help_requests WHERE status='Pending'");
    if(rs3.next()) pending = rs3.getInt(1);
}
%>

<!--  CARDS -->
<div class="cards">

    <div class="card green">
        <h3>Total Requests</h3>
        <p><%= total %></p>
    </div>

    <div class="card blue">
        <h3>Resolved</h3>
        <p><%= resolved %></p>
    </div>

    <div class="card orange">
        <h3>Pending</h3>
        <p><%= pending %></p>
    </div>

    <div class="card red">
        <h3>Response Rate</h3>
        <p>
            <%= total == 0 ? "0%" : (resolved * 100 / total) + "%" %>
        </p>
    </div>

</div>

<!--  TABLE -->
<h3 style="margin-top:30px;">Recent Help Requests</h3>

<table>
<tr>
    <th>ID</th>
    <th>User</th>
    <th>Query</th>
    <th>Status</th>
</tr>

<%
if(con != null){

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM help_requests ORDER BY id DESC LIMIT 5"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getString("query") %></td>
    <td><%= rs.getString("status") %></td>
</tr>

<%
    }
}
%>

</table>

</div>

</body>
</html>
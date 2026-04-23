<%@ page import="java.sql.*, com.crop.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Help Requests</title>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            margin: 0;
        }

        h2 {
            text-align: center;
            margin-top: 20px;
        }

        /* TABLE */
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th {
            background: #27ae60;
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

        /* STATUS */
        .pending {
            color: orange;
            font-weight: bold;
        }

        .resolved {
            color: green;
            font-weight: bold;
        }

        /* ERROR BOX */
        .error-box {
            text-align: center;
            color: red;
            margin-top: 30px;
            font-size: 18px;
        }

    </style>
</head>

<body>

<h2> Help Requests</h2>

<%
Connection con = DBConnection.getConnection();

if(con == null){
%>
    <div class="error-box">
         Database Connection Failed! Check DB settings.
    </div>
<%
} else {

    PreparedStatement ps = con.prepareStatement("SELECT * FROM help_requests");
    ResultSet rs = ps.executeQuery();
%>

<table>
<tr>
    <th>ID</th>
    <th>User</th>
    <th>Query</th>
    <th>Status</th>
</tr>

<%
    while(rs.next()){
        String status = rs.getString("status");
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getString("query") %></td>
    <td class="<%= status.equalsIgnoreCase("Resolved") ? "resolved" : "pending" %>">
        <%= status %>
    </td>
</tr>
<%
    }
%>

</table>

<%
}
%>

</body>
</html>
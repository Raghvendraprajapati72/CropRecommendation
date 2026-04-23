<%@ page import="java.sql.*" %>
<%@ page import="com.crop.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Help Requests</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
        }

        .container {
            padding: 30px;
        }

        h2 {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        th {
            background: #2c3e50;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f1f1f1;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            color: white;
        }

        .resolve {
            background: #27ae60;
        }

        .pending {
            color: orange;
            font-weight: bold;
        }

        .done {
            color: green;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 20px;
            color: gray;
        }

        .error {
            color: red;
        }
    </style>
</head>

<body>

<div class="container">

<h2> Help Requests</h2>

<table>
<tr>
    <th>ID</th>
    <th>User</th>
    <th>Query</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean hasData = false;

try {
    con = DBConnection.getConnection();

    if (con == null) {
        throw new Exception("Database connection failed");
    }

    ps = con.prepareStatement("SELECT * FROM help_requests");
    rs = ps.executeQuery();

    while(rs.next()){
        hasData = true;
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getString("query") %></td>

    <td>
        <span class="<%= rs.getString("status").equalsIgnoreCase("Resolved") ? "done" : "pending" %>">
            <%= rs.getString("status") %>
        </span>
    </td>

    <td>
        <a class="btn resolve"
           href="<%= request.getContextPath() %>/updateStatus?id=<%= rs.getInt("id") %>">
           Resolve
        </a>
    </td>
</tr>

<%
    }

    if(!hasData){
%>

<tr>
    <td colspan="5" class="empty">No Help Requests Found</td>
</tr>

<%
    }

} catch(Exception e){
%>

<tr>
    <td colspan="5" class="error">Error: <%= e.getMessage() %></td>
</tr>

<%
} finally {
    try { if(rs != null) rs.close(); } catch(Exception e){}
    try { if(ps != null) ps.close(); } catch(Exception e){}
    try { if(con != null) con.close(); } catch(Exception e){}
}
%>

</table>

</div>

</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{background:#f4f6f9;}
.sidebar{height:100vh;background:#1e293b;color:white;}
.sidebar a{color:white;text-decoration:none;display:block;padding:8px;border-radius:6px;}
.sidebar a:hover{background:#334155;}
.active-menu{background:#22c55e;color:white !important;}
.topbar{background:white;box-shadow:0 2px 5px rgba(0,0,0,0.1);}
.card{border:none;border-radius:12px;box-shadow:0 4px 10px rgba(0,0,0,0.05);}
</style>
</head>

<body>

<div class="d-flex">

<!--  SIDEBAR -->
<div class="sidebar p-3" style="width:250px;">
    <h4> AgriAdmin</h4>
    <hr>

    <a href="${pageContext.request.contextPath}/admin"
       class="${showDashboard ? 'active-menu' : ''}">
        Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/admin?view=users"
       class="${showUsers ? 'active-menu' : ''}">
        Users
    </a>
</div>

<!--  MAIN -->
<div class="flex-grow-1">

<!--  TOPBAR -->
<div class="d-flex justify-content-between p-3 topbar">
    <h5>Admin Dashboard</h5>
    <div>
         ${sessionScope.user}
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-danger ms-2">Logout</a>
    </div>
</div>

<div class="p-4">

<!-- ================= DASHBOARD ================= -->
<c:if test="${showDashboard}">

<div class="row mb-4">
    <div class="col-md-4">
        <div class="card p-3 text-center">
            <h6>Total Users</h6>
            <h3 id="totalUsers">0</h3>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-3 text-center">
            <h6>Admins</h6>
            <h3 id="adminCount">0</h3>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-3 text-center">
            <h6>Users</h6>
            <h3 id="userCount">0</h3>
        </div>
    </div>
</div>

<div class="card p-3">
    <h5>User Analytics</h5>
    <canvas id="userChart"></canvas>
</div>

</c:if>

<!-- ================= USERS ================= -->
<c:if test="${showUsers}">

<div class="card p-3">
<h5>User Management</h5>

<table id="userTable" class="table table-striped">
<thead class="table-dark">
<tr>
    <th>ID</th>
    <th>Username</th>
    <th>Role</th>
    <th>Status</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<c:forEach var="u" items="${users}">
<tr>
    <td>${u.id}</td>
    <td>${u.username}</td>

    <td><span class="badge bg-success">${u.role}</span></td>

    <td>
        <span class="badge 
        ${u.status == 'active' ? 'bg-success' : 'bg-danger'}">
        ${u.status}
        </span>
    </td>

    <td>
        <button class="btn btn-sm btn-danger"
            onclick="deleteUserAjax('${u.id}', this)">Delete</button>

        <button class="btn btn-sm btn-warning"
            onclick="toggleUser('${u.id}')">Toggle</button>
    </td>
</tr>
</c:forEach>
</tbody>
</table>

</div>

</c:if>

</div>
</div>
</div>
<a href="${pageContext.request.contextPath}/admin?view=help"
   class="${showHelp ? 'active-menu' : ''}">
    Help Requests
</a>
<script>
$(document).ready(function () {
    $('#userTable').DataTable({ pageLength: 5 });
    loadChart();
});

function loadChart(){
    let admin = 0, user = 0;

    document.querySelectorAll("#userTable tbody tr").forEach(row => {
        let role = row.cells[2].innerText.trim();
        if(role === "admin") admin++;
        else user++;
    });

    document.getElementById("totalUsers").innerText = admin + user;
    document.getElementById("adminCount").innerText = admin;
    document.getElementById("userCount").innerText = user;

    new Chart(document.getElementById('userChart'), {
        type: 'bar',
        data: {
            labels: ['Admin', 'Users'],
            datasets: [{
                label: 'Users',
                data: [admin, user]
            }]
        }
    });
}

function deleteUserAjax(id, btn){
    if(confirm("Delete user?")){
        fetch("${pageContext.request.contextPath}/deleteUser?id=" + id)
        .then(res => res.text())
        .then(data => {
            if(data === "success"){
                btn.closest("tr").remove();
                location.reload();
            }
        });
    }
}

function toggleUser(id){
    fetch("${pageContext.request.contextPath}/toggleUser?id=" + id)
    .then(res => res.text())
    .then(data => {
        if(data === "success"){
            location.reload();
        }
    });
}
</script>
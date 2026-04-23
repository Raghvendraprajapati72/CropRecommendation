<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>Prediction History</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body class="bg-light">

<div class="container mt-4">

    <div class="d-flex justify-content-between">
        <h3>📜 Prediction History</h3>
        <a href="${pageContext.request.contextPath}/views/FarmerDashboard.jsp"
           class="btn btn-primary btn-sm">← Dashboard</a>
    </div>

    <!-- EMPTY STATE -->
    <c:if test="${empty historyList}">
        <div class="alert alert-warning mt-3 text-center">
            No history found 🚫
        </div>
    </c:if>

    <!-- 🔍 FILTER -->
    <div class="row mb-3 mt-3">
        <div class="col-md-3">
            <input type="date" id="fromDate" class="form-control">
        </div>
        <div class="col-md-3">
            <input type="date" id="toDate" class="form-control">
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" onclick="filterTable()">Filter</button>
        </div>
        <div class="col-md-3 text-end">
            <button class="btn btn-success" onclick="exportTable()">Export Excel</button>
        </div>
    </div>

    <!-- 📊 CHART -->
    <div class="card p-3 mb-4">
        <canvas id="historyChart"></canvas>
    </div>

    <!-- TABLE -->
    <table id="historyTable" class="table table-bordered table-hover bg-white">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Crop</th>
                <th>Temp</th>
                <th>Humidity</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="h" items="${historyList}">
                <tr>
                    <td>${h.id}</td>

                    <!-- ✅ FIX -->
                    <td><span class="badge bg-success">${h.result}</span></td>

                    <td>${h.temperature} °C</td>
                    <td>${h.humidity} %</td>

                    <td class="date">${h.date}</td>

                    <td>
                        <button class="btn btn-danger btn-sm"
                            onclick="deleteHistory(${h.id}, this)">
                            Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</div>

<script>
let table;
let chart;

// INIT
$(document).ready(function () {
    table = $('#historyTable').DataTable({
        pageLength: 5
    });

    loadChart();
});


// 📊 CHART
function loadChart(){

    let labels = [];
    let data = [];

    document.querySelectorAll("#historyTable tbody tr").forEach(row => {
        labels.push(row.cells[1].innerText);
        data.push(parseFloat(row.cells[2].innerText));
    });

    if(chart){
        chart.destroy(); // 🔥 prevent duplicate
    }

    chart = new Chart(document.getElementById("historyChart"), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Temperature',
                data: data
            }]
        }
    });
}


// 🔍 FILTER
function filterTable(){

    let from = document.getElementById("fromDate").value;
    let to = document.getElementById("toDate").value;

    document.querySelectorAll("#historyTable tbody tr").forEach(row => {

        let date = row.querySelector(".date").innerText.substring(0,10);

        if((!from || date >= from) && (!to || date <= to)){
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });

    loadChart(); // update chart
}


// 📥 EXPORT
function exportTable(){
    let table = document.getElementById("historyTable").outerHTML;

    let blob = new Blob([table], { type: "application/vnd.ms-excel" });
    let url = URL.createObjectURL(blob);

    let a = document.createElement("a");
    a.href = url;
    a.download = "history.xls";
    a.click();
}


// 🗑 DELETE
function deleteHistory(id, btn){

    if(confirm("Delete this record?")){

        fetch("${pageContext.request.contextPath}/deleteHistory?id=" + id)
        .then(res => res.text())
        .then(data => {

            if(data === "success"){
                btn.closest("tr").remove();
                loadChart(); // 🔥 update chart
            } else {
                alert("Delete failed");
            }
        });
    }
}
</script>

</body>
</html>
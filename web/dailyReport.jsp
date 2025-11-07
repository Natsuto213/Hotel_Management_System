<%-- 
    Document   : pendingTasks
    Created on : Nov 1, 2025, 4:10:15 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <title>Daily Report</title>
    <link rel="stylesheet" href="css/homeStyle.css"/>
    <link rel="stylesheet" href="css/recepDashboardStyle.css"/>
    <link rel="stylesheet" href="css/tableStyle.css"/>
<head>
    <title>Báo cáo vệ sinh hằng ngày</title>
    <style>
        body { font-family: Arial; background: #f4f6f9; padding: 20px; }
        h2 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        a { text-decoration: none; color: #007bff; }
    </style>
</head>
<body>

<h2>BÁO CÁO VỆ SINH HẰNG NGÀY</h2>

<table>
    <tr>
        <th>Ngày dọn</th>
        <th>Phòng</th>
        <th>Loại</th>
        <th>Nhân viên</th>
        <th>Trạng thái</th>
    </tr>

    <c:forEach var="r" items="${REPORT}">
        <tr>
            <td>${r.date}</td>
            <td>${r.room}</td>
            <td>${r.type}</td>
            <td>${r.staff}</td>
            <td>${r.status}</td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="HousekeepingController?action=dashboard">⬅ Quay lại Dashboard</a>

</body>
</html>

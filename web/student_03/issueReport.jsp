<%-- 
    Document   : issueReport
    Created on : Nov 1, 2025, 10:21:23 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <title>yêu bảo trì</title>
    <link rel="stylesheet" href="css/homeStyle.css"/>
    <link rel="stylesheet" href="css/recepDashboardStyle.css"/>
    <link rel="stylesheet" href="css/tableStyle.css"/>
<head><title>Maintenance Issue Report</title></head>
<body>
<h2>Yêu cầu bảo trì</h2>
<style>
        body { font-family: Arial; background: #f4f6f9; padding: 20px; }
        h2 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        a { text-decoration: none; color: #007bff; }
    </style>
<table border="1">
    <tr>
        <th>Phòng</th>
        <th>Yêu cầu bảo trì</th>
        <th>Ngày báo cáo</th>
        <th>Trạng thái</th>
        <th>Bảo trì bởi</th>
    </tr>
    <c:forEach var="row" items="${ISSUES}">
        <tr>
            <td>${row.room}</td>
            <td>${row.desc}</td>
            <td>${row.date}</td>
            <td>${row.status}</td>
            <td>${row.fixed}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
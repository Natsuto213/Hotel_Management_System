<%-- 
    Document   : report4
    Created on : Nov 2, 2025, 9:40:56 PM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doanh thu dịch vụ</title>
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
<body class="receptionish-dashboard">

<h2 class="table-title">Báo cáo 4: Doanh thu dịch vụ</h2>
<table class="table-center">
    <tr>
        <th>Tên dịch vụ</th>
        <th>Tổng số lượng</th>
        <th>Tổng doanh thu</th>
        <th>Kỳ báo cáo</th>
    </tr>
    <c:forEach var="item" items="${LIST}">
        <tr>
            <td>${item.serviceName}</td>
            <td>${item.quantity}</td>
            <td>${item.totalRevenue}</td>
            <td>${item.period}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>


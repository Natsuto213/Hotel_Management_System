<%-- 
    Document   : report2
    Created on : Nov 2, 2025, 9:20:11 PM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dịch vụ đang chờ</title>
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

<h2 class="table-title">Báo cáo 2: Dịch vụ đang chờ</h2>
<table class="table-center">
    <tr>
        <th>Thời gian yêu cầu</th>
        <th>Tên khách</th>
        <th>Số phòng</th>
        <th>Tên dịch vụ</th>
        <th>Số lượng</th>
        <th>Nhân viên phụ trách</th>
    </tr>
    <c:forEach var="item" items="${LIST}">
        <tr>
            <td>${item.requestTime}</td>
            <td>${item.guestName}</td>
            <td>${item.roomNumber}</td>
            <td>${item.serviceName}</td>
            <td>${item.quantity}</td>
            <td>${item.assignedStaff}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>


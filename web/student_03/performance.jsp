<%-- 
    Document   : performance
    Created on : Nov 1, 2025, 10:35:47 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Housekeeping Staff Performance</title></head>
<body>
<h2>Đánh giá hiệu suất nhân viên dọn phòng</h2>
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
        <th>Tên nhân viên</th>
        <th>Phòng đã vệ sinh</th>
        <th>Vệ sinh sâu </th>
        <th>Ngày</th>
    </tr>
    <c:forEach var="row" items="${PERFORMANCE}">
        <tr>
            <td>${row.staff}</td>
            <td>${row.rooms}</td>
            <td>${row.deep}</td>
            <td>${row.date}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
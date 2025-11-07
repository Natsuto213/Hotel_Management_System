<%-- 
    Document   : statusReport
    Created on : Nov 1, 2025, 4:51:51 PM
    Author     : Admin
--%>

<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>Báo cáo trạng thái phòng</title>
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
    <h1>Báo cáo trạng thái phòng</h1>

    <table>
        <tr>
            <th>Mã phòng</th>
            <th>Loại phòng</th>
            <th>Trạng thái</th>
            <th>Nhân viên phụ trách</th>
        </tr>

        <c:forEach var="room" items="${ROOMS}">
            <tr>
                <td>${room.roomID}</td>
                <td>${room.roomType}</td>
                <td>${room.status}</td>
                <td>${room.staffName}</td>
            </tr>
        </c:forEach>
    </table>

    <c:if test="${empty ROOMS}">
        <p style="text-align:center; color:red;">Không có dữ liệu phòng nào để hiển thị.</p>
    </c:if>

    <div style="text-align:center;">
        <a href="HousekeepingDashboard.jsp">⬅ Quay lại Dashboard</a>
    </div>
</body>
</html>

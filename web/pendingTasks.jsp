<%-- 
    Document   : pendingTasks
    Created on : Nov 1, 2025, 4:44:05 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Pending Cleaning Tasks</title>
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
    <h2>Danh sách công việc dọn phòng đang chờ xử lý</h2>

    <c:if test="${empty TASKS}">
        <p>Không có công việc nào đang chờ.</p>
    </c:if>

    <c:if test="${not empty TASKS}">
        <table>
            <tr>
                <th>Mã phòng</th>
                <th>Tên nhân viên</th>
                <th>Thời gian giao việc</th>
                <th>Trạng thái</th>
            </tr>
            <c:forEach var="task" items="${TASKS}">
                <tr>
                    <td>${task.roomNumber}</td>
                    <td>${task.staffName}</td>
                    <td>${task.assignedTime}</td>
                    <td>${task.status}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>

    <a href="HousekeepingController?action=dashboard" class="button">⬅ Quay lại Dashboard</a>
</body>
</html>

<%-- 
    Document   : Service
    Created on : Nov 2, 2025, 11:38:29 AM
    Author     : Admin
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Staff Dashboard</title>
    <link rel="stylesheet" href="css/homeStyle.css"/>
    <link rel="stylesheet" href="css/recepDashboardStyle.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <style>
        .create-btn {
            display: inline-block;
            margin: 10px;
            padding: 12px 25px;
            background-color: #007bff;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
            min-width: 220px;
            text-align: center;
        }

        .create-btn:hover {
            background-color: #0056b3;
        }

        .report-buttons {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 30px;
            padding: 0 20px;
        }

        main {
            margin-top: 100px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
    </style>
</head>

<body class="receptionish-dashboard">
<c:set var="staff" value="${sessionScope.STAFF}" />

<c:choose>
    <c:when test="${staff != null}">
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=service" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>
                <nav class="main-nav">
                    <span class="welcome">
                        <i class="fa-solid fa-user"></i> Xin chào, ${staff.username}!
                    </span>
                    <a href="LogoutController" class="nav-button-primary">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                    </a>
                </nav>
            </div>
        </header>

        <main>
            <h1>Service Staff Dashboard</h1>
            <p style="color: #555;">Chọn loại báo cáo bạn muốn xem:</p>

            <div class="report-buttons">
                <a href="${pageContext.request.contextPath}/ServiceStaffController?action=report1" class="create-btn">
                    <i class="fa-solid fa-list"></i> Báo cáo 1: Dịch vụ hôm nay
                </a>
                <a href="${pageContext.request.contextPath}/ServiceStaffController?action=report2" class="create-btn">
                    <i class="fa-solid fa-clock"></i> Báo cáo 2: Dịch vụ đang chờ
                </a>
                <a href="${pageContext.request.contextPath}/ServiceStaffController?action=report3" class="create-btn">
                    <i class="fa-solid fa-user-check"></i> Báo cáo 3: Hiệu suất nhân viên
                </a>
                <a href="${pageContext.request.contextPath}/ServiceStaffController?action=report4" class="create-btn">
                    <i class="fa-solid fa-chart-line"></i> Báo cáo 4: Doanh thu dịch vụ
                </a>                
            </div>
        </main>
    </c:when>

    <c:otherwise>
        <jsp:forward page="login.jsp"/>
    </c:otherwise>
</c:choose>

</body>
</html>

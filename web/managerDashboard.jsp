<%-- 
    Document   : managerDashboard
    Created on : Nov 6, 2025, 2:46:39 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Dashboard Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            /* =========================
               BƯỚC 2: THÊM CSS HEADER
               ========================= */
            :root {
                /* Lấy màu chủ đạo từ trang manager */
                --primary-color: #d63384;
            }

            .main-header {
                background-color: #ffffff;
                border-bottom: 1px solid #ddd;
                padding: 12px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }

            .main-header .container {
                /* Thêm class container để giữ cho nội dung header thẳng hàng */
                display: flex;
                justify-content: space-between;
                align-items: center;
                width: 100%;
            }

            .logo {
                font-size: 22px;
                font-weight: 600;
                color: var(--primary-color);
                text-decoration: none;
                transition: color 0.3s ease;
            }
            .logo:hover {
                color: #a01549; /* Màu hover đậm hơn */
            }

            .main-nav {
                display: flex;
                gap: 16px;
                align-items: center;
            }

            .welcome {
                color: #333;
                text-decoration: none;
                font-weight: 500;
                padding: 8px 0;
            }
            .welcome:hover {
                color: var(--primary-color);
            }

            .nav-button-primary {
                background-color: var(--primary-color);
                color: white;
                border: 1px solid var(--primary-color);
                padding: 8px 16px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                transition: background-color 0.3s;
            }
            .nav-button-primary:hover {
                background-color: #a01549; /* Màu hover đậm hơn */
            }

            /* ================================= 
               BƯỚC 3: SỬA CSS CŨ
               ================================= */

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #fff5f7 0%, #ffe0e8 100%);
                /* XÓA padding: 20px; để header chiếm toàn bộ chiều rộng */
                padding: 0;
                min-height: 100vh;
            }

            /* Thêm container để bọc nội dung chính */
            .manager-container {
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #d63384;
                /* THÊM margin-top để tạo khoảng cách với header */
                margin-top: 30px;
                margin-bottom: 30px;
                font-size: 2.5em;
                text-shadow: 2px 2px 4px rgba(214, 51, 132, 0.1);
            }

            h2 {
                color: #c2185b;
                margin-bottom: 20px;
                font-size: 1.5em;
                border-bottom: 3px solid #ffb3d9;
                padding-bottom: 10px;
            }

            /* (CSS còn lại giữ nguyên) */
            .revenue-report, .top10_guests_report, .most_used_services, .room_occupancy_rate {
                background: white;
                padding: 30px;
                margin-bottom: 30px;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(214, 51, 132, 0.15);
            }
            .tab-buttons {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }
            .tab-buttons button {
                padding: 12px 30px;
                border: none;
                background: linear-gradient(135deg, #ffb3d9 0%, #ff85c1 100%);
                color: white;
                border-radius: 8px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 3px 10px rgba(255, 133, 193, 0.3);
            }
            .tab-buttons button:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 133, 193, 0.4);
                background: linear-gradient(135deg, #ff85c1 0%, #ff5ca8 100%);
            }
            .tab-content {
                background: #fff5f7;
                padding: 25px;
                border-radius: 10px;
                border: 2px solid #ffcce0;
            }
            form {
                display: flex;
                align-items: center;
                gap: 15px;
                flex-wrap: wrap;
            }
            label {
                color: #c2185b;
                font-weight: 600;
                font-size: 16px;
            }
            input[type="date"], input[type="month"], input[type="number"] {
                padding: 10px 15px;
                border: 2px solid #ffb3d9;
                border-radius: 8px;
                font-size: 15px;
                transition: all 0.3s ease;
                background: white;
            }
            input[type="date"]:focus, input[type="month"]:focus, input[type="number"]:focus {
                outline: none;
                border-color: #ff85c1;
                box-shadow: 0 0 10px rgba(255, 133, 193, 0.3);
            }
            button[type="submit"] {
                padding: 10px 25px;
                background: linear-gradient(135deg, #d63384 0%, #c2185b 100%);
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 3px 10px rgba(214, 51, 132, 0.3);
            }
            button[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(214, 51, 132, 0.4);
                background: linear-gradient(135deg, #c2185b 0%, #a01549 100%);
            }
            .tab-content p {
                margin-top: 20px;
                font-size: 18px;
                color: #555;
            }
            .tab-content p b {
                color: #d63384;
                font-size: 22px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            }
            th {
                background: linear-gradient(135deg, #ffb3d9 0%, #ff85c1 100%);
                color: white;
                padding: 15px;
                text-align: left;
                font-weight: 600;
                font-size: 15px;
            }
            td {
                padding: 12px 15px;
                border-bottom: 1px solid #ffcce0;
                color: #555;
            }
            tr:hover {
                background: #fff5f7;
            }
            tr:last-child td {
                border-bottom: none;
            }
            
            .room_occupancy_rate{
                height: fit-content;
            }
            
            .room_occupancy_rate span {
                display: inline-block;
                padding: 15px 30px;
                background: linear-gradient(135deg, #ffb3d9 0%, #ff85c1 100%);
                color: white;
                border-radius: 8px;
                font-size: 24px;
                font-weight: 700;
                box-shadow: 0 4px 12px rgba(255, 133, 193, 0.3);
            }

            p {
                color: #888;
                font-style: italic;
            }
        </style>
    </head>

    <body>

        <c:set var="staff" value="${sessionScope.STAFF}"/>
        <c:choose>
            <c:when test="${staff != null && staff.role == 'Manager'}">

                <header class="main-header">
                    <div class="container">
                        <a href="#" class="logo">
                            <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                        </a>
                        <nav class="main-nav">
                            <a href="#" class="welcome">

                                <i class="fa-solid fa-user-shield"></i> Xin chào, ${staff.username}!
                            </a>
                            <a href="MainController?action=logoutUser" class="nav-button-primary">
                                <i class="fa-solid fa-user-minus"></i> Đăng xuất
                            </a>
                        </nav>
                    </div>
                </header>

                <div class="manager-container">

                    <c:set var="top10" value="${requestScope.Top10Guest}"/>
                    <c:set var="mostUseService" value="${requestScope.MostUsedService}"/>
                    <c:set var="occupancyRate" value="${requestScope.OccupancyRate}"/>
                    <c:set var="cancellationRate" value="${requestScope.CancellationRate}"/>

                    <h1>THIS IS MANAGER DASHBOARD</h1>

                    <div style="display: flex; justify-content: space-between; gap: 10px">
                        <div class="revenue-report"> 
                            <h2>Revenue Report</h2>
                            <div class="tab-buttons">
                                <button type="button" onclick="showTab('daily')">Daily</button>
                                <button type="button" onclick="showTab('monthly')">Monthly</button>
                                <button type="button" onclick="showTab('yearly')">Yearly</button>
                            </div>

                            <div id="daily" class="tab-content" style="display:none;">
                                <form action="MainController" method="post">
                                    <input type="hidden" name="type" value="daily">
                                    <label>Select Date:</label>
                                    <input type="date" name="date" required="">
                                    <button type="submit" name="action" value="revenueReport">View Revenue</button>
                                </form>
                                <c:if test="${not empty dailyRevenue}">
                                    <p>Revenue for ${param.date}: <b><fmt:formatNumber value="${requestScope.dailyRevenue}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</b></p>
                                </c:if>
                            </div>

                            <div id="monthly" class="tab-content" style="display:none;">
                                <form action="MainController" method="post">
                                    <input type="hidden" name="type" value="monthly">
                                    <label>Select Month:</label>
                                    <input type="month" name="month" required="">
                                    <button type="submit" name="action" value="revenueReport">View Revenue</button>
                                </form>
                                <c:if test="${not empty monthlyRevenue}">
                                    <p>Revenue for ${param.month}: <b><fmt:formatNumber value="${requestScope.monthlyRevenue}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</b></p>
                                </c:if>
                            </div>

                            <div id="yearly" class="tab-content" style="display:none;">
                                <form action="MainController" method="post">
                                    <input type="hidden" name="type" value="yearly">
                                    <label>Select Year:</label>
                                    <input type="number" name="year" min="2000" max="2100" required="">
                                    <button type="submit" name="action" value="revenueReport">View Revenue</button>
                                </form>
                                <c:if test="${not empty yearlyRevenue}">
                                    <p>Revenue for ${param.year}: <b><fmt:formatNumber value="${requestScope.yearlyRevenue}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</b></p>
                                </c:if>
                            </div>
                        </div>

                        <div class="room_occupancy_rate">
                            <h2>Room occupancy rate per month: </h2>
                            <c:choose>
                                <c:when test="${occupancyRate != null}">
                                    <span>${occupancyRate}</span>
                                </c:when>
                                <c:otherwise>
                                    <p>No data</p>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="room_occupancy_rate">
                            <h2>Cancellation rate: </h2>
                            <c:choose>
                                <c:when test="${cancellationRate != null}">
                                    <span>${cancellationRate}</span>
                                </c:when>
                                <c:otherwise>
                                    <p>No data</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>


                    <div class="top10_guests_report">
                        <h2>TOP 10 FREQUENT GUESTS</h2>
                        <c:choose>
                            <c:when test="${top10 != null && not empty top10}">

                                <table>
                                    <tr>
                                        <th>No.</th>
                                        <th>ID</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Phone Number</th>
                                        <th>Total Bookings</th>
                                    </tr>
                                    <c:forEach var="g" items="${top10}" varStatus="status">
                                        <tr>
                                            <td>${status.count}</td>
                                            <td>${g.guestId}</td>
                                            <td>${g.fullname}</td>
                                            <td>${g.email}</td>
                                            <td>${g.phone}</td>
                                            <td>${g.totalBooking}</td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p>No data</p>

                            </c:otherwise>
                        </c:choose>
                    </div>


                    <div class="most_used_services">
                        <h2>TOP 10 MOST USED SERVICES</h2>
                        <c:choose>
                            <c:when test="${mostUseService != null && not empty mostUseService}">
                                <table>
                                    <tr>
                                        <th>Service ID</th>
                                        <th>Service Name</th>
                                        <th>Service Type</th>
                                        <th>Total Used</th>
                                    </tr>
                                    <c:forEach var="s" items="${mostUseService}">
                                        <tr>
                                            <td>${s.serviceid}</td>
                                            <td>${s.servicename}</td>
                                            <td>${s.servicetype}</td>
                                            <td>${s.totalUsed}</td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p>No data</p>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <script>
                        function showTab(tabName) {
                            document.querySelectorAll('.tab-content').forEach(tab => tab.style.display = 'none');
                            document.getElementById(tabName).style.display = 'block';
                        }

                        // Lấy giá trị activeTab từ server
                        const activeTab = '${requestScope.activeTab}';
                        if (activeTab) {
                            showTab(activeTab);
                        } else {
                            // Mặc định là daily nếu chưa có lựa chọn
                            showTab('daily');
                        }
                    </script>

                </div> </c:when>
            <c:otherwise>
                <%-- Nếu không phải Manager, chuyển về trang chủ --%>
                <jsp:forward page="home.jsp"/>
            </c:otherwise>
        </c:choose>

    </body>
</html>
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
    </head>
    <body>
        <c:set var="top10" value="${requestScope.Top10Guest}"/>
        <c:set var="mostUseService" value="${requestScope.MostUsedService}"/>
        <c:set var="occupancyRate" value="${requestScope.OccupancyRate}"/>

        <h1>THIS IS MANAGER DASHBOARD</h1>

        <div class="revenue-report" style="margin-top: 30px;">
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
    </body>
</html>

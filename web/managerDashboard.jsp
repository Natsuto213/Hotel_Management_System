<%-- 
    Document   : managerDashboard
    Created on : Nov 6, 2025, 2:46:39 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Dashboard Page</title>
    </head>
    <body>
        <c:set var="top10" value="${requestScope.TOP10GUEST}"/>

        <h1>THIS IS MANAGER DASHBOARD</h1>

        <c:if test="${top10 != null && not empty top10}">
            <div class="top10_guests_report">
                <h1>TOP 10 FREQUENT GUESTS</h1>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Total Bookings</th>
                    </tr>
                    <c:forEach var="g" items="${top10}">
                        <tr>
                            <td>${g.guestId}</td>
                            <td>${g.fullname}</td>
                            <td>${g.email}</td>
                            <td>${g.phone}</td>
                            <td>${g.totalBooking}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:if>
    </body>
</html>

<%-- 
    Document   : EditBooking
    Created on : Oct 17, 2025, 8:30:31 AM
    Author     : Admin
--%>

<%@page import="utils.IConstants"%>
<%@page import="model.Guest"%>
<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit booking Page</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/recepDashboardStyle.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body class="receptionish-dashboard">
        <%
            Staff staff = (Staff) session.getAttribute("STAFF");
            if (staff != null) {
        %>
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>
                <nav class="main-nav">
                    <span class="welcome">Xin chào, <%= staff.getUsername()%>!</span>
                    <a href="MainController?action=logout" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                </nav>
            </div>
        </header>

                    <h1 style="margin-top: 100px; text-align: center">Edit booking for ${requestScope.txtguestName}, id: ${requestScope.txtguestID}</h1>


        <form action="MainController" method="post">
            <input type="hidden" name="txtguestID" value="${requestScope.txtguestID}">
            <button class="create-btn" name="action" value="booking">Create booking for customer</button>
        </form>

        <c:set var="list" value="${requestScope.BookingList}"/>
        <c:if test="${list!=null && not empty list}">
            <table>
                <tr><th>Room ID</th><th>Room Number</th><th>Room Type</th><th>Check-in</th><th>Check-out</th><th>Status</th></tr>
                        <c:forEach var="b" items="${list}" >
                    <tr>
                        <td>${b.roomId}</td>
                        <td>${b.roomNumber}</td>
                        <td>${b.typeName}</td>
                        <td>${b.checkInDate}</td>
                        <td>${b.checkOutDate}</td>
                        <td>${b.status}</td>
                        <td>
                            <form action="action">


                            </form>
                        </td>
                    </tr>
                </c:forEach> 
            </table>
        </c:if>

        <%
            } else {
                request.getRequestDispatcher(IConstants.HOME).forward(request, response);
            }
        %>
    </body>
</html>

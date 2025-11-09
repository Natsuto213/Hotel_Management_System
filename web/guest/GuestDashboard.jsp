<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <c:set var="guest" value="${sessionScope.USER}"/>
    <c:set var="isLogin" value="${sessionScope.isLogin}"/>

    <c:if test="${guest == null}">
        <jsp:forward page="home.jsp"/>
    </c:if>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guest Dashboard</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/guestDashboard.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body class="guest-dashboard">
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>
                <nav class="main-nav">
                    <a href="MainController?action=findBookings" class="welcome">
                        <i class="fa-solid fa-user"></i> Xin chào, ${guest.username}!
                    </a>
                    <a href="MainController?action=logoutUser" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                </nav>
            </div>
        </header>

        <c:set var="bookinglist" value="${requestScope.BookingList}"/>

        <h1 style="margin-top: 80px; text-align: center">Bookings History</h1>

        <h1>${ERROR}</h1>

        <div class="booking-list""> 
            <c:choose>
                <c:when test="${bookinglist != null && not empty bookinglist}">
                    <table>
                        <tr>
                            <th>Room Number</th>
                            <th>Room Type</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        <c:forEach var="b" items="${bookinglist}">
                            <tr>
                                <td>${b.roomNumber}</td>
                                <td>${b.typeName}</td>
                                <td>${b.checkInDate}</td>
                                <td>${b.checkOutDate}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.status == 'Reserved'}">
                                            <span class="status-badge status-confirmed">${b.status}</span>
                                        </c:when>
                                        <c:when test="${b.status == 'Checked-in'}">
                                            <span class="status-badge status-checked-in">${b.status}</span>
                                        </c:when>
                                        <c:when test="${b.status == 'Checked-out'}">
                                            <span class="status-badge status-checked-out">${b.status}</span>
                                        </c:when>
                                        <c:when test="${b.status == 'Cancelled'}">
                                            <span class="status-badge status-cancelled">${b.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.status != 'Checked-out'}">
                                            <a href="MainController?action=bookingInformation&roomid=${b.roomId}&bookingid=${b.bookingId}&type=view" class="action-btn btn-view">View</a>
                                            <a href="MainController?action=bookingInformation&roomid=${b.roomId}&bookingid=${b.bookingId}&type=edit" class="action-btn btn-edit">Edit</a>
                                            <a href="MainController?action=preCheckout&roomid=${b.roomId}&bookingid=${b.bookingId}" class="action-btn btn-checkout">Checkout</a>
                                        </c:when>
                                        <c:otherwise>
                                            <p>...</p>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="not-found">Not have any booking yet</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>

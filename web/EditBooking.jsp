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
        <link rel="stylesheet" href="css/editBookingStyle.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body class="receptionish-dashboard">
        <c:set var="staff" value="${sessionScope.STAFF}"/>
        <c:choose>
            <c:when test="${staff!=null}">
                <header class="main-header">
                    <div class="container">
                        <a href="MainController?action=home" class="logo">
                            <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                        </a>
                        <nav class="main-nav">
                            <a href="MainController?action=recepDashboard" class="welcome">
                                <i class="fa-solid fa-user"></i> Xin chào, ${staff.username}!
                            </a>
                            <a href="MainController?action=logoutUser" class="nav-button-primary">
                                <i class="fa-solid fa-user-minus"></i> Đăng xuất
                            </a>
                        </nav>
                    </div>
                </header>
                <c:set var="guest" value="${sessionScope.USER}"/>
                <h1 style="margin-top: 100px; text-align: center">Edit booking for ${guest.fullname}, id: ${guest.guestId}</h1>
                <p style="margin-top: 12px; font-size: 20px; text-align: center">${requestScope.ERROR}</p>

                <form action="MainController" method="post" class="create-booking-form">
                    <button class="create-btn" name="action" value="booking">Create booking for customer</button>
                </form>

                <c:set var="list" value="${requestScope.BookingList}"/>
                <c:set var="roomList" value="${requestScope.RoomList}"/>
                <c:choose>
                    <c:when test="${list != null && not empty list}">
                        <table>
                            <tr>
                                <th>Room ID</th>
                                <th>Room Number</th>
                                <th>Room Type</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            <c:forEach var="b" items="${list}">
                                <form action="MainController" method="post">
                                    <tr>
                                        <td>${b.roomId}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${requestScope.assignBookingId != null && requestScope.assignBookingId == b.bookingId}">
                                                    ${b.roomNumber}
                                                    <select name="newRoomId" style="margin-left: 10px;">
                                                        <c:forEach var="r" items="${roomList}">
                                                            <option value="${r.roomId}">${r.roomNumber}</option>
                                                        </c:forEach>
                                                    </select>
                                                </c:when>
                                                <c:otherwise>
                                                    ${b.roomNumber}  
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status != 'Checked-in'}">
                                                    <select name="txtroomType" >
                                                        <option value="Single" ${b.typeName == 'Single' ? 'selected' : ''}>Single</option>
                                                        <option value="Double" ${b.typeName == 'Double' ? 'selected' : ''}>Double</option>
                                                        <option value="Suite" ${b.typeName == 'Suite' ? 'selected' : ''}>Suite</option>
                                                        <option value="Deluxe" ${b.typeName == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                                                        <option value="Family" ${b.typeName == 'Family' ? 'selected' : ''}>Family</option>
                                                        <option value="Presidential" ${b.typeName == 'Presidential' ? 'selected' : ''}>Presidential</option>
                                                    </select>
                                                </c:when>
                                                <c:otherwise>
                                                    ${b.typeName}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>       
                                            <c:choose>
                                                <c:when test="${b.status != 'Checked-in'}">
                                                    <input type="date" name="txtcheckin" value="${b.checkInDate}">  
                                                    <input type="hidden" name="txtroomType" value="${b.typeName}">  
                                                    <input type="hidden" name="bookingid" value="${b.bookingId}">
                                                    <input type="hidden" name="roomid" value="${b.roomId}">
                                                    <button type="submit" name="action" value="checkin">Check in</button>
                                                </c:when>
                                                <c:otherwise>
                                                    ${b.checkInDate}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status != 'Checked-in'}">
                                                    <input type="date" name="txtcheckout" value="${b.checkOutDate}">
                                                </c:when>
                                                <c:otherwise>
                                                    ${b.checkOutDate}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${b.status}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status != 'Checked-in'}">
                                                    <input type="hidden" name="bookingid" value="${b.bookingId}">
                                                    <input type="hidden" name="roomid" value="${b.roomId}">
                                                    <input type="hidden" name="txtroomType" value="${b.typeName}">
                                                    <button type="submit" name="action" value="update" style="margin-right: 10px">Update</button>
                                                    <button type="submit" name="action" value="remove" onclick="return window.confirm('Xác nhận xóa booking này')">Remove</button>
                                                </c:when>
                                                <c:when test="${requestScope.assignBookingId != null && requestScope.assignBookingId == b.bookingId}">
                                                    <input type="hidden" name="newRoomId" value="${r.roomId}">
                                                    <input type="hidden" name="oldRoomId" value="${b.roomId}">
                                                    <input type="hidden" name="bookingid" value="${b.bookingId}">
                                                    <button type="submit" name="action" value="confirmAssign">Confirm</button>
                                                    <button type="submit" name="action" value="cancelAssign">Cancel</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="roomid" value="${b.roomId}">
                                                    <input type="hidden" name="roomType" value="${b.typeName}">
                                                    <input type="hidden" name="bookingid" value="${b.bookingId}">
                                                    <button type="submit" name="action" value="assign">Assign Room</button>
                                                    <button type="submit" name="action" value="checkout" onclick="return window.confirm('Xác nhận checkout booking này')">Check out</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="not-found">Not have any booking yet</p>
                    </c:otherwise>
                </c:choose>

            </c:when>
            <c:otherwise>
                <jsp:forward page="home.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>

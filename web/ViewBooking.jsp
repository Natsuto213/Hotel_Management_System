<%-- 
    Document   : View_EditBooking
    Created on : Nov 5, 2025, 10:12:18 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Booking</title>
    </head>
    <body>
        <c:set var="guest" value="${sessionScope.USER}"/>
        <c:set var="room" value="${requestScope.ROOM}"/>
        <c:set var="roomType" value="${requestScope.ROOMTYPE}"/>
        <c:set var="booking" value="${requestScope.BOOKING}"/>
        <c:set var="payment" value="${requestScope.PAYMENT}"/>
        <c:set var="cart" value="${requestScope.CART}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}" />


        <div class="guest-info">
            <h1>Guest Information</h1>

            <label>Full Name</label>
            <p>${guest.fullname}</p>

            <label>Phone Number</label>
            <p>${guest.phone}</p>

            <label>Email</label>
            <p>${guest.email}</p>
        </div>

        <div class="booking-info">
            <h1>Booking Information</h1>

            <label>Room Number</label>
            <p>${room.roomNumber}</p>

            <label>Room Type</label>
            <p>${roomType.typeName}</p>

            <label>Check-in</label>
            <p>${booking.checkInDate}</p>

            <label>Check-out</label>
            <p>${booking.checkOutDate}</p>

            <label>Price per night</label>
            <p>${roomType.formattedPrice} VND</p>
        </div>

        <div class="service-info">
            <h1>Additional Services</h1>
            <c:if test="${cart == null || empty cart}">
                <h3>No service yet</h3>
            </c:if>
            <c:set var="serviceTotal" value="0" scope="page" />
            <c:forEach var="c" items="${cart}">
                <c:set var="subtotal" value="${c.price * c.quantity}" />
                <span>${c.servicename}</span>
                <span>${c.formattedPrice} VNÐ</span>
                <span>${c.quantity}</span>
                <span>${c.servicedate}</span>
                <br>
                <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
            </c:forEach>
        </div>

        <div class="payment-info">
            <h1>Payment Information</h1>
            <label>Method</label>
            <p>${payment.paymentMethod}</p>
            <label>Status</label>
            <p>${payment.status}</p>
        </div>

        <div class="summary">
            <h1>Booking Summary</h1>

            <fmt:parseDate var="checkInDate" value="${booking.checkInDate}" pattern="yyyy-MM-dd" />
            <fmt:parseDate var="checkOutDate" value="${booking.checkOutDate}" pattern="yyyy-MM-dd" />
            <c:set var="night" value="${(checkOutDate.time - checkInDate.time) / (1000*60*60*24)}" />
            <c:set var="roomTotal" value="${night * roomType.price}" />
            <c:set var="total" value="${roomTotal + serviceTotal}"/>

            <p>Room (<fmt:formatNumber value="${night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights):  <fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</p>
            <p>Total Service: <fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</p>
            <p>VAT (8%): <fmt:formatNumber value="${total * 0.08}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</p>
            <hr>
            <p>Total Amount: <fmt:formatNumber value="${total * 1.08}" type="number" groupingUsed="true"/> VND</p>
        </div>  
        <form action="MainController">
            <button type="submit" name="action" value="findBookings">Back To History</button>
        </form>
    </body>
</html>

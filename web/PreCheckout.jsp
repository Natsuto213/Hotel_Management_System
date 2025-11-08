<%-- 
    Document   : PreCheckout
    Created on : Nov 8, 2025, 10:32:47 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
    </head>
    <body>
        <h1>Checkout Page</h1>
        <c:set var="guest" value="${sessionScope.USER}"/>
        <c:set var="room" value="${requestScope.ROOM}"/>
        <c:set var="roomType" value="${requestScope.ROOMTYPE}"/>
        <c:set var="booking" value="${requestScope.BOOKING}"/>
        <c:set var="cart" value="${requestScope.CART}"/>


        <div class="guest-info">
            <h1>Guest Information</h1>
            <div>
                <label>Full Name</label>
                <p>${guest.fullname}</p>
            </div>
            <div>
                <label>Phone Number</label>
                <p>${guest.phone}</p>
            </div>
            <div>
                <label>Email</label>
                <p>${guest.email}</p>
            </div>
            <div>
                <label>ID Number</label>
                <p>${guest.idNumber}</p>
            </div>
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

        <form action="MainController" method="post">
            <div class="payment-info">
                <h1>Payment Method</h1>
                <label class="method-option">
                    <input type="radio" name="payment" value="Credit Card" required="">
                    <span class="custom-radio"></span>
                    <i class="fa-solid fa-credit-card icon"></i>
                    <span>Credit Card</span>
                </label><br>

                <label class="method-option">
                    <input type="radio" name="payment" value="Debit Card">
                    <span class="custom-radio"></span>
                    <i class="fa-regular fa-credit-card icon"></i>
                    <span>Debit Card</span>
                </label><br>

                <label class="method-option">
                    <input type="radio" name="payment" value="Transfer">
                    <span class="custom-radio"></span>
                    <i class="fa-solid fa-building-columns icon"></i>
                    <span>Bank Transfer</span>
                </label>
            </div>

            <div class="summary">
                <h1>Booking Summary</h1>
                <fmt:parseDate var="checkInDate" value="${booking.checkInDate}" pattern="yyyy-MM-dd" />
                <fmt:parseDate var="checkOutDate" value="${booking.checkOutDate}" pattern="yyyy-MM-dd" />

                <c:set var="night" value="${(checkOutDate.time - checkInDate.time) / (1000*60*60*24)}" />
                <c:set var="roomTotal" value="${night * roomType.price}" />
                <c:set var="total" value="${roomTotal + serviceTotal}"/>

                <p>Room (${night} nights): <span><fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</span></p>
                <p>Total Service: <span><fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</span></p>
                <p>VAT (8%): <fmt:formatNumber value="${total * 0.08}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</p>
                <hr>
                <p>Total Amount: <span><fmt:formatNumber value="${total * 1.08}" type="number" groupingUsed="true"/> VND</span></p>

                <input type="hidden" name="night" value="${night}">
                <input type="hidden" name="roomTotal" value="${roomTotal}">
                <input type="hidden" name="serviceTotal" value="${serviceTotal}">
                <input type="hidden" name="total" value="${total}">

                <input type="hidden" name="roomid" value="${room.roomId}">
                <input type="hidden" name="bookingid" value="${booking.bookingId}">

                <c:set var="isCheckout" value="${true}" scope="session"/>

                <button type="submit" name="action" value="home" class="btn btn-outline">Back To Home</button>
                <button type="submit" name="action" value="checkout" class="btn btn-primary">Confirm Checkout</button>
            </div>
        </form>

    </body>
</html>

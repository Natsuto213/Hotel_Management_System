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
        <title>Edit Booking</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <c:set var="guest" value="${sessionScope.USER}"/>
        <c:set var="room" value="${requestScope.ROOM}"/>
        <c:set var="roomType" value="${requestScope.ROOMTYPE}"/>
        <c:set var="booking" value="${requestScope.BOOKING}"/>
        <c:set var="payment" value="${requestScope.PAYMENT}"/>

        <c:set var="cart" value="${requestScope.CART}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}" />

        <h3>${param.MSG}</h3>

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
            <div class="new-service" >
                <label>Select Service</label>
                <form action="MainController" method="post">
                    <select name="serviceid" required="">
                        <option value="" disabled selected>-- Select Service --</option>
                        <c:forEach var="s" items="${servicelist}">
                            <option value="${s.serviceid}">${s.servicename} (+${s.formattedPrice})</option>
                        </c:forEach>
                    </select>
                    <input type="number" name="quantity" placeholder="enter quantity" required="">
                    <input type="text" name="serviceDate" placeholder="Service Date" 
                           onfocus="(this.type = 'date')" 
                           onblur="if (!this.value)
                                       this.type = 'text'"
                           required=""
                           >   
                    <input type="hidden" name="roomid" value="${param.roomid}" >
                    <input type="hidden" name="bookingid" value="${param.bookingid}" >
                    <input type="hidden" name="isPreBooking" value="false" >
                    <button type="submit" name="action" value="addService"><i class="fa-solid fa-plus"></i></button>
                </form>
            </div>

            <div class="view-service">
                <c:set var="serviceTotal" value="0" scope="page" />
                <c:forEach var="c" items="${cart}">
                    <c:set var="subtotal" value="${c.price * c.quantity}" />
                    <form action="MainController" method="post">
                        <span>${c.servicename}</span>
                        <span>${c.formattedPrice} VNÐ</span>
                        <span>${c.quantity}</span>
                        <span>${c.servicedate}</span>
                        <input type="hidden" name="serviceId" value="${c.serviceid}" >
                        <input type="hidden" name="serviceDate" value="${c.servicedate}" >
                        <input type="hidden" name="bookingid" value="${param.bookingid}" >
                        <input type="hidden" name="roomid" value="${param.roomid}" >
                        <button type="submit" name="action" value="deleteService"><i class="fa-solid fa-x"></i></button>
                    </form>
                    <br>
                    <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
                </c:forEach>
            </div>
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

            <input type="hidden" name="total" value="${total * 1.08}">
            <input type="hidden" name="roomid" value="${room.roomId}">
            <input type="hidden" name="bookingid" value="${booking.bookingId}">
            <button type="submit" name="action" value="confirmEdit">Confirm</button>
        </form>
    </body>
</html>

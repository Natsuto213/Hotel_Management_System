<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pre Booking Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:set var="guest" value="${sessionScope.USER}" />
        <c:set var="booking" value="${sessionScope.BOOKING}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}" />

        <div class="guest-info">
            <h1>Guest Information</h1>

            <label>Full Name</label>
            <p>${guest.fullname}</p>

            <label>Phone Number</label>
            <p>${guest.phone}</p>

            <label>Email</label>
            <p>${guest.email}</p>

            <label>ID Number</label>
            <p>${guest.idNumber}</p>
        </div>

        <div class="room-info">
            <h1>Room Information</h1>

            <label>Room Number</label>
            <p>${booking.roomNumber}</p>

            <label>Room Type</label>
            <p>${booking.typeName}</p>

            <label>Check-in</label>
            <p>${booking.checkInDate}</p>

            <label>Check-out</label>
            <p>${booking.checkOutDate}</p>

            <label>Capacity</label>
            <p>${booking.guests}</p>

            <label>Price per night</label>
            <p>${booking.formattedPrice} VND</p>
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
                        <button type="submit" name="action" value="deleteService"><i class="fa-solid fa-x"></i></button>
                    </form>
                    <br>
                    <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
                </c:forEach>
            </div>

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
                <c:set var="roomTotal" value="${night * booking.price}" />
                <c:set var="total" value="${roomTotal + serviceTotal}"/>

                <p>Room (${night} nights):  <fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</p>
                <p>Total Service: <fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</p>
                <hr>
                <p>Total Amount: <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VND</p>
            </div>

            <input type="hidden" name="night" value="${night}">
            <input type="hidden" name="roomTotal" value="${roomTotal}">
            <input type="hidden" name="serviceTotal" value="${serviceTotal}">
            <input type="hidden" name="total" value="${total}">

            <button type="submit" name="action" value="home">Back To Home</button>
            <button type="submit" name="action" value="createBooking">Confirm Booking</button>
        </form>
    </body>
</html>

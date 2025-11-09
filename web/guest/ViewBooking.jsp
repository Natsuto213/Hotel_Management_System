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
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* =================================
                GLOBAL & BODY STYLING
                ================================= */
            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f7f4f6;
                color: #333;
                line-height: 1.6;
                margin: 0;
                padding: 30px 15px;
            }

            /* Container cho toàn bộ form */
            .booking-view-container {
                max-width: 900px;
                margin: 0 auto;
            }

            .booking-success-message {
                background-color: #d4edda; /* Nền xanh lá nhạt */
                color: #155724;           /* Chữ xanh lá */
                border: 1px solid #c3e6cb;
                padding: 15px 20px;
                border-radius: 8px;
                text-align: center;       /* Căn giữa chữ */
                font-weight: 500;
                font-size: 1.1rem;
                margin-bottom: 25px;
            }

            /* =================================
                SUCCESS MESSAGE
                ================================= */
            .success-message {
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
            }
            .success-message::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f058"; /* fa-check-circle */
                font-size: 1.5rem;
            }

            /* =================================
                CARD STYLING
                ================================= */
            .guest-info,
            .booking-info,
            .service-info,
            .summary {
                background-color: #ffffff;
                border-radius: 12px;
                padding: 25px 30px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.07);
                margin-bottom: 25px;
            }

            /* =================================
                HEADER STYLING (h1)
                ================================= */
            h1 {
                font-size: 1.6rem;
                font-weight: 600;
                color: #a91370;
                margin-top: 0;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                display: flex;
                align-items: center;
                gap: 12px;
            }
            /* Tự động thêm icon vào H1 */
            .guest-info h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f007"; /* fa-user */
            }
            .booking-info h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f236"; /* fa-bed */
            }
            .service-info h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f560"; /* fa-concierge-bell */
            }
            .summary h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f570"; /* fa-file-invoice-dollar */
            }

            /* =================================
                INFO BLOCKS (Guest & Booking)
                ================================= */
            .guest-info,
            .booking-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 5px 20px;
            }
            .guest-info h1,
            .booking-info h1 {
                grid-column: 1 / -1;
            }
            .guest-info div,
            .booking-info div {
                margin-bottom: 10px;
            }
            .guest-info label,
            .booking-info label {
                display: block;
                font-weight: 600;
                color: #555;
                font-size: 0.9rem;
            }
            .guest-info p,
            .booking-info p {
                font-size: 1.1rem;
                margin: 0;
                color: #000;
            }

            /* =================================
                SERVICE INFO
                ================================= */
            .service-info h3 {
                color: #999;
                font-weight: 400;
                font-style: italic;
                text-align: center;
                margin: 20px 0;
            }

            .service-list {
                margin-top: 20px;
            }
            .service-item {
                display: flex;
                align-items: center;
                gap: 15px;
                padding: 12px 0;
                border-bottom: 1px solid #f0f0f0;
            }
            .service-item span:nth-child(1) {
                flex: 3;
                font-weight: 500;
            } /* Tên */
            .service-item span:nth-child(2) {
                flex: 2;
                color: #555;
            } /* Giá */
            .service-item span:nth-child(3) {
                flex: 1;
                text-align: center;
                color: #555;
            } /* SL */
            .service-item span:nth-child(4) {
                flex: 2;
                color: #555;
            } /* Ngày */

            /* =================================
                SUMMARY
                ================================= */
            .summary p {
                display: flex;
                justify-content: space-between;
                font-size: 1rem;
                margin: 14px 0;
                color: #555;
            }
            .summary p span {
                font-weight: 600;
                color: #000;
            }
            .summary p:last-of-type {
                font-size: 1.4rem;
                font-weight: 700;
                color: #a91370;
                margin-top: 20px;
            }
            .summary p:last-of-type span {
                color: #a91370;
            }

            .summary hr {
                border: 0;
                border-top: 1px dashed #ccc;
                margin: 20px 0;
            }

            /* =================================
                BUTTONS
                ================================= */
            .btn-container {
                text-align: center;
                margin-top: 20px;
            }

            .btn {
                font-family: 'Montserrat', sans-serif;
                padding: 12px 25px;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                border: none;
                margin: 0 5px;
            }

            .btn-primary {
                background-color: #c71585;
                color: white;
            }
            .btn-primary:hover {
                background-color: #a91370;
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(199, 21, 133, 0.3);
            }

            .btn-outline {
                background-color: transparent;
                color: #555;
                border: 2px solid #ccc;
            }
            .btn-outline:hover {
                background-color: #f9f9f9;
                color: #000;
                border-color: #aaa;
            }
        </style>
    </head>
    <body>
        

        <c:set var="guest" value="${sessionScope.USER}"/>
        <c:set var="room" value="${requestScope.ROOM}"/>
        <c:set var="roomType" value="${requestScope.ROOMTYPE}"/>
        <c:set var="booking" value="${requestScope.BOOKING}"/>
        <c:set var="cart" value="${CART}"/>
        <c:set var="isBooking" value="${false}" scope="session"/>

        <div class="booking-view-container">
            <c:if test="${BookingSuccessfull != null && !empty BookingSuccessfull}">
                <h3 class="booking-success-message">${BookingSuccessfull}</h3>
            </c:if>
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

            <div class="btn-container">
                <form action="MainController">
                    <c:choose>
                        <c:when test="${BookingSuccessfull != null}">

                            <button type="submit" name="action" value="home" class="btn btn-primary">
                                Back To Home
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" name="action" value="findBookings" class="btn btn-outline">
                                Back To History
                            </button>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>
        </div>

    </body>
</html>

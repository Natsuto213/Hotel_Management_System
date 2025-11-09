<%-- 
    Document   : EditBooking
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

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

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
            .booking-form-container {
                max-width: 900px;
                margin: 0 auto;
            }

            /* =================================
                MESSAGE STYLING (Success/Error)
            ================================= */
            .info-message, .error-message {
                padding: 15px 20px;
                border-radius: 8px;
                text-align: center;
                font-weight: 500;
                font-size: 1.1rem;
                margin-bottom: 25px;
            }

            /* Thông báo thành công (màu xanh) */
            .info-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            /* Thông báo lỗi (màu đỏ) */
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* =================================
                CARD STYLING
            ================================= */
            .guest-info,
            .booking-info,
            .service-info,
            .payment-info,
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
            .payment-info h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f09d"; /* fa-credit-card */
            }
            .summary h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f570"; /* fa-file-invoice-dollar */
            }

            /* =================================
                INFO BLOCKS (Grid Layout)
            ================================= */
            .guest-info,
            .booking-info,
            .payment-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 5px 20px;
            }
            .guest-info h1,
            .booking-info h1,
            .payment-info h1 {
                grid-column: 1 / -1;
            }
            .guest-info div,
            .booking-info div,
            .payment-info div {
                margin-bottom: 10px;
            }
            .guest-info label,
            .booking-info label,
            .payment-info label {
                display: block;
                font-weight: 600;
                color: #555;
                font-size: 0.9rem;
            }
            .guest-info p,
            .booking-info p,
            .payment-info p {
                font-size: 1.1rem;
                margin: 0;
                color: #000;
            }

            /* =================================
                SERVICE INFO (Form)
            ================================= */
            .new-service form {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                align-items: center;
            }
            .new-service label {
                font-weight: 600;
                flex-basis: 100%;
            }
            .new-service select,
            .new-service input {
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-family: inherit;
                font-size: 0.95rem;
                box-sizing: border-box;
            }
            .new-service select {
                flex: 3;
                min-width: 200px;
            }
            .new-service input[type="number"] {
                flex: 1;
                min-width: 100px;
            }
            .new-service input[type="text"],
            .new-service input[type="date"] {
                flex: 2;
                min-width: 150px;
            }
            .new-service button {
                background-color: #c71585;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px 15px;
                cursor: pointer;
                font-size: 1rem;
                transition: background-color 0.3s;
            }
            .new-service button:hover {
                background-color: #a91370;
            }

            /* Danh sách service đã thêm */
            .view-service {
                margin-top: 25px;
            }
            .view-service form {
                display: flex;
                align-items: center;
                gap: 15px;
                padding: 12px 0;
                border-bottom: 1px solid #f0f0f0;
            }
            .view-service form span {
                font-size: 0.95rem;
            }
            .view-service form span:nth-child(1) {
                flex: 3;
                font-weight: 500;
            } /* Tên */
            .view-service form span:nth-child(2) {
                flex: 2;
                color: #555;
            } /* Giá */
            .view-service form span:nth-child(3) {
                flex: 1;
                text-align: center;
            } /* SL */
            .view-service form span:nth-child(4) {
                flex: 2;
                color: #555;
            } /* Ngày */

            .view-service form button {
                background: #e74c3c;
                color: white;
                border: none;
                border-radius: 50%;
                width: 28px;
                height: 28px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.3s;
            }
            .view-service form button:hover {
                background: #c0392b;
            }
            .view-service br {
                display: none; /* Ẩn thẻ <br> thừa */
            }

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
                /* Thêm để xử lý float (nếu dùng) */
                overflow: hidden;
                padding: 10px 0;
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
                float: right; /* Đẩy nút chính sang phải */
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
                float: left; /* Đẩy nút phụ sang trái */
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
        <c:set var="payment" value="${requestScope.PAYMENT}"/>

        <c:set var="cart" value="${requestScope.CART}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}" />

        <div class="booking-form-container">


            <c:if test="${param.MSG != null && !empty param.MSG}">

                <c:choose>
                    <c:when test="${param.MSG.contains('Error') || param.MSG.contains('Failed')}">
                        <h3 class="error-message">${param.MSG}</h3>
                    </c:when>
                    <c:otherwise>
                        <h3 class="info-message">${param.MSG}</h3>
                    </c:otherwise>
                </c:choose>
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
            </div>

            <div class="booking-info">
                <h1>Booking Information</h1>
                <div>
                    <label>Room Number</label>
                    <p>${room.roomNumber}</p>
                </div>
                <div>
                    <label>Room Type</label>
                    <p>${roomType.typeName}</p>
                </div>
                <div>
                    <label>Check-in</label>
                    <p>${booking.checkInDate}</p>
                </div>
                <div>
                    <label>Check-out</label>
                    <p>${booking.checkOutDate}</p>
                </div>
                <div>
                    <label>Price per night</label>
                    <p>${roomType.formattedPrice} VND</p>
                </div>
            </div>

            <div class="service-info">
                <h1>Additional Services</h1>
                <div class="new-service" >
                    <form action="MainController" method="post">
                        <label>Select Service</label> <%-- THAY ĐỔI: Chuyển Label ra ngoài form --%>
                        <select name="serviceid" required="">
                            <option value="" disabled selected>-- Select Service --</option>
                            <c:forEach var="s" items="${servicelist}">
                                <option value="${s.serviceid}">${s.servicename} (+${s.formattedPrice})</option>
                            </c:forEach>
                        </select>
                        <input type="number" name="quantity" min="1" value="1" placeholder="Quantity" required="">
                        <input type="text" name="serviceDate" placeholder="Service Date" 
                               onfocus="
                                       this.type = 'date';
                                       this.min = '${booking.checkInDate}';
                                       this.max = '${booking.checkOutDate}';
                               " 
                               onblur="if (!this.value)
                                           this.type = 'text'"
                               required=""
                               >   
                        <input type="hidden" name="roomid" value="${param.roomid}" >
                        <input type="hidden" name="bookingid" value="${param.bookingid}" >
                        <input type="hidden" name="type" value="editBooking" >  
                        <button type="submit" name="action" value="addService"><i class="fa-solid fa-plus"></i></button>
                    </form>
                </div>

                <div class="view-service">
                    <c:set var="serviceTotal" value="0" scope="page" />
                    <c:forEach var="c" items="${cart}">
                        <c:set var="subtotal" value="${c.price * c.quantity}" />
                        <form action="MainController" method="post">
                            <span>${c.servicename}</span>
                            <span><fmt:formatNumber value="${c.price}" type="number" groupingUsed="true"/> VNĐ</span>
                            <span>x ${c.quantity}</span>
                            <span>${c.servicedate}</span>
                            <input type="hidden" name="serviceId" value="${c.serviceid}" >
                            <input type="hidden" name="serviceDate" value="${c.servicedate}" >
                            <input type="hidden" name="bookingid" value="${param.bookingid}" >
                            <input type="hidden" name="roomid" value="${param.roomid}" >
                            <button type="submit" name="action" value="deleteService"><i class="fa-solid fa-x"></i></button>
                        </form>
                        <%-- XÓA <br> --%>
                        <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
                    </c:forEach>
                </div>
            </div>

            <div class="payment-info">
                <h1>Payment Information</h1>
                <div>
                    <label>Method</label>
                    <p>${payment.paymentMethod}</p>
                </div>
                <div>
                    <label>Status</label>
                    <p>${payment.status}</p>
                </div>
            </div>

            <div class="summary">
                <h1>Booking Summary</h1>

                <fmt:parseDate var="checkInDate" value="${booking.checkInDate}" pattern="yyyy-MM-dd" />
                <fmt:parseDate var="checkOutDate" value="${booking.checkOutDate}" pattern="yyyy-MM-dd" />
                <c:set var="night" value="${(checkOutDate.time - checkInDate.time) / (1000*60*60*24)}" />
                <c:set var="roomTotal" value="${night * roomType.price}" />
                <c:set var="total" value="${roomTotal + serviceTotal}"/>
                <c:set var="tax" value="${requestScope.TAX}"/>

                <p>Room (<fmt:formatNumber value="${night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights):  <fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</p>
                <p>Total Service: <fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</p>
                <p>VAT (<fmt:formatNumber value="${tax * 100}" type="number" groupingUsed="true" maxFractionDigits="0"/>%): <fmt:formatNumber value="${total * tax}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</p>
                <hr>
                <p>Total Amount: <fmt:formatNumber value="${total * (1 + tax)}" type="number" groupingUsed="true"/> VND</p>
            </div>  


            <div class="btn-container">
                <form action="MainController">
                    <button type="submit" name="action" value="findBookings" class="btn btn-outline">Back To History</button>

                    <input type="hidden" name="total" value="${total * 1.08}">
                    <input type="hidden" name="roomid" value="${room.roomId}">
                    <input type="hidden" name="bookingid" value="${booking.bookingId}">
                    <button type="submit" name="action" value="confirmEdit" class="btn btn-primary">Confirm</button>
                </form>
            </div>
        </div>
    </body>
</html>
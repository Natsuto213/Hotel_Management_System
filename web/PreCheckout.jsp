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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #ffb3d1 0%, #ff8db3 100%);
                min-height: 100vh;
                padding: 20px;
                color: #333;
            }

            body > h1 {
                text-align: center;
                color: white;
                font-size: 2.5rem;
                margin-bottom: 30px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            }

            .guest-info,
            .booking-info,
            .service-info,
            .payment-info,
            .summary {
                background: white;
                border-radius: 12px;
                padding: 25px;
                margin-bottom: 20px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                max-width: 900px;
                margin-left: auto;
                margin-right: auto;
            }

            .guest-info h1,
            .booking-info h1,
            .service-info h1,
            .payment-info h1,
            .summary h1 {
                color: #ff6b9d;
                font-size: 1.8rem;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 3px solid #ff6b9d;
            }

            .service-info h3 {
                color: #999;
                font-style: italic;
                text-align: center;
                padding: 20px;
            }

            .guest-info > div {
                display: grid;
                grid-template-columns: 150px 1fr;
                gap: 10px;
                padding: 12px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .guest-info > div:last-child {
                border-bottom: none;
            }

            .guest-info label {
                font-weight: 600;
                color: #555;
            }

            .guest-info p {
                color: #333;
            }

            /* CSS MỚI CHO BOOKING INFO (DÙNG GRID) */
            .booking-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 5px 20px;
            }

            .booking-info h1 {
                grid-column: 1 / -1;
                color: #ff6b9d;
                font-size: 1.8rem;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 3px solid #ff6b9d;
            }

            .booking-info div {
                margin-bottom: 10px;
            }

            .booking-info label {
                display: block;
                font-weight: 600;
                color: #555;
                font-size: 0.9rem;
            }

            .booking-info p {
                display: block;
                font-size: 1.1rem;
                margin: 0;
                color: #000;
            }

            .service-info {
                overflow-x: auto;
            }

            /* =================================
               ĐOẠN NÀY ĐÃ ĐƯỢC DI CHUYỂN RA NGOÀI
               ================================= */

            .service-list {
                margin-top: 20px;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .service-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #fff5f8;
                padding: 15px 20px;
                border-radius: 8px;
                border: 1px solid #ffe0eb;
            }

            .service-item .service-name {
                font-weight: 600;
                font-size: 1.1rem;
                color: #c44569;
                flex: 2;
            }

            .service-item .service-details {
                flex: 3;
                color: #555;
                text-align: center;
                font-size: 0.95rem;
            }

            .service-item .service-subtotal {
                flex: 1.5;
                font-weight: 600;
                color: #333;
                text-align: right;
                font-size: 1.05rem;
            }

            .service-info > span,
            .service-info > br {
                display: none;
            }

            /* CSS CHO PAYMENT (ĐÃ SỬA) */
            .method-option {
                display: flex;
                align-items: center;
                padding: 15px;
                margin: 10px 0;
                border: 2px solid #ffe0eb;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                background: #fff5f8;
            }

            .method-option:hover {
                border-color: #ff6b9d;
                background: #ffe0eb;
            }

            .method-option input[type="radio"] {
                margin-right: 15px;
                width: 20px;
                height: 20px;
                cursor: pointer;
                accent-color: #ff6b9d;
            }

            .method-option .icon {
                font-size: 1.5rem;
                margin-right: 10px;
                color: #ff6b9d;
            }

            .method-option span:last-child {
                font-weight: 500;
                font-size: 1.1rem;
            }

            /* CSS CHO SUMMARY (ĐÃ SỬA) */
            .summary p {
                display: flex;
                justify-content: space-between;
                padding: 12px 0;
                font-size: 1.05rem;
            }

            .summary p span {
                font-weight: 600;
                color: #ff6b9d;
            }

            .summary hr {
                margin: 20px 0;
                border: none;
                border-top: 2px solid #ff6b9d;
            }

            .summary p:last-of-type {
                font-size: 1.3rem;
                font-weight: bold;
                color: #ff6b9d;
                margin-top: 10px;
            }

            .summary p:last-of-type span {
                color: #c44569;
                font-size: 1.4rem;
            }

            /* CSS CHO BUTTONS (ĐÃ SỬA) */
            .btn {
                padding: 14px 30px;
                font-size: 1.1rem;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 600;
                margin: 10px 5px;
            }

            .btn-outline {
                background: white;
                color: #ff6b9d;
                border: 2px solid #ff6b9d;
            }

            .btn-outline:hover {
                background: #ff6b9d;
                color: white;
            }

            .btn-primary {
                background: linear-gradient(135deg, #ff6b9d 0%, #c44569 100%);
                color: white;
                border: none;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(255, 107, 157, 0.4);
            }

            /* CSS CHO BUTTON CONTAINER (ĐÃ THÊM) */
            .summary .button-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 25px;
            }
            .summary .button-container .btn {
                margin: 0; /* Ghi đè margin cũ */
            }

            /* CSS CHO FORM (ĐÃ SỬA) */
            form {
                max-width: 900px;
                margin: 0 auto;
            }

            /* CSS CHO MEDIA QUERY (ĐÃ SỬA) */
            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                body > h1 {
                    font-size: 2rem;
                }

                .guest-info > div {
                    grid-template-columns: 1fr;
                }

                .booking-info label {
                    display: block;
                    width: 100%;
                }

                .booking-info p {
                    display: block;
                    margin-left: 0;
                    margin-bottom: 10px;
                }

                .btn {
                    width: 100%;
                    margin: 5px 0;
                }
            }
        </style>
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
            <c:if test="${cart == null || empty cart}">
                <h3>No service yet</h3>
            </c:if>

            <c:set var="serviceTotal" value="0" scope="page" />

            <%-- Thêm một container cho danh sách --%>
            <div class="service-list">
                <c:forEach var="c" items="${cart}">
                    <c:set var="subtotal" value="${c.price * c.quantity}" />

                    <%-- Đây là "khung chữ nhật" cho mỗi service --%>
                    <div class="service-item">
                        <span class="service-name">${c.servicename}</span>
                        <span class="service-details">
                            <fmt:formatNumber value="${c.price}" type="number" groupingUsed="true"/> VND x ${c.quantity} | ${c.servicedate}
                        </span>
                        <span class="service-subtotal">
                            <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/> VND
                        </span>
                    </div>

                    <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
                </c:forEach>
            </div> <%-- Đóng service-list --%>
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
                <c:set var="tax" value="${requestScope.TAX}"/>

                <p>Room (<fmt:formatNumber value="${night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights):  <fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</p>
                <p>Total Service: <fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</p>
                <p>VAT (<fmt:formatNumber value="${tax*100}" type="number" groupingUsed="true" maxFractionDigits="0"/>%): <fmt:formatNumber value="${total * tax}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</p>
                <hr>
                <p>Total Amount: <fmt:formatNumber value="${total * (1 + tax)}" type="number" groupingUsed="true"/> VND</p>

                <input type="hidden" name="night" value="${night}">
                <input type="hidden" name="roomTotal" value="${roomTotal}">
                <input type="hidden" name="serviceTotal" value="${serviceTotal}">
                <input type="hidden" name="total" value="${total}">

                <input type="hidden" name="roomid" value="${room.roomId}">
                <input type="hidden" name="bookingid" value="${booking.bookingId}">

                <c:set var="isCheckout" value="${true}" scope="session"/>
                <div class="button-container">
                    <button type="submit" name="action" value="home" class="btn btn-outline">Back To Home</button>
                    <button type="submit" name="action" value="checkout" class="btn btn-primary">Confirm Checkout</button>
                </div>
            </div>
        </form>

    </body>
</html>

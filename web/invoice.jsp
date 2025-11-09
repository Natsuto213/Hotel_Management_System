<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="model.RoomType"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Booking"%>
<%@page import="model.Staff"%>
<%@page import="model.Guest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice Page</title>

        <%-- Bỏ link CSS cũ, thay bằng <style> trực tiếp --%>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            /* =================================
                GLOBAL & BODY STYLING
            ================================= */
            :root {
                --primary-color: #a91370;
                --primary-color-dark: #c71585;
            }

            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f7f4f6;
                color: #333;
                line-height: 1.6;
                margin: 0;
                padding: 0;
            }

            .invoice-container {
                max-width: 900px;
                margin: 0 auto;
                padding: 30px 15px;
            }

            /* =================================
                SUCCESS BANNER (ĐÃ STYLE LẠI)
            ================================= */
            .success-banner {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-color-dark));
                color: white;
                border-radius: 12px;
                padding: 30px;
                text-align: center;
                margin-bottom: 25px;
                box-shadow: 0 6px 20px rgba(199, 21, 133, 0.3);
            }
            .success-banner i {
                font-size: 3rem;
                margin-bottom: 15px;
            }
            .success-banner h1 {
                font-size: 2rem;
                font-weight: 700;
                margin: 0;
            }
            .success-banner p {
                font-size: 1rem;
                opacity: 0.9;
                margin-top: 10px;
            }

            /* =================================
                CARD STYLING (MỚI)
            ================================= */
            .card {
                background-color: #ffffff;
                border-radius: 12px;
                padding: 25px 30px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.07);
                margin-bottom: 25px;
            }

            /* =================================
                SECTION HEADER (MỚI - THEO ẢNH)
            ================================= */
            .section-header {
                text-align: center;
                margin-bottom: 20px;
            }
            .section-header i {
                font-size: 1.8rem;
                color: var(--primary-color);
            }
            .section-header h2 {
                font-size: 1.6rem;
                color: #333;
                margin-top: 8px;
                font-weight: 600;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 15px;
            }

            /* =================================
                GUEST & BOOKING INFO
            ================================= */
            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px 30px;
            }
            .info-block h3 {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 10px;
                padding-bottom: 5px;
                border-bottom: 1px solid #eee;
            }
            .info-block h3 i {
                margin-right: 8px;
            }
            .info-block p {
                font-size: 0.95rem;
                margin-bottom: 5px;
            }
            .info-block p strong {
                color: #555;
            }

            /* =================================
                ROOM INFO (MỚI - THEO ẢNH)
            ================================= */
            .room-details-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px 25px;
                text-align: center;
            }
            .room-details-grid div {
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #f0f0f0;
            }
            .room-details-grid label {
                display: block;
                font-size: 0.9rem;
                color: #777;
                font-weight: 500;
                margin-bottom: 5px;
            }
            .room-details-grid p {
                font-size: 1.2rem;
                font-weight: 600;
                color: var(--primary-color);
                margin: 0;
            }

            /* =================================
                SERVICE LIST (MỚI)
            ================================= */
            .service-info h3.no-service {
                color: #999;
                font-style: italic;
                text-align: center;
                margin: 20px 0;
            }
            .service-list {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            .service-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #fdfafc;
                padding: 15px 20px;
                border-radius: 8px;
                border: 1px solid #f5eef3;
            }
            .service-item .service-name {
                font-weight: 600;
                font-size: 1rem;
                color: var(--primary-color);
                flex: 2;
            }
            .service-item .service-details {
                flex: 3;
                color: #555;
                text-align: center;
                font-size: 0.9rem;
            }
            .service-item .service-subtotal {
                flex: 1.5;
                font-weight: 600;
                color: #333;
                text-align: right;
                font-size: 1rem;
            }

            /* =================================
                PRICE SUMMARY (ĐÃ STYLE LẠI)
            ================================= */
            .summary-info p {
                display: flex;
                justify-content: space-between;
                font-size: 1rem;
                margin: 14px 0;
                color: #555;
                padding-bottom: 10px;
                border-bottom: 1px dashed #eee;
            }
            .summary-info p span {
                font-weight: 600;
                color: #000;
            }
            .summary-info hr {
                border: 0;
                border-top: 2px solid #f0f0f0;
                margin: 20px 0;
            }
            .summary-info .total-amount {
                background: linear-gradient(135deg, var(--primary-color), var(--primary-color-dark));
                color: white;
                padding: 20px;
                border-radius: 8px;
                margin-top: 20px;
                font-size: 1.2rem;
                font-weight: 700;
                display: flex;
                justify-content: space-between;
            }
            .summary-info .total-amount span {
                color: white;
                font-size: 1.4rem;
            }

            /* =================================
                BUTTONS (ĐÃ SỬA)
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
                background-color: var(--primary-color-dark);
                color: white;
            }
            .btn-primary:hover {
                background-color: var(--primary-color);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(199, 21, 133, 0.3);
            }

            /* =================================
                NOTES SECTION (ĐÃ STYLE LẠI)
            ================================= */
            .notes-section {
                margin-top: 25px;
                background: #fdfafc;
                border: 1px solid #f5eef3;
                border-radius: 8px;
                padding: 20px;
            }
            .notes-section h4 {
                font-weight: 600;
                color: var(--primary-color);
                font-size: 1rem;
                margin-bottom: 10px;
            }
            .notes-section h4 i {
                margin-right: 8px;
            }
            .notes-section ul {
                list-style-type: none;
                padding-left: 0;
                margin: 0;
            }
            .notes-section li {
                font-size: 0.85rem;
                color: #555;
                margin-bottom: 5px;
                position: relative;
                padding-left: 15px;
            }
            .notes-section li::before {
                content: '•';
                position: absolute;
                left: 0;
                color: var(--primary-color);
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <c:set var="guest" value="${sessionScope.USER}" />
        <c:set var="room" value="${requestScope.ROOM}"/>
        <c:set var="roomType" value="${requestScope.ROOMTYPE}"/>
        <c:set var="booking" value="${requestScope.BOOKING}"/>
        <c:set var="cart" value="${requestScope.CART}"/>
        <c:set var="isCheckout" value="${false}" scope="session"/>

        <div class="invoice-container">
            <!-- Success Banner -->
            <div class="success-banner">
                <i class="fa-solid fa-circle-check"></i>
                <h1>Booking Successfully!</h1>
                <p>Cảm ơn bạn đã tin tưởng và lựa chọn Grand Hotel. Chúng tôi rất vui được phục vụ bạn.</p>
            </div>

            <!-- Invoice Card -->

            <!-- Guest & Booking Info -->
            <div class="card">
                <div class="info-grid">
                    <div class="info-block">
                        <h3><i class="fa-solid fa-user"></i> Guest Information</h3>
                        <p><strong>Full Name: </strong>${guest.fullname}</p>
                        <p><strong>Phone: </strong>${guest.phone}</p>
                        <p><strong>Email: </strong>${guest.email}</p>
                    </div>

                    <div class="info-block">
                        <fmt:parseDate var="checkInDate" value="${booking.checkInDate}" pattern="yyyy-MM-dd" />
                        <fmt:parseDate var="checkOutDate" value="${booking.checkOutDate}" pattern="yyyy-MM-dd" />
                        <c:set var="night" value="${(checkOutDate.time - checkInDate.time) / (1000*60*60*24)}" />

                        <h3><i class="fa-solid fa-calendar-check"></i> Booking Information</h3>
                        <p><strong>Mã Đặt Phòng: </strong> #${sessionScope.bookingid}</p>
                        <p><strong>Booking Date: </strong> ${booking.bookingDate}</p>
                        <p><strong>Check-in: </strong> ${booking.checkInDate}</p>
                        <p><strong>Check-out: </strong> ${booking.checkOutDate}</p>
                        <p><strong>Số đêm: </strong><fmt:formatNumber value="${night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights</p>
                    </div>
                </div>
            </div>

            <!-- Room Information (MỚI) -->
            <div class="card room-info">
                <div class="section-header">
                    <i class="fa-solid fa-bed"></i>
                    <h2>Room Information</h2>
                </div>
                <div class="room-details-grid">
                    <div>
                        <label>Room Type</label>
                        <p>${roomType.typeName}</p>
                    </div>
                    <div>
                        <label>Room Number</label>
                        <p>${room.roomNumber}</p>
                    </div>
                    <div>
                        <label>Diện tích</label>
                        <p>25m²</p>
                    </div>
                </div>
            </div>

            <!-- Service Information (MỚI) -->
            <div class="card service-info">
                <div class="section-header">
                    <i class="fa-solid fa-concierge-bell"></i>
                    <h2>Service Information</h2>
                </div>

                <c:choose>
                    <c:when test="${cart == null || empty cart}">
                        <h3 class="no-service">No service</h3>
                    </c:when>
                    <c:otherwise>
                        <c:set var="serviceTotal" value="0" scope="page" />
                        <div class="service-list">
                            <c:forEach var="c" items="${cart}">
                                <c:set var="subtotal" value="${c.price * c.quantity}" />
                                <div class="service-item">
                                    <span class="service-name">${c.servicename}</span>
                                    <span class="service-details">
                                        <fmt:formatNumber value="${c.price}" type="number" groupingUsed="true"/> VNĐ x ${c.quantity} | ${c.servicedate}
                                    </span>
                                    <span class="service-subtotal">
                                        <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/> VNĐ
                                    </span>
                                </div>
                                <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>


            <!-- Price Breakdown (MỚI) -->
            <div class="card summary-info">
                <div class="section-header">
                    <i class="fa-solid fa-file-invoice-dollar"></i>
                    <h2>Price Summary</h2>
                </div>

                <c:set var="roomTotal" value="${night * roomType.price}" />
                <c:set var="total" value="${roomTotal + serviceTotal}"/>
                <c:set var="tax" value="${requestScope.TAX}"/>

                <p>Room (<fmt:formatNumber value="${night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights): 
                    <span><fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</span>
                </p>
                <p>Total Service: 
                    <span><fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</span>
                </p>
                <p>VAT (<fmt:formatNumber value="${tax*100}" type="number" groupingUsed="true" maxFractionDigits="0"/>%): 
                    <span><fmt:formatNumber value="${total * tax}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</span>
                </p>

                <div class="total-amount">
                    <label>TOTAL AMOUNT:</label>
                    <span><fmt:formatNumber value="${total * (1+tax)}" type="number" groupingUsed="true"/> VND</span>
                </div>
            </div>

            <!-- Action Buttons (ĐÃ SỬA) -->
            <div class="btn-container">
                <a href="MainController?action=home" class="btn btn-primary">
                    <i class="fa-solid fa-home"></i> Về trang chủ
                </a>
            </div>

            <!-- Notes -->
            <div class="notes-section">
                <h4><i class="fa-solid fa-circle-info"></i> Lưu ý quan trọng</h4>
                <ul>
                    <li>Giờ nhận phòng: 14:00 | Giờ trả phòng: 12:00</li>
                    <li>Vui lòng mang theo CMND/CCCD khi làm thủ tục nhận phòng</li>
                    <li>Thanh toán tại quầy lễ tân khi nhận phòng</li>
                    <li>Để hủy hoặc thay đổi đặt phòng, vui lòng liên hệ ít nhất 24h trước ngày nhận phòng</li>
                    <li>Mọi thắc mắc xin liên hệ: (012) 345 5678 hoặc support@grandhotel.com</li>
                </ul>
            </div>

        </div> <%-- Đóng .invoice-container --%>


        <script>
            // Tự động cuộn lên đầu trang khi load
            window.scrollTo(0, 0);
        </script>

        <c:remove var="bookingid" scope="session"/>

    </body>
</html>
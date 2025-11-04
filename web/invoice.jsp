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
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/invoiceStyle.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:set var="guest" value="${sessionScope.USER}" />
        <c:set var="booking" value="${sessionScope.BOOKING}"/>

        <div class="invoice-container">
            <!-- Success Banner -->
            <div class="success-banner">
                <i class="fa-solid fa-circle-check"></i>
                <h1>Booking Susscessfully!</h1>
                <p>Cảm ơn bạn đã tin tưởng và lựa chọn Grand Hotel. Chúng tôi rất vui được phục vụ bạn.</p>
            </div>

            <!-- Invoice Card -->
            <div class="invoice-card">
                <!-- Invoice Header -->
                <div class="invoice-header">
                    <div class="hotel-info">
                        <h2><i class="fa-solid fa-building"></i> Grand Hotel</h2>
                        <p>123 Đường ABC, Quận 1, TP.HCM</p>
                        <p>Hotline: (012) 345 5678 | Email: support@grandhotel.com</p>
                    </div>
                    <div class="invoice-number">
                        <h3>MÃ ĐẶT PHÒNG</h3>
                        <div class="number">#${requestScope.bookingid}</div>
                    </div>
                </div>

                <!-- Invoice Body -->
                <div class="invoice-body">
                    <!-- Customer & Booking Info -->
                    <div class="info-section">
                        <div class="info-block">
                            <h3><i class="fa-solid fa-user"></i> Guest Information </h3>
                            <p><strong>Full Name: </strong>${guest.fullname}</p>
                            <p><strong>Phone: </strong>${guest.phone}</p>
                            <p><strong>Email: </strong>${guest.email}</p>
                        </div>

                        <div class="info-block">
                            <h3><i class="fa-solid fa-calendar-check"></i> Booking Information </h3>
                            <p><strong>Booking Date: </strong> ${booking.bookingDate}</p>
                            <p><strong>Check-in: </strong> ${booking.checkInDate}</p>
                            <p><strong>Check-out: </strong> ${booking.checkOutDate}</p>
                            <p><strong>Night: </strong><fmt:formatNumber value="${requestScope.night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights</p>
                        </div>
                    </div>

                    <div class="booking-details">
                        <h3><i class="fa-solid fa-bed"></i> Room Information </h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Room Type: </label>
                                <span>${booking.typeName}</span>
                            </div>
                            <div class="detail-item">
                                <label>Room Number: </label>
                                <span>${booking.roomNumber}</span>
                            </div>
                            <div class="detail-item">
                                <label>Guests: </label>
                                <span>${booking.guests} guests</span>
                            </div>
                            <div class="detail-item">
                                <label>Diện tích: </label>
                                <span>25m²</span>
                            </div>
                        </div>
                    </div>

                    <!-- Price Breakdown -->
                    <div class="price-breakdown">
                        <h3><i class="fa-solid fa-file-invoice-dollar"></i> Price Summary</h3>
                        <div class="price-item">
                            <label>Price per night</label>
                            <span><fmt:formatNumber value="${booking.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</span>
                        </div>
                        <div class="price-item">
                            <label>Nights: </label>
                            <span><fmt:formatNumber value="${requestScope.night}" type="number" groupingUsed="true" maxFractionDigits="0"/> nights</span>
                        </div>
                        <hr>
                        <div class="price-item">
                            <label>Total Room price: </label>
                            <span><fmt:formatNumber value="${requestScope.roomTotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</span>
                        </div>
                        <div class="price-item">
                            <label>Total Service:</label>
                            <span><fmt:formatNumber value="${requestScope.serviceTotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</span>
                        </div>
                        <div class="price-item">
                            <label>VAT (8%)</label>
                            <span><fmt:formatNumber value="${requestScope.total * 0.08}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</span>
                        </div>
                        <div class="total-amount">
                            <label>TOTAL AMOUNT (VAT 8%): </label>
                            <span><fmt:formatNumber value="${requestScope.total * 1.08}" type="number" groupingUsed="true" maxFractionDigits="0"/> VND</span>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <button class="btn btn-primary" onclick="window.print()">
                            <i class="fa-solid fa-print"></i> In hóa đơn
                        </button>
                        <button class="btn btn-secondary" onclick="downloadPDF()">
                            <i class="fa-solid fa-file-pdf"></i> Tải PDF
                        </button>
                        <a href="MainController?action=home" class="btn btn-outline">
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
                </div>
            </div>
        </div>

        <footer class="main-footer">
            <div class="container footer-grid">
                <div class="footer-col">
                    <a href="#" class="logo">Grand Hotel</a>
                    <p>Khách sạn hàng đầu với dịch vụ đẳng cấp quốc tế và không gian sang trọng.</p>
                </div>
                <div class="footer-col">
                    <h4>Liên hệ</h4>
                    <ul>
                        <li>📞(012) 345 5678</li>
                        <li>📧support@grandhotel.com</li>
                        <li>📍123 Đường ABC, Quận 1, TP.HCM</li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Dịch vụ</h4>
                    <ul>
                        <li><a href="#">Spa & Massage</a></li>
                        <li><a href="#">Nhà hàng & Bar</a></li>
                        <li><a href="#">Hội nghị & Sự kiện</a></li>
                        <li><a href="#">Đưa đón sân bay</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-copyright">
                <p>© 2025 Grand Hotel. Tất cả quyền được bảo lưu.</p>
            </div>
        </footer>

        <script>
            function downloadPDF() {
                // Tạm thời dùng print, có thể tích hợp thư viện PDF sau
                alert('Chức năng tải PDF đang được phát triển. Vui lòng sử dụng "In hóa đơn" và chọn "Save as PDF"');
            }

            // Tự động cuộn lên đầu trang khi load
            window.scrollTo(0, 0);
        </script>
    </body>
</html>
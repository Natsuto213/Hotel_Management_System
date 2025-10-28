<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="model.RoomType"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Booking"%>
<%@page import="model.Staff"%>
<%@page import="model.Guest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    // function để tìm tên loại phòng từ ID
    public String getRoomTypeNameById(int roomTypeId, List<RoomType> allRoomTypes) {
        if (allRoomTypes == null) {
            return "Không có loại phòng nào";
        }
        for (RoomType rt : allRoomTypes) {
            if (rt.getRoomTypeId() == roomTypeId) {
                return rt.getTypeName();
            }
        }
        return "Unknown";
    }
%>

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
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>

                <%
                    HttpSession sessionObj = request.getSession(false);
                    Boolean isLogin = false;
                    String username = "";
                    Guest guest = null;

                    if (sessionObj != null) {
                        isLogin = (Boolean) sessionObj.getAttribute("isLogin");

                        Object user = sessionObj.getAttribute("USER");
                        if (user instanceof Guest) {
                            guest = (Guest) user;
                            username = guest.getUsername();
                        }
                    }

                    // Lấy thông tin booking
                    Booking booking = (Booking) request.getAttribute("BOOKING");
                    RoomType roomInfo = (RoomType) request.getAttribute("ROOM_INFO");

                    String bookingId = "BK" + System.currentTimeMillis();
                    String roomType = "";
                    double roomPrice = 0;
                    int capacity = 0;
                    long nights = 0;
                    long totalAmount = 0;
                    String checkinStr = "";
                    String checkoutStr = "";
                    String bookingDateStr = "";
                    String status = "Reserved";

                    if (booking != null) {
                        // Lấy thông tin từ booking
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        checkinStr = booking.getCheckInDate().format(formatter);
                        checkoutStr = booking.getCheckOutDate().format(formatter);
                        bookingDateStr = booking.getBookingDate().format(formatter);
                        status = booking.getStatus();

                        // Tính số đêm
                        nights = ChronoUnit.DAYS.between(booking.getCheckInDate(), booking.getCheckOutDate());

                        if (roomInfo != null) {
                            roomType = roomInfo.getTypeName();
                            roomPrice = roomInfo.getPrice();
                            capacity = roomInfo.getCapacity();
                            totalAmount = (long) roomPrice * nights;
                        }
                        roomType = "Single";
                        roomPrice = 1500000.00;
                    }
                %>

                <nav class="main-nav">
                    <% if (isLogin != null && isLogin == true) {%>
                    <span class="welcome">Xin chào, <%= username%>!</span>
                    <a href="MainController?action=logout" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                    <% } else { %>
                    <a href="MainController?action=login" class="nav-button-secondary">
                        <i class="fa-solid fa-user"></i> Đăng nhập
                    </a>
                    <a href="MainController?action=register" class="nav-button-primary">
                        <i class="fa-solid fa-user-plus"></i> Đăng ký
                    </a>
                    <% }%>
                </nav>
            </div>
        </header>

        <div class="invoice-container">
            <!-- Success Banner -->
            <div class="success-banner">
                <i class="fa-solid fa-circle-check"></i>
                <h1>Đặt phòng thành công!</h1>
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
                        <div class="number"><%= bookingId%></div>
                    </div>
                </div>

                <!-- Invoice Body -->
                <div class="invoice-body">
                    <!-- Customer & Booking Info -->
                    <div class="info-section">
                        <div class="info-block">
                            <h3><i class="fa-solid fa-user"></i> Thông tin khách hàng</h3>
                            <p><strong>Họ và tên:</strong> <%= username%></p>
                            <% if (guest != null) {%>
                            <p><strong>Email:</strong> <%= guest.getEmail() != null ? guest.getEmail() : "Chưa cập nhật"%></p>
                            <p><strong>Số điện thoại:</strong> <%= guest.getPhone() != null ? guest.getPhone() : "Chưa cập nhật"%></p>
                            <% }%>
                            <p><strong>Trạng thái:</strong> <span class="status-badge reserved"><%= status%></span></p>
                        </div>

                        <div class="info-block">
                            <h3><i class="fa-solid fa-calendar-check"></i> Thông tin đặt phòng</h3>
                            <p><strong>Ngày đặt:</strong> <%= bookingDateStr%></p>
                            <p><strong>Ngày nhận phòng:</strong> <%= checkinStr%></p>
                            <p><strong>Ngày trả phòng:</strong> <%= checkoutStr%></p>
                            <p><strong>Số đêm:</strong> <%= nights%> đêm</p>
                        </div>
                    </div>

                    <!-- Booking Details -->
                    <div class="booking-details">
                        <h3><i class="fa-solid fa-bed"></i> Chi tiết phòng</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Loại phòng:</label>
                                <span>Phòng <%= roomType%></span>
                            </div>
                            <div class="detail-item">
                                <label>Mã phòng:</label>
                                <span><% if (booking != null) {%>R<%= String.format("%03d", booking.getRoomId())%><% }%></span>
                            </div>
                            <div class="detail-item">
                                <label>Số khách:</label>
                                <span>2 người</span>
                            </div>
                            <div class="detail-item">
                                <label>Diện tích:</label>
                                <span>25m²</span>
                            </div>
                        </div>
                    </div>

                    <!-- Price Breakdown -->
                    <div class="price-breakdown">
                        <h3><i class="fa-solid fa-file-invoice-dollar"></i> Chi tiết thanh toán</h3>
                        <div class="price-item">
                            <label>Giá phòng/đêm:</label>
                            <span><%= String.format("%,.0f", roomPrice)%>đ</span>
                        </div>
                        <div class="price-item">
                            <label>Số đêm:</label>
                            <span><%= nights%> đêm</span>
                        </div>
                        <div class="price-item">
                            <label>Tạm tính:</label>
                            <span><%= String.format("%,d", totalAmount)%>đ</span>
                        </div>
                        <div class="price-item">
                            <label>Thuế & Phí dịch vụ (10%):</label>
                            <span><%= String.format("%,d", (long) (totalAmount * 0.1))%>đ</span>
                        </div>

                        <div class="total-amount">
                            <label>TỔNG THANH TOÁN:</label>
                            <span><%= String.format("%,d", (long) (totalAmount * 1.1))%>đ</span>
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
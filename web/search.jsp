<%@page import="model.RoomType"%>
<%@page import="java.util.List"%>
<%@page import="model.Room"%>
<%@page import="model.Staff"%>
<%@page import="model.Guest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kết quả tìm kiếm - Grand Hotel</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/searchStyle.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <%
            // Lấy dữ liệu từ request
            List<Room> searchResults = (List<Room>) request.getAttribute("availableRooms");
            List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");

            // Lấy tham số tìm kiếm
            String checkIn = request.getParameter("check-in");
            String checkOut = request.getParameter("check-out");
            String guests = request.getParameter("guests");
            String roomTypeParam = request.getParameter("room-type");

            // Session user
            HttpSession sessionObj = request.getSession(false);
            Boolean isLogin = false;
            String username = "";
            Staff staff = (Staff) sessionObj.getAttribute("STAFF");
            Guest user = (Guest) sessionObj.getAttribute("USER");

            if (sessionObj != null) {
                isLogin = (Boolean) sessionObj.getAttribute("isLogin");
                if (staff != null) {
                    username = staff.getUsername();
                } else if (user != null) {
                    username = user.getUsername();
                }
            }
        %>

        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>

                <nav class="main-nav">
                    <%
                        if (isLogin != null && isLogin == true) {
                            if (staff != null && staff.getRole().equalsIgnoreCase("receptionist")) {
                    %>
                    <a href="MainController?action=recepDashboard" class="welcome">
                        <i class="fa-solid fa-user"></i> Xin chào, <%= username%>!
                    </a>
                    <a href="MainController?action=logout" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                    <%
                    } else {
                    %>
                    <span class="welcome">Xin chào, <%= username%>!</span>
                    <a href="MainController?action=logoutUser" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                    <%
                        }
                    } else { %>
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

        <section class="search-header">
            <div class="container">
                <h1><i class="fa-solid fa-magnifying-glass"></i> Kết quả tìm kiếm</h1>
                <p>Các phòng phù hợp với yêu cầu của bạn</p>
            </div>
        </section>

        <div class="container">
            <div class="search-info">
                <div class="search-params">
                    <div class="search-param">
                        <div class="search-param-label">
                            <i class="fa-solid fa-calendar-check"></i> Nhận phòng
                        </div>
                        <div class="search-param-value"><%= checkIn != null ? checkIn : "Chưa chọn"%></div>
                    </div>
                    <div class="search-param">
                        <div class="search-param-label">
                            <i class="fa-solid fa-calendar-xmark"></i> Trả phòng
                        </div>
                        <div class="search-param-value"><%= checkOut != null ? checkOut : "Chưa chọn"%></div>
                    </div>
                    <div class="search-param">
                        <div class="search-param-label">
                            <i class="fa-solid fa-users"></i> Số khách
                        </div>
                        <div class="search-param-value"><%= guests != null ? guests + " người" : "Chưa chọn"%></div>
                    </div>
                    <div class="search-param">
                        <div class="search-param-label">
                            <i class="fa-solid fa-door-open"></i> Loại phòng
                        </div>
                        <div class="search-param-value">
                            <%
                                if (roomTypeParam != null && !roomTypeParam.isEmpty()) {
                                    out.print(roomTypeParam);
                                } else {
                                    out.print("Tất cả");
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>

            <h1 style="text-align: center">${requestScope.ERROR}</h1>

            <section class="results-section">
                <div class="results-header">
                    <div class="results-count">
                        Tìm thấy <span><%= searchResults != null ? searchResults.size() : 0%></span> phòng phù hợp
                    </div>
                    <button class="modify-search-btn" onclick="window.history.back()">
                        <i class="fa-solid fa-rotate-left"></i> Tìm kiếm lại
                    </button>
                </div>

                <%
                    if (searchResults != null && !searchResults.isEmpty()) {
                        // Map để lưu ảnh cho từng loại phòng
                        java.util.Map<String, String> roomTypeImages = new java.util.HashMap<>();
                        roomTypeImages.put("Single", "Images/SingleRoom.jpg");
                        roomTypeImages.put("Double", "Images/DoubleRoom.jpg");
                        roomTypeImages.put("Suite", "Images/SuiteRoom.jpg");
                        roomTypeImages.put("Deluxe", "Images/DeluxeRoom.jpg");
                        roomTypeImages.put("Family", "Images/FamilyRoom.jpg");
                        roomTypeImages.put("Presidential", "Images/Presidential.jpg");

                        for (Room room : searchResults) {
                            // Tìm RoomType tương ứng
                            RoomType roomType = null;
                            if (roomTypes != null) {
                                for (RoomType rt : roomTypes) {
                                    if (rt.getRoomTypeId() == room.getRoomTypeId()) {
                                        roomType = rt;
                                        break;
                                    }
                                }
                            }

                            if (roomType != null) {
                                String imageUrl = roomTypeImages.getOrDefault(roomType.getTypeName(), "Images/default.jpg");
                                boolean isAvailable = "Available".equalsIgnoreCase(room.getStatus());
                %>

                <div class="room-card">
                    <div class="room-card-content">
                        <div class="room-card-image">
                            <img src="<%= imageUrl%>" alt="Phòng <%= room.getRoomNumber()%>">
                            <div class="room-status-badge">
                                <i class="fa-solid fa-check-circle"></i>
                                Còn trống
                            </div>
                            <div class="room-number-badge">
                                Phòng <%= room.getRoomNumber()%>
                            </div>
                        </div>

                        <div class="room-card-details">
                            <div>
                                <div class="room-type-header">
                                    <div class="room-type-category"><%= roomType.getTypeName()%></div>
                                    <h2 class="room-type-name">Phòng <%= roomType.getTypeName()%></h2>
                                </div>

                                <div class="room-amenities">
                                    <div class="amenity-item">
                                        <i class="fa-solid fa-users"></i>
                                        <span>Tối đa <%= roomType.getCapacity()%> khách</span>
                                    </div>
                                    <div class="amenity-item">
                                        <i class="fa-solid fa-bed"></i>
                                        <span>Giường <%= roomType.getTypeName()%></span>
                                    </div>
                                    <div class="amenity-item">
                                        <i class="fa-solid fa-bath"></i>
                                        <span>Phòng tắm riêng</span>
                                    </div>
                                    <div class="amenity-item">
                                        <i class="fa-solid fa-wifi"></i>
                                        <span>WiFi miễn phí</span>
                                    </div>
                                    <div class="amenity-item">
                                        <i class="fa-solid fa-wind"></i>
                                        <span>Điều hòa nhiệt độ</span>
                                    </div>
                                    <div class="amenity-item">
                                        <i class="fa-solid fa-tv"></i>
                                        <span>TV màn hình phẳng</span>
                                    </div>
                                </div>
                            </div>

                            <div class="room-card-footer">
                                <div class="room-price">
                                    <%= String.format("%,d", (int) roomType.getPrice())%>đ
                                    <span class="room-price-label">/đêm</span>
                                </div>
                                <form action="MainController" method="post" style="display: inline;">
                                    <input type="hidden" name="roomId" value="<%= room.getRoomId()%>">
                                    <input type="hidden" name="roomNumber" value="<%= room.getRoomNumber()%>">
                                    <input type="hidden" name="roomType" value="<%= roomType.getTypeName()%>">
                                    <input type="hidden" name="checkIn" value="<%= checkIn%>">
                                    <input type="hidden" name="checkOut" value="<%= checkOut%>">
                                    <input type="hidden" name="guests" value="<%= guests%>">
                                    <input type="hidden" name="price" value="<%= roomType.getPrice() %>">

                                    <button type="submit" name="action"  value="preBooking" class="book-room-btn">
                                        <i class="fa-solid fa-calendar-check"></i>
                                        Đặt phòng ngay
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                        }
                    }
                } else {
                %>

                <div class="no-results">
                    <div class="no-results-icon">
                        <i class="fa-solid fa-bed-pulse"></i>
                    </div>
                    <h2>Không tìm thấy phòng phù hợp</h2>
                    <p>Rất tiếc, không có phòng nào phù hợp với tiêu chí tìm kiếm của bạn.</p>
                    <button class="modify-search-btn" onclick="window.history.back()">
                        <i class="fa-solid fa-magnifying-glass"></i> Thử tìm kiếm khác
                    </button>
                </div>

                <%
                    }
                %>
            </section>
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
    </body>
</html>
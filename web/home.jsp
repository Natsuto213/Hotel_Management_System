<%@page import="model.Staff"%>
<%@page import="model.Guest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Grand Hotel</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
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

                    if (sessionObj != null) {
                        isLogin = (Boolean) sessionObj.getAttribute("isLogin");
                        
                        Object staff = sessionObj.getAttribute("STAFF");
                        Object user = sessionObj.getAttribute("USER");
                        if (staff instanceof Staff) {
                            username = ((Staff) user).getUsername();
                        } else if (user instanceof Guest) {
                            username = ((Guest) user).getUsername();
                        }
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

        <section class="hero-section">
            <div class="hero-content">
                <h1>Chào mừng đến với Grand Hotel</h1>
                <p>Trải nghiệm dịch vụ đẳng cấp thế giới với không gian sang trọng và tiện nghi hiện đại</p>
            </div>
        </section>

        <section class="booking-section">
            <div class="container">
                <h2 class="section-subtitle">Tìm kiếm phòng lý tưởng</h2>
                <p class="section-description">Chọn phòng và các tiện nghi mong muốn cho kỳ nghỉ trọn vẹn</p>
                <form class="booking-form">
                    <div class="form-group">
                        <label for="check-in">Ngày nhận phòng</label>
                        <input type="date" id="check-in">
                    </div>
                    <div class="form-group">
                        <label for="check-out">Ngày trả phòng</label>
                        <input type="date" id="check-out">
                    </div>
                    <div class="form-group">

                        <label for="guests">Số khách</label>
                        <input type="number" id="guests" placeholder="Số lượng">
                    </div>
                    <div class="form-group">
                        <label for="room-type">Loại phòng</label>
                        <select id="room-type">
                            <option>Tất cả</option>
                            <option>Phòng Single</option>
                            <option>Phòng Double</option>
                            <option>Phòng Suite</option>
                            <option>Phòng Deluxe</option>
                            <option>Phòng Family</option>
                            <option>Phòng Presidential</option>
                        </select>
                    </div>
                    <button type="submit" class="search-button">
                        Tìm kiếm</button>
                </form>
            </div>
        </section>

        <main class="rooms-section">
            <div class="container">
                <h2 class="section-title">Các phòng của chúng tôi</h2>
                <p class="section-description">Từ phòng tiêu chuẩn ấm cúng, sang trọng, với cơ sở vật chất tốt sẽ mang đến trải nghiệm tuyệt vời</p>

                <div class="rooms-grid">
                    <div class="room-card">
                        <div class="room-image">
                            <img src="Images/SingleRoom.jpg" alt="Phòng Single">
                            <span class="room-tag">Single</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Single</h3>
                            <p>Phòng đơn cùng với đầy đủ tiện nghi cơ bản, phù hợp cho kỳ nghỉ của bạn.</p>
                            <div class="room-amenities">

                                <span><i class="fa-solid fa-users"></i> Tối đa 2 khách</span>
                                <span><i class="fa-solid fa-vector-square"></i> 25m²</span>
                                <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                                <span><i class="fa-solid fa-car"></i> Parking</span>
                            </div>
                            <div class="room-price">1.500.000đ <span class="per-night">/đêm</span></div>
                            <form action="MainController" method="post">
                                <input type="hidden" name="txtroomtype" value="Single" />
                                <button type="submit" class="book-button" name = "action" value="booking">Đặt phòng ngay</button>
                            </form>
                        </div>
                    </div>

                    <div class="room-card">
                        <div class="room-image">
                            <img src=Images/DoubleRoom.jpg alt="Phòng Double">
                            <span class="room-tag">Double</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Double</h3>
                            <p>Phòng rộng rãi với view đẹp, trang bị nội thất hiện đại và các tiện ích cao cấp.</p>

                            <div class="room-amenities">
                                <span><i class="fa-solid fa-users"></i> Tối đa 2 khách</span>
                                <span><i class="fa-solid fa-vector-square"></i> 35m²</span>
                                <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                                <span><i class="fa-solid fa-car"></i> Parking</span>
                            </div>
                            <div class="room-price">2.500.000đ <span class="per-night">/đêm</span></div>
                            <form action="MainController" method="post">
                                <input type="hidden" name="txtroomtype" value="Double" />
                                <button type="submit" class="book-button" name = "action" value="booking">Đặt phòng ngay</button>
                            </form>
                        </div>
                    </div>

                    <div class="room-card">
                        <div class="room-image">
                            <img src=Images/SuiteRoom.jpg alt="Phòng Suite">
                            <span class="room-tag">Suite</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Suite</h3>
                            <p>Phòng suite sang trọng với phòng khách riêng biệt và dịch vụ hoàn hảo.</p>
                            <div class="room-amenities">
                                <span><i class="fa-solid fa-users"></i> Tối đa 4 khách</span>
                                <span><i class="fa-solid fa-vector-square"></i> 50m²</span>
                                <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                                <span><i class="fa-solid fa-car"></i> Parking</span>
                            </div>
                            <div class="room-price">4.999.000đ <span class="per-night">/đêm</span></div>
                            <form action="MainController" method="post">
                                <input type="hidden" name="txtroomtype" value="Suite" />
                                <button type="submit" class="book-button" name = "action" value="booking">Đặt phòng ngay</button>
                            </form>
                        </div>
                    </div>

                    <div class="room-card">
                        <div class="room-image">
                            <img src=Images/DeluxeRoom.jpg alt="Phòng Deluxe">
                            <span class="room-tag">Deluxe</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Deluxe</h3>
                            <p>Phòng rộng rãi với view đẹp, thiết kế hiện đại và các tiện ích cao cấp.</p>
                            <div class="room-amenities">
                                <span><i class="fa-solid fa-users"></i> Tối đa 4 khách</span>
                                <span><i class="fa-solid fa-vector-square"></i> 50m²</span>
                                <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                                <span><i class="fa-solid fa-car"></i> Parking</span>
                            </div>
                            <div class="room-price">6.999.000đ <span class="per-night">/đêm</span></div>
                            <form action="MainController" method="post">
                                <input type="hidden" name="txtroomtype" value="Deluxe" />
                                <button type="submit" class="book-button" name = "action" value="booking">Đặt phòng ngay</button>
                            </form>
                        </div>
                    </div>

                    <div class="room-card">
                        <div class="room-image">
                            <img src=Images/FamilyRoom.jpg alt="Phòng Family">
                            <span class="room-tag">Family</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Family</h3>
                            <p>Phòng rộng rãi được thiết kế đặc biệt cho gia đình có trẻ em với khu vực chơi riêng.</p>
                            <div class="room-amenities">
                                <span><i class="fa-solid fa-users"></i> Tối đa 4 khách</span>
                                <span><i class="fa-solid fa-vector-square"></i> 50m²</span>
                                <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                                <span><i class="fa-solid fa-car"></i> Parking</span>
                            </div>
                            <div class="room-price">9.999.000đ <span class="per-night">/đêm</span></div>
                            <form action="MainController" method="post">
                                <input type="hidden" name="txtroomtype" value="Family" />
                                <button type="submit" class="book-button" name = "action" value="booking">Đặt phòng ngay</button>
                            </form>                       
                        </div>
                    </div>

                    <div class="room-card">
                        <div class="room-image">
                            <img src=Images/Presidential.jpg alt="Phòng Presidential">
                            <span class="room-tag">Presidential</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Presidential</h3>
                            <p>Phòng cao cấp nhất với thiết kế đẳng cấp quốc tế và dịch vụ VIP độc quyền.</p>
                            <div class="room-amenities">
                                <span><i class="fa-solid fa-users"></i> Tối đa 6 khách</span>
                                <span><i class="fa-solid fa-vector-square"></i> 50m²</span>
                                <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                                <span><i class="fa-solid fa-car"></i> Parking</span>
                            </div>
                            <div class="room-price">11.999.000đ <span class="per-night">/đêm</span></div>
                            <form action="MainController" method="post">
                                <input type="hidden" name="txtroomtype" value="Presidential" />
                                <button type="submit" class="book-button" name = "action" value="booking">Đặt phòng ngay</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

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

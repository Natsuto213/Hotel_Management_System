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
    </head>
    <body>
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">Grand Hotel</a>
                <nav class="main-nav">
                    <a href="MainController?action=login" class="nav-button-secondary">Đăng nhập</a>
                    <a href="MainController?action=register" class="nav-button-primary">Đăng ký</a>
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
                        </select>
                    </div>
                    <button type="submit" class="search-button">Tìm kiếm</button>
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
                            <img src="Images/StandardRoom.jpg" alt="Phòng Single">
                            <span class="room-tag">Single</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Single</h3>
                            <p>Phòng đơn cùng với đầy đủ tiện nghi cơ bản, phù hợp cho kỳ nghỉ của bạn.</p>
                            <div class="room-amenities">
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Tối đa 2 khách</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> 25m²</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Bathroom</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Parking</span>
                            </div>
                            <div class="room-price">1.500.000đ <span class="per-night">/đêm</span></div>
                            <button class="book-button">Đặt phòng ngay</button>
                        </div>
                    </div>

                    <div class="room-card">
                        <div class="room-image">
                            <img src=Images/DeluxeRoom.jpg alt="Phòng Double">
                            <span class="room-tag">Double</span>
                        </div>
                        <div class="room-info">
                            <h3>Phòng Double</h3>
                            <p>Phòng rộng rãi với view đẹp, trang bị nội thất hiện đại và các tiện ích cao cấp.</p>
                            <div class="room-amenities">
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Tối đa 2 khách</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> 35m²</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Bathroom</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Parking</span>
                            </div>
                            <div class="room-price">2.500.000đ <span class="per-night">/đêm</span></div>
                            <button class="book-button">Đặt phòng ngay</button>
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
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Tối đa 4 khách</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> 50m²</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Bathroom</span>
                                <span><img src="https://via.placeholder.com/16x16.png?text=ICON" alt="icon"> Parking</span>
                            </div>
                            <div class="room-price">4.500.000đ <span class="per-night">/đêm</span></div>
                            <button class="book-button">Đặt phòng ngay</button>
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
                        <li>(012) 345 5678</li>
                        <li>support@grandhotel.com</li>
                        <li>123 Đường ABC, Quận 1, TP.HCM</li>
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

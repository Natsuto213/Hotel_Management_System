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

                    List<Room> rooms = (List<Room>) sessionObj.getAttribute("rooms");
                    List<RoomType> roomTypes = (List<RoomType>) sessionObj.getAttribute("roomTypes");

                    Boolean isLogin = false;
                    String username = "";
                    Staff staff = (Staff) sessionObj.getAttribute("STAFF");
                    Guest user = (Guest) sessionObj.getAttribute("USER");

                    if (sessionObj != null) {
                        isLogin = (Boolean) sessionObj.getAttribute("isLogin");
                        if (staff != null) {
                            username = staff.getUsername();
                        } else if (user instanceof Guest) {
                            username = user.getUsername();
                        }
                    }
                %>

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
                    <a href="MainController?action=logout" class="nav-button-primary">
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
                <form class="booking-form" action="SearchController" method="get" onsubmit="return validateBookingForm()">
                    <div class="form-group">
                        <label for="check-in">Ngày nhận phòng</label>
                        <input type="date" id="check-in" name="check-in" required=""> </div>
                    <div class="form-group">
                        <label for="check-out">Ngày trả phòng</label>
                        <input type="date" id="check-out" name="check-out" required=""> </div>
                    <div class="form-group">
                        <label for="guests">Số khách</label>
                        <input type="number" id="guests" name="guests" placeholder="Số lượng" required=""> </div>
                    <div class="form-group">
                        <label for="room-type">Loại phòng</label>
                        <select id="room-type" name="room-type" required=""> <option value="">Chọn</option>
                            <%
                                if (roomTypes != null) {
                                    for (RoomType rt : roomTypes) {
                            %>
                            <option value="<%= rt.getRoomTypeId()%>"><%= rt.getTypeName()%></option> <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <button type="submit" class="search-button">
                        <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
                    </button>
                </form>
            </div>
        </section>

        <main class="rooms-section">
            <div class="container">
                <h2 class="section-title">Không Gian Nghỉ Dưỡng Đa Dạng</h2>
                <p class="section-description">Từ những căn phòng ấm cúng đến các suite tổng thống sang trọng, mỗi không gian đều là một tuyên ngôn về sự tinh tế.</p>

                <%
                    if (roomTypes != null) {
                        String[] images = {
                            "Images/SingleRoom.jpg",
                            "Images/DoubleRoom.jpg",
                            "Images/SuiteRoom.jpg",
                            "Images/DeluxeRoom.jpg",
                            "Images/FamilyRoom.jpg",
                            "Images/Presidential.jpg"
                        };
                        String[] descriptions = {
                            "Không gian nghỉ ngơi tinh tế với đầy đủ tiện nghi hiện đại. Phòng Single được thiết kế tối ưu cho sự riêng tư và thoải mái, phù hợp cho chuyến công tác hoặc kỳ nghỉ dưỡng cá nhân.",
                            "Kết hợp hoàn hảo giữa phong cách cổ điển và hiện đại, phòng Double mang đến không gian sống rộng rãi với nội thất cao cấp và ánh sáng tự nhiên tràn ngập, tạo nên bầu không khí lãng mạn cho mọi khoảnh khắc.",
                            "Tận hưởng sự xa hoa trong không gian Suite với khu vực sinh hoạt tách biệt, phòng ngủ riêng tư và ban công view toàn cảnh. Mỗi chi tiết được chăm chút tỉ mỉ để mang lại trải nghiệm nghỉ dưỡng đẳng cấp 5 sao.",
                            "Biểu tượng của sự tinh tế và đẳng cấp, phòng Deluxe sở hữu thiết kế nội thất sang trọng, hệ thống âm thanh cao cấp và phòng tắm spa riêng, đáp ứng mọi nhu cầu của khách hàng khó tính nhất.",
                            "Thiên đường dành cho gia đình với nhiều phòng ngủ kết nối, khu vui chơi an toàn cho trẻ em và góc bếp tiện nghi. Family Suite tạo điều kiện để cả gia đình cùng tận hưởng những khoảnh khắc ấm áp và đáng nhớ."

                        };

                        int itemIndex = 0;
                        for (RoomType rt : roomTypes) {
                            itemIndex++;
                            String imageUrl = (itemIndex < images.length) ? images[itemIndex] : images[0];
                            String description = (itemIndex < descriptions.length) ? descriptions[itemIndex] : "Đỉnh cao của sự xa hoa và đẳng cấp hoàng gia. Presidential Suite với diện tích rộng lớn, thiết kế độc đáo, bồn tắm jacuzzi riêng và dịch vụ butler 24/7 sẽ biến kỳ nghỉ của bạn thành một trải nghiệm không thể nào quên.";

                %>

                <div class="room-feature reveal">
                    <div class="room-feature-image">
                        <img src="<%= imageUrl%>" alt="Phòng <%= rt.getTypeName()%>">
                        <span class="room-tag"><%= rt.getTypeName()%></span> 
                    </div>  
                    <div class="room-feature-content">
                        <h3>Phòng <%= rt.getTypeName()%></h3> <br>
                        <p><%= description%></p>
                        <div class="room-feature-details">
                            <span><i class="fa-solid fa-users"></i> Tối đa <%= rt.getCapacity()%> khách</span>
                            <span><i class="fa-solid fa-bath"></i> Bathroom</span>
                            <span><i class="fa-solid fa-car"></i> Parking</span>
                        </div>
                        <span class="room-type-subtitle"><%= rt.getFormattedPrice()%> VND / đêm</span>
                    </div>
                </div>

                <%
                        }
                    }
                %>
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
        <script>
            const isLoggedIn = <%= (isLogin != null && isLogin == true) ? "true" : "false"%>;

            // Thiết lập ngày tối thiểu cho input check-in và check-out
            window.addEventListener('DOMContentLoaded', function () {
                const checkInInput = document.getElementById('check-in');
                const checkOutInput = document.getElementById('check-out');

                // Lấy ngày mai (ngày hiện tại + 1)
                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);
                const minDate = tomorrow.toISOString().split('T')[0];

                // Set min date cho check-in là ngày mai
                checkInInput.setAttribute('min', minDate);

                // Khi chọn ngày check-in, update min date cho check-out
                checkInInput.addEventListener('change', function () {
                    const checkInDate = new Date(this.value);
                    checkInDate.setDate(checkInDate.getDate() + 1);
                    const minCheckOut = checkInDate.toISOString().split('T')[0];
                    checkOutInput.setAttribute('min', minCheckOut);

                    // Reset check-out nếu nó nhỏ hơn check-in + 1
                    if (checkOutInput.value && checkOutInput.value <= this.value) {
                        checkOutInput.value = '';
                    }
                });
            });

            function validateBookingForm() {
                // Kiểm tra đăng nhập
                if (!isLoggedIn) {
                    alert('Bạn cần đăng nhập để tìm kiếm phòng!');
                    window.location.href = 'MainController?action=login';
                    return false;
                }

                const checkIn = document.getElementById('check-in').value;
                const checkOut = document.getElementById('check-out').value;
                const guests = document.getElementById('guests').value;
                const roomType = document.getElementById('room-type').value;

                // Kiểm tra các trường bắt buộc
                if (!checkIn || !checkOut || !guests || !roomType) {
                    alert('Vui lòng điền đầy đủ thông tin!');
                    return false;
                }

                // Kiểm tra số khách
                if (guests < 1) {
                    alert('Số khách phải từ 1 trở lên!');
                    return false;
                }

                // Kiểm tra ngày nhận phòng phải từ ngày mai
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const checkInDate = new Date(checkIn);
                const tomorrow = new Date(today);
                tomorrow.setDate(tomorrow.getDate() + 1);

                if (checkInDate < tomorrow) {
                    alert('Ngày nhận phòng phải từ ngày mai trở đi!');
                    return false;
                }

                // Kiểm tra ngày trả phòng phải sau ngày nhận phòng
                const checkOutDate = new Date(checkOut);
                if (checkOutDate <= checkInDate) {
                    alert('Ngày trả phòng phải sau ngày nhận phòng!');
                    return false;
                }

                return true;
            }

            function checkLogin() {
                if (!isLoggedIn) {
                    alert('Bạn cần đăng nhập để đặt phòng!');
                    window.location.href = 'MainController?action=login';
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>

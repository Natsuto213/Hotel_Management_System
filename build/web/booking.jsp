
<%@page import="model.Room"%>
<%@page import="java.util.List"%>
<%@page import="model.RoomType"%>
<%@page import="utils.IConstants"%>
<%@page import="model.Guest"%>
<%@page import="model.Staff"%>
<%-- 
    Document   : booking
    Created on : Oct 9, 2025, 12:27:18 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Page</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/pagesStyle.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body class="register-page">
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>

                <%
                    HttpSession sessionObj = request.getSession(false);
                    List<RoomType> roomTypes = (List<RoomType>) sessionObj.getAttribute("roomTypes");

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
                    %>
                </nav>
            </div>
        </header>

        <section class="booking-section" style="margin-top: 100px">
            <div class="container">
                <h2 class="section-subtitle">Tìm kiếm phòng lý tưởng</h2>
                <p class="section-description">Chọn phòng và các tiện nghi mong muốn cho kỳ nghỉ trọn vẹn</p>
                <form class="booking-form" action="MainController" method="get" onsubmit="return validateBookingForm()">
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
                    <button type="submit" name="action" value="search" class="search-button">
                        <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
                    </button>
                </form>
            </div>
        </section>
        <%
            } else {
                request.setAttribute("ERROR", "Vui lòng đăng nhập trước khi đặt phòng");
                request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);
            }
        %>
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

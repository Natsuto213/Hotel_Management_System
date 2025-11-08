<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pre Booking Page</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

        <style>
            /* =================================
                GLOBAL & BODY STYLING
                (Giống invoice.jsp)
                ================================= */
            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f7f4f6; /* Đã đổi sang màu nền xám-hồng nhạt */
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
                CARD STYLING
                (Áp dụng style .invoice-card cho các section)
                ================================= */
            .guest-info,
            .room-info,
            .service-info,
            .payment-info,
            .summary {
                background-color: #ffffff;
                border-radius: 12px;
                padding: 25px 30px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.07);
                margin-bottom: 25px; /* Thêm khoảng cách giữa các card */
            }

            /* =================================
                HEADER STYLING (h1)
                (Thêm icon tự động giống invoice)
                ================================= */
            h1 {
                font-size: 1.6rem;
                font-weight: 600;
                color: #a91370; /* === ĐÃ ĐỔI MÀU === */
                margin-top: 0;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                display: flex;
                align-items: center;
                gap: 12px;
            }
            /* Tự động thêm icon vào H1 */
            .guest-info h1::before {
                font-family: "Font Awesome 6 Free";
                font-weight: 900;
                content: "\f007"; /* fa-user */
            }
            .room-info h1::before {
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
                INFO BLOCKS (Guest & Room)
                (Sử dụng Grid để căn chỉnh)
                ================================= */
            .guest-info,
            .room-info {
                display: grid;
                /* 2 cột, tự động xuống hàng trên màn hình nhỏ */
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 5px 20px;
            }
            .guest-info h1,
            .room-info h1 {
                grid-column: 1 / -1; /* Header chiếm toàn bộ chiều rộng */
            }
            .guest-info div,
            .room-info div {
                margin-bottom: 10px;
            }
            .guest-info label,
            .room-info label {
                display: block;
                font-weight: 600;
                color: #555;
                font-size: 0.9rem;
            }
            .guest-info p,
            .room-info p {
                font-size: 1.1rem;
                margin: 0;
                color: #000;
            }

            /* =================================
                SERVICE INFO
                ================================= */

            /* Form thêm service */
            .new-service form {
                display: flex;
                flex-wrap: wrap; /* Tự xuống hàng nếu không đủ chỗ */
                gap: 10px;
                align-items: center;
            }
            .new-service label {
                font-weight: 600;
                flex-basis: 100%; /* Label chiếm 1 hàng */
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
                background-color: #c71585; /* === ĐÃ ĐỔI MÀU === */
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
            } /* === ĐÃ ĐỔI MÀU === */

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
                background: #e74c3c; /* Màu đỏ cho nút xóa */
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
                display: none;
            } /* Ẩn thẻ <br> thừa */

            /* =================================
                PAYMENT INFO (Custom Radio Button)
                ================================= */
            .method-option {
                display: flex;
                align-items: center;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                margin-bottom: 10px;
                cursor: pointer;
                transition: border-color 0.3s, box-shadow 0.3s;
            }
            .method-option:hover {
                border-color: #c71585; /* === ĐÃ ĐỔI MÀU === */
            }
            .method-option input[type="radio"] {
                display: none; /* Ẩn radio mặc định */
            }
            .custom-radio {
                width: 20px;
                height: 20px;
                border: 2px solid #aaa;
                border-radius: 50%;
                margin-right: 15px;
                display: grid;
                place-items: center;
                transition: all 0.3s;
            }
            /* Hiệu ứng khi được chọn */
            .method-option input[type="radio"]:checked + .custom-radio {
                border-color: #c71585; /* === ĐÃ ĐỔI MÀU === */
                background-color: #c71585; /* === ĐÃ ĐỔI MÀU === */
            }
            .custom-radio::before {
                content: '';
                width: 10px;
                height: 10px;
                background-color: white;
                border-radius: 50%;
                transform: scale(0);
                transition: transform 0.3s;
            }
            .method-option input[type="radio"]:checked + .custom-radio::before {
                transform: scale(1);
            }
            .method-option .icon {
                font-size: 1.5rem;
                color: #c71585; /* === ĐÃ ĐỔI MÀU === */
                margin-right: 15px;
                width: 30px;
                text-align: center;
            }
            .method-option span {
                font-weight: 500;
            }

            /* =================================
                SUMMARY (Giống .price-breakdown)
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
            .summary p:last-of-type { /* Total Amount */
                font-size: 1.4rem;
                font-weight: 700;
                color: #a91370; /* === ĐÃ ĐỔI MÀU === */
                margin-top: 20px;
            }
            .summary p:last-of-type span {
                color: #a91370; /* === ĐÃ ĐỔI MÀU === */
            }

            .summary hr {
                border: 0;
                border-top: 1px dashed #ccc;
                margin: 20px 0;
            }

            /* =================================
                FINAL BUTTONS (Giống .btn)
                ================================= */
            .summary .btn {
                font-family: 'Montserrat', sans-serif;
                padding: 12px 25px;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 20px;
                text-decoration: none;
                display: inline-block;
                border: none;
            }

            /* Nút "Confirm Booking" (Giống .btn-primary) */
            .summary .btn-primary {
                background-color: #c71585; /* === ĐÃ ĐỔI MÀU === */
                color: white;
                float: right; /* Đặt ở bên phải */
            }
            .summary .btn-primary:hover {
                background-color: #a91370; /* === ĐÃ ĐỔI MÀU === */
                transform: translateY(-2px);
                /* === ĐÃ ĐỔI MÀU SHADOW === */
                box-shadow: 0 4px 10px rgba(199, 21, 133, 0.3);
            }

            /* Nút "Back To Home" (Giống .btn-outline) */
            .summary .btn-outline {
                background-color: transparent;
                color: #555;
                border: 2px solid #ccc;
            }
            .summary .btn-outline:hover {
                background-color: #f9f9f9;
                color: #000;
                border-color: #aaa;
            }
        </style>

    </head>

    <body>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:set var="guest" value="${sessionScope.USER}" />
        <c:set var="booking" value="${sessionScope.BOOKING}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}" />

        <div class="booking-form-container">

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

            <div class="room-info">
                <h1>Room Information</h1>
                <div>
                    <label>Room Number</label>
                    <p>${booking.roomNumber}</p>
                </div>
                <div>
                    <label>Room Type</label>
                    <p>${booking.typeName}</p>
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
                    <label>Capacity</label>
                    <p>${booking.guests}</p>
                </div>
                <div>
                    <label>Price per night</label>
                    <p>${booking.formattedPrice} VND</p>
                </div>
            </div>

            <div class="service-info">
                <h1>Additional Services</h1>

                <div class="new-service" >
                    <form action="MainController" method="post" 
                          onsubmit="return validateServiceDate(this);"
                          data-checkin="${booking.checkInDate}" 
                          data-checkout="${booking.checkOutDate}">

                        <label>Select Service</label> <select name="serviceid" required="">
                            <option value="" disabled selected>-- Select Service --</option>
                            <c:forEach var="s" items="${servicelist}">
                                <option value="${s.serviceid}">${s.servicename} (+${s.formattedPrice})</option>
                            </c:forEach>
                        </select>
                        <input type="number" name="quantity" min="1" value="1" placeholder="enter quantity" required="">
                        <input type="text" name="serviceDate" placeholder="Service Date" 
                               onfocus="(this.type = 'date')" 
                               onblur="if (!this.value)
                                           this.type = 'text'"
                               required=""
                               id="service-date-input" >  
                        <input type="hidden" name="isPreBooking" value="true" >  
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
                            <button type="submit" name="action" value="deleteService"><i class="fa-solid fa-x"></i></button>
                        </form>
                        <c:set var="serviceTotal" value="${serviceTotal + subtotal}" />
                    </c:forEach>
                </div>
            </div>

            <form action="MainController" method="post">
                <div class="summary">
                    <h1>Booking Summary</h1>
                    <fmt:parseDate var="checkInDate" value="${booking.checkInDate}" pattern="yyyy-MM-dd" />
                    <fmt:parseDate var="checkOutDate" value="${booking.checkOutDate}" pattern="yyyy-MM-dd" />

                    <c:set var="night" value="${(checkOutDate.time - checkInDate.time) / (1000*60*60*24)}" />
                    <c:set var="roomTotal" value="${night * booking.price}" />
                    <c:set var="total" value="${roomTotal + serviceTotal}"/>

                    <p>Room (${night} nights): <span><fmt:formatNumber value="${roomTotal}" type="number" groupingUsed="true"/> VND</span></p>
                    <p>Total Service: <span><fmt:formatNumber value="${serviceTotal}" type="number" groupingUsed="true"/> VND</span></p>
                    <hr>
                    <p>Total Amount: <span><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VND</span></p>

                    <input type="hidden" name="night" value="${night}">
                    <input type="hidden" name="roomTotal" value="${roomTotal}">
                    <input type="hidden" name="serviceTotal" value="${serviceTotal}">
                    <input type="hidden" name="total" value="${total}">

                    <c:set var="isBooking" value="${true}" scope="session"/>


                    <button type="submit" name="action" value="home" class="btn btn-outline">Back To Home</button>
                    <button type="submit" name="action" value="createBooking" class="btn btn-primary">Confirm Booking</button>
                </div>
            </form>

        </div>

        <script>
            function validateServiceDate(form) {
                // Lấy ngày check-in và check-out từ data attributes
                const checkInString = form.dataset.checkin;
                const checkOutString = form.dataset.checkout;

                // Lấy ngày dịch vụ từ input
                const serviceDateString = document.getElementById('service-date-input').value;

                if (!serviceDateString) {
                    alert('Vui lòng chọn ngày sử dụng dịch vụ.');
                    return false;
                }

                // Tạo đối tượng Date (sử dụng T00:00:00Z để so sánh UTC, tránh lỗi múi giờ)
                const checkInDate = new Date(checkInString + 'T00:00:00Z');
                const checkOutDate = new Date(checkOutString + 'T00:00:00Z');
                const serviceDate = new Date(serviceDateString + 'T00:00:00Z');

                // Điều kiện: Ngày dịch vụ PHẢI nằm TRONG KHOẢNG [checkIn, checkOut]
                if (serviceDate < checkInDate || serviceDate > checkOutDate) {
                    // Hiển thị thông báo lỗi (với dấu \ như bạn yêu cầu)
                    alert('Ngày dịch vụ phải nằm trong khoảng thời gian Check-in (${booking.checkInDate}) và Check-out (${booking.checkOutDate}).');
                    return false;
                }

                // Nếu ngày hợp lệ
                return true;
            }
        </script>
    </body>
</html>
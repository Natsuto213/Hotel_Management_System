<%-- 
    Document   : register
    Created on : Oct 7, 2025, 10:23:26 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/pagesStyle.css"/>
        <link rel="stylesheet" href="css/registerStyle.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body class="register-page">
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i>
                    <span>Grand Hotel</span>
                </a>
                <nav class="main-nav">
                    <a href="MainController?action=login" class="nav-button-primary">
                        <i class="fa-solid fa-user"></i> Đăng nhập
                    </a>
                </nav>
            </div>
        </header>

         <div class="register-wrapper">
            <div class="register-container">
                <i class="fa-solid fa-user-plus register-icon"></i>
                <h1 class="register-title">Đăng Ký</h1>
                <p class="register-subtitle">Tạo tài khoản mới để bắt đầu!</p>

                <form action="MainController" method="post">
                    <div class="form-group full-width">
                        <label class="form-label">
                            <i class="fa-solid fa-user"></i>
                            Họ và tên
                        </label>
                        <input 
                            type="text" 
                            name="txtfullname" 
                            class="form-input" 
                            placeholder="Nhập họ và tên" 
                            required
                        />
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">
                            <i class="fa-solid fa-user-circle"></i>
                            Tên đăng nhập
                        </label>
                        <input 
                            type="text" 
                            name="txtus" 
                            class="form-input" 
                            placeholder="Nhập tên đăng nhập" 
                            required
                        />
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">
                            <i class="fa-solid fa-envelope"></i>
                            Email
                        </label>
                        <input 
                            type="email" 
                            name="txtemail" 
                            class="form-input" 
                            placeholder="email@example.com" 
                            required
                        />
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fa-solid fa-lock"></i>
                                Mật khẩu
                            </label>
                            <input 
                                type="password" 
                                name="txtpassword" 
                                class="form-input" 
                                placeholder="Nhập mật khẩu" 
                                required
                            />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fa-solid fa-lock"></i>
                                Xác nhận
                            </label>
                            <input 
                                type="password" 
                                name="txtconfirmpassword" 
                                class="form-input" 
                                placeholder="Nhập lại mật khẩu" 
                                required
                            />
                            <div id="password-error"></div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fa-solid fa-phone"></i>
                                Số điện thoại
                            </label>
                            <input 
                                type="text" 
                                name="txtphone" 
                                class="form-input" 
                                placeholder="09xxxxxxxx" 
                                pattern="^(03|05|07|08|09)\d{8}$"
                                required
                            />
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fa-solid fa-calendar"></i>
                                Ngày sinh
                            </label>
                            <input 
                                type="date" 
                                name="txtdob" 
                                class="form-input"
                                required
                            />
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">
                            <i class="fa-solid fa-location-dot"></i>
                            Địa chỉ
                        </label>
                        <input 
                            type="text" 
                            name="txtaddress" 
                            class="form-input" 
                            placeholder="Nhập địa chỉ"
                            required
                        />
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">
                            <i class="fa-solid fa-id-card"></i>
                            Số CMND/CCCD
                        </label>
                        <input 
                            type="text" 
                            name="txtidnumber" 
                            class="form-input" 
                            placeholder="Số CMND/CCCD"
                            required
                        />
                    </div>
                    <%
                        if (request.getAttribute("ERROR") != null) {
                            out.print(request.getAttribute("ERROR"));
                        }
                    %>
                <button type="submit" name="action" value="createUser" class="register-button">
                        <i class="fa-solid fa-user-plus"></i>
                        Đăng ký
                    </button>
                </form>

                <p class="login-link">
                    Đã có tài khoản? <a href="MainController?action=login">Đăng nhập ngay</a>
                </p>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const password = document.querySelector("input[name='txtpassword']");
                const confirm = document.querySelector("input[name='txtconfirmpassword']");

                // Tạo phần hiển thị lỗi nếu chưa có
                let errorMsg = document.createElement("div");
                errorMsg.id = "password-error";
                confirm.insertAdjacentElement("afterend", errorMsg);

                // Hàm kiểm tra khớp mật khẩu
                function checkPasswords() {
                    if (confirm.value.length === 0) {
                        errorMsg.textContent = "";
                        confirm.classList.remove("error-input");
                        return;
                    }

                    if (password.value !== confirm.value) {
                        confirm.classList.add("error-input");
                        errorMsg.textContent = "Mật khẩu xác nhận không khớp!";
                    } else {
                        confirm.classList.remove("error-input");
                        errorMsg.textContent = "";
                    }
                }

                // Gọi kiểm tra khi người dùng đang nhập
                confirm.addEventListener("input", checkPasswords);
                password.addEventListener("input", checkPasswords);
            });
        </script>

    </body>
</html>
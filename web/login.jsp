<%-- 
    Document   : login
    Created on : Oct 4, 2025, 4:50:11 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng Nhập - Grand Hotel</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/pagesStyle.css"/>
        <link rel="stylesheet" href="css/loginStyle.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        
    
</head>
<body>
    
    <header class="main-header">
        <div class="container">
            <a href="MainController?action=home" class="logo">
                <i class="fa-solid fa-building fa-lg"></i>
                <span>Grand Hotel</span>
            </a>
            <nav class="main-nav">
                <a href="MainController?action=home" class="nav-button-secondary">
                    <i class="fa-solid fa-house"></i> Trang chủ
                </a>
                <a href="MainController?action=register" class="nav-button-primary">
                    <i class="fa-solid fa-user-plus"></i> Đăng ký
                </a>
            </nav>
        </div>
    </header>

    <!-- Login Form -->
    <div class="login-wrapper">
        <div class="login-container">
        <i class="fa-solid fa-arrow-right-to-bracket login-icon"></i>
        <h1 class="login-title">Đăng Nhập</h1>
        <p class="login-subtitle">Chào mừng quay trở lại!</p>

        <form action="MainController" method="post">
            <div class="form-group">
                <label class="form-label">
                    <i class="fa-solid fa-user"></i>
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

            <button type="submit" name="action" value="loginUser" class="login-button">
                <i class="fa-solid fa-arrow-right-to-bracket"></i>
                Đăng nhập
            </button>
        </form>

        <p class="register-link">
            Chưa có tài khoản? <a href="MainController?action=register">Đăng ký ngay</a>
        </p>

        <!-- Error message placeholder -->
        <div id="errorMessage" style="display: none;" class="error-message">
            Tên đăng nhập hoặc mật khẩu không đúng!
        </div>
        </div>
    </div>

    <script>
        // Hiển thị thông báo lỗi nếu có
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('error')) {
            document.getElementById('errorMessage').style.display = 'block';
        }
    </script>
</body>
</html>
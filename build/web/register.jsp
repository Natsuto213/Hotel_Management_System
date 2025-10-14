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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    </head>
    <body class="register-page">
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>
                <nav class="main-nav">

                    <a href="MainController?action=login" class="nav-button-secondary">
                        <i class="fa-solid fa-user"></i> Đăng nhập
                    </a>
                    <a href="MainController?action=register" class="nav-button-primary">
                        <i class="fa-solid fa-user-plus"></i> Đăng ký
                    </a>

                </nav>
            </div>
        </header>

        <div class="register-form">
            <form action="MainController" method="post">
                <h1 class="register-title">Register form</h1>
                <p><input type="text" name="txtfullname" required="" placeholder="Full Name *"></p>
                <p><input type="text" name="txtus" required="" placeholder="User Name *"></p>
                <p><input type="password" name="txtpassword" required="" placeholder="Password *"></p>
                <p><input type="text" name="txtphone" placeholder="Phone" pattern="^(03|05|07|08|09)\d{8}$"></p>
                <p><input type="text" name="txtemail" placeholder="Email" pattern="^[a-zA-Z0-9]+[@][a-zA-Z]+([.][a-zA-Z]+){1,2)$"></p>
                <p><input type="text" name="txtaddress" placeholder="Address"></p>
                <p><input type="text" name="txtidnumber" placeholder="ID Number"></p>
                <p><input type="date" name="txtdob"></p>
                <p><button type="submit" name="action" value="createUser">Submit</button></p>
            </form>
        </div>
    </body>
</html>

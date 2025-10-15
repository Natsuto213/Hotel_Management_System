<%-- 
    Document   : login
    Created on : Oct 4, 2025, 4:50:11 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
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

        <div class="form-page">
            <form action="MainController" method="post">
                <h1>Login</h1>
                <p><input type="text" name="txtus" placeholder="Username *" required="" /></p>
                <p><input type="password" name="txtpassword" placeholder="Password *" required=""/></p>
                <p><button type="submit" name="action" value="loginUser">Đăng nhập</button></p>
            </form>
            <p>
                <%
                    if (request.getAttribute("ERROR") != null) {
                        out.print(request.getAttribute("ERROR"));
                    }
                %>
            </p>
        </div>
    </body>
</html>

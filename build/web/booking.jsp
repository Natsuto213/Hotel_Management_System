
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
                    Boolean isLogin = false;
                    String username = "";

                    if (sessionObj != null) {
                        isLogin = (Boolean) sessionObj.getAttribute("isLogin");

                        Object user = sessionObj.getAttribute("USER");
                        if (user instanceof Staff) {
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
                    <% } %>
                </nav>
            </div>
        </header>

        <div class="form-page">
            <form action="MainController" method="post">
                <h1>Booking</h1>
                <input type="hidden" name="txtroomtype" value="${txtroomtype}">
                <input type="text" name="txtcheckin" placeholder="Ngày nhận phòng"
                       onfocus="this.type = 'date'" 
                       onblur="if (!this.value)
                               this.type = 'text'">             
                <input type="text" name="txtchecout" placeholder="Ngày trả phòng"
                       onfocus ="this.type = 'date'"
                       onblur = "if (!this.value)
                               this.type = 'text'">
                <p><button type="submit" name="action" value="bookroom">Đặt phòng ngay</button></p>
                <p>
                    <%
                        if (request.getAttribute("ERROR") != null) {
                            out.print(request.getAttribute("ERROR"));
                        }
                    %>
                </p>
            </form> 
        </div>
    </body>
</html>

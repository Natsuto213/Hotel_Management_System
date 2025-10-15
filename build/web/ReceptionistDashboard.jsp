<%-- 
    Document   : ReceptionistDashboard
    Created on : Oct 15, 2025, 2:18:57 PM
    Author     : Admin
--%>

<%@page import="model.Guest"%>
<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receptionist Dashboard</title>
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
                    <span class="welcome">Xin chào, <%= username%>!</span>
                    <a href="MainController?action=logout" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                </nav>
            </div>
        </header>

        <h1 style="margin-top: 100px; text-align: center">Receptionist Dashboard</h1>
    </body>
</html>

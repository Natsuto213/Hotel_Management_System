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
    </head>
    <body>
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

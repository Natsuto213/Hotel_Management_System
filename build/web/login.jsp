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
    </head>
    <body>
        <form action="MainController" method="post">
            <p>username:<input type="text" name="txtus" placeholder="Enter your name" required="" />*</p>
            <p>password:<input type="password" name="txtpassword" placeholder="Enter your password" required=""/>*</p>
            <p><input type="submit" name="action" value="loginUser" ></p>
        </form>
        <p><%
            if (request.getAttribute("ERROR") != null) {
                out.print(request.getAttribute("ERROR"));
            }
            %></p>
    </body>
</html>

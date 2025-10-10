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
    </head>
    <body>
        <form action="MainController" method="post">
            <p>Full name: <input type="text" name="txtfullname" required="">*</p>
            <p>User name: <input type="text" name="txtus" required="">*</p>
            <p>Password: <input type="password" name="txtpassword" required="">*</p>
            <p>Phone: <input type="text" name="txtphone"></p>
            <p>Email: <input type="text" name="txtemail"></p>
            <p>Address: <input type="text" name="txtaddress"></p>
            <p>ID Number: <input type="text" name="txtidnumber"></p>
            <p>Date of birth: <input type="date" name="txtdob"></p>
            <p><button type="submit" name="action" value="createUser">Submit</button></p>
        </form>
    </body>
</html>


<%-- 
    Document   : register
    Created on : Oct 4, 2025, 4:50:18 PM
    Author     : Admin
--%>

<%@page import="utils.IConstants"%>
<%@page import="model.Staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Register new Staff</h1>
        <form action="MainController" method="post" accept-charset="utf-8">
            <p>Full name: <input type="text" name="txtfullname" required="">*</p>
            <p>Username: <input type="text" name="txtus" required="">*</p>
            <p>Password: <input type="password" name="txtpassword" required="">*</p>
            <p>Phone: <input type="text" name="txtphone"></p>
            <p>Email: <input type="text" name="txtemail" pattern="^[a-zA-Z0-9]+[@][a-zA-Z]+([.][a-zA-Z]+){1,2)$"></p>
            <p>Role: <select name="txtrole">
                    <option value="Admin">Admin</option>
                    <option value="Receptionist">Receptionist</option>
                    <option value="Manager">Manager</option>
                    <option value="Housekeeping">Housekeeping</option>
                    <option value="ServiceStaff">Service Staff</option>  
                </select>
            </p>
            <p><input type="submit" name="action" value="createStaff"></p>
        </form>
    </body>
</html>

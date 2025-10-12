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
    </head>
    <body>
        <form action="MainController" method="post">
            <input type="hidden" name="txtroomtypeid" value="<%= request.getAttribute("txtroomtypeid")%>">
            <p>Check-in <input type="date" name="txtcheck-in" required="">*</p>
            <p>Check-out <input type="date" name ="txtcheck-out" required="">*</p>
            <p><button type="submit" name="action" value="bookroom">Đặt phòng ngay</button></p>
        </form>   
    </body>
</html>

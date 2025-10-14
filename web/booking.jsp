
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


    </head>
    <body>
        <div class="booking-page">
            <form action="MainController" method="post">
                <h1>Đơn đặt phòng</h1>
                <input type="hidden" name="txtroomtypeid" value="<%= request.getAttribute("txtroomtypeid")%>">
                <input type="text" name="txtcheckin" placeholder="Ngày nhận phòng"
                       onfocus="this.type = 'date'" 
                       onblur="if (!this.value)
                                   this.type = 'text'">             
                <input type="text" name="txtchecout" placeholder="Ngày trả phòng"
                       onfocus ="this.type = 'date'"
                       onblur = "if (!this.value)
                                   this.type = 'text'">
                <p><button type="submit" name="action" value="bookroom">Đặt phòng ngay</button></p>
            </form> 
        </div>
    </body>
</html>

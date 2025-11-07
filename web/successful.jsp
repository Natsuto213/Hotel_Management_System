<%-- 
    Document   : successfull
    Created on : Nov 7, 2025, 9:52:12 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Successful Page</title>
    </head>
    <body>
        <h1>${MSG}</h1>
        <form action="MainController" method="post">
            <button type="submit" name="action" value="home">Back To Home</button>
        </form>    </body>
</html>

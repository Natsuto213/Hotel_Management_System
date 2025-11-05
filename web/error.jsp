<%-- 
    Document   : error
    Created on : Nov 5, 2025, 9:54:10 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR Page</title>
    </head>
    <body>
        <h1>${ERROR}</h1>
        <form action="MainController" method="post">
            <button type="submit" name="action" value="home">Back To Home</button>
        </form>
    </body>
</html>

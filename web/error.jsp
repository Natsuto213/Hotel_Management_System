<%-- 
    Document   : error
    Created on : Oct 6, 2025, 3:20:22 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <p><%
            if (request.getAttribute("ERROR") != null) {
                out.print(request.getAttribute("ERROR"));
            }
            %></p>    
    </body>
</html>

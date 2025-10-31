<%@page import="java.util.ArrayList"%>
<%@page import="utils.IConstants"%>
<%@page import="model.Guest"%>
<%@page import="model.Staff"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receptionist Dashboard</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/recepDashboardStyle.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    
    <body class="receptionish-dashboard">
        <c:set var="staff" value="${sessionScope.STAFF}" />
        <c:choose>
            <c:when test="${staff!=null}">
                <header class="main-header">
                    <div class="container">
                        <a href="MainController?action=home" class="logo">
                            <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                        </a>
                        <nav class="main-nav">
                            <a href="MainController?action=recepDashboard" class="welcome">
                                <i class="fa-solid fa-user"></i> Xin chào, ${staff.username}!
                            </a>
                            <a href="MainController?action=logoutUser" class="nav-button-primary">
                                <i class="fa-solid fa-user-minus"></i> Đăng xuất
                            </a>
                        </nav>
                    </div>
                </header>

                <h1 style="margin-top: 100px; text-align: center">Receptionist Dashboard</h1>

                <h2>${requestScope.ERROR}</h2>

                <a href="MainController?action=register" class="create-btn">
                    <i class="fa-solid fa-user-plus"></i> Create account for customer
                </a>   

                <%
                    request.getSession().removeAttribute("USER");
                    String keyword = "";
                    if (request.getParameter("txtsearch") != null) {
                        keyword = request.getParameter("txtsearch");
                    }
                %>

                <form action="MainController" method="post">
                    <input type="text" name="txtsearch" placeholder="Customer's information"  value="<%= keyword%>">
                    <input type="hidden" name="txtsearch" value="<%= keyword%>">
                    <button type="submit" name="action" value="searchGuest">Search</button>
                </form>

                <!-- xuat ket qua search o day -->
                <%
                    ArrayList<Guest> list = (ArrayList) request.getAttribute("GUESTS");
                    if (list != null && !list.isEmpty()) {
                %>
                <table>
                    <tr><th>Guest ID</th><th>Full name</th><th>Phone</th><th>Email</th><th>Address</th><th>ID number</th><th>Date of birth</th><th>Action</th></tr>
                            <%
                                for (Guest g : list) {
                            %>
                    <tr>
                        <td> <%= g.getGuestId()%> </td>
                        <td> <%= g.getFullname()%> </td>
                        <td> <%= g.getPhone()%> </td>
                        <td> <%= g.getEmail()%> </td>
                        <td> <%= g.getAddress()%> </td>
                        <td> <%= g.getIdNumber()%> </td>
                        <td> <%= g.getDateOfBirth()%> </td>
                        <td>
                            <form action="MainController" method="post">
                                <input type="hidden" name="guestid" value="<%= g.getGuestId()%>">
                                <button type="submit" name="action" value="getBookings">edit booking</button> 
                            </form>
                        </td>
                    </tr>
                    <%}%>
                </table>
                <%} else {%>
                <p class="not-found">Not found</p>
                <%}%>
            </c:when>
            <c:otherwise >
                <jsp:forward page="home.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>

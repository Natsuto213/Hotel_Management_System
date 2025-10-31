<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <c:set var="guest" value="${sessionScope.USER}"/>
    <c:set var="isLogin" value="${sessionScope.isLogin}"/>

    <c:if test="${guest == null}">
        <jsp:forward page="home.jsp"/>
    </c:if>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guest Dashboard</title>
        <link rel="stylesheet" href="css/homeStyle.css"/>
        <link rel="stylesheet" href="css/guestDashboard.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body class="guest-dashboard">
        <header class="main-header">
            <div class="container">
                <a href="MainController?action=home" class="logo">
                    <i class="fa-solid fa-building fa-lg"></i> Grand Hotel
                </a>
                <nav class="main-nav">
                    <a href="MainController?action=findBookings" class="welcome">
                        <i class="fa-solid fa-user"></i> Xin chào, ${guest.username}!
                    </a>
                    <a href="MainController?action=logoutUser" class="nav-button-primary">
                        <i class="fa-solid fa-user-minus"></i> Đăng xuất
                    </a>
                </nav>
            </div>
        </header>

        <c:set var="bookinglist" value="${requestScope.BookingList}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}"/>
        
        
        <h1 style="margin-top: 80px; text-align: center">Guest Dashboard</h1>
        
        <a href="MainController?action=cart" class="view-cart-btn">
            <i class="fa-solid fa-cart-shopping"></i> View Cart
        </a> 

        <div class="display-table">
            <div class="booking-list""> 
                <c:choose>
                    <c:when test="${bookinglist != null && not empty bookinglist}">
                        <h1>All bookings</h1>
                        <table>
                            <tr>
                                <th>Room Number</th>
                                <th>Room Type</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            <c:forEach var="b" items="${bookinglist}">
                                <tr>
                                    <td>${b.roomNumber}</td>
                                    <td>${b.typeName}</td>
                                    <td>${b.checkInDate}</td>
                                    <td>${b.checkOutDate}</td>
                                    <td>${b.status}</td>
                                    <td>
                                        <form action="MainController" method="post">
                                            <input type="hidden" name="roomNumber" value="${b.roomNumber}">
                                            <input type="hidden" name="bookingid" value="${b.bookingId}">
                                            <button type="submit" name="action" value="findBookings" 
                                                    ${b.status eq 'Checked-out' ? 'disabled' : ''}>
                                                Choose
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                </form>
                            </c:forEach>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="not-found">Not have any booking yet</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${servicelist != null}">
                <div>
                    <h1>Add service for room number ${param.roomNumber}</h1>
                    <table>
                        <tr>
                            <th>Service</th>
                            <th>Service Type</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                        <c:forEach var="s" items="${servicelist}">
                            <tr>
                                <td>${s.servicename}</td>
                                <td>${s.servicetype}</td>
                                <td>${s.formattedPrice}</td>
                                <td>
                                    <form action="MainController" method="post">
                                        <input type="hidden" name="bookingid" value="${param.bookingid}">
                                        <input type="hidden" name="serviceid" value="${s.serviceid}" />
                                        <input                                             
                                            type="text" 
                                            name="serviceDate" 
                                            placeholder="Service Date" 
                                            onfocus="(this.type = 'date')" 
                                            onblur="if (!this.value)
                                                        this.type = 'text'"
                                            required=""
                                            >                                       
                                        <button type="submit" name="action" value="addService">Add</button>   
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </c:if>
        </div>
    </body>
</html>

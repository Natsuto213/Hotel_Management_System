
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>
    </head>
    <body>
        <c:set var="cart" value="${requestScope.CART}"/>
        <c:set var="roomNumber" value="${param.roomNumber}"/>
        <c:set var="servicelist" value="${requestScope.ServiceList}"/>

        <div class="service-list">
            <h1>Add service for room number ${param.roomNumber}</h1>
            <table>
                <tr>
                    <th>Service</th>
                    <th>Service Type</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="s" items="${servicelist}">
                    <tr>
                        <td>${s.servicename}</td>
                        <td>${s.servicetype}</td>
                    <form action="MainController" method="post">
                        <td>
                            <input type="number" name="quantity" placeholder="enter quantity" required="">
                        </td>
                        <td>${s.formattedPrice}</td>
                        <td>
                            <input type="hidden" name="bookingid" value="${param.bookingid}">
                            <input type="hidden" name="serviceid" value="${s.serviceid}" />
                            <input                                             
                                type="text" 
                                name="serviceDate" 
                                class="service-date-input"
                                placeholder="Service Date" 
                                onfocus="(this.type = 'date')" 
                                onblur="if (!this.value)
                                                this.type = 'text'"
                                required=""
                                >                                       
                            <button type="submit" name="action" value="addService">Add</button>   

                        </td>
                    </form>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <h1 style="margin-top: 100px; text-align: center">Cart for room ${param.roomNumber}</h1>

        <table>
            <tr>
                <th>Service Name</th>
                <th>Service Type</th>
                <th>Quantity</th>
                <th>Service Date</th>
                <th>Price</th>
            </tr>
            <c:forEach var="c" items="${cart}">
                <c:set var="subtotal" value="${c.price * c.quantity}" />
                <tr>
                    <td>${c.servicename}</td>
                    <td>${c.servicetype}</td>
                    <td>${c.quantity}</td>
                    <td>${c.servicedate}</td>
                    <td><fmt:formatNumber value="${c.price}" type="number" groupingUsed="true"/></td>
                </tr>
                <c:set var="total" value="${total + subtotal}" />
            </c:forEach>
        </table>

        <div class="checkout-container">
            <span style="margin-left: 20px; font-size: 18px; font-weight: bold;">
                <p>Tổng tiền dịch vụ: <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> đ</p>
            </span>
            <form action="MainController" method="post">
                <button type="submit" name="action" value="checkout" class="Check-out-btn">
                    <i class="fa-solid fa-calendar-check"></i>
                    Check Out
                </button>
            </form>
        </div>

    </body> 
</html>

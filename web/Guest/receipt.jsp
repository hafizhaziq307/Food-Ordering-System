<%-- 
    Document   : receipt
    Created on : May 27, 2020, 4:05:58 PM
    Author     : ASUS
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="com.foodordering.order.Order"%>
<%@page import="com.foodordering.order.OrderDAO"%>
<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page import="com.foodordering.victuals.Victuals"%>
<%@page import="com.foodordering.victuals.VictualsDAO"%>
<%@page import="com.foodordering.cart.Cart"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>
        <link rel="stylesheet" href="Style/dropdown.css"/>
        <style>
            table>tbody>tr:nth-child(even){
                background-color: white;

            }

            table>tbody>tr:nth-child(odd){
                background-color: #F7F7F7;

            }
            .row table tbody tr td,.row table thead tr th{
                padding: 1rem;
            }

            .row .checkoutbtn{
                background-color: #F86F38;
                color: white;
                font-size: 1.6rem;
                opacity: 0.6;
                transition: 0.3s;
                font-weight: bold;
            }

            .row .checkoutbtn:hover{
                opacity: 1;
            }

            .default-button{
                padding: 0rem 1rem;
                height: 4rem;
            }

            .logout-btn{
                color: black;
                background-color: white;
                opacity: 0.6;
                transition: .3s;
                font-size: 1.4rem;
            }

            .logout-btn:hover{
                opacity: 1;
            }



        </style>
    </head>
    <%
        VictualsDAO victualDAO = new VictualsDAO();

        int custid = (int) session.getAttribute("id");

        ProfileDAO profileDAO = new ProfileDAO();
        Profile profile = profileDAO.retrieveProfile(custid);

        OrderDAO orderDAO = new OrderDAO();
        List<Order> allOrder = orderDAO.retrieveAllOrder((int) session.getAttribute("id"));


    %>
    <body>
        <!-- Header  -->

        <div class="row" style="background-color: #2B2B2B;color: white;margin-bottom: 3rem;">
            <div class=" eight columns">
                <h4 style="margin-left: 1rem;">Welcome, <%= profile.getName()%></h4>
            </div>
            <div class=" four columns">
                <div class="nav-item">
                    <div style="display: flex; align-items: center;justify-content: flex-end;">
                        <div style="margin-right: 2rem;">
                            <button class="logout-btn" type="button" onclick="window.location.href = 'customer-logout.jsp'">logout</button>
                        </div>

                        <div style="margin-right: 2rem;text-align: right;">
                            <img src="Image/icon/cart.png" alt="cart" style="width: 4rem; height: 4rem;cursor: pointer;"
                                 onclick="window.location.href = 'OrderServlet?option=DELETEALL&txtcustid=<%= custid%>'">
                        </div>
                    </div>
                </div>


                <!-- dropdown -->
                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction()">LIST</button>

                    <div id="myDropdown" class="dropdown-content" >
                        <a href="OrderServlet?option=DELETEALL&txtcustid=<%= custid%>">CART</a>
                        <a href="customer-logout.jsp">LOGOUT</a>
                    </div>
                </div>
            </div>

        </div>

        <!-- Content -->
        <form action="OrderServlet" method="post">
            <div class="container" style="max-width: 70rem;">
                <div class="row">
                    <table class="u-full-width">
                        <thead>
                            <tr style="background-color: #F86F38;">
                                <th colspan="2">
                                    <div style="display: flex;">
                                        <div style="margin-right: 1rem;">
                                            <img src="Image/icon/back.png" onclick="window.location.href = 'OrderServlet?option=DELETEALL&txtcustid=<%= custid%>'"
                                                 style="cursor: pointer; width: 4.5rem; height: 4.5rem;" alt="back" >
                                        </div>
                                        <div><h4>Order Summary</h4></div>
                                    </div>
                                </th>
                            </tr>
                        </thead>

                        <tbody style="overflow: auto;max-height: 10rem;">

                            <tr>
                                <td colspan="2">
                                    <div class="row">
                                        <div>
                                            <label>Payment Method</label>
                                            <div>
                                                <select class="u-full-width" onchange="selectPayment(this)" required>
                                                    <option value="">Select Payment</option>
                                                    <option id="online-choice" value="online">Online</option>
                                                    <option value="cash">Cash</option>
                                                </select>

                                                <!-- payment image -->
                                                <input id="img-pay" name="txtpayment" type="file" disabled>

                                            </div>
                                        </div>
                                    </div>
                                </td>

                            </tr>
                            <!-- start error -->
                            <tr>
                                <td colspan="2"><%= allOrder.size()%> items in cart</td>
                            </tr>                    

                            <%
                                double total = 0.0;
                                for (int i = 0; i < allOrder.size(); i++) {
                                    Victuals item = victualDAO.retrieveVictuals(allOrder.get(i).getCode());
                            %>
                            <tr>
                                <td>
                                    <div style="display: flex;">
                                        <div style="margin-right:.4rem;"><img src="Image/menu/<%= item.getImage()%>" alt="img" style="width: 8rem;height: 8rem;"></div>
                                        <div>
                                            <div><%= item.getName()%></div>        
                                            <div>Qty <%= allOrder.get(i).getQty()%></div>
                                            <input type="hidden" name="txtorderid" value="<%= allOrder.get(i).getOrderid()%>">
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div style="display:flex;flex-wrap: wrap;justify-content: center;">
                                        <fmt:formatNumber var="totals" type="number" minFractionDigits="2" value="<%= item.getPrice() * allOrder.get(i).getQty()%>"/>
                                        <input type="hidden" name="txttotalprice" value="${totals}">
                                        <div>RM&nbsp;</div>
                                        <div>${totals}</div>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    total += item.getPrice() * allOrder.get(i).getQty();
                                }
                            %>

                            <tr>
                                <td>Cart Subotal</td>
                                <td>
                                    <div style="display:flex;flex-wrap: wrap;justify-content: center;">
                                        <fmt:formatNumber var="subtotal" type="number" minFractionDigits="2" value="<%= total%>"/>
                                        <div>RM&nbsp;</div>
                                        <div>${subtotal}</div>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>Delivery</td>
                                <td>
                                    <div style="display:flex;flex-wrap: wrap;justify-content: center;">
                                        <fmt:formatNumber var="deliverycost" type="number" minFractionDigits="2" value="5.00"/>
                                        <div>RM&nbsp;</div>
                                        <div>${deliverycost}</div>
                                    </div>
                                </td>
                            </tr>

                            <tr style="font-weight: bold;">
                                <td>Order Total</td>
                                <td>
                                    <div style="display:flex;flex-wrap: wrap;justify-content: center;">
                                        <fmt:formatNumber var="ordertotal" type="number" minFractionDigits="2" value="${subtotal + deliverycost}"/>
                                        <div>RM&nbsp;</div>
                                        <div>${ordertotal}</div>

                                        <!-- date today -->
                                        <input type="hidden" name="txtdate" value="<%= java.time.LocalDate.now()%>">

                                        <input type="hidden" name="txtcustid" value="<%= session.getAttribute("id")%>">

                                        <input type="hidden" name="txtaddress" value="empty">


                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <button class="u-full-width checkoutbtn" name="option" value="UPDATE" type="submit" style="max-width: 40rem;">Checkout</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>

        <script>
            // Get the modal
            var modal = document.getElementById("myModal");

            // Get the button that opens the modal
            var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
            btn.onfocus = function () {
                modal.style.display = "block";
            }

// When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
                newAddress();
            }

// When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target === modal) {
                    modal.style.display = "none";

                    newAddress();
                }
            }

            function selectPayment(selectElement) {

                var imgbtn = document.getElementById("img-pay");

                if (selectElement.value === "online") {
                    imgbtn.disabled = false;
                    imgbtn.required = true;

                } else {
                    imgbtn.disabled = true;
                    imgbtn.required = false;

                }
            }

            function newAddress() {
                var address = document.getElementById("address").value;
                var city = document.getElementById("city").value;
                var state = document.getElementById("state").value;
                var zipcode = document.getElementById("zipcode").value;

                btn.value = address + " " + zipcode + " " + city + " " + state;

            }



            function defaultAddress(address) {
                var btn = document.getElementById("myBtn");

                btn.value = address;
            }
            
            //dropdown
            function myFunction() {
                document.getElementById("myDropdown").classList.toggle("show");
            }

            window.onclick = function (event) {
                if (!event.target.matches('.dropbtn')) {
                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    var i;
                    for (i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            }

        </script>

    </body>
</html>

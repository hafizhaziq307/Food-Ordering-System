<%-- 
    Document   : cart
    Created on : May 5, 2020, 2:48:13 AM
    Author     : ASUS
--%>

<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page import="com.foodordering.victuals.Victuals"%>
<%@page import="com.foodordering.victuals.VictualsDAO"%>
<%@page import="com.foodordering.cart.Cart"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Food Ordering System</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>
        <link rel="stylesheet" href="Style/dropdown.css"/>
        <style>

            /*default styling*/
            .row .qtybtn,input[type=number]{
                padding: 0 .5rem;
                height: 2.5rem;
                line-height: 1rem;
                border-radius: 0;

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

            .food-img{
                max-width: 10rem;
                max-height: 10rem;
            }

            table tbody .item-list:nth-child(even){
                background-color: white;

            }

            table tbody .item-list:nth-child(odd){
                background-color: #F7F7F7;

            }
            input[type=number]::-webkit-inner-spin-button, 
            input[type=number]::-webkit-outer-spin-button { 
                -webkit-appearance: none; 
                margin: 0; 
            }

            /* Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }

            .row div table thead tr th{
                padding: 1rem;
            }

            .row div table tbody tr td{
                padding: 1rem;
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
        if (request.getAttribute("msg") != null) {
            String message = (String) request.getAttribute("msg");
            out.println("<script>");
            out.println("alert('" + message + "')");
            out.println("</script>");
        }
        int custid = (int) session.getAttribute("id");

        ProfileDAO profileDAO = new ProfileDAO();
        Profile profile = profileDAO.retrieveProfile(custid);

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
                                 onclick="window.location.href = 'CartServlet?option=LIST&txtcustid=<%= custid%>'">
                        </div>
                    </div>
                </div>


                <!-- dropdown -->
                <div class="dropdown">
                    <button class="dropbtn" onclick="myFunction()">LIST</button>

                    <div id="myDropdown" class="dropdown-content" >
                        <a href="CartServlet?option=LIST&txtcustid=<%= custid%>">CART</a>
                        <a href="customer-logout.jsp">LOGOUT</a>
                    </div>
                </div>
            </div>

        </div>


        <!-- Content -->
        <div class="container u-max-full-width" style="padding:1rem;">

            <form action="OrderServlet" method="post">
                <div class="row">
                    <div class="eight columns" style="margin-bottom: 1rem;" >

                        <table class="u-full-width">
                            <thead>
                                <tr style="background-color: #F86F38;">
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Sub Total</th>
                                    <th></th>
                                </tr>
                            </thead>


                            <tbody>

                                <%                                    List<Cart> allCart = (List<Cart>) request.getAttribute("theCart");

                                    VictualsDAO victualDAO = new VictualsDAO();

                                    double total = 0.0;

                                    for (int i = 0; i < allCart.size(); i++) {
                                        Victuals item = victualDAO.retrieveVictuals(allCart.get(i).getCode());


                                %>
                                <tr class="item-list">
                                    <td><img class="food-img" src="Image/menu/<%= item.getImage()%>" alt="img"></td>
                                    <td>
                                        <div>
                                            <%= item.getName()%>
                                            <input type="hidden" name="txtcode" value="<%= allCart.get(i).getCode()%>">
                                            <input type="hidden" name="txtqty" value="<%= allCart.get(i).getQty()%>">
                                        </div>

                                        <div>
                                            <fmt:formatNumber var="price" type="number" minFractionDigits="2" value="<%= item.getPrice()%>"/>
                                            <div style="display:flex;">
                                                <div>RM&nbsp;</div>
                                                <div><label>${price}</label></div>
                                            </div>
                                        </div>

                                        <div style="display:flex;">
                                            <button type="button" class="qtybtn" onclick="window.location.href = 'CartServlet?option=UPDATE&txtcartid=<%= allCart.get(i).getCartId()%>&txtqty=<%= (allCart.get(i).getQty() > 1) ? allCart.get(i).getQty() - 1 : allCart.get(i).getQty()%>&txtcustid=<%= session.getAttribute("id")%>'">&minus;</button>
                                            <input type="number" class="qty" max="10" min="0" style="text-align:center;" size="1" value="<%= allCart.get(i).getQty()%>" readonly>
                                            <button type="button" class="qtybtn" onclick="window.location.href = 'CartServlet?option=UPDATE&txtcartid=<%= allCart.get(i).getCartId()%>&txtqty=<%= allCart.get(i).getQty() + 1%>&txtcustid=<%= session.getAttribute("id")%>'">&plus;</button>
                                        </div>
                                    </td>

                                    <td>
                                        <fmt:formatNumber var="stotal" type="number" minFractionDigits="2" value="<%= item.getPrice() * allCart.get(i).getQty()%>"/>
                                        <div style="display:flex;">
                                            <div>RM&nbsp;</div>
                                            <div><label>${stotal}</label></div>
                                        </div>
                                    </td>
                                    <td><a href="CartServlet?option=DELETE&txtcartid=<%= allCart.get(i).getCartId()%>&txtcustid=<%= session.getAttribute("id")%>"><img src="Image/icon/bin.png" style="width: 3rem; height: 3rem;" alt="del"></a></td>
                                </tr>
                                <%
                                        total = total + (item.getPrice() * allCart.get(i).getQty());
                                    }

                                %>

                                <tr style="background-color: #F86F38;">
                                    <td colspan="2" style="text-align: center;"><a style="color: black;" href="CartServlet?option=DELETEALL&txtcustid=<%= session.getAttribute("id")%>">Delete All </a></td>
                                    <td colspan="2" style="text-align: center;"><a style="color: black;" href="VictualsServlet?option=LISTCUST">Continue Shopping</a></td>
                                </tr>

                            </tbody>

                        </table>

                    </div>


                    <div class="four columns" style="padding: 1rem;background-color: #2B2B2B;color: white;">
                        <div style="display:flex;flex-wrap: wrap;justify-content: center;">
                            <fmt:formatNumber var="gtotal" type="number" minFractionDigits="2" value="<%= total%>"/>
                            <div><h4>TOTAL:&nbsp;</h4></div>
                            <div><h4>RM&nbsp;</h4></div>
                            <div><h4>${gtotal}</h4></div>

                        </div>

                        <%
                            if (profile.getEmail().equals("Guest@gmail.com")) {
                        %>
                        <input type="hidden" name="txtuser" value="Guest">
                        <input type="hidden" name="txttableno" value="<%= profile.getPassword().substring(2, 3)%>">
                        <%
                        } else {
                        %>
                        <input type="hidden" name="txtuser" value="Customer">
                        <input type="hidden" name="txttableno" value="0">
                        <c:set var="deliverycost" value="5.00"/>
                        <input type="hidden" name="txttotalprice" value="${gtotal + deliverycost}">


                        <%
                            }
                        %>
                        <input type="hidden" name="txtcustid" value="<%= session.getAttribute("id")%>">


                        <button class="u-full-width checkoutbtn" name="option" value="ADD" type="submit">PAY</button>
                    </div>

                </div>
            </form>

        </div>

        <script>
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

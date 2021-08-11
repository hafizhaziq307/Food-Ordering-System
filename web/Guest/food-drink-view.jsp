<%-- 
    Document   : food-drink-view
    Created on : May 5, 2020, 1:30:17 AM
    Author     : ASUS
--%>

<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.foodordering.victuals.Victuals"%>
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
            .addtocartbtn{
                position: fixed;
                left: 0;
                bottom: 0;
                width: 100%;
                background-color: red;
                border: none;
                margin: 0 auto;
                color: white;
                font-size: 1.6rem;
                opacity: 0.6;
                transition: 0.3s;
                font-weight: bold;

            }

            .addtocartbtn:hover {
                color:white;
                opacity: 1;
            }

            .row{
                background-color: #333;
            }


            .row>div{
                color: white;
            }

            .victuals-items{
                width:17rem;
                height: 15rem;
                text-align: center;
                padding: 1rem;
                margin: .5rem;
                background-color: #2B2B2B;
            }

            :checked + label{
                border: 4px solid #F86F38;
                width: 10rem;
                height: 10rem;
                margin: auto;

            }

            label,img{
                width: 10rem;
                height: 10rem;
            }

            .item-container{
                display: flex;
                flex-wrap: wrap;
                padding: 1rem;
                justify-content: center;
            }

            .item-title{
                padding:10px;
                background-color: #F86F38;
                color:white;
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
        List<Victuals> allVictuals = (List<Victuals>) request.getAttribute("theVictuals");

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
        <div class="container u-full-width">

            <form action="CartServlet" method="post">
                <div class="row " >

                    <!-- Rice Container -->
                    <h4  class="item-title">Rice</h4>
                    <div id="rice-container" class="item-container">
                        <%                            for (int i = 0; i < allVictuals.size(); i++) {
                                if (allVictuals.get(i).getName().contains("Nasi")) {
                        %>
                        <div class="victuals-items">

                            <div>
                                <input  type="checkbox" id="<%= allVictuals.get(i).getCode()%>" 
                                        value ="<%= allVictuals.get(i).getCode()%>"  name="txtcode" style="display:none;">

                                <label for="<%= allVictuals.get(i).getCode()%>" style="margin: auto;">
                                    <div style="text-align: center;">
                                        <img src="Image/menu/<%= allVictuals.get(i).getImage()%>" alt="img" >
                                    </div>
                                </label>
                            </div>

                            <div>
                                <%= allVictuals.get(i).getName()%>
                            </div>

                            <div>
                                RM <fmt:formatNumber type="number" minFractionDigits="2" value="<%= allVictuals.get(i).getPrice()%>"/>
                            </div>
                        </div>

                        <%
                                }
                            }
                        %>

                    </div>
                </div>


                <!-- Mee Container -->
                <div class="row">
                    <h4 class="item-title">Mee</h4>
                    <div class="item-container">
                        <%                            for (int i = 0; i < allVictuals.size(); i++) {
                                if (allVictuals.get(i).getName().contains("Mee")) {
                        %>
                        <div class="victuals-items">

                            <div>
                                <input  type="checkbox" id="<%= allVictuals.get(i).getCode()%>" 
                                        value ="<%= allVictuals.get(i).getCode()%>"  name="txtcode" style="display:none;">

                                <label for="<%= allVictuals.get(i).getCode()%>" style="margin: auto;">
                                    <div style="text-align: center;">
                                        <img src="Image/menu/<%= allVictuals.get(i).getImage()%>" alt="img" >
                                    </div>
                                </label>
                            </div>

                            <div>
                                <%= allVictuals.get(i).getName()%>
                            </div>

                            <div>
                                RM <fmt:formatNumber type="number" minFractionDigits="2" value="<%= allVictuals.get(i).getPrice()%>"/>
                            </div>
                        </div>

                        <%
                                }
                            }
                        %>
                    </div>
                </div>

                <!-- Beverage Container -->
                <div class="row">
                    <h4 class="item-title">Beverage</h4>
                    <div class="item-container">
                        <%
                            for (int i = 0; i < allVictuals.size(); i++) {
                                if (allVictuals.get(i).getType().equals("drink") || allVictuals.get(i).getType().equals("Drink")) {
                        %>
                        <div class="victuals-items">

                            <div>
                                <input  type="checkbox" id="<%= allVictuals.get(i).getCode()%>" 
                                        value ="<%= allVictuals.get(i).getCode()%>"  name="txtcode" style="display:none;">

                                <label for="<%= allVictuals.get(i).getCode()%>" style="margin: auto;">
                                    <div style="text-align: center;">
                                        <img src="Image/menu/<%= allVictuals.get(i).getImage()%>" alt="img" >
                                    </div>
                                </label>
                            </div>

                            <div>
                                <%= allVictuals.get(i).getName()%>
                            </div>

                            <div>
                                RM <fmt:formatNumber type="number" minFractionDigits="2" value="<%= allVictuals.get(i).getPrice()%>"/>
                            </div>
                        </div>

                        <%
                                }
                            }
                        %>

                    </div>
                </div>

                <div class="row">
                    <input type="hidden" name="txtcustid" value="<%= custid%>">
                    <input type="hidden" name="option" value="ADD">
                    <button class="addtocartbtn" type="submit">Add to Cart</button>
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

<%-- 
    Document   : food-update-form
    Created on : Apr 27, 2020, 5:08:57 PM
    Author     : ASUS
--%>

<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page import="com.foodordering.victuals.Victuals"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Food Ordering System</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>

        <style>
            .container{
                background-color: #2B2B2B;
                color: white;
                padding: 3rem;
                max-width:70rem;
                border: 2px solid white;
                border-radius: 10rem 10rem 1rem 1rem;
            }

            input[type=text]{
                color: black;
            }

            div .btn {
                background-color: #F86F38;
                color: white;
                font-size: 1.6rem;
                opacity: 0.6;
                transition: 0.3s;
            }

            div .btn:hover {
                opacity: 1;
                color: white;
            }
            
            .container button{
                outline: none;
                border: none;
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
        Victuals theVictual = (Victuals) request.getAttribute("theVictual");
    %>
    <%
        int custid = (int) session.getAttribute("id");

        ProfileDAO profileDAO = new ProfileDAO();
        Profile profile = profileDAO.retrieveProfile(custid);

    %>
    <body>
        <div class="row" style="background-color: #2B2B2B;color: white;margin-bottom: 3rem;">
            <div class="welcometext nine columns">
                <h4>Welcome, <%= profile.getName()%></h4>
            </div>
            <div class="welcometext three columns">
                <button class="logout-btn" type="button" onclick="window.location.href = 'customer-logout.jsp'">logout</button>
            </div>
        </div>
        <div class="container">
            <form action="VictualsServlet">
                <div class="row" style="text-align:center;">
                    <%
                        if (theVictual.getType().equals("food")) {
                    %>
                    <h2>Update Food</h2>
                    <%
                    } else {
                    %>
                    <h2>Update Drink</h2>
                    <%
                        }
                    %>
                </div>
                <div class="row">
                    <div class="three columns">
                        Image:
                    </div>

                    <div class=" nine columns">
                        <div>
                            <img src="Image/menu/<%= theVictual.getImage()%>" alt="" id="drink-image" style="width: 15rem; height: 12rem;">
                        </div>

                        <div>
                            <input type="file" name="txtimage"  id="imagebtn">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <%
                        if (theVictual.getType().equals("food")) {
                    %>
                    <div class="three columns">
                        Food Name:
                    </div>
                    <%
                    } else {
                    %>
                    <div class="three columns">
                        Drink Name:
                    </div>
                    <%
                        }
                    %>

                    <div class=" nine columns">
                        <input type="text" value="<%= theVictual.getName()%>" name="txtname" class="u-full-width">
                    </div>
                </div>

                <div class="row">
                    <div class="three columns">
                        Price(RM):
                    </div>

                    <div class=" nine columns">
                        <input type="text" value="<%= theVictual.getPrice()%>" size="4" name="txtprice">
                    </div>
                </div>

                <div class="row" style="text-align: center;">
                    <input type="hidden" value="<%= theVictual.getType()%>" name="txttype">
                    <input type="hidden" value="<%= theVictual.getCode()%>" name="txtcode">
                    <input type="hidden" name="option" value="UPDATE">
                    <button class="btn" type="submit">UPDATE</button>
                    <button class="btn" type="button" onclick="window.history.back();"> BACK</button>
                </div> 
            </form>
        </div>

        <script>
            var imagebtn = document.getElementById("imagebtn");
            var drinkimage = document.getElementById("drink-image");

            imagebtn.addEventListener("change", function () {
                drinkimage.src = "Image/menu/" + imagebtn.value.replace(/^.*[\\\/]/, '');

            });
        </script>

    </body>
</html>
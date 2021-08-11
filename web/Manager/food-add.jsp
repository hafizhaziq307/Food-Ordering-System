<%-- 
    Document   : food-add-form
    Created on : Apr 27, 2020, 1:52:31 PM
    Author     : ASUS
--%>

<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Food Ordering System</title>

        <link rel="stylesheet" href="../Style/normalize.css"/>
        <link rel="stylesheet" href="../Style/theme.css"/>
        <link rel="stylesheet" href="../Style/skeleton.css"/>
        <style>
            body{
                color: white;
            }

            .container{
                background-color: #2B2B2B;
                color: white;
                padding: 3rem;
                max-width:70rem;
                border: 2px solid white;
                border-radius: 10rem 1rem;
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
            .container button{
                outline: none;
                border: none;
            }


        </style>
    </head>
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
                <button class="logout-btn" type="button" onclick="window.location.href = '../customer-logout.jsp'">logout</button>
            </div>
        </div>
        <div class="container">
            <form action="../VictualsServlet">
                <div class="row" style="text-align:center;">
                    <h2>Add New Food</h2>
                </div>
                <div class="row">
                    <div class="three columns">
                        Image:
                    </div>

                    <div class=" nine columns">
                        <div>
                            <img src="../Image/icon/no-image.png" alt="" id="food-image" style="width: 15rem; height: 12rem;">
                        </div>

                        <div>
                            <input type="file" name="txtimage"  id="imagebtn">
                        </div>


                    </div>
                </div>

                <div class="row">

                    <div class="three columns">
                        Drink Name:
                    </div>

                    <div class=" nine columns">
                        <input type="text"  name="txtname" class=" u-full-width">

                    </div>
                </div>

                <div class="row">
                    <div class="three columns">
                        Price(RM):
                    </div>

                    <div class=" nine columns">
                        <input type="text" size="4" name="txtprice">
                    </div>
                </div>

                <div class="row" style="text-align: center;">
                    <input type="hidden" value="food" name="txttype">
                    <input type="hidden" name="option" value="ADD">
                    <button class="btn" type="submit">ADD</button>
                    <button class="btn" type="button" onclick="window.history.back();"> BACK</button>
                </div> 
            </form>
        </div>

        <script>
            var imagebtn = document.getElementById("imagebtn");
            var foodimage = document.getElementById("food-image");

            imagebtn.addEventListener("change", function () {
                foodimage.src = "../Image/menu/" + imagebtn.value.replace(/^.*[\\\/]/, '');

            });

        </script>

    </body>
</html>

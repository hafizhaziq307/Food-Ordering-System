<%-- 
    Document   : header.jsp
    Created on : May 22, 2020, 10:07:37 PM
    Author     : ASUS
--%>

<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>

        <style>
            .nav-container{
                display: flex;
                background-color: #2B2B2B;
                height: 6rem;
                padding-top:  1.5rem;
                margin-bottom: 5rem;
            }

            .nav-item a{
                background-color: #333;
                margin: 0rem 1rem;
                text-align: center;
                padding: 2rem 4rem;
                line-height: 4rem;
                border: 1px solid white;
                text-decoration: none;
                color: white;
            }

            .nav-item a:hover{
                background-color: white;
                color: black;
                transition: 0.3s;

            }

            .dropdown button{
                background-color: #333;
                margin: 0rem 1rem;
                text-align: center;
                padding: 1rem 2.5rem;
                line-height: 3rem;
                border: 1px solid white;
                text-decoration: none;
                color: white;
            }



            /*Drop down css*/

            .dropbtn{
                border-radius: 0;
            }

            .dropbtn:hover, .dropbtn:focus {
                background-color: white;
                color: #333;
                transition: 0.3s;

            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f1f1f1;
                min-width: 160px;
                overflow: auto;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown a:hover {
                background-color: #ddd;
            }

            .show {
                display: block;
            }

            @media screen and (max-width: 2000px) {
                .nav-item{
                    display: block;
                }

                .dropdown{
                    display: none;
                }

            }

            @media screen and (max-width: 700px) {
                .nav-item{
                    display: none;
                }

                .dropdown{
                    display: block;
                }

            }



        </style>

    </head>

    <body>
        <div class="row nav-container">
            <div class="nav-item">
                <a href="mainpage.jsp">HOMEPAGE</a>
            </div>
            <div class="nav-item">
                <a href="customer-login.jsp">LOGIN</a>
            </div>
            <div class="nav-item">
                <a href="guest-login.jsp">GUEST</a>
            </div>
            <div class="nav-item">
                <a href="customer-register.jsp">REGISTER</a>
            </div>

            <div class="dropdown">
                <button class="dropbtn" onclick="myFunction()">LIST</button>

                <div id="myDropdown" class="dropdown-content" >
                    <a href="mainpage.jsp">HOMEPAGE</a>
                    <a href="customer-login.jsp">LOGIN</a>
                    <a href="guest-login.jsp">GUEST</a>
                    <a href="customer-register.jsp">REGISTER</a>
                </div>
            </div>
        </div>

    <script>
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

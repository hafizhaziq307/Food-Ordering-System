<%-- 
    Document   : mainpage
    Created on : May 4, 2020, 10:09:28 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Food Ordering System</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/background.css"/>
        <style>
            .content{
                margin: auto;
                padding: 2rem;
                color: white;
                max-width: 80rem;
            }

            img {
                border-radius: 100rem;
                width: 100%;
                height: auto;
            }

            .content div div{
                text-align: center;
                margin: auto;
            }

            .content div a{
                background-color: #F86F38;
                border: none;
                color: white;
                font-size: 1.5rem;
                font-weight: bold;
                opacity: 0.6;
                transition: 0.3s;
                border-radius: 0;
                text-decoration: none;
                padding: 20px 20px;
                display: block;
            }
            .content div a:hover {
                opacity: 1;
            }

            /* Larger than desktop */
            @media (min-width: 1000px) {
                img{
                    width: 90%;
                }
            }

        </style>
    </head>
    <body>
        <%@include  file="header.jsp" %>

        <div class="container">

            <div class="row content">

                <div class="seven columns">
                    <img src="Image/main.png" alt="">
                </div>

                <div class="five columns" style="padding: 1rem;">
                    <div><h2>Welcome to ExStudent Restaurant</h2></div>
                    <div style="padding-bottom:.5rem;"><a class="u-full-width" style="margin: auto;" href="guest-login.jsp">EAT</a></div>
                    <div style="padding-top:.5rem;"><a class="u-full-width" style="margin: auto;" href="customer-login.jsp">DELIVERY</a></div>
                </div>

            </div>

        </div>

    </body>
</html>

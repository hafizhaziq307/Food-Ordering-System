<%-- 
    Document   : counterPayment
    Created on : May 29, 2020, 8:53:39 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>
        <link rel="stylesheet" href="../Style/normalize.css"/>
        <link rel="stylesheet" href="../Style/theme.css"/>
        <link rel="stylesheet" href="../Style/skeleton.css"/>

        <style>
            body{
                color: white;
                padding-top: 10rem;
            }

            .container .row div{
                text-align: center;
                max-width: 50rem;
                margin: auto;
                border: 1px solid black;
                background-color: #333333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row" >
                <div>
                    <h2>Thank You <br> Please Come Again</h2>
                    <img src="Image/icon/face.png" alt="smile face">
                    <h5>You will be logout in <span id="countdown" style="color: #F86F38;">10</span> seconds</h5>

                </div>
            </div>
        </div>

        <script>
            var timeleft = 9;
            var downloadTimer = setInterval(function () {
                if (timeleft <= 0) {
                    clearInterval(downloadTimer);
                    window.location.replace("customer-logout.jsp");

                }
                document.getElementById("countdown").innerHTML = "&nbsp;" + timeleft + "&nbsp;";
                timeleft -= 1;
            }, 1000);

        </script>

    </body>
</html>

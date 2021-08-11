<%-- 
    Document   : customer-login
    Created on : May 4, 2020, 11:17:14 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="Style/background.css"/>

        <style>

            .container{
                max-width: 40rem;
                margin: auto;
                padding: 2rem;
                background-color: #2B2B2B;
                color: white;
            }

            .container .row{
                padding: 2rem 3rem;
            }

            .container .row input {
                border: none;
                border-bottom: 3px solid black;
                padding: 14px 0px;
                font-size: 16px;
                transition: 0.5s;
                color: white;
                outline: none;
                background-color: inherit;
                border-radius: 0px;
            } 

            .container .row input:focus {
                border: none;
                border-bottom: 3px solid white;

            }

            ::placeholder {
                color: white;
            }

            .row button {
                background-color: #F86F38;
                color: white;
                font-size: 1.6rem;
                opacity: 0.6;
                transition: 0.3s;
                max-width: 30rem;
                outline: none;
                border: none;
                
            }

            .row button:hover {
                color: white;
                opacity: 1;
            }

        </style>
    </head>
    <body style="margin:0">
        <%
            if (request.getAttribute("msg") != null) {
                String message = (String) request.getAttribute("msg");
                out.println("<script>");
                out.println("alert('" + message + "')");
                out.println("</script>");
            }
        %>
        
        <%@include  file="header.jsp" %>
        
        <form action="profileServlet" method="post">
            <div class="container" style="max-width: 50rem;">
                <div class="row" style="text-align:center;">
                    <h4><strong>Log in to your Account</strong></h4>
                </div>

                <div class="row">
                    <input class="u-full-width" type="email" placeholder="Email Address" name="txtemail">
                </div>

                <div class="row">
                    <input class="u-full-width" type="password" placeholder="Password" name="txtpassword">
                </div>

                <div class="row" style="text-align: center;"> 
                    <input type="hidden" name="txtuser" value="Customer">
                    <input type="hidden" name="option" value="CHECK"> 
                    <button class="u-full-width" type="submit">Sign In</button>
                </div>

                <div class="row" style="text-align:center;">
                    Don't have Account? <a href="customer-register.jsp" style="color: #F86F38;">Sign up</a>
                </div>

            </div>
        </form>

    </body>
</html>

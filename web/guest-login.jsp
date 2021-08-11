<%-- 
    Document   : guestlogin
    Created on : May 4, 2020, 10:56:58 AM
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
            ::placeholder {
                color: gray;
            }

            .content-container{
                max-width: 50rem;
                margin: auto;
                padding: 2rem;
                color: white;
            }

            .content-container div input {
                font-size: 1.5rem;
                text-align: center;
                font-weight: bold;
                border: .3rem solid #ccc;
                transition: 0.5s;
                outline: none;
                color: black;
                border-radius: 0;
                padding: 2.2rem 0;
            }

            .content-container div input:focus {
                border: .3rem solid #555;
            }

            div button {
                background-color: #F86F38;
                border: none;
                color: white;
                font-size: 1.5rem;
                opacity: 0.6;
                transition: 0.3s;
                border-radius: 0;
            }

            div button:hover {
                opacity: 1;
                color: white;
            }

        </style>
    </head>
    <body>
        <%@include  file="header.jsp" %>
        
        <form action="profileServlet" method="post">
            <div class="container">

                <div class="row content-container">

                    <div class="eight columns">
                        <input class="u-full-width" type="text" maxlength="10" placeholder="Customer ID" name="txtpassword" required>
                        <input type="hidden" name="txtemail" value="Guest@gmail.com">
                    </div>

                    <div class="four columns">
                        <input type="hidden" name="txtuser" value="Guest">
                        <input type="hidden" name="option" value="CHECK">
                        <button type="submit" class="u-full-width">Next</button>
                    </div>

                </div>

            </div>
        </form>

    </body>
</html>

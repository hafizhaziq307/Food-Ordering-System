<%-- 
    Document   : register
    Created on : May 4, 2020, 1:16:23 PM
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
            .container{
                padding: 2rem;
                background-color: #2B2B2B;
                color: white;
                border-radius: 100px 10px;
            }
            .container input{
                color: black;
            }

            .container .form-item{
                padding: 1rem 2rem;
            }

            ::placeholder {
                color: white;
            }

            .signupbtn {
                background-color: #F86F38;
                border: none;
                color: white;
                font-size: 1.5rem;
                opacity: 0.6;
                transition: 0.3s;
                max-width: 30rem;
            }

            .signupbtn:hover {
                opacity: 1;
                color: white;
            }

            /*---------------------------------modal-------------------------------------*/

            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
                color: black;
            }

            /* Modal Content/Box */
            .modal-content {
                background-color: #fefefe;
                margin: 15% auto; /* 15% from the top and centered */
                padding: 2rem;
                border: 1px solid #888;
                max-width: 70rem; /* Could be more or less, depending on screen size */
            }

            /* The Close Button */
            .modal-content .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .modal-content .close:hover,
            .modal-content .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

        </style>
    </head>
    <body>
        <%@include  file="header.jsp" %>

        <div class="container" style="max-width:80rem;">

            <form action="profileServlet">

                <div class="row">
                    <h4 style="text-align:center;font-weight: bold;">Personal Info</h4>
                </div>

                <div class="row">
                    <div class="one-half column">
                        <div class="form-item">
                            <label>Name:</label>
                            <input class="u-full-width " type="text" name="txtname">
                        </div>

                        <div class="form-item">
                            <label>Email:</label>
                            <input class="u-full-width" type="text" name="txtemail">
                        </div>

                        <div class="form-item">
                            <label>Password:</label>
                            <input class="u-full-width" type="password" name="txtpassword">
                        </div>

                    </div>

                    <div class="one-half column">
                        
                        <div class="form-item">
                            <label>Phone Number:</label>
                            <input class="u-full-width" type="text" name="txtphoneno">
                        </div>

                        <div class="form-item">
                            <label>Address:</label>
                            <textarea name="txtaddress" class="u-full-width" id="myBtn" cols="30" rows="10" style="height: 14rem;resize: none;color: black;cursor: pointer;"></textarea>
                        </div>

                        <!-- The Modal -->
                        <div id="myModal" class="modal">

                            <!-- Modal content -->
                            <div class="modal-content u-full-width">
                                <span class="close">&times;</span>
                                <div class="row">
                                    <div class="six columns">
                                        <div>
                                            <label>Address</label>
                                            <input type="text" id="address" class="u-full-width">
                                        </div>
                                        <div>
                                            <label>Zipcode</label>
                                            <input type="text" id="zipcode">
                                        </div>

                                    </div>

                                    <div class="five columns">
                                        <div>
                                            <label>City</label>
                                            <input type="text" id="city">
                                        </div>
                                        <div>
                                            <label>State</label>
                                            <input type="text" id="state">
                                        </div>


                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

                <div class="row" style="text-align: center;">
                    <input type="hidden" name="option" value="ADD">
                    <button  class="signupbtn u-full-width" type="submit">Sign Up</button>
                </div>
            </form>

        </div>

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

            function newAddress() {
                var address = document.getElementById("address").value;
                var city = document.getElementById("city").value;
                var state = document.getElementById("state").value;
                var zipcode = document.getElementById("zipcode").value;

                btn.value = address + " " + zipcode + " " + city + " " + state;

            }
        </script>








    </body>
</html>

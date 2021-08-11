<%-- 
    Document   : view
    Created on : May 4, 2020, 3:01:36 PM
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Food Ordering System</title>
        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>

        <style>
            body{
                color: white;
            }
            .category-container, .delete-container, .update-container, .add-container {
                padding: 1rem;
                background-color: #2B2B2B;
                border: 1px solid white;
                margin-bottom: 1rem;
            }

            .delete-container form button{
                background-color: #EC4C47;
                color: white;
                font-size: 1.6rem;
                opacity: 0.6;
                transition: 0.3s;
            }
            .delete-container form button:hover{
                opacity: 1;
            }

            .update-container form button{
                background-color: #2098D1;
                color: white;
                font-size: 1.6rem;
                opacity: 0.6;
                transition: 0.3s;
            }
            .update-container form button:hover{
                opacity: 1;
            }

            .victuals-list-items{
                display:flex;
                flex-wrap: wrap;
                justify-content: center;
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

            .add-container button{
                color: white;
                transition: 0.3s;
                opacity: 0.6;
                font-size: 1.3rem;
            }

            .add-container button:hover{
                opacity: 1;
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
        if (request.getAttribute("msg") != null) {
            String message = (String) request.getAttribute("msg");
            out.println("<script>");
            out.println("alert('" + message + "')");
            out.println("</script>");
        }

        List<Victuals> allVictuals = (List<Victuals>) request.getAttribute("theVictuals");
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


        <div class="container u-full-width">

            <div class="three columns">
                <div class="category-container">
                    <h5>Categories</h5>
                    <ul>
                        <li><a href="VictualsServlet?option=LIST">All Product</a></li>
                        <li><a href="VictualsServlet?option=RICE-SORT">Rice</a></li>
                        <li><a href="VictualsServlet?option=MEE-SORT">Mee</a></li>
                        <li><a href="VictualsServlet?option=BEVERAGE-SORT">Beverage</a></li>
                    </ul>
                </div>  
                <div class="add-container">
                    <button style="background-color: #9146AB" class="u-full-width" onclick="window.location.href = 'Manager/food-add.jsp'">ADD FOOD</button>
                    <button style="background-color: #F59C10" class="u-full-width" onclick="window.location.href = 'Manager/drink-add.jsp'">ADD DRINK</button>
                    <button style="background-color: #2ECD71" class="u-full-width" onclick="window.location.href = 'paymentServlet?option=LIST'">CHART</button>
                </div>

                <div class="update-container">
                    <form action="VictualsServlet">
                        <input type="text" id="update" class="u-full-width" style="color:black;" readonly>
                        <input type="hidden" id="idupdate" name="txtcode">
                        <input type="hidden" name="option" value="LOAD">
                        <button type="submit" class="u-full-width">UPDATE</button>
                    </form>
                </div>

                <div class="delete-container">
                    <form action="VictualsServlet">
                        <input type="text" id="delete" class="u-full-width" style="color:black;" readonly>
                        <input type="hidden" id="iddelete" name="txtcode">
                        <input type="hidden" name="option" value="DELETE">
                        <button type="submit" class="u-full-width">DELETE</button>
                    </form>
                </div>
            </div>

            <div class="nine columns" style="background-color:#333;">

                <%
                    if (request.getAttribute("categoryName") != null) {
                        out.println("<h4 style='padding:1rem;background-color: #F86F38;'>" + request.getAttribute("categoryName") + "</h4>");
                    }
                %>

                <div class="victuals-list-items">
                    <%
                        for (int i = 0; i < allVictuals.size(); i++) {
                    %>
                    <div class="victuals-items">

                        <div>
                            <input  type="radio" id="<%= allVictuals.get(i).getCode()%>" 
                                    onclick="check(this.value,<%= allVictuals.get(i).getCode()%>)" 
                                    value ="<%= allVictuals.get(i).getName()%>"  name="txtname" style="display:none;">

                            <label for="<%= allVictuals.get(i).getCode()%>" style="margin: auto;">
                                <div style="text-align: center;">
                                    <img src="Image/menu/<%= allVictuals.get(i).getImage()%>" alt="img" style="cursor: pointer;">
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
                    %>
                </div>
            </div>
        </div>

        <script>
            var updateinput = document.getElementById("update");
            var deleteinput = document.getElementById("delete");
            var idupdate = document.getElementById("idupdate");
            var iddelete = document.getElementById("iddelete");

            function check(name, code) {
                updateinput.value = name;
                deleteinput.value = name;
                idupdate.value = code;
                iddelete.value = code;
            }
        </script>



    </body>
</html>

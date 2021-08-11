<%-- 
    Document   : view-chart
    Created on : Jun 1, 2020, 3:44:38 AM
    Author     : ASUS
--%>

<%@page import="com.foodordering.profile.Profile"%>
<%@page import="com.foodordering.profile.ProfileDAO"%>
<%@page import="com.foodordering.order.Order"%>
<%@page import="com.foodordering.order.OrderDAO"%>
<%@page import="com.foodordering.payment.Payment"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" href="Style/normalize.css"/>
        <link rel="stylesheet" href="Style/theme.css"/>
        <link rel="stylesheet" href="Style/skeleton.css"/>

        <style>

            .back-btn{
                background-color: #F86F38;
                opacity: 0.6;
                transition: .3s;
                color: white;
            }

            .back-btn:hover{
                opacity: 1; 
                color: white;
            }

            .back-container,.graph-container{
                border: 2px solid white;
                background-color: #333;
                text-align: center;
                padding: 1rem ;
                margin-bottom: 1rem;

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

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
    </head>
    <%
        List<Payment> allPayment = (List<Payment>) request.getAttribute("thePayment");
        double[] price = new double[allPayment.size()];
        String[] month = new String[allPayment.size()];

        double total1 = 0;
        double total2 = 0;
        double total3 = 0;
        double total4 = 0;
        double total5 = 0;
        double total6 = 0;
        double total7 = 0;
        double total8 = 0;
        double total9 = 0;
        double total10 = 0;
        double total11 = 0;
        double total12 = 0;

        OrderDAO orderDAO = new OrderDAO();

        for (int i = 0; i < allPayment.size(); i++) {
            price[i] = allPayment.get(i).getTotalPrice();

            Order order = orderDAO.retrieveOrder(allPayment.get(i).getOrderid());

            month[i] = order.getOrderdate().substring(5, 7);

            switch (month[i]) {
                case "01":
                    total1 += price[i];
                    break;
                case "02":
                    total2 += price[i];
                    break;
                case "03":
                    total3 += price[i];
                    break;
                case "04":
                    total4 += price[i];
                    break;
                case "05":
                    total5 += price[i];
                    break;
                case "06":
                    total6 += price[i];
                    break;
                case "07":
                    total7 += price[i];
                    break;
                case "08":
                    total8 += price[i];
                    break;
                case "09":
                    total9 += price[i];
                    break;
                case "10":
                    total10 += price[i];
                    break;
                case "11":
                    total11 += price[i];
                    break;
                case "12":
                    total12 += price[i];
                    break;

            }

        }
        double[] totalIncome = {total1, total2, total3, total4, total5, total6, total7, total8, total9, total10, total11, total12};

    %>

    <%        int custid = (int) session.getAttribute("id");

        ProfileDAO profileDAO = new ProfileDAO();
        Profile profile = profileDAO.retrieveProfile(custid);

    %>
    <body>
        <!-- header -->
        <div class="row" style="background-color: #2B2B2B;color: white;margin-bottom: 3rem;">
            <div class="welcometext nine columns">
                <h4>Welcome, <%= profile.getName()%></h4>
            </div>
            <div class="welcometext three columns">
                <button class="logout-btn"  type="button" onclick="window.location.href = 'customer-logout.jsp'">logout</button>
            </div>
        </div>

        <!-- content -->
        <div class="container u-full-width">
            <div class="row">
                <div class="three columns back-container">
                    <button type="button" class="back-btn u-full-width" style="font-size: 1.6rem;" onclick="window.history.back()">Back</button>

                </div>

                <div  class="nine columns graph-container" style="padding: 2rem;">
                    <div style="background-color: white;" > 
                        <h5 style="text-align: center;background-color: #F86F38; padding: 1rem;color: white;">Total Income Per Month</h5>
                        <div style="width: 100%;height: 30rem;">
                            <canvas id="myChart"></canvas>
                        </div>
                    </div>
                </div>


            </div>
        </div>





        <script>
            var ctx = document.getElementById('myChart').getContext('2d');
            var label = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

            var data = new Array(12);

            <% for (int i = 0; i < totalIncome.length; i++) {%>
            data[<%= i%>] = "<%= totalIncome[i]%>";
            <% }%>

            var myLineChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: label,
                    datasets: [{
                            lineTension: 0,
                            fill: false,
                            data: data,
                            label: "Total Income",
                            borderColor: "rgb(0,176,80)",
                            backgroundColor: "rgb(0,176,80)",
                            borderWidth: 1

                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                }

            });

        </script>

    </body>
</html>

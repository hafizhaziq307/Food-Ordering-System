/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.order;

import com.foodordering.cart.CartDAO;
import com.foodordering.payment.Payment;
import com.foodordering.payment.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ASUS
 */
public class OrderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String option = request.getParameter("option");

            switch (option) {
                case "ADD":
                    addOrder(request, response);
                    break;
                case "UPDATE":
                    updateOrder(request, response);
                    break;
                case "DELETEALL":
                    deleteAllOrder(request, response);
                    break;

            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void addOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int tableno = Integer.parseInt(request.getParameter("txttableno"));
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));
        String[] qty = request.getParameterValues("txtqty");
        String[] code = request.getParameterValues("txtcode");

        List<Order> allOrder = new ArrayList<>();

        OrderDAO orderDAO = new OrderDAO();

        for (int i = 0; i < code.length; i++) {
            Order order = new Order();

            order.setTableno(tableno);
            order.setCustid(cust_id);
            order.setQty(Integer.parseInt(qty[i]));
            order.setCode(Integer.parseInt(code[i]));

            allOrder.add(order);

        }

        int result = orderDAO.addOrder(allOrder);
        if (result > 0) {
            listOrder(request, response);
        }

    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PaymentDAO paymentDAO = new PaymentDAO();

        String[] order_id = request.getParameterValues("txtorderid");
        String orderdate = request.getParameter("txtdate");
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));
        String address = request.getParameter("txtaddress");
        String pay = request.getParameter("txtpayment");
        String totalprice[] = request.getParameterValues("txttotalprice");

        if (pay == null) {
            pay = "pay by cash";

        }

        List<Order> allOrder = new ArrayList<>();
        List<Payment> allPayment = new ArrayList<>();

        OrderDAO orderDAO = new OrderDAO();

        for (int i = 0; i < order_id.length; i++) {

            Order order = new Order();

            order.setOrderdate(orderdate);
            order.setOrderid(Integer.parseInt(order_id[i]));
            order.setCustid(cust_id);

            allOrder.add(order);

            Payment payment = new Payment();
            payment.setOrderid(Integer.parseInt(order_id[i]));
            payment.setPayimage(pay);
            payment.setTotalPrice(Double.parseDouble(totalprice[i]));

            allPayment.add(payment);

        }
        paymentDAO.addPayment(allPayment);

        int result = orderDAO.updateOrder(allOrder);

        if (result > 0) {
            CartDAO cartDAO = new CartDAO();
            cartDAO.deleteAllCart(cust_id);

            RequestDispatcher dispatcher = request.getRequestDispatcher("Guest/counterPayment.jsp");
            dispatcher.forward(request, response);
        }

    }

    private void deleteAllOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));

        OrderDAO orderDAO = new OrderDAO();

        int result = orderDAO.deleteAllOrder(cust_id);

        if (result > 0) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("CartServlet?option=LIST");
            dispatcher.forward(request, response);
        }
    }

    private void listOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String user = request.getParameter("txtuser");
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));

        OrderDAO orderDAO = new OrderDAO();
        List<Order> allOrders = orderDAO.retrieveAllOrder(cust_id);

        request.setAttribute("theOrder", allOrders);

        if (user.equals("Guest")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Guest/receipt.jsp");
            dispatcher.forward(request, response);

        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("Guest/Customer/receipt.jsp?");
            dispatcher.forward(request, response);
        }

    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

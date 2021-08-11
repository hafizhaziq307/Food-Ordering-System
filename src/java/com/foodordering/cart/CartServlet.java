/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.cart;

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
public class CartServlet extends HttpServlet {

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
                    addCart(request, response);
                    break;

                case "DELETE":
                    deleteCart(request, response);
                    break;

                case "DELETEALL":
                    deleteAllCart(request, response);
                    break;

                case "UPDATE":
                    updateCart(request, response);
                    break;

                case "LIST":
                    listCart(request, response);
                    break;

            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void addCart(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));
        String[] code = request.getParameterValues("txtcode");
        List<Cart> allAddCart = new ArrayList<>();
        List<Cart> allUpdateCart = new ArrayList<>();
        CartDAO cartDAO = new CartDAO();

        try (PrintWriter out = response.getWriter()) {
            out.println("length: " + code.length);
            for (int i = 0; i < code.length; i++) {

                Cart cart = new Cart();

                //check if item on cart already exists
                if (cartDAO.checkCart(Integer.parseInt(code[i]), cust_id) == true) {

                    Cart objcart = cartDAO.retrieveCart(Integer.parseInt(code[i]), cust_id);

                    int newqty = objcart.getQty() + 1;

                    cart.setQty(newqty);
                    cart.setCartId(objcart.getCartId());

                    allUpdateCart.add(cart);

                } else {
                    cart.setCustId(cust_id);
                    cart.setQty(1);
                    cart.setCode(Integer.parseInt(code[i]));

                    allAddCart.add(cart);
                }
            }

            cartDAO.updateAllCart(allUpdateCart);
            cartDAO.addCart(allAddCart);
            listCart(request, response);
            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    }

    private void deleteCart(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int cart_id = Integer.parseInt(request.getParameter("txtcartid"));
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));

        CartDAO cartDAO = new CartDAO();

        int result = cartDAO.deleteCart(cart_id, cust_id);

        if (result > 0) {
            listCart(request, response);
        }
    }

    private void deleteAllCart(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));

        CartDAO cartDAO = new CartDAO();

        int result = cartDAO.deleteAllCart(cust_id);

        if (result > 0) {
            request.setAttribute("msg", "Success Delete All Items");
            request.setAttribute("theCart", null);
            listCart(request, response);
        }
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int cart_id = Integer.parseInt(request.getParameter("txtcartid"));
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));
        int qty = Integer.parseInt(request.getParameter("txtqty"));

        Cart cart = new Cart();

        cart.setCartId(cart_id);
        cart.setCustId(cust_id);
        cart.setQty(qty);

        CartDAO cartDAO = new CartDAO();

        int result = cartDAO.updateCart(cart);

        if (result > 0) {
            listCart(request, response);
        }
    }

    private void listCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int cust_id = Integer.parseInt(request.getParameter("txtcustid"));

        CartDAO cartDAO = new CartDAO();
        List<Cart> allCart = cartDAO.retrieveAllCart(cust_id);

        request.setAttribute("theCart", allCart);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Guest/cart.jsp");

        dispatcher.forward(request, response);

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

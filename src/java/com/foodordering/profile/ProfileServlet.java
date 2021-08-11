/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.profile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
public class ProfileServlet extends HttpServlet {

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
                    addProfile(request, response);
                    break;

                case "LOAD":
                    loadProfile(request, response);
                    break;

                case "CHECK":
                    checkProfile(request, response);
                    break;

            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void addProfile(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String name = request.getParameter("txtname");
        String password = request.getParameter("txtpassword");
        String email = request.getParameter("txtemail");
        String address = request.getParameter("txtaddress");
        String phoneno = request.getParameter("txtphoneno");

        Profile profile = new Profile();

        profile.setName(name);
        profile.setPassword(password);
        profile.setEmail(email);
        profile.setAddress(address);
        profile.setPhoneno(phoneno);

        ProfileDAO profileDAO = new ProfileDAO();

        int result = profileDAO.addProfile(profile);

        if (result > 0) {
            request.setAttribute("msg", "Success Create Profile");
            RequestDispatcher dispatcher = request.getRequestDispatcher("customer-login.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void loadProfile(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));

        ProfileDAO profileDAO = new ProfileDAO();
        Profile theProfile = profileDAO.retrieveProfile(id);

        request.setAttribute("theProfile", theProfile);

        RequestDispatcher dispatcher = request.getRequestDispatcher("profile-update.jsp");

        dispatcher.forward(request, response);

    }

    private void checkProfile(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String email = request.getParameter("txtemail");
        String password = request.getParameter("txtpassword");
        String user = request.getParameter("txtuser");

        //Admin & Customer login
        if (user.equals("Customer")) {
            if (email.equals("admin@gmail.com") && password.equals("admin")) {
                ProfileDAO profileDAO = new ProfileDAO();
                int result = profileDAO.checkProfile(email, password);

                if (result > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("id", result);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("VictualsServlet?option=LIST");

                dispatcher.forward(request, response);

                } else {
                    response.sendRedirect("customer-register.jsp");

                }

            } else {
                ProfileDAO profileDAO = new ProfileDAO();
                int result = profileDAO.checkProfile(email, password);

                if (result > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("id", result);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("VictualsServlet?option=LISTCUST");

                    dispatcher.forward(request, response);

                } else {
                    response.sendRedirect("customer-register.jsp");

                }
                
            }

        } //Guest login
        else if (user.equals("Guest")) {
            ProfileDAO profileDAO = new ProfileDAO();
            int result = profileDAO.checkProfile(email, password);

            if (result > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("id", result);
                RequestDispatcher dispatcher = request.getRequestDispatcher("VictualsServlet?option=LISTCUST");

                dispatcher.forward(request, response);

            } else {
                response.sendRedirect("customer-register.jsp");

            }

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

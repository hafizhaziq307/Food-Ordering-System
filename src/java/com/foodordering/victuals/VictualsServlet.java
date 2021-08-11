/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.victuals;

import java.io.IOException;
import java.io.PrintWriter;
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
public class VictualsServlet extends HttpServlet {

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
                    addVictuals(request, response);
                    break;
                case "UPDATE":
                    updateVictuals(request, response);

                    break;
                case "DELETE":
                    deleteVictuals(request, response);

                    break;
                case "LIST":
                    listVictuals(request, response);
                    break;

                case "LISTCUST":
                    listVictualsCust(request, response);
                    break;

                case "LOAD":
                    loadVictuals(request, response);
                    break;
                    
                case "RICE-SORT":
                    listVictualsRice(request, response);
                    break;
                    
                case "MEE-SORT":
                    listVictualsMee(request, response);
                    break;
                    
                case "BEVERAGE-SORT":
                    listVictualsBeverage(request, response);
                    break;

            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void addVictuals(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String name = request.getParameter("txtname");
        double price = Double.parseDouble(request.getParameter("txtprice"));
        String image = request.getParameter("txtimage");
        String type = request.getParameter("txttype");

        Victuals victuals = new Victuals();

        victuals.setName(name);
        victuals.setPrice(price);
        victuals.setImage(image);
        victuals.setType(type);

        VictualsDAO victualsDAO = new VictualsDAO();

        int result = victualsDAO.addVictuals(victuals);

        if (result > 0) {
            request.setAttribute("msg", "Success Add Victual");
            listVictuals(request, response);
        }

    }

    private void updateVictuals(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int code = Integer.parseInt(request.getParameter("txtcode"));
        String name = request.getParameter("txtname");
        double price = Double.parseDouble(request.getParameter("txtprice"));
        String image = request.getParameter("txtimage");
        String type = request.getParameter("txttype");

        Victuals victuals = new Victuals();

        victuals.setCode(code);
        victuals.setName(name);
        victuals.setPrice(price);
        victuals.setImage(image);
        victuals.setType(type);

        VictualsDAO victualsDAO = new VictualsDAO();

        int result = victualsDAO.updateVictuals(victuals);

        if (result > 0) {
            request.setAttribute("msg", "Success Update Victual");
            listVictuals(request, response);
        }
    }

    private void deleteVictuals(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int code = Integer.parseInt(request.getParameter("txtcode"));

        VictualsDAO victualsDAO = new VictualsDAO();

        int result = victualsDAO.deleteVictuals(code);

        if (result > 0) {
            request.setAttribute("msg", "Success Delete Victual");
            listVictuals(request, response);
        }

    }

    private void listVictuals(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VictualsDAO victualsDAO = new VictualsDAO();
        List<Victuals> allVictuals = victualsDAO.retrieveAllVictuals();

        request.setAttribute("theVictuals", allVictuals);
        request.setAttribute("categoryName", "All Product");

        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager/food-drink-view.jsp");

        dispatcher.forward(request, response);

    }
    
    private void listVictualsRice(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VictualsDAO victualsDAO = new VictualsDAO();
        List<Victuals> allVictuals = victualsDAO.retrieveAllVictualsRice();

        request.setAttribute("theVictuals", allVictuals);
        request.setAttribute("categoryName", "Nasi Goreng");

        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager/food-drink-view.jsp");

        dispatcher.forward(request, response);

    }
    
    private void listVictualsMee(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VictualsDAO victualsDAO = new VictualsDAO();
        List<Victuals> allVictuals = victualsDAO.retrieveAllVictualsMee();

        request.setAttribute("theVictuals", allVictuals);
        request.setAttribute("categoryName", "Mee");

        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager/food-drink-view.jsp");

        dispatcher.forward(request, response);

    }
    
    private void listVictualsBeverage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VictualsDAO victualsDAO = new VictualsDAO();
        List<Victuals> allVictuals = victualsDAO.retrieveAllVictualsBeverage();

        request.setAttribute("theVictuals", allVictuals);
        request.setAttribute("categoryName", "Beverage");

        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager/food-drink-view.jsp");

        dispatcher.forward(request, response);

    }

    private void listVictualsCust(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VictualsDAO victualsDAO = new VictualsDAO();
        List<Victuals> allVictuals = victualsDAO.retrieveAllVictuals();

        request.setAttribute("theVictuals", allVictuals);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Guest/food-drink-view.jsp");

        dispatcher.forward(request, response);

    }
    

    private void loadVictuals(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int code = Integer.parseInt(request.getParameter("txtcode"));

        VictualsDAO victualsDAO = new VictualsDAO();
        Victuals theVictual = victualsDAO.retrieveVictuals(code);

        request.setAttribute("theVictual", theVictual);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager/victual-update.jsp");

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

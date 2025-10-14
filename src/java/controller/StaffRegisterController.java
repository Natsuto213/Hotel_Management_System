
package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Staff;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/StaffRegisterController"})
public class StaffRegisterController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("utf-8");
            String fullname = request.getParameter("txtfullname");
            String username = request.getParameter("txtus");
            String password = request.getParameter("txtpassword");
            String phone = request.getParameter("txtphone");
            String email = request.getParameter("txtemail");
            String role = request.getParameter("txtrole");
            if (fullname != null && username != null && password != null && phone != null && email != null && role != null) {
                Staff staff = new Staff(fullname, username, password, phone, email, role);
                StaffDAO d = new StaffDAO();
                boolean isdupplicate = d.checkDupplicate(username, email);
                if (!isdupplicate) {
                    int result = d.insertStaff(staff);
                    if (result > 0) {
                        request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);
                    } else {
                        request.getRequestDispatcher(IConstants.ERROR).forward(request, response);
                    }
                } else {
                    request.getRequestDispatcher(IConstants.ERROR).forward(request, response);

                }
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

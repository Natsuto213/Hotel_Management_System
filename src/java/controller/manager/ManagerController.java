/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookingServiceDetail;
import model.Guest;
import model.Staff;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManagerController", urlPatterns = {"/ManagerController"})
public class ManagerController extends HttpServlet {

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
            HttpSession session = request.getSession();
            boolean isLogin = (boolean) session.getAttribute("isLogin");
            Staff staff = (Staff) session.getAttribute("STAFF");
            if (isLogin != true || !staff.getRole().equalsIgnoreCase("manager")) {
                request.getRequestDispatcher(IConstants.HOME).forward(request, response);
            } else {
                ManagerDAO md = new ManagerDAO();

                ArrayList<Guest> top10guest = md.top10FrequentGuests();
                ArrayList<BookingServiceDetail> mostUsedService = md.mostUsedService();
                double occupancyRate = md.roomOccupancyRate();
                double cancellationRate = md.cancellationRate();

                request.setAttribute("Top10Guest", top10guest);
                request.setAttribute("MostUsedService", mostUsedService);
                request.setAttribute("OccupancyRate", occupancyRate);
                request.setAttribute("CancellationRate", cancellationRate);

                request.getRequestDispatcher(IConstants.DASHBOARD_MANAGER).forward(request, response);
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

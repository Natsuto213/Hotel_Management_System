/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BookingService;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddServiceController", urlPatterns = {"/AddServiceController"})
public class AddServiceController extends HttpServlet {

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
            String bookingIdStr = request.getParameter("bookingid");
            String serviceIdStr = request.getParameter("serviceid");
            String quantityStr = request.getParameter("quantity");
            String bookingDateStr = request.getParameter("serviceDate");

            int bookingId = Integer.parseInt(bookingIdStr.trim());
            int serviceId = Integer.parseInt(serviceIdStr.trim());
            int quantity = Integer.parseInt(quantityStr.trim());
            LocalDate bookingDate = LocalDate.parse(bookingDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            BookingServiceDAO bsd = new BookingServiceDAO();
            BookingService find = bsd.findBookingService(bookingId, serviceId, bookingDate);
            if (find == null) {
                BookingService newService = new BookingService(bookingId, serviceId, quantity, bookingDate, 0);
                bsd.addService(newService);
            } else {
                quantity += find.getQuantity();
                int bookingServiceId = bsd.findBookingServiceID(bookingId, serviceId, bookingDate);
                bsd.updateService(quantity, bookingServiceId);
            }

            request.getRequestDispatcher(IConstants.CONTROLLER_GET_CART).forward(request, response);
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

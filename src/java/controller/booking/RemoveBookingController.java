/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.booking;

import dao.BookingDAO;
import dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RemoveBookingController", urlPatterns = {"/RemoveBookingController"})
public class RemoveBookingController extends HttpServlet {

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
            String checkinStr = request.getParameter("txtcheckin");
            LocalDate checkin = LocalDate.parse(checkinStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate now = LocalDate.now();
            if (checkin.isAfter(now)) {
                String roomIdStr = request.getParameter("roomid");
                int roomId = Integer.parseInt(roomIdStr);

                String bookingIdStr = request.getParameter("bookingid");
                int bookingId = Integer.parseInt(bookingIdStr);

                BookingDAO b = new BookingDAO();
                RoomDAO r = new RoomDAO();

                int result = 0;
                result = b.removeBooking(bookingId);
                if (result > 0) {
                    r.changeRoomStatus("Available", roomId);
                    request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKINGS).forward(request, response);
                } else {
                    request.setAttribute("ERROR", "Xóa booking lỗi");
                    request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKINGS).forward(request, response);
                }
            } else {
                request.setAttribute("ERROR", "Đã qua ngày check in, không thể xóa booking");
                request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKINGS).forward(request, response);
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

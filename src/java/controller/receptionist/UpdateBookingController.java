/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receptionist;

import dao.BookingDAO;
import dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Booking;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateBookingController", urlPatterns = {"/UpdateBookingController"})
public class UpdateBookingController extends HttpServlet {

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
            String roomType = request.getParameter("txtroomType");

            String checkinStr = request.getParameter("txtcheckin");
            String checkoutStr = request.getParameter("txtcheckout");

            LocalDate checkin = LocalDate.parse(checkinStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate checkout = LocalDate.parse(checkoutStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            LocalDateTime checkinDate = checkin.atTime(14, 00, 00);
            LocalDateTime checkoutDate = checkout.atTime(12, 00, 00);

            LocalDate now = LocalDate.now();
            if (checkin.isAfter(now)) {
                if (roomType != null && checkinStr != null && checkoutStr != null) {
                    String roomIdStr = request.getParameter("roomid");
                    int oldRoomId = Integer.parseInt(roomIdStr);

                    String bookingIdStr = request.getParameter("bookingid");
                    int bookingId = Integer.parseInt(bookingIdStr);

                    BookingDAO b = new BookingDAO();
                    RoomDAO r = new RoomDAO();

                    int newRoomId = r.getAvailableRoomIdByType(roomType, checkin, checkout);
                    if (newRoomId == 0) {
                        request.setAttribute("ERROR", "No suitable rooms available.");
                        request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKINGS).forward(request, response);
                    } else {
                        Booking booking = new Booking(bookingId, newRoomId, checkinDate, checkoutDate);
                        int result = b.updateBooking(booking);
                        if (result > 0) {
                            r.changeRoomStatus("Available", oldRoomId);
                            r.changeRoomStatus("Occupied", newRoomId);
                            request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKINGS).forward(request, response);
                        }
                    }
                }
            } else {
                request.setAttribute("ERROR", "Đã qua ngày check in, không thể cập nhật booking");
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

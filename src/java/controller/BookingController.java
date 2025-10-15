/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import javax.servlet.http.HttpSession;
import model.Booking;
import model.Guest;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingController", urlPatterns = {"/BookingController"})
public class BookingController extends HttpServlet {

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
            Guest guest = (Guest) session.getAttribute("USER");
            if (guest != null) {
                int guestId = guest.getGuestId();
                String roomType = request.getParameter("txtroomtype");
                RoomDAO rd = new RoomDAO();
                int roomId = rd.getAvailableRoomIdByType(roomType);
                if (roomId != 0) {
                    String checkinStr = request.getParameter("txtcheckin");
                    String checkoutStr = request.getParameter("txtchecout");
                    LocalDate checkin = LocalDate.parse(checkinStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate checkout = LocalDate.parse(checkoutStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate bookingDate = LocalDate.now();

                    if (guestId != 0 && roomId != 0 && checkin != null && checkout != null) {
                        Booking booking = new Booking(roomId, guestId, roomId, checkin, checkout, bookingDate, "Reserved");
                        BookingDAO bd = new BookingDAO();
                        int result = bd.createBooking(booking);
                        if (result > 0) {
                            request.setAttribute("BOOKING", booking);
                            int check = rd.changeRoomStatus("Occupied", roomId);
                            if (check > 0) {
                                request.getRequestDispatcher(IConstants.INVOICE).forward(request, response);

                            } else {
                                request.setAttribute("ERROR", "Đổi trạng thái phòng lỗi");
                                request.getRequestDispatcher(IConstants.BOOKING).forward(request, response);
                            }
                        } else {
                            request.setAttribute("ERROR", "Lỗi đặt phòng");
                            request.getRequestDispatcher(IConstants.BOOKING).forward(request, response);
                        }
                    }
                } else {
                    request.setAttribute("ERROR", " Không còn phòng trống thuộc loại này!");
                    request.getRequestDispatcher(IConstants.BOOKING).forward(request, response);
                }
            } else {
                request.setAttribute("ERROR", "Không lấy được GUEST từ session");
                request.getRequestDispatcher(IConstants.BOOKING).forward(request, response);
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

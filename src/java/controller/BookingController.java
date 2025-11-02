/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import dao.RoomDAO;
import dao.RoomTypeDAO;
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

                String checkinStr = request.getParameter("checkIn");
                String checkoutStr = request.getParameter("checkOut");

                //kiểm tra null 
                if (checkinStr == null || checkinStr.trim().isEmpty()
                        || checkoutStr == null || checkoutStr.trim().isEmpty()) {
                    request.setAttribute("ERROR", "Vui lòng nhập đầy đủ ngày nhận phòng và ngày trả phòng!");
                    request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);
                }

                LocalDate checkin = LocalDate.parse(checkinStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalDate checkout = LocalDate.parse(checkoutStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                LocalDateTime checkinDate = checkin.atTime(14, 00, 00);
                LocalDateTime checkoutDate = checkout.atTime(12, 00, 00);

                LocalDate today = LocalDate.now();

                //validate checkin
                if (checkin.isBefore(today)) {
                    request.setAttribute("ERROR", "Ngày nhận phòng phải sau ngày hiện tại ít nhất 1 ngày!");
                    request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);
                    return;
                }

                //validate checkout
                if (!checkout.isAfter(checkin)) {
                    request.setAttribute("ERROR", "Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!");
                    request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);
                    return;
                }

                //kiểm tra phòng
                RoomDAO rd = new RoomDAO();
                RoomTypeDAO rtd = new RoomTypeDAO();
                int roomId = rd.getAvailableRoomIdByType(roomType);
                if (roomId != 0) {
                    if (guestId != 0 && roomId != 0) {
                        Booking booking = new Booking(roomId, guestId, roomId, checkinDate, checkoutDate, today, "Reserved");
                        BookingDAO bd = new BookingDAO();
                        int result = bd.createBooking(booking);
                        if (result > 0) {
                            request.setAttribute("BOOKING", booking);
                            request.getRequestDispatcher(IConstants.CONTROLLER_CHECK_OUT).forward(request, response);
                        } else {
                            request.setAttribute("ERROR", "Lỗi đặt phòng");
                            request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);
                        }
                    }
                } else {
                    request.setAttribute("ERROR", " Không còn phòng trống thuộc loại này!");
                    request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);
                }
            } else {
                request.setAttribute("ERROR", "Không lấy được GUEST từ session");
                request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);
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

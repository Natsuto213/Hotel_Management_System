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

@WebServlet(name = "EditBookingController", urlPatterns = {"/EditBookingController"})
public class EditBookingController extends HttpServlet {

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
            
            String action = request.getParameter("action");
            String roomIdStr = request.getParameter("roomid");
            int roomId = Integer.parseInt(roomIdStr);
            String bookingIdStr = request.getParameter("bookingid");
            int bookingId = Integer.parseInt(bookingIdStr);
            BookingDAO b = new BookingDAO();
            RoomDAO r = new RoomDAO();
            int result = 0;
            if (action.equalsIgnoreCase("update")) {
                String roomType = request.getParameter("txtroomType");
                String checkinStr = request.getParameter("txtcheckin");
                String checkoutStr = request.getParameter("txtcheckout");
                if (roomType != null && checkinStr != null && checkoutStr != null) {
                    int roomID = r.getAvailableRoomIdByType(roomType);
                    LocalDate checkin = LocalDate.parse(checkinStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    LocalDate checkout = LocalDate.parse(checkoutStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    Booking booking = new Booking(bookingId, roomID, checkin, checkout);
                    result = b.updateBooking(booking);
                    if (result > 0) {
                        r.changeRoomStatus("Available", roomId);
                        r.changeRoomStatus("Occupied", roomID);
//                        request.setAttribute("txtguestID", guest.getGuestId());
                        request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKING).forward(request, response);
                    }
                }
            } else {
                result = b.removeBooking(bookingId);
                if (result > 0) {
                    r.changeRoomStatus("Available", roomId);
                    request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKING).forward(request, response);
                } else {
                    request.setAttribute("ERROR", "Xóa booking lỗi");
                    request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKING).forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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

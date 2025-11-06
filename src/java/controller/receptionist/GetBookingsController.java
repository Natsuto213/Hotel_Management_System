package controller.receptionist;

import controller.*;
import dao.BookingDAO;
import dao.GuestDAO;
import dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookingDetail;
import model.Guest;
import model.Room;
import utils.IConstants;

@WebServlet(name = "GetBookingsController", urlPatterns = {"/GetBookingsController"})
public class GetBookingsController extends HttpServlet {

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
            Guest guest = null;

            if (session.getAttribute("USER") == null) {
                String guestid = request.getParameter("guestid");
                if (guestid != null) {
                    GuestDAO d = new GuestDAO();
                    guest = d.findGuestByGuestID(Integer.parseInt(guestid));
                    session.setAttribute("USER", guest);
                }
            } else {
                guest = (Guest) session.getAttribute("USER");
            }

            if (guest == null) {
                request.setAttribute("ERROR", "Không tìm thấy thông tin khách hàng");
                request.getRequestDispatcher(IConstants.DASHBOARD_RECEPTIONIST).forward(request, response);
                return;
            }

            BookingDAO b = new BookingDAO();
            ArrayList<BookingDetail> bookinglist = b.getBookings(guest.getGuestId());
            request.setAttribute("BookingList", bookinglist);

            String roomType = request.getParameter("roomType");
            String assignBookingId = request.getParameter("bookingid");
            if (roomType != null && assignBookingId != null) {
                RoomDAO r = new RoomDAO();
                ArrayList<Room> roomlist = r.getAvailableRoomsByType(roomType);
                request.setAttribute("assignBookingId", assignBookingId);
                request.setAttribute("RoomList", roomlist);
            }
            
            request.getRequestDispatcher(IConstants.EDIT_BOOKING_RECEP).forward(request, response);

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

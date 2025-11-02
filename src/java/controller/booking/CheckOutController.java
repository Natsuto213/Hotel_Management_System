package controller.booking;

import dao.BookingDAO;
import dao.RoomDAO;
import dao.RoomTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Booking;
import model.RoomType;
import utils.IConstants;

@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String bookingidStr = request.getParameter("bookingid");
            String roomidStr = request.getParameter("roomid");
            if (bookingidStr != null && roomidStr != null) {
                int bookingid = Integer.parseInt(bookingidStr);
                int roomid = Integer.parseInt(roomidStr);

                BookingDAO bd = new BookingDAO();
                RoomDAO rd = new RoomDAO();
                RoomTypeDAO rtd = new RoomTypeDAO();

                int check = bd.changeBookingStatus("Checked-out", bookingid);
                if (check > 0) {
                    Booking booking = bd.getBooking(bookingid);
                    RoomType roomInfo = rtd.getRoomType(roomid);
                    rd.changeRoomStatus("Available", roomid);
                    
                    request.setAttribute("BOOKING", booking);
                    request.setAttribute("ROOM_INFO", roomInfo);
                    request.getRequestDispatcher(IConstants.INVOICE).forward(request, response);
                }
            } else {
                request.setAttribute("ERROR", "Không lấy được parameter");
                request.getRequestDispatcher(IConstants.CONTROLLER_GET_BOOKINGS).forward(request, response);
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

package controller;

import dao.BookingDAO;
import dao.BookingServiceDAO;
import dao.InvoiceDAO;
import dao.PaymentDAO;
import dao.RoomDAO;
import dao.RoomTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.BookingServiceDetail;
import model.Invoice;
import model.Payment;
import model.Room;
import model.RoomType;
import utils.DBUtils;
import utils.IConstants;

@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        Connection cn = DBUtils.getConnection();
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            boolean isCheckout = (boolean) session.getAttribute("isCheckout");
            cn.setAutoCommit(false);

            int roomid = Integer.parseInt(request.getParameter("roomid").trim());
            int bookingid = Integer.parseInt(request.getParameter("bookingid").trim());
            double amount = Double.parseDouble(request.getParameter("total").trim());
            String paymentMethod = request.getParameter("payment");
            LocalDate today = LocalDate.now();

            RoomDAO rd = new RoomDAO();
            rd.changeRoomStatus("Available", roomid);

            BookingDAO bd = new BookingDAO();
            bd.changeBookingStatus("Checked-out", bookingid);

            //CREATE PAYMENT
            Payment payment = new Payment(bookingid, today, amount * 1.08, paymentMethod, "Pending");
            PaymentDAO pd = new PaymentDAO();
            pd.addService(payment, cn);

            //CREATE INVOICE
            Invoice invoice = new Invoice(bookingid, today, amount * 1.08, "Unpaid");
            InvoiceDAO id = new InvoiceDAO();
            id.addInvoice(invoice, cn);

            if (isCheckout) {
                cn.commit();
            }

            //Forward to invoice.jsp
            session.setAttribute("bookingid", bookingid);
            RoomTypeDAO rtd = new RoomTypeDAO();
            BookingServiceDAO bsd = new BookingServiceDAO();

            Room room = rd.getRoom(roomid);
            RoomType roomType = rtd.getRoomType(roomid);
            Booking booking = bd.getBooking(bookingid);
            ArrayList<BookingServiceDetail> cart = bsd.getCart(bookingid);

            request.setAttribute("ROOM", room);
            request.setAttribute("ROOMTYPE", roomType);
            request.setAttribute("BOOKING", booking);
            request.setAttribute("CART", cart);

            request.getRequestDispatcher(IConstants.INVOICE).forward(request, response);

        } catch (Exception e) {
            try {
                cn.rollback();
            } catch (SQLException ex) {
                e.printStackTrace();
            }
            request.setAttribute("ERROR", "Booking failed! Please try again");
            request.getRequestDispatcher(IConstants.ERROR).forward(request, response);
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                    cn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CheckOutController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CheckOutController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CheckOutController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CheckOutController.class.getName()).log(Level.SEVERE, null, ex);
        }
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

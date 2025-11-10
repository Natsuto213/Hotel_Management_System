package controller;

import controller.feature.EmailSender;
import dao.BookingDAO;
import dao.BookingServiceDAO;
import dao.InvoiceDAO;
import dao.PaymentDAO;
import dao.RoomDAO;
import dao.RoomTypeDAO;
import dao.SystemConfigDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import model.Guest;
import model.Invoice;
import model.Payment;
import model.Room;
import model.RoomType;
import utils.DBUtils;
import utils.IConstants;

@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    protected boolean sendBookingConfirmationEmail(String recipientEmail, int bookingId) {
        try {
            BookingDAO bookingDAO = new BookingDAO();
            RoomDAO roomDAO = new RoomDAO();

            // Lấy thông tin booking
            Booking booking = bookingDAO.getBooking(bookingId);
            if (booking == null) {
                System.err.println("Không tìm thấy booking với ID: " + bookingId);
                return false;
            }

            // Lấy thông tin room
            Room room = roomDAO.getRoom(booking.getRoomId());

            // Format ngày tháng
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            String checkIn = booking.getCheckInDate().format(dateTimeFormatter);
            String checkOut = booking.getCheckOutDate().format(dateTimeFormatter);
            
            // Tạo nội dung email đơn giản
            String emailBody = String.format(
                    "Your check-out was completed successfully.\n"
                    + "Room number: %s\n"
                    + "Check-in date: %s\n"
                    + "Check-out date: %s",
                    room.getRoomNumber(),
                    checkIn,
                    checkOut
            );

            // Gửi email
            EmailSender emailSender = new EmailSender();
            boolean result = emailSender.sendTextEmail(
                    recipientEmail,
                    "Check-out Confirmation – Thank you for staying with us! #" + bookingId,
                    emailBody
            );

            if (result) {
                System.out.println("✓ Đã gửi email xác nhận đơn giản booking #" + bookingId + " đến: " + recipientEmail);
            }

            return result;

        } catch (Exception e) {
            System.err.println("✗ Lỗi khi gửi email xác nhận booking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        Connection cn = DBUtils.getConnection();
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Guest guest = (Guest) session.getAttribute("USER");

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

            SystemConfigDAO scd = new SystemConfigDAO();
            double tax = scd.getTax();

            //CREATE PAYMENT
            Payment payment = new Payment(bookingid, today, amount * (1 + tax), paymentMethod, "Pending");
            PaymentDAO pd = new PaymentDAO();
            pd.addService(payment, cn);

            //CREATE INVOICE
            Invoice invoice = new Invoice(bookingid, today, amount * (1 + tax), "Unpaid");
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
            request.setAttribute("TAX", tax);

            sendBookingConfirmationEmail(guest.getEmail(), bookingid);
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

    public CheckOutController() {
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

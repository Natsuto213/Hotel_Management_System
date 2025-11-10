/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.booking;

import controller.feature.EmailSender;
import dao.BookingDAO;
import dao.BookingServiceDAO;
import dao.GuestDAO;
import dao.RoomDAO;
import dao.RoomTypeDAO;
import dao.SystemConfigDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Booking;
import model.BookingDetail;
import model.BookingService;
import model.BookingServiceDetail;
import model.Guest;
import model.Room;
import model.RoomType;
import model.Service;
import utils.DBUtils;
import utils.IConstants;
import controller.feature.EmailSender;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingController", urlPatterns = {"/BookingController"})
public class BookingController extends HttpServlet {
    
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
                "Đăng kí thành công. Số phòng: %s, Check-in: %s, Check-out: %s",
                room.getRoomNumber(),
                checkIn,
                checkOut
            );
            
            // Gửi email
            EmailSender emailSender = new EmailSender();
            boolean result = emailSender.sendTextEmail(
                recipientEmail, 
                "Xác nhận đặt phòng thành công #" + bookingId,
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
            cn.setAutoCommit(false);
            HttpSession session = request.getSession();
            boolean isBooking = (boolean) session.getAttribute("isBooking");

            //CREATE BOOKING
            Guest guest = (Guest) session.getAttribute("USER");
            BookingDetail bookingdetail = (BookingDetail) session.getAttribute("BOOKING");

            int guestid = guest.getGuestId();
            int roomid = bookingdetail.getRoomId();
            LocalDate checkIn = bookingdetail.getCheckInDate();
            LocalDate checkOut = bookingdetail.getCheckOutDate();
            LocalDateTime checkinDate = checkIn.atTime(14, 00, 00);
            LocalDateTime checkoutDate = checkOut.atTime(12, 00, 00);
            LocalDate today = LocalDate.now();

            Booking booking = new Booking(guestid, roomid, checkinDate, checkoutDate, today, "Reserved");
            BookingDAO bd = new BookingDAO();

            bd.createBooking(booking, cn);
            int bookingid = booking.getBookingId();

            //CREATE BOOKING SERVICE
            BookingServiceDAO bsd = new BookingServiceDAO();
            ArrayList<BookingServiceDetail> cart = (ArrayList<BookingServiceDetail>) session.getAttribute("CART");
            if (cart == null || cart.isEmpty()) {
                cart = bsd.getCart(bookingid);
            }
            if (cart != null) {
                for (BookingServiceDetail c : cart) {
                    int serviceid = c.getServiceid();
                    int quantity = c.getQuantity();
                    LocalDate serviceDate = c.getServicedate();
                    BookingService bs = new BookingService(bookingid, serviceid, quantity, serviceDate, 0);
                    bsd.addService(bs, cn);
                }
            }

            if (isBooking) {
                cn.commit();
                // Send confirmation email after successful booking
                sendBookingConfirmationEmail(guest.getEmail(), bookingid);
            }

            RoomDAO rd = new RoomDAO();
            Room room = rd.getRoom(roomid);

            RoomTypeDAO rtd = new RoomTypeDAO();
            RoomType roomType = rtd.getRoomType(roomid);

            SystemConfigDAO scd = new SystemConfigDAO();
            double tax = scd.getTax();

            request.setAttribute("ROOM", room);
            request.setAttribute("ROOMTYPE", roomType);
            request.setAttribute("BOOKING", booking);
            session.setAttribute("bookingid", bookingid);
            request.setAttribute("TAX", tax);
            request.setAttribute("BookingSuccessfull", "Booking Sucessful! Enjoy your vacation!");

            request.getRequestDispatcher(IConstants.VIEW_BOOKING).forward(request, response);
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
            Logger.getLogger(BookingController.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (SQLException ex) {
            Logger.getLogger(BookingController.class
                    .getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(BookingController.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (SQLException ex) {
            Logger.getLogger(BookingController.class
                    .getName()).log(Level.SEVERE, null, ex);
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

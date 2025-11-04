/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import dao.BookingServiceDAO;
import dao.InvoiceDAO;
import dao.PaymentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
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
import model.Invoice;
import model.Payment;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingController", urlPatterns = {"/BookingController"})
public class BookingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();

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
            bd.createBooking(booking);

            //CREATE BOOKING SERVICE
            ArrayList<BookingServiceDetail> cart = (ArrayList<BookingServiceDetail>) session.getAttribute("CART");
            BookingServiceDAO bsd = new BookingServiceDAO();

            int bookingid = booking.getBookingId();
            for (BookingServiceDetail c : cart) {
                int serviceid = c.getServiceid();
                int quantity = c.getQuantity();
                LocalDate serviceDate = c.getServicedate();
                BookingService bs = new BookingService(bookingid, serviceid, quantity, serviceDate, 0);
                bsd.addService(bs);
            }

            //CREATE PAYMENT
            int amount = Integer.parseInt(request.getParameter("amount").trim());
            String paymentMethod = request.getParameter("payment");
            Payment payment = new Payment(bookingid, today, amount, paymentMethod, "Pending");

            PaymentDAO pd = new PaymentDAO();
            pd.addService(payment);

            //CREATE INVOICE
            Invoice invoice = new Invoice(bookingid, today, amount, "Paid");
            InvoiceDAO id = new InvoiceDAO();
            id.addInvoice(invoice);
            
            request.getRequestDispatcher(IConstants.INVOICE).forward(request, response);
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

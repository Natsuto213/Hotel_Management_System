/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingServiceDAO;
import dao.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookingService;
import model.BookingServiceDetail;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddServiceController", urlPatterns = {"/AddServiceController"})
public class AddServiceController extends HttpServlet {

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
            int bookingid = Integer.parseInt(request.getParameter("bookingid").trim());

            int serviceId = Integer.parseInt(request.getParameter("serviceid").trim());
            int quantity = Integer.parseInt(request.getParameter("quantity").trim());
            LocalDate serviceDate = LocalDate.parse(request.getParameter("serviceDate"), DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            if (bookingid == 0) {

                // Add Service tu Prebooking
                ServiceDAO sd = new ServiceDAO();
                String serviceName = sd.getName(serviceId);
                double price = sd.getPrice(serviceId);
                BookingServiceDetail newBooking = new BookingServiceDetail(serviceId, serviceName, quantity, serviceDate, price);

                HttpSession session = request.getSession();
                ArrayList<BookingServiceDetail> cart = (ArrayList<BookingServiceDetail>) session.getAttribute("CART");

                // neu chua co cart thi tao moi
                if (cart == null) {
                    cart = new ArrayList<>();
                    cart.add(newBooking);
                } else { //cart da ton tai
                    // xem service vua add co trong cart khong
                    BookingServiceDetail find = null;
                    for (BookingServiceDetail bsd : cart) {
                        if (bsd.getServiceid() == newBooking.getServiceid() && bsd.getServicedate().equals(newBooking.getServicedate())) {
                            find = bsd;
                            break;
                        }
                    }
                    if (find != null) { // neu co add quantity vua nhap + quantity da co san
                        find.setQuantity(find.getQuantity() + newBooking.getQuantity());
                    } else { //new khong chi nhap quantity vua nhap
                        cart.add(newBooking);
                    }
                }

                session.setAttribute("CART", cart);
                request.getRequestDispatcher(IConstants.CONTROLLER_PRE_BOOKING).forward(request, response);
            } else {

                // Add Service tu EditBooking
                int roomid = Integer.parseInt(request.getParameter("roomid").trim());
                BookingServiceDAO bsd = new BookingServiceDAO();
                BookingService find = bsd.findBookingService(bookingid, serviceId, serviceDate);

                if (find == null) {
                    BookingService newBooking = new BookingService(bookingid, serviceId, quantity, serviceDate, 0);
                    bsd.addService2(newBooking);
                } else {
                    quantity += find.getQuantity();
                    int cartId = bsd.findBookingServiceID(bookingid, serviceId, serviceDate);
                    bsd.updateService(quantity, cartId);
                }
                response.sendRedirect("BookingInformation?isEdit=edit&MSG=Update Successfull&roomid=" + roomid + "&bookingid=" + bookingid);
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

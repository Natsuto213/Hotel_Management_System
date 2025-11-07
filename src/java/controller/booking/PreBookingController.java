package controller.booking;

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
import model.BookingDetail;
import model.Service;
import utils.IConstants;

@WebServlet(name = "PreBookingController", urlPatterns = {"/PreBookingController"})
public class PreBookingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();

            if (session.getAttribute("BOOKING") == null) {
                int roomid = Integer.parseInt(request.getParameter("roomId").trim());
                String roomNumber = request.getParameter("roomNumber");
                String roomType = request.getParameter("roomType");
                LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalDate bookingDate = LocalDate.now();
                int guests = Integer.parseInt(request.getParameter("guests").trim());
                double price = Double.parseDouble(request.getParameter("price").trim());

                BookingDetail booking = new BookingDetail(roomid, roomNumber, roomType, checkIn, checkOut, bookingDate, price, guests);
                session.setAttribute("BOOKING", booking);
            }

            ServiceDAO sd = new ServiceDAO();
            ArrayList<Service> servicelist = sd.getAllServices();

            request.setAttribute("ServiceList", servicelist);
            request.getRequestDispatcher(IConstants.PREBOOKING).forward(request, response);
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

package controller;

import dao.BookingDAO;
import dao.ServiceDAO;
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
import model.Service;
import utils.IConstants;

@WebServlet(name = "FindBookingsController", urlPatterns = {"/FindBookingsController"})
public class FindBookingsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Guest guest = (Guest) session.getAttribute("USER");

            String roomNumber = request.getParameter("roomNumber");
            String bookingid = request.getParameter("bookingid");

            if (guest != null) {
                BookingDAO bd = new BookingDAO();
                ArrayList<BookingDetail> bookinglist = bd.getBookings(guest.getGuestId());
                request.setAttribute("BookingList", bookinglist);
            }

            if (bookingid != null) {
                ServiceDAO sd = new ServiceDAO();
                ArrayList<Service> servicelist = sd.getAllServices();
                request.setAttribute("ServiceList", servicelist);
            }

            request.getRequestDispatcher(IConstants.DASHBOARD_GUEST).forward(request, response);

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

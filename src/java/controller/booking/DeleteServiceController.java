package controller.booking;

import dao.BookingServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.BookingServiceDetail;
import utils.IConstants;

@WebServlet(name = "DeleteServiceController", urlPatterns = {"/DeleteServiceController"})
public class DeleteServiceController extends HttpServlet {

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

            int serviceId = Integer.parseInt(request.getParameter("serviceId").trim());
            LocalDate serviceDate = LocalDate.parse(request.getParameter("serviceDate"), DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            ArrayList<BookingServiceDetail> cart = (ArrayList<BookingServiceDetail>) session.getAttribute("CART");
            if (cart != null && !cart.isEmpty()) {
                
                // delete service tu PreBooking
                Iterator<BookingServiceDetail> iterator = cart.iterator();
                while (iterator.hasNext()) {
                    BookingServiceDetail bsd = iterator.next();
                    if (bsd.getServiceid() == serviceId && bsd.getServicedate().equals(serviceDate)) {
                        iterator.remove();
                        break;
                    }
                }
                session.setAttribute("CART", cart);
                request.getRequestDispatcher(IConstants.CONTROLLER_PRE_BOOKING).forward(request, response);
            } else {
                // delete service tu EditBooking
                int roomid = Integer.parseInt(request.getParameter("roomid").trim());
                int bookingid = Integer.parseInt(request.getParameter("bookingid").trim());
                BookingServiceDAO bsd = new BookingServiceDAO();
                int result = bsd.deleteService(serviceId, serviceDate);
                if (result > 0) {
                    response.sendRedirect("BookingInformation?type=edit&MSG=Delete Successfull&roomid=" + roomid + "&bookingid=" + bookingid);
                } else {
                    session.setAttribute("ERROR", "Delete service fail! Please try again");
                    request.getRequestDispatcher(IConstants.ERROR).forward(request, response);
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

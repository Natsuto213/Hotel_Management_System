package controller;

import dao.GuestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.IConstants;

/**
 *
 * @author Admin
 */
public class MainController extends HttpServlet {

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
            String url = IConstants.HOME;
            try {
                String action = request.getParameter("action");
                if (action == null || action.isEmpty()) {
                    action = "home";
                }
                switch (action) {
                    case "home":
                        url = IConstants.HOME;
                        break;
                    case "login":
                        url = IConstants.LOGIN;
                        break;
                    case "register":
                        url = IConstants.REGISTER;
                        break;
                    case "recepDashboard":
                        url = IConstants.DASHBOARD_RECEPTIONIST;
                        break;
                    case "loginUser":
                        url = IConstants.CONTROLLER_LOGIN;
                        break;
                    case "logout":
                        url = IConstants.CONTROLLER_LOGOUT;
                        break;
                    case "createStaff":
                        url = IConstants.CONTROLLER_REGIS_STAFF;
                        break;
                    case "createUser":
                        url = IConstants.CONTROLLER_REGIS_GUEST;
                        break;
                    case "searchGuest":
                        String keyword = request.getParameter("txtsearch");
                        request.setAttribute("txtsearch", keyword);
                        url = IConstants.CONTROLLER_GET_GUESTS;
                        break;
                    case "booking":
                        String roomType = request.getParameter("txtroomtype");
                        request.setAttribute("txtroomtype", roomType);
                        url = IConstants.BOOKING;
                        break;
                    case "bookroom":
                        roomType = request.getParameter("txtroomtype");
                        request.setAttribute("txtroomtype", roomType);
                        url = IConstants.CONTROLLER_BOOKING;
                        break;
                    case "getBookings":
                        String guestid = request.getParameter("guestid");
                        request.setAttribute("guestid", guestid);
                        url = IConstants.CONTROLLER_GET_BOOKINGS;
                        break;
                    case "editBooking":
                        String bookingid = request.getParameter("bookingid");
                        request.setAttribute("bookingid", bookingid);
                        String roomid = request.getParameter("roomid");
                        request.setAttribute("roomid", roomid);
                        String todo = request.getParameter("action");
                        request.setAttribute("action", todo);
                        url = IConstants.CONTROLLER_EDIT_BOOKING;
                        break;
                    case "checkin":
                        bookingid = request.getParameter("bookingid");
                        request.setAttribute("bookingid", bookingid);
                        url = IConstants.CONTROLLER_CHECK_IN;
                        break;
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    request.getRequestDispatcher(url).forward(request, response);
                } catch (Exception e) {
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

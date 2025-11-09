package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.IConstants;

public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String url = IConstants.HOME;
            try {
                String action = request.getParameter("action");
                if (action == null || action.isEmpty()) {
                    action = "home";
                }
                switch (action) {
                    //--------PAGE--------
                    case "home":
                        session.removeAttribute("BOOKING");
                        session.removeAttribute("CART");
                        url = IConstants.HOME;
                        break;
                    case "login":
                        url = IConstants.LOGIN;
                        break;
                    case "register":
                        url = IConstants.REGISTER;
                        break;
                    case "booking":
                        url = IConstants.BOOKING;
                        break;

                    //--------DASHBOARD + REPORT--------
                    case "recepDashboard":
                        url = IConstants.DASHBOARD_RECEPTIONIST;
                        break;
                    case "guestDashboard":
                        url = IConstants.DASHBOARD_GUEST;
                        break;
                    case "housekeepingDashboard":
                        url = IConstants.DASHBOARD_HOUSEKEEPING;
                        break;
                    case "serviceDashboard":
                        url = IConstants.DASHBOARD_SERVICE;
                        break;
                    case "revenueReport":
                        url = IConstants.CONTROLLER_REVENUE_REPORT;
                        break;
                    case "housekeeping":
                        url = IConstants.CONTROLLER_HOUSEKEEPING;
                        break;
                    case "updateTax":
                        url = IConstants.CONTROLLER_UPDATE_TAX;
                        break;

                    //--------CONTROLLER--------
                    case "loginUser":
                        url = IConstants.CONTROLLER_LOGIN;
                        break;
                    case "logoutUser":
                        url = IConstants.CONTROLLER_LOGOUT;
                        break;
                    case "createStaff":
                        url = IConstants.CONTROLLER_REGIS_STAFF;
                        break;
                    case "createUser":
                        url = IConstants.CONTROLLER_REGIS_GUEST;
                        break;

                    //--------BOOKING--------
                    case "search":
                        url = IConstants.CONTROLLER_SEARCH;
                        break;
                    case "preBooking":
                        url = IConstants.CONTROLLER_PRE_BOOKING;
                        break;
                    case "addService":
                        url = IConstants.CONTROLLER_ADD_SERVICE;
                        break;
                    case "deleteService":
                        url = IConstants.CONTROLLER_DELETE_SERVICE;
                        break;
                    case "createBooking":
                        url = IConstants.CONTROLLER_BOOKING;
                        break;
                    case "preCheckout":
                        url = IConstants.CONTROLLER_PRE_CHECKOUT;
                        break;

                    //--------GUEST--------
                    case "bookingInformation":
                        url = IConstants.CONTROLLER_BOOKING_INFO;
                        break;
                    case "findBookings":
                        url = IConstants.CONTROLLER_FIND_BOOKINGS;
                        break;
                    case "confirmEdit":
                        url = IConstants.CONTROLLER_CONFIRM_EDIT;
                        break;

                    //--------RECEPTIONIST--------
                    case "searchGuest":
                        url = IConstants.CONTROLLER_GET_GUESTS;
                        break;
                    case "getBookings":
                        url = IConstants.CONTROLLER_GET_BOOKINGS;
                        break;
                    case "update":
                        url = IConstants.CONTROLLER_UPDATE_BOOKING;
                        break;
                    case "remove":
                        url = IConstants.CONTROLLER_REMOVE_BOOKING;
                        break;
                    case "checkin":
                        url = IConstants.CONTROLLER_CHECK_IN;
                        break;
                    case "checkout":
                        url = IConstants.CONTROLLER_CHECK_OUT;
                        break;
                    case "assign":
                        url = IConstants.CONTROLLER_GET_BOOKINGS;
                        break;
                    case "confirmAssign":
                        url = IConstants.CONTROLLER_ASSIGN_ROOMS;
                        break;
                    case "cancelAssign":
                        url = IConstants.CONTROLLER_GET_BOOKINGS;
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

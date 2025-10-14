/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.GuestDAO;
import dao.StaffDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Guest;
import model.Staff;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private StaffDAO staffDAO;
    private GuestDAO guestDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
        guestDAO = new GuestDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("txtus");
        String password = request.getParameter("txtpassword");

        Staff staff = staffDAO.getStaff(username, password);
        Guest guest = guestDAO.getGuest(username, password);
        request.getSession().setAttribute("isLogin", false);

        if (staff != null) {
            request.getSession().setAttribute("isLogin", true);
            request.getSession().setAttribute("USER", staff);
            response.sendRedirect(IConstants.HOME);
            return; // Dừng thực thi
        }
        if (guest != null) {
            request.getSession().setAttribute("isLogin", true);
            request.getSession().setAttribute("USER", guest);
            request.getRequestDispatcher(IConstants.HOME).forward(request, response);
            return; // Dừng thực thi
        }

// Nếu cả hai đều null
        request.setAttribute("error", "Invalid username or password");
        request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);

        //
//        if (username != null && !username.isEmpty() && password != null && !password.isEmpty()) {
//            Object currentUser = staffService.getStaffByUsernameAndPassword(username, password);
//
//            if (currentUser == null) {
//                currentUser = guestService.getGuestByUsernameAndPassword(username, password);
//            }
//
//            if (currentUser != null) {
//                HttpSession session = request.getSession(true);
//                session.setAttribute("USER", currentUser);
//
//                String userRole = "";
//                if (currentUser instanceof StaffModel) {
//                    userRole = ((StaffModel) currentUser).getRole();
//                } else if (currentUser instanceof GuestModel) {
//                    userRole = "GUEST";
//                }
//
//                String redirectUrl = IConstants.HOME;
//                switch (userRole.toUpperCase()) {
//                    case "GUEST":
//                        redirectUrl = IConstants.HOME;
//                        break;
//                }
//                response.sendRedirect(request.getContextPath() + redirectUrl);
//
//            } else {
//                request.setAttribute(RequestAttribute.ERROR_LOGIN_MESSAGE, "Incorrect username or password.");
//                request.getRequestDispatcher(IConstants.HOME).forward(request, response);
//            }
//        } else {
//            request.setAttribute(RequestAttribute.ERROR_LOGIN_MESSAGE, "Username and password are required.");
//            request.getRequestDispatcher(IConstants.HOME).forward(request, response);
//        }
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

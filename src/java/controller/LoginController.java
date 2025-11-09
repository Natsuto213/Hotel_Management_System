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
import javax.servlet.http.HttpSession;
import model.Guest;
import model.Staff;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

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
        HttpSession session = request.getSession();

        Staff staff = staffDAO.getStaff(username, password);
        Guest guest = guestDAO.getGuest(username, password);

        if (username != null && password != null && !username.isEmpty() && !password.isEmpty()) {

            if (staff != null) {
                session.setAttribute("isLogin", true);
                session.setAttribute("STAFF", staff);
                String role = staff.getRole().toLowerCase();
                switch (role) {
                    case "admin":
                        request.getRequestDispatcher(IConstants.CONTROLLER_ADMIN).forward(request, response);
                        break;
                    case "receptionist":
                        request.getRequestDispatcher(IConstants.DASHBOARD_RECEPTIONIST).forward(request, response);
                        break;
                    case "manager":
                        request.getRequestDispatcher(IConstants.CONTROLLER_MANAGER).forward(request, response);
                        break;
                    case "housekeeping":
                        request.getRequestDispatcher(IConstants.DASHBOARD_HOUSEKEEPING).forward(request, response);
                        break;
                    case "servicestaff":
                        request.getRequestDispatcher(IConstants.DASHBOARD_SERVICE).forward(request, response);
                        break;
                }
                return;
            }
            if (guest != null) {
                session.setAttribute("isLogin", true);
                session.setAttribute("USER", guest);
                response.sendRedirect(IConstants.HOME);
                return;
            }

            // Nếu cả hai đều null
            request.setAttribute("ERROR", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);
        } else {
            request.setAttribute("ERROR", "Username and password are required.");
            request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);
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

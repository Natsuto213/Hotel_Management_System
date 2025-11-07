/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Staff;
import utils.IConstants;

/**
 *
 * @author votra
 */
@WebServlet(name = "AddStaffController", urlPatterns = {"/AddStaffController"})
public class AddStaffController extends HttpServlet {

    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
    }

    public boolean isUsernameExist(String username) {
        return staffDAO.isUsernameExist(username);
    }

    public boolean addStaff(Staff staff) {
        return staffDAO.addStaff(staff);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        Staff newStaff = new Staff(fullName, username, password, phone, email, role);
        System.out.println(newStaff);

        if (!isUsernameExist(username)) {
            addStaff(newStaff);
            response.sendRedirect(IConstants.CONTROLLER_ADMIN);
        } else {
            request.setAttribute("error", "Username already exists!");
            StaffDAO staffDAO = new StaffDAO();
            ArrayList<Staff> staffs = staffDAO.getAllStaff();
            request.setAttribute("staffs", staffs);
            HttpSession session = request.getSession(false);
            if (session != null) {
                request.setAttribute("admin", session.getAttribute("STAFF"));
            }
            request.getRequestDispatcher(IConstants.CONTROLLER_ADMIN).forward(request, response);

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

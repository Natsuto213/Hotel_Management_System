/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.GuestDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Guest;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

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
            String fullname = request.getParameter("txtfullname");
            String username = request.getParameter("txtus");
            String password = request.getParameter("txtpassword");
            String phone = request.getParameter("txtphone");
            String email = request.getParameter("txtemail");
            String address = request.getParameter("txtaddress");
            String idnumber = request.getParameter("txtidnumber");
            String dobStr = request.getParameter("txtdob");
            LocalDate dob = LocalDate.parse(dobStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            if (fullname != null && !fullname.isEmpty()
                    && username != null && !username.isEmpty()
                    && password != null && !password.isEmpty()
                    && phone != null && email != null && address != null && idnumber != null && dob != null) {
                Guest guest = new Guest(fullname, username, password, phone, email, address, idnumber, dob);
                GuestDAO d = new GuestDAO();
                int result = d.createGuest(guest);
                if (result > 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("USER", guest);
                    // Tai chua co login nen chuyen ve home. Sau khi co login thi login sau do ve home va hien welcome
                    request.getRequestDispatcher(IConstants.HOME).forward(request, response);
                } else {
                    request.setAttribute("ERROR", "Tạo tài khoản thất bài hoặc tài khoản đã bị trùng. Vui lòng đổi username hoặc email");
                    request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);
                }
            } else {
                request.setAttribute("ERROR", "Vui lòng điên đủ các ô");
                request.getRequestDispatcher(IConstants.LOGIN).forward(request, response);
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

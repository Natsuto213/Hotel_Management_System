package controller;

import dao.ServiceDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Staff;
import utils.IConstants;

@WebServlet(name = "ServiceStaffController", urlPatterns = {"/ServiceStaffController"})
public class ServiceStaffController extends HttpServlet {
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("STAFF");

        if (staff == null || !"servicestaff".equalsIgnoreCase(staff.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        try {
            switch (action) {
                case "dashboard":
                    request.getRequestDispatcher(IConstants.DASHBOARD_SERVICE).forward(request, response);
                    break;
                case "report1":
                    request.setAttribute("LIST", serviceDAO.getTodayServices());
                    request.getRequestDispatcher("report1.jsp").forward(request, response);
                    break;
                case "report2":
                    request.setAttribute("LIST", serviceDAO.getPendingServices());
                    request.getRequestDispatcher("report2.jsp").forward(request, response);
                    break;
                case "report3":
                    request.setAttribute("LIST", serviceDAO.getServiceByStaff());
                    request.getRequestDispatcher("report3.jsp").forward(request, response);
                    break;
                case "report4":
                    request.setAttribute("LIST", serviceDAO.getRevenueReport());
                    request.getRequestDispatcher("report4.jsp").forward(request, response);
                    break;
                default:
                    request.getRequestDispatcher(IConstants.DASHBOARD_SERVICE)
                           .forward(request, response);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ServiceStaffController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException { processRequest(request, response) ; }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}

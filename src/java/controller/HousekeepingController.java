/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */

        
package controller;

import dao.HousekeepingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Staff;
import utils.IConstants;

/**
 *
 * @author Admin
 */

public class HousekeepingController extends HttpServlet {
    private HousekeepingDAO hkDAO;
    
    @Override
   public void init() throws ServletException {
       hkDAO = new HousekeepingDAO();
   } 
   
   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
           throws ServletException, IOException{
       
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("STAFF");
        
        if (staff == null || !"housekeeping".equalsIgnoreCase(staff.getRole())){
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "dashboard";
                
        
        switch (action){
            case "dashboard":
                request.getRequestDispatcher(IConstants.DASHBOARD_HOUSEKEEPING).forward(request, response);
                break;
            case "updateStatus":
                String roomNumber = request.getParameter("roomNumber");
                String status = request.getParameter("status");
                boolean ok = hkDAO.updateRoomStatus(roomNumber, status, staff.getStaffID());
                request.setAttribute("MESSAGE", ok ? "Cập nhật thành công" : "Cập nhật thất bại");
                request.getRequestDispatcher(IConstants.DASHBOARD_HOUSEKEEPING).forward(request, response);
                break;
            case "dailyReport":
                request.setAttribute("REPORT", hkDAO.getDailyCleaningReport());
                request.getRequestDispatcher("dailyReport.jsp").forward(request, response);
                break;
            case "pendingTasks":
                request.setAttribute("TASKS", hkDAO.getPendingCleaningTasks());
                request.getRequestDispatcher("pendingTasks.jsp").forward(request, response);
                break;
            case "statusReport":
                request.setAttribute("ROOMS", hkDAO.getRoomStatusReport());
                request.getRequestDispatcher("statusReport.jsp").forward(request, response);
                break;
            case "issueReport":
                request.setAttribute("ISSUES", hkDAO.getMaintenanceIssues());
                request.getRequestDispatcher("issueReport.jsp").forward(request, response);
                break;
            case "performance":
                request.setAttribute("PERFORMANCE", hkDAO.getStaffPerformance());
                request.getRequestDispatcher("performance.jsp").forward(request, response);
                break;
            default:
                request.getRequestDispatcher(IConstants.DASHBOARD_HOUSEKEEPING).forward(request, response);
                break;
        }
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
          
}

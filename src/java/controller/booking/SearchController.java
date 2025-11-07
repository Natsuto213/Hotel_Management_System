/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.booking;

import dao.RoomDAO;
import dao.RoomTypeDAO;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Room;
import model.RoomType;
import utils.IConstants;

/**
 *
 * @author votra
 */
@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {

    private RoomDAO roomDAO;
    private RoomTypeDAO roomTypeDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
        roomTypeDAO = new RoomTypeDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String checkIn = request.getParameter("check-in");
        String checkOut = request.getParameter("check-out");
        String guests = request.getParameter("guests");
        String roomTypeStr = request.getParameter("room-type");
        int roomType = Integer.parseInt(roomTypeStr);

        // THÊM KIỂM TRA NULL Ở ĐÂY
        if (checkIn == null || checkOut == null || guests == null || roomTypeStr == null
                || checkIn.isEmpty() || checkOut.isEmpty() || guests.isEmpty()) {

            // Nếu thiếu, quay về trang chủ
            request.setAttribute("ERROR", "Vui lòng điền đầy đủ thông tin tìm kiếm.");
            request.getRequestDispatcher(IConstants.HOME).forward(request, response);
        }

        LocalDate checkInDate = LocalDate.parse(checkIn);
        LocalDate checkOutDate = LocalDate.parse(checkOut);

        LocalDateTime checkInDateTime = checkInDate.atStartOfDay();
        LocalDateTime checkOutDateTime = checkOutDate.atTime(23, 59, 59);

        ArrayList<Room> availableRooms = roomDAO.getAvailableRooms(roomType, checkInDateTime, checkOutDateTime);
        ArrayList<RoomType> roomTypes = roomTypeDAO.getAllRoomType();
        
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("roomTypes", roomTypes);
        request.setAttribute("checkIn", checkIn);
        request.setAttribute("checkOut", checkOut);
        request.setAttribute("guests", guests);
        request.setAttribute("roomType", roomType);

        request.getRequestDispatcher(IConstants.SEARCH).forward(request, response);

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

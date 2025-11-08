/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.guest;

import dao.BookingDAO;
import dao.BookingServiceDAO;
import dao.RoomDAO;
import dao.RoomTypeDAO;
import dao.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Booking;
import model.BookingServiceDetail;
import model.Room;
import model.RoomType;
import model.Service;
import utils.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingInformation", urlPatterns = {"/BookingInformation"})
public class BookingInformation extends HttpServlet {

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
            String type = request.getParameter("type");
            int roomid = Integer.parseInt(request.getParameter("roomid").trim());
            int bookingid = Integer.parseInt(request.getParameter("bookingid").trim());

            RoomDAO rd = new RoomDAO();
            Room room = rd.getRoom(roomid);

            RoomTypeDAO rtd = new RoomTypeDAO();
            RoomType roomType = rtd.getRoomType(roomid);

            BookingDAO bd = new BookingDAO();
            Booking booking = bd.getBooking(bookingid);

            BookingServiceDAO bsd = new BookingServiceDAO();
            ArrayList<BookingServiceDetail> cart = bsd.getCart(bookingid);

            request.setAttribute("ROOM", room);
            request.setAttribute("ROOMTYPE", roomType);
            request.setAttribute("BOOKING", booking);
            request.setAttribute("CART", cart);

            switch (type) {
                case "view":
                    request.getRequestDispatcher(IConstants.VIEW_BOOKING).forward(request, response);
                case "edit":
                    ServiceDAO sd = new ServiceDAO();
                    ArrayList<Service> servicelist = sd.getAllServices();
                    request.setAttribute("ServiceList", servicelist);
                    String msg = request.getParameter("MSG");
                    request.getRequestDispatcher(IConstants.EDIT_BOOKING).forward(request, response);
                default:
                    request.getRequestDispatcher(IConstants.VIEW_BOOKING).forward(request, response);

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

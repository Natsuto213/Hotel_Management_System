/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RoomDAO;
import dao.RoomTypeDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Room;
import model.RoomType;
import utils.IConstants;

/**
 *
 * @author votra
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private RoomDAO roomDAO;
    private RoomTypeDAO roomTypeDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
        roomTypeDAO = new RoomTypeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServletContext context = request.getServletContext();
        HttpSession session = request.getSession();
        Boolean isLogin = false;

        ArrayList<Room> rooms = roomDAO.getAllRoom();
        ArrayList<RoomType> roomTypes = roomTypeDAO.getAllRoomType();

        session.setAttribute("isLogin", isLogin);
        context.setAttribute("rooms", rooms);
        context.setAttribute("roomTypes", roomTypes);

        request.getRequestDispatcher(IConstants.HOME).forward(request, response);
    }

}

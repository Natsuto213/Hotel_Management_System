/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Staff;

/**
 *
 * @author votra
 */
@WebServlet(name = "EditStaffController", urlPatterns = {"/EditStaffController"})
public class EditStaffController extends HttpServlet {

    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO();
    }

    public boolean isUsernameExist(String username) {
        return staffDAO.isUsernameExist(username);
    }

    public boolean updateStaff(Staff staff) {
        return staffDAO.updateStaff(staff);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Thêm dòng này để hỗ trợ tiếng Việt

        try {
            // Lấy ID trước
            int id = Integer.parseInt(request.getParameter("staffId"));

            // Lấy các tham số khác
            String fullName = request.getParameter("fullName");
            String role = request.getParameter("role");
            String username = request.getParameter("username");
            String newPassword = request.getParameter("password"); // Lấy mật khẩu mới từ form
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");

            String finalPassword; // Biến để lưu mật khẩu cuối cùng

            // == PHẦN LOGIC MỚI BẮT ĐẦU TỪ ĐÂY ==
            if (newPassword == null || newPassword.trim().isEmpty()) {
                // 1. Mật khẩu để trống -> Lấy mật khẩu cũ
                // Bạn cần gọi hàm helper mới mà chúng ta đã thêm
                
                Staff oldStaff = staffDAO.getStaffById(id);
                if (oldStaff != null) {
                    finalPassword = oldStaff.getPasswordHash();
                } else {
                    // Xử lý lỗi nếu không tìm thấy staff (hiếm khi xảy ra nếu ID đúng)
                    // Ở đây tôi sẽ tạm đặt là rỗng, nhưng bạn nên xử lý kỹ hơn
                    finalPassword = ""; // Hoặc ném ra lỗi
                }
            } else {
                // 2. Người dùng đã nhập mật khẩu mới
                // QUAN TRỌNG: Nếu bạn có mã hóa mật khẩu, hãy mã hóa 'newPassword' ở đây
                finalPassword = newPassword;
            }
            // == KẾT THÚC LOGIC MỚI ==

            // Tạo đối tượng Staff với mật khẩu chính xác
            Staff staff = new Staff(id, fullName, username, finalPassword, phone, email, role);

            // Cập nhật staff
            updateStaff(staff);

            // Chuyển hướng về trang admin
            response.sendRedirect("AdminController");

        } catch (NumberFormatException e) {
            // Xử lý nếu 'staffId' không phải là số
            e.printStackTrace(); // Ghi log lỗi
            response.sendRedirect("AdminController?error=invalidId");
        } catch (Exception e) {
            // Xử lý các lỗi chung khác
            e.printStackTrace();
            response.sendRedirect("AdminController?error=updateFailed");
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

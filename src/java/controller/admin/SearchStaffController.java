package controller.admin;

import dao.StaffDAO; // Import DAO
import java.io.IOException;
import java.util.ArrayList; // Import ArrayList
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // Import Session
import model.Staff; // Import Model
import utils.IConstants;

/**
 *
 * @author TR_NGHIA
 */

@WebServlet(name = "SearchStaffController", urlPatterns = {"/SearchStaffController"})
public class SearchStaffController extends HttpServlet {

    private StaffDAO staffDAO; // Khai báo DAO

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAO(); // Khởi tạo DAO khi servlet chạy
    }

    /**
     * Processes requests for both HTTP GET and POST methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Hỗ trợ tiếng Việt

        // Lấy URL của trang dashboard (tôi đoán tên là adminDashboard.jsp)
        // *** THAY ĐỔI "adminDashboard.jsp" NẾU TÊN FILE CỦA BẠN KHÁC ***
        String url = IConstants.DASHBOARD_ADMIN; 

        try {
            // 1. Lấy từ khóa tìm kiếm từ form
            String searchName = request.getParameter("txtSearch");
            
            // 2. Gọi DAO để lấy danh sách nhân viên đã lọc
            ArrayList<Staff> staffList;
            if (searchName == null || searchName.trim().isEmpty()) {
                // Nếu không nhập gì, lấy tất cả
                staffList = staffDAO.getAllStaff();
            } else {
                // Nếu có nhập, thì tìm kiếm
                staffList = staffDAO.searchStaffByName(searchName);
            }

            // 3. Đặt kết quả vào request attribute với tên "staffs"
            request.setAttribute("staffs", staffList);

            // 4. (QUAN TRỌNG) Lấy 'admin' từ session và đặt lại vào request
            // Trang JSP của bạn cần 'admin' để hiển thị header
            HttpSession session = request.getSession();
            Staff admin = (Staff) session.getAttribute("admin"); // Giả sử bạn lưu admin trong session với tên "admin"
            if (admin != null) {
                request.setAttribute("admin", admin);
            }
            
            // 5. Thêm từ khóa tìm kiếm vào request để giữ lại trên ô input (nếu muốn)
            request.setAttribute("lastSearch", searchName);

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, có thể log lại và trả về danh sách rỗng
            request.setAttribute("staffs", new ArrayList<Staff>());
            request.setAttribute("error", "Lỗi khi tìm kiếm: " + e.getMessage());
        } finally {
            // 6. Chuyển tiếp (Forward) về trang JSP để hiển thị kết quả
            // Dùng forward để giữ lại các attribute trong request
            request.getRequestDispatcher(IConstants.DASHBOARD_ADMIN).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP GET method.
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
     * Handles the HTTP POST method.
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
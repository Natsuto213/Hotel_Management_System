package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Staff;
import utils.DBUtils;

/**
 *
 * @author votra
 */
public class StaffDAO {

    public Staff getStaff(String username, String password) {
        Staff result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                //step 2
                String sql = "SELECT *"
                        + "  FROM [HotelManagement].[dbo].[STAFF]"
                        + "  WHERE [Username] = ? AND [Password] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, username);
                st.setString(2, password);
                ResultSet table = st.executeQuery();
                //step 3
                if (table != null) {
                    while (table.next()) {
                        int staffId = table.getInt("StaffID");
                        String fullName = table.getString("FullName");
                        String role = table.getString("Role");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
                        result = new Staff(staffId, fullName, username, password, phone, email, role);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public ArrayList<Staff> getAllStaff() {
        ArrayList<Staff> result = new ArrayList<>();
        String sql = "SELECT [StaffID] ,[FullName] ,[Role] ,[Username] ,[Password] ,[Phone] ,[Email] "
                + "FROM [HotelManagement].[dbo].[STAFF]";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    int id = rs.getInt("StaffID");
                    String fullName = rs.getString("FullName");
                    String role = rs.getString("Role");
                    String username = rs.getString("Username");
                    String passwordHash = rs.getString("Password");
                    String phone = rs.getString("Phone");
                    String email = rs.getString("Email");
                    Staff staff =new Staff(id, fullName, username, passwordHash, phone, email, role);
                    result.add(staff);
                }

            }
        } catch (Exception e) {

        }
        return result;
    }

    public int insertStaff(Staff staff) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "insert dbo.STAFF(FullName,Role,Username,PasswordHash,Phone,Email) values(?,?,?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, staff.getFullname());
                st.setString(2, staff.getRole());
                st.setString(3, staff.getUsername());
                st.setString(4, staff.getPasswordHash());
                st.setString(5, staff.getPhone());
                st.setString(6, staff.getEmail());
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public boolean checkDupplicate(String username, String email) {
        boolean result = false; // khong dupplicate
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select * from dbo.STAFF where Username=? OR Email=?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, username);
                st.setString(2, email);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = true; // co dupplicate
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public boolean isUsernameExist(String username) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) AS count FROM [HotelManagement].[dbo].[STAFF] WHERE [Username] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, username);
                ResultSet table = st.executeQuery();
                if (table.next()) {
                    int count = table.getInt("count");
                    result = count > 0;
                }
                table.close();
                st.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
     public boolean addStaff(Staff staff) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO [HotelManagement].[dbo].[STAFF] ([FullName] ,[Role] ,[Username] ,[PasswordHash] ,[Phone] ,[Email]) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, staff.getFullname());
                st.setString(2, staff.getRole());
                st.setString(3, staff.getUsername());
                st.setString(4, staff.getPasswordHash());
                st.setString(5, staff.getPhone());
                st.setString(6, staff.getEmail());

                int rowAffected = st.executeUpdate();
                result = rowAffected > 0;

                st.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean deleteStaff(int staffId) {
        boolean result = false;

        String sql = "DELETE FROM [HotelManagement].[dbo].[STAFF] WHERE [StaffID] = ?";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, staffId);
            int rowsAffected = ps.executeUpdate();
            result = rowsAffected > 0;
            ps.close();
            con.close();
        } catch (Exception e) {

        }

        return result;
    }

    public boolean updateStaff(Staff staff) {
        boolean result = false;

        String sql = "UPDATE [HotelManagement].[dbo].[STAFF] SET [FullName] = ?, [Role] = ?, [Username] = ?, [PasswordHash] = ?, [Phone] = ?, [Email] = ? WHERE [StaffID] = ?";

        try {
            Connection con = DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staff.getFullname());
            ps.setString(2, staff.getRole());
            ps.setString(3, staff.getUsername());
            ps.setString(4, staff.getPasswordHash());
            ps.setString(5, staff.getPhone());
            ps.setString(6, staff.getEmail());
            ps.setInt(7, staff.getStaffID());
            int rowsAffected = ps.executeUpdate();
            result = rowsAffected > 0;
            ps.close();
            con.close();

        } catch (Exception e) {
            // TODO: handle exception
        }

        return result;
    }

    public Staff getStaffById(int id) {
        Staff result = null;
        // Lấy tất cả các cột giống như trong hàm getAllStaff
        String sql = "SELECT [StaffID], [FullName], [Role], [Username], [PasswordHash], [Phone], [Email] "
                + "FROM [HotelManagement].[dbo].[STAFF] WHERE [StaffID] = ?";

        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                ps = cn.prepareStatement(sql);
                ps.setInt(1, id); // Thiết lập tham số ID cho câu lệnh WHERE
                rs = ps.executeQuery();

                // Vì ID là duy nhất, chúng ta chỉ cần dùng 'if' thay vì 'while'
                if (rs != null && rs.next()) {
                    // Đọc dữ liệu từ ResultSet
                    int staffId = rs.getInt("StaffID");
                    String fullName = rs.getString("FullName");
                    String role = rs.getString("Role");
                    String username = rs.getString("Username");
                    String passwordHash = rs.getString("PasswordHash"); // Lấy mật khẩu đã hash
                    String phone = rs.getString("Phone");
                    String email = rs.getString("Email");

                    // Tạo đối tượng Staff
                    // (Thứ tự các tham số dựa theo hàm getAllStaff của bạn)
                    result = new Staff(staffId, fullName, username, passwordHash, phone, email, role);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console
        } finally {
            // Đóng tất cả tài nguyên để tránh rò rỉ (leak)
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result; // Trả về null nếu không tìm thấy hoặc có lỗi
    }

    public ArrayList<Staff> searchStaffByName(String searchName) {
        ArrayList<Staff> result = new ArrayList<>();

        // Câu SQL dùng LIKE để tìm kiếm gần đúng
        String sql = "SELECT [StaffID], [FullName], [Role], [Username], [PasswordHash], [Phone], [Email] "
                + "FROM [HotelManagement].[dbo].[STAFF] "
                + "WHERE [FullName] LIKE ?"; // Tìm theo FullName

        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                ps = cn.prepareStatement(sql);
                // Thiết lập tham số cho LIKE (tìm bất cứ đâu có chứa searchName)
                ps.setString(1, "%" + searchName + "%");

                rs = ps.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        // Đọc dữ liệu từ ResultSet
                        int staffId = rs.getInt("StaffID");
                        String fullName = rs.getString("FullName");
                        String role = rs.getString("Role");
                        String username = rs.getString("Username");
                        String passwordHash = rs.getString("PasswordHash");
                        String phone = rs.getString("Phone");
                        String email = rs.getString("Email");

                        // Tạo đối tượng Staff và thêm vào danh sách
                        Staff staff = new Staff(staffId, fullName, username, passwordHash, phone, email, role);
                        result.add(staff);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console
        } finally {
            // Đóng tất cả tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result; // Trả về danh sách (có thể rỗng nếu không tìm thấy)
    }
}

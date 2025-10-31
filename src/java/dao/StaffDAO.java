package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}

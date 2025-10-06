package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Staff;
import utils.DBUtils;

public class StaffDAO {

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
                String sql = "select *  from dbo.STAFF where Username=? OR Email=?";
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

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Optional;
import model.Staff;
import utils.DBUtils;

/**
 *
 * @author votra
 */
public class StaffDAO {

    public Staff getStaff(String username, String password) {

        Staff result = null;
        try {
            Connection cn = DBUtils.getConnection();//step 1
            if (cn != null) {
                //step 2
                String sql = "SELECT [StaffID]\n"
                        + "      ,[FullName]\n"
                        + "      ,[Role]\n"
                        + "      ,[Username]\n"
                        + "      ,[PasswordHash]\n"
                        + "      ,[Phone]\n"
                        + "      ,[Email]\n"
                        + "  FROM [HotelManagement].[dbo].[STAFF]"
                        + "  WHERE [Username] = ? AND [PasswordHash] = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement st = cn.prepareStatement(sql);//ho tro execute
                st.setString(1, username);
                st.setString(2, password);
                ResultSet table = st.executeQuery();
                //step 3
                if (table != null) {
                    while (table.next()) {//di qua dong mau xam
                        int staffId = table.getInt("StaffID");
                        String fullName = table.getString("FullName");
                        String role = table.getString("Role");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
                        String passwordHash = table.getString("PasswordHash");
                       
                        result = new Staff(staffId, fullName, role, username, password, phone, email);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
//    // ========= LẤY TẤT CẢ STAFF =========
//    public List<Staff> findAll() {
//        return query("SELECT * FROM STAFF");
//    }
//
//    // ========= TÌM STAFF THEO ID =========
//    public Optional<Staff> findById(int id) {
//        List<Staff> staffs = query("SELECT * FROM STAFF WHERE StaffID = ?", id);
//        return staffs.stream().findFirst();
//    }
//
//    // ========= TÌM STAFF THEO USERNAME =========
//    public Optional<Staff> findByUsername(String userName) {
//        List<Staff> staffs = query("SELECT * FROM STAFF WHERE UserName = ?", userName);
//        return staffs.stream().findFirst();
//    }
}

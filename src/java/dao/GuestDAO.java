/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import model.Guest;
import utils.DBUtils;

/**
 *
 * @author votra
 */
public class GuestDAO {

    public Guest getGuest(String username, String password) {

        Guest result = null;
        try {
            Connection cn = DBUtils.getConnection();//step 1
            if (cn != null) {
                //step 2
                String sql = "SELECT [GuestID]\n"
                        + "      ,[FullName]\n"
                        + "      ,[Phone]\n"
                        + "      ,[Email]\n"
                        + "      ,[Username]\n"
                        + "      ,[PasswordHash]\n"
                        + "      ,[Address]\n"
                        + "      ,[IDNumber]\n"
                        + "      ,[DateOfBirth]\n"
                        + "  FROM [HotelManagement].[dbo].[GUEST]\n"
                        + "  WHERE [FullName] = ? AND [PasswordHash] = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement st = cn.prepareStatement(sql);//ho tro execute
                st.setString(1, username);
                st.setString(2, password);
                ResultSet table = st.executeQuery();
                //step 3
                if (table != null) {
                    while (table.next()) {//di qua dong mau xam
                        int guestId = table.getInt("GuestID");
                        String fullName = table.getString("FullName");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
//                        String passwordHash = table.getString("PasswordHash");
                        String address = table.getString("Address");
                        String idNumber = table.getString("IDNumber");
                        Date dateOfBirth = table.getDate("DateOfBirth");
                        LocalDate dob = LocalDate.parse((CharSequence) dateOfBirth, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        result = new Guest(fullName, username, password, phone, email, address, idNumber, dob);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int createGuest(Guest guest) {
        int guestid = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO GUEST (FullName, Username, PasswordHash, Phone, Email, Address, IDNumber, DateOfBirth)\n"
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                PreparedStatement st = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                st.setString(1, guest.getFullname());
                st.setString(2, guest.getUsername());
                st.setString(3, guest.getPasswordHash());
                st.setString(4, guest.getPhone());
                st.setString(5, guest.getEmail());
                st.setString(6, guest.getAddress());
                st.setString(7, guest.getIdNumber());
                if (guest.getDateOfBirth() != null) {
                    st.setDate(8, java.sql.Date.valueOf(guest.getDateOfBirth()));
                } else {
                    st.setNull(8, java.sql.Types.DATE);
                }
                int result = st.executeUpdate();
                if (result > 0) {
                    ResultSet table = st.getGeneratedKeys();
                    if (table != null && table.next()) {
                        guestid = table.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                cn.setAutoCommit(true);
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return guestid;
    }

}

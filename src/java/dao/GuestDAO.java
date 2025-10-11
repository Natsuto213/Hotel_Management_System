/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import model.Guest;
import utils.DBUtils;

/**
 *
 * @author votra
 */
public class GuestDAO {

//    public Guest getAllGuest() {
//
//        ArrayList<Guest> list = new ArrayList<>();
//        try {
//            Connection cn = DBUtils.getConnection();//step 1
//            if (cn != null) {
//                //step 2
//                String sql = "SELECT [GuestID]\n"
//                        + "      ,[FullName]\n"
//                        + "      ,[Phone]\n"
//                        + "      ,[Email]\n"
//                        + "      ,[PasswordHash]\n"
//                        + "      ,[Address]\n"
//                        + "      ,[IDNumber]\n"
//                        + "      ,[DateOfBirth]\n"
//                        + "  FROM [HotelManagement].[dbo].[GUEST]";
//                PreparedStatement st = cn.prepareStatement(sql);//ho tro execute
//                ResultSet table = st.executeQuery();
//                //step 3
//                if (table != null) {
//                    while (table.next()) {//di qua dong mau xam
//                        int staffid = table.getInt("StaffID");
//                        String fullname = table.getString("FullName");
//                        String role = table.getString("Role");
////                        String username = table.getString("Username");
////                        String password = table.getString("PasswordHash");
//                        String phone = table.getString("Phone");
//                        String email = table.getString("Email");
//
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return list;
//    }
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
                        + "      ,[Address]\n"
                        + "      ,[IDNumber]\n"
                        + "      ,[DateOfBirth]\n"
                        + "  FROM [HotelManagement].[dbo].[GUEST]\n"
                        + "  WHERE [FullName] = ? AND [Email] = ?";
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
                        String address = table.getString("Address");
                        String idNumber = table.getString("IDNumber");
                        Date dobTemp = table.getDate("DateOfBirth");
                        LocalDate dob = dobTemp.toLocalDate();
                        result = new Guest(guestId, fullName, username, password, phone, email, address, idNumber, dob);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int createGuest(Guest guest) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO GUEST (FullName, Username, PasswordHash, Phone, Email, Address, IDNumber, DateOfBirth)\n"
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, guest.getFullname());
                st.setString(2, guest.getUsername());
                st.setString(3, guest.getPasswordHash());
                st.setString(4, guest.getPhone());
                st.setString(5, guest.getEmail());
                st.setString(6, guest.getAddress());
                st.setString(7, guest.getIdNumber());
                st.setDate(8, java.sql.Date.valueOf(guest.getDateOfBirth()));
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

}

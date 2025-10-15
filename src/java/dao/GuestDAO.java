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
import model.Guest;
import utils.DBUtils;

/**
 *
 * @author votra
 */
public class GuestDAO {

    public Guest getGuest(String username, String password) {
        Guest result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                //step 2
                String sql = "SELECT * \n"
                        + "FROM [HotelManagement].[dbo].[GUEST]\n"
                        + "WHERE [Username] = ? AND [PasswordHash] = ?";
                PreparedStatement st = cn.prepareStatement(sql);//ho tro execute
                st.setString(1, username);
                st.setString(2, password);
                ResultSet table = st.executeQuery();
                //step 3
                if (table != null) {
                    while (table.next()) {
                        int guestId = table.getInt("GuestID");
                        String fullName = table.getString("FullName");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
                        String address = table.getString("Address");
                        String idNumber = table.getString("IDNumber");
                        Date dateOfBirth = table.getDate("DateOfBirth");
                        LocalDate dob = null;
                        if (dateOfBirth != null) {
                            dob = dateOfBirth.toLocalDate();
                        }
                        result = new Guest(guestId, fullName, username, password, phone, email, address, idNumber, dob);
                    }
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

    public int createGuest(Guest guest) {
        int result = 0;
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
                result = st.executeUpdate();
                if (result > 0) {
                    ResultSet table = st.getGeneratedKeys();
                    if (table.next()) {
                        guest.setGuestId(table.getInt(1));
                    }
                }
                return result;
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

    public boolean checkDupplicate(String value) {
        boolean result = false; // khong dupplicate
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select * from dbo.GUEST where Username=? OR Email=? OR Phone = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, value);
                st.setString(2, value);
                st.setString(3, value);
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

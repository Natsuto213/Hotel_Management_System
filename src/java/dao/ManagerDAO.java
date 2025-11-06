/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Guest;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class ManagerDAO {

    public ArrayList<Guest> top10FrequentGuests() {
        ArrayList<Guest> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 10\n"
                        + "    g.GuestID,\n"
                        + "    g.FullName,\n"
                        + "    g.Email,\n"
                        + "	g.Phone,\n"
                        + "    COUNT(b.BookingID) AS [TotalBookings]\n"
                        + "FROM GUEST g\n"
                        + "JOIN BOOKING b ON g.GuestID = b.GuestID\n"
                        + "WHERE b.Status IN ('Completed', 'Checked-out')\n"
                        + "GROUP BY g.GuestID, g.FullName, g.Email, g.Phone\n"
                        + "ORDER BY [TotalBookings] DESC;";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int guestID = table.getInt("GuestID");
                        String fullname = table.getString("FullName");
                        String email = table.getString("Email");
                        String phone = table.getString("Phone");
                        int totalBooking = table.getInt("TotalBookings");
                        Guest guest = new Guest(guestID, fullname, phone, email, totalBooking);
                        result.add(guest);
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
}

package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import model.Booking;
import utils.DBUtils;

public class BookingDAO {

    public int createBooking(Booking booking) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "  INSERT INTO BOOKING ([GuestID], [RoomID], [CheckInDate], [CheckOutDate], [BookingDate], [Status])\n"
                        + "  VALUES (?, ?, ?, ?, ?);";
                PreparedStatement st = cn.prepareCall(sql);
                Date bookingdate = new Date(System.currentTimeMillis());
                st.setInt(1, booking.getGuestId());
                st.setInt(2, booking.getRoomId());
                st.setDate(3, java.sql.Date.valueOf(booking.getCheckInDate()));
                st.setDate(4, java.sql.Date.valueOf(booking.getCheckOutDate()));
                st.setDate(5, bookingdate);
                st.setString(6, booking.getStatus());
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

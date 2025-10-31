package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import model.BookingService;
import model.Service;
import utils.DBUtils;

public class BookingServiceDAO {

    public BookingService findBookingService(int bookingId, int serviceId, LocalDate bookingDate) {
        BookingService result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM BOOKING_SERVICE\n"
                        + "WHERE BookingID = ? AND ServiceID = ? AND ServiceDate = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingId);
                st.setInt(2, serviceId);
                st.setDate(3, java.sql.Date.valueOf(bookingDate));
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    int cartId = table.getInt("Booking_Service_ID");
                    int quantity = table.getInt("Quantity");
                    LocalDate serviceDate = table.getDate("ServiceDate").toLocalDate();
                    int status = table.getInt("Status");
                    result = new BookingService(cartId, bookingId, serviceId, quantity, serviceDate, status);
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

    public int addService(BookingService bs) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO BOOKING_SERVICE (BookingID, ServiceID, Quantity, ServiceDate, Status)\n"
                        + "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bs.getBookingid());
                st.setInt(2, bs.getServiceid());
                st.setInt(3, bs.getQuantity());
                st.setDate(4, java.sql.Date.valueOf(bs.getServicedate()));
                st.setInt(5, bs.getStatus());
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

    public int updateService(int quantity, int cartId) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE BOOKING_SERVICE\n"
                        + "SET Quantity = ?\n"
                        + "WHERE Booking_Service_ID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, quantity);
                st.setInt(2, cartId);
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

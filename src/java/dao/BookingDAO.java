package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import model.Booking;
import model.BookingDetail;
import utils.DBUtils;

public class BookingDAO {

    public int createBooking(Booking booking) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "  INSERT INTO BOOKING ([GuestID], [RoomID], [CheckInDate], [CheckOutDate], [BookingDate], [Status])\n"
                        + "  VALUES (?, ?, ?, ?, ?, ?);";
                PreparedStatement st = cn.prepareCall(sql);
                st.setInt(1, booking.getGuestId());
                st.setInt(2, booking.getRoomId());
                st.setDate(3, java.sql.Date.valueOf(booking.getCheckInDate()));
                st.setDate(4, java.sql.Date.valueOf(booking.getCheckOutDate()));
                st.setDate(5, java.sql.Date.valueOf(booking.getBookingDate()));
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

    public int removeBooking(int bookingID) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "DELETE FROM BOOKING \n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareCall(sql);
                st.setInt(1, bookingID);
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

    public int updateBooking(Booking b) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "  UPDATE BOOKING\n"
                        + "  SET RoomID = ?, CheckInDate = ?, CheckOutDate = ?\n"
                        + "  WHERE BookingID = ?";
                PreparedStatement st = cn.prepareCall(sql);
                st.setInt(1, b.getRoomId());
                st.setDate(2, java.sql.Date.valueOf(b.getCheckInDate()));
                st.setDate(3, java.sql.Date.valueOf(b.getCheckOutDate()));
                st.setInt(4, b.getBookingId());
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

    public ArrayList getBookings(int guestID) {
        ArrayList<BookingDetail> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT  b.BookingID, r.RoomID, r.RoomNumber, rt.TypeName, b.CheckInDate, b.CheckOutDate, b.BookingDate, b.Status\n"
                        + "FROM BOOKING b \n"
                        + "JOIN ROOM r on b.RoomID = r.RoomID\n"
                        + "JOIN ROOM_TYPE rt on r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE GuestID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, guestID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingId = table.getInt("BookingID");
                        int roomId = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        Date checkinDate = table.getDate("CheckInDate");
                        Date checkoutDate = table.getDate("CheckOutDate");
                        LocalDate checkin = checkinDate.toLocalDate();
                        LocalDate checkout = checkoutDate.toLocalDate();
                        String status = table.getString("Status");
                        BookingDetail booking = new BookingDetail(bookingId, roomId, roomNumber, roomType, checkin, checkout, status);
                        list.add(booking);
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
        return list;
    }

    public int checkInBooking(int bookingID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE BOOKING\n"
                        + "SET Status = 'Checked-in'\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
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

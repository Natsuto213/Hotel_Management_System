package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Booking;
import model.BookingDetail;
import utils.DBUtils;

public class BookingDAO {

    public Booking getBooking(int bookingid) {
        Booking result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * \n"
                        + "FROM BOOKING\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingid);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    int guestID = table.getInt("GuestID");
                    int roomID = table.getInt("RoomID");
                    LocalDateTime checkIn = table.getTimestamp("CheckInDate").toLocalDateTime();
                    LocalDateTime checkOut = table.getTimestamp("CheckOutDate").toLocalDateTime();
                    LocalDate bookingDate = table.getDate("BookingDate").toLocalDate();
                    String status = table.getString("Status");
                    result = new Booking(bookingid, guestID, roomID, checkIn, checkOut, bookingDate, status);
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

    public int createBooking(Booking booking, Connection cn) {
        int result = 0;
        try {
            if (cn != null) {
                String sql = "INSERT INTO BOOKING ([GuestID], [RoomID], [CheckInDate], [CheckOutDate], [BookingDate], [Status])\n"
                        + "  VALUES (?, ?, ?, ?, ?, ?);";
                PreparedStatement st = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                st.setInt(1, booking.getGuestId());
                st.setInt(2, booking.getRoomId());
                st.setTimestamp(3, java.sql.Timestamp.valueOf(booking.getCheckInDate()));
                st.setTimestamp(4, java.sql.Timestamp.valueOf(booking.getCheckOutDate()));
                st.setDate(5, java.sql.Date.valueOf(booking.getBookingDate()));
                st.setString(6, booking.getStatus());
                result = st.executeUpdate();
                if (result > 0) {
                    ResultSet table = st.getGeneratedKeys();
                    if (table.next()) {
                        booking.setBookingId(table.getInt(1));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public ArrayList<Booking> getBookingByCheckInCheckOut(LocalDateTime checkInDate, LocalDateTime checkOutDate) {
        ArrayList<Booking> result = new ArrayList<>();

        String sql = "SELECT [BookingID]\n"
                + "      ,[GuestID]\n"
                + "      ,[RoomID]\n"
                + "      ,[CheckInDate]\n"
                + "      ,[CheckOutDate]\n"
                + "      ,[BookingDate]\n"
                + "      ,[Status]\n"
                + "FROM [HotelManagement].[dbo].[BOOKING]\n"
                + "WHERE CheckInDate < ? AND CheckOutDate > ?";

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DBUtils.getConnection();
            pst = con.prepareStatement(sql);
            pst.setTimestamp(1, java.sql.Timestamp.valueOf(checkInDate));
            pst.setTimestamp(2, java.sql.Timestamp.valueOf(checkOutDate));
            rs = pst.executeQuery();

            if (rs != null) {
                while (rs.next()) {
                    int bookingId = rs.getInt("BookingID");
                    int guestId = rs.getInt("GuestID");
                    int roomId = rs.getInt("RoomID");
                    String status = rs.getString("Status");
                    LocalDateTime checkIn = rs.getObject("CheckInDate", LocalDateTime.class);
                    LocalDateTime checkOut = rs.getObject("CheckOutDate", LocalDateTime.class);
                    LocalDate bookingDate = rs.getObject("BookingDate", LocalDate.class);
                    if (checkIn.isBefore(checkOutDate) && checkOut.isAfter(checkInDate)) {
                        Booking bookingValid = new Booking();
                        bookingValid.setBookingId(bookingId);
                        bookingValid.setGuestId(guestId);
                        bookingValid.setRoomId(roomId);
                        bookingValid.setStatus(status);
                        bookingValid.setCheckInDate(checkIn);
                        bookingValid.setCheckOutDate(checkOut);
                        bookingValid.setBookingDate(bookingDate);
                        result.add(bookingValid);
                    }
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        ArrayList<Booking> result2 = new ArrayList<>();
        List<LocalDate> datesInRange = new ArrayList<>();

        LocalDate currentDate = checkInDate.toLocalDate();
        LocalDate endDate = checkOutDate.toLocalDate();

        while (!currentDate.isAfter(endDate)) {
            datesInRange.add(currentDate);
            currentDate = currentDate.plusDays(1);
        }

        for (Booking booking : result) {
            LocalDate bookingCheckInDate = booking.getCheckInDate().toLocalDate();
            LocalDate bookingCheckOutDate = booking.getCheckOutDate().toLocalDate();

            for (LocalDate date : datesInRange) {
                if ((date.isEqual(bookingCheckInDate) || date.isAfter(bookingCheckInDate))
                        && (date.isEqual(bookingCheckOutDate) || date.isBefore(bookingCheckOutDate))) {
                    result2.add(booking);
                    break;
                }
            }

        }
        return result2;
    }

    public int removeBooking(int bookingID) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE BOOKING\n"
                        + "SET Status = 'Canceled'\n"
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

    public int updateBooking(Booking b) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE BOOKING\n"
                        + "  SET RoomID = ?, CheckInDate = ?, CheckOutDate = ?\n"
                        + "  WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, b.getRoomId());
                st.setTimestamp(2, java.sql.Timestamp.valueOf(b.getCheckInDate()));
                st.setTimestamp(3, java.sql.Timestamp.valueOf(b.getCheckOutDate()));
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

    public int changeRoomID(int newRoomId, int bookingId) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE BOOKING\n"
                        + "SET RoomID = ?\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, newRoomId);
                st.setInt(2, bookingId);
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

    public int changeBookingStatus(String status, int bookingid) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE BOOKING\n"
                        + "SET Status = ?\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, status);
                st.setInt(2, bookingid);
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

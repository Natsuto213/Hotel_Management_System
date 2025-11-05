package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import model.BookingService;
import model.BookingServiceDetail;
import utils.DBUtils;

public class BookingServiceDAO {

    public ArrayList<BookingServiceDetail> getCart(int bookingId) {
        ArrayList<BookingServiceDetail> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT bs.Booking_Service_ID, s.ServiceID, s.ServiceName, s.ServiceType, bs.Quantity, bs.ServiceDate, s.Price\n"
                        + "FROM BOOKING_SERVICE bs \n"
                        + "JOIN SERVICE s on bs.ServiceID = s.ServiceID\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingId);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingServiceId = table.getInt("Booking_Service_ID");
                        int serviceId = table.getInt("ServiceID");
                        String ServiceName = table.getString("ServiceName");
                        String ServiceType = table.getString("ServiceType");
                        int quantity = table.getInt("Quantity");
                        LocalDate serviceDate = table.getDate("ServiceDate").toLocalDate();
                        double price = table.getDouble("Price");
                        BookingServiceDetail bsd = new BookingServiceDetail(bookingServiceId, serviceId, ServiceName, ServiceType, quantity, serviceDate, price);
                        result.add(bsd);
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

    public BookingService findBookingService(int bookingId, int serviceId, LocalDate serviceDate) {
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
                st.setDate(3, java.sql.Date.valueOf(serviceDate));
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    int cartId = table.getInt("Booking_Service_ID");
                    int quantity = table.getInt("Quantity");
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

    public int findBookingServiceID(int bookingId, int serviceId, LocalDate serviceDate) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT Booking_Service_ID\n"
                        + "FROM BOOKING_SERVICE\n"
                        + "WHERE BookingID = ? AND ServiceID = ? AND ServiceDate = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingId);
                st.setInt(2, serviceId);
                st.setDate(3, java.sql.Date.valueOf(serviceDate));
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getInt("Booking_Service_ID");
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

    public int addService(BookingService bs, Connection cn) {
        int result = 0;
        try {
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
        }
        return result;
    }

    public int addService2(BookingService bs) {
        Connection cn = null;
        int result = 0;
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

    public int deleteService(int serviceId, LocalDate serviceDate) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "DELETE FROM BOOKING_SERVICE\n"
                        + "WHERE ServiceID = ? AND ServiceDate = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, serviceId);
                st.setDate(2, java.sql.Date.valueOf(serviceDate));
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

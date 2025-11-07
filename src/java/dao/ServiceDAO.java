package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;
import utils.DBUtils;

public class ServiceDAO {

    public String getName(int id) {
        String result = "";
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT ServiceName\n"
                        + "FROM SERVICE\n"
                        + "WHERE ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getString("ServiceName");
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

    public double getPrice(int id) {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT Price\n"
                        + "FROM SERVICE\n"
                        + "WHERE ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("Price");
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

    public ArrayList getAllServices() {
        ArrayList<Service> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * "
                        + "FROM SERVICE";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceId = table.getInt("ServiceID");
                        String serviceName = table.getString("ServiceName");
                        String serviceType = table.getString("ServiceType");
                        double price = table.getDouble("Price");

                        Service service = new Service(serviceId, serviceName, serviceType, price);
                        result.add(service);
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

    public Service getServiceById(int serviceId) {
        Service result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM SERVICE\n"
                        + "WHERE ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, serviceId);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    String serviceName = table.getString("ServiceName");
                    String serviceType = table.getString("ServiceType");
                    double price = table.getDouble("Price");

                    result = new Service(serviceId, serviceName, serviceType, price);
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

    // STUDENT 3
    public List<Service> getTodayServices() throws SQLException, ClassNotFoundException {
        List<Service> list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        String sql = "SELECT bs.ServiceDate, g.FullName AS guestName, r.RoomNumber, s.ServiceName, bs.Quantity, "
                + "CASE WHEN bs.Status = 1 THEN 'Completed' ELSE 'Pending' END AS status "
                + "FROM BOOKING_SERVICE bs "
                + "JOIN BOOKING b ON bs.BookingID = b.BookingID "
                + "JOIN GUEST g ON b.GuestID = g.GuestID "
                + "JOIN ROOM r ON b.RoomID = r.RoomID "
                + "JOIN SERVICE s ON bs.ServiceID = s.ServiceID "
                + "WHERE CAST(bs.ServiceDate AS DATE) = CAST(GETDATE() AS DATE)";

        PreparedStatement pst = cn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            Service s = new Service();
            s.setServiceDate(rs.getDate("ServiceDate"));
            s.setGuestName(rs.getString("guestName"));
            s.setRoomNumber(rs.getString("RoomNumber"));
            s.setServicename(rs.getString("ServiceName"));
            s.setQuantity(rs.getInt("Quantity"));
            s.setStatus(rs.getString("status"));
            list.add(s);
        }

        rs.close();
        pst.close();
        cn.close();
        return list;
    }

    public List getPendingServices() throws SQLException, ClassNotFoundException {
        List list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        String sql = "SELECT bs.ServiceDate AS requestTime, g.FullName AS guestName, r.RoomNumber, s.ServiceName, bs.Quantity "
                + "FROM BOOKING_SERVICE bs "
                + "JOIN BOOKING b ON bs.BookingID = b.BookingID "
                + "JOIN GUEST g ON b.GuestID = g.GuestID "
                + "JOIN ROOM r ON b.RoomID = r.RoomID "
                + "JOIN SERVICE s ON bs.ServiceID = s.ServiceID "
                + "WHERE bs.Status = 0";

        PreparedStatement pst = cn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            Service s = new Service();
            s.setServiceDate(rs.getDate("requestTime"));
            s.setGuestName(rs.getString("guestName"));
            s.setRoomNumber(rs.getString("RoomNumber"));
            s.setServicename(rs.getString("ServiceName"));
            s.setQuantity(rs.getInt("Quantity"));
            list.add(s);
        }

        rs.close();
        pst.close();
        cn.close();
        return list;

    }

    public List<Object[]> getServiceByStaff() throws SQLException, ClassNotFoundException {
        List<Object[]> list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        String sql = "SELECT s.ServiceName, COUNT(*) AS totalCompleted, CAST(bs.ServiceDate AS DATE) AS date "
                + "FROM BOOKING_SERVICE bs "
                + "JOIN SERVICE s ON bs.ServiceID = s.ServiceID "
                + "WHERE bs.Status = 1 "
                + "GROUP BY s.ServiceName, CAST(bs.ServiceDate AS DATE)";

        PreparedStatement pst = cn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            list.add(new Object[]{
                rs.getString("ServiceName"),
                rs.getInt("totalCompleted"),
                rs.getDate("date")
            });
        }

        rs.close();
        pst.close();
        cn.close();
        return list;

    }

    public List<Object[]> getRevenueReport() throws SQLException, ClassNotFoundException {
        List<Object[]> list = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        String sql = "SELECT s.ServiceName, SUM(bs.Quantity) AS quantity, SUM(bs.Quantity * s.Price) AS totalRevenue, CAST(bs.ServiceDate AS DATE) AS period "
                + "FROM BOOKING_SERVICE bs "
                + "JOIN SERVICE s ON bs.ServiceID = s.ServiceID "
                + "WHERE bs.Status = 1 "
                + "GROUP BY s.ServiceName, CAST(bs.ServiceDate AS DATE)";

        PreparedStatement pst = cn.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            list.add(new Object[]{
                rs.getString("ServiceName"),
                rs.getInt("quantity"),
                rs.getDouble("totalRevenue"),
                rs.getDate("period")
            });
        }

        rs.close();
        pst.close();
        cn.close();
        return list;
    }
}

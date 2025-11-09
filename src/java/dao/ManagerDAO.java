/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import model.BookingServiceDetail;
import model.Guest;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class ManagerDAO {

    public double dailyRevenue(LocalDate date) {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT SUM(Amount) AS [DailyRevenue]\n"
                        + "FROM PAYMENT\n"
                        + "WHERE CAST(PaymentDate AS DATE) = ?\n"
                        + "GROUP BY CAST(PaymentDate AS DATE)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setDate(1, java.sql.Date.valueOf(date));
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("DailyRevenue");
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

    public double monthlyRevenue(LocalDate date) {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT SUM(Amount) AS [MonthlyRevenue]\n"
                        + "FROM PAYMENT\n"
                        + "WHERE YEAR(PaymentDate) = ?\n"
                        + "    AND MONTH(PaymentDate) = ?;";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, date.getYear());
                st.setInt(2, date.getMonthValue());
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("MonthlyRevenue");
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

    public double yearlyRevenue(int year) {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT SUM(Amount) AS [YearlyRevenue]\n"
                        + "FROM PAYMENT\n"
                        + "WHERE YEAR(PaymentDate) = ?;";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, year);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("YearlyRevenue");
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

    public ArrayList<BookingServiceDetail> mostUsedService() {
        ArrayList<BookingServiceDetail> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 10\n"
                        + "    s.ServiceID,\n"
                        + "    s.ServiceName,\n"
                        + "    s.ServiceType,\n"
                        + "    SUM(bs.Quantity) AS [TotalUsed]\n"
                        + "FROM SERVICE s\n"
                        + "JOIN BOOKING_SERVICE bs ON s.ServiceID = bs.ServiceID\n"
                        + "GROUP BY s.ServiceID, s.ServiceName, s.ServiceType\n"
                        + "ORDER BY [TotalUsed] DESC;";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceID = table.getInt("ServiceID");
                        String serviceName = table.getString("ServiceName");
                        String serviceType = table.getString("ServiceType");
                        int totalUsed = table.getInt("TotalUsed");
                        BookingServiceDetail item = new BookingServiceDetail(serviceID, serviceName, serviceType, totalUsed);
                        result.add(item);
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

    public double roomOccupancyRate() {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "WITH OccupiedDays AS (\n"
                        + "    SELECT \n"
                        + "        YEAR(CheckInDate) AS [Year],\n"
                        + "        MONTH(CheckInDate) AS [Month],\n"
                        + "        SUM(DATEDIFF(DAY, CheckInDate, CheckOutDate)) AS [TotalOccupiedDays]\n"
                        + "    FROM BOOKING\n"
                        + "    WHERE Status IN ('Checked-in', 'Checked-out', 'Completed')\n"
                        + "    GROUP BY YEAR(CheckInDate), MONTH(CheckInDate)\n"
                        + "),\n"
                        + "TotalRooms AS (\n"
                        + "    SELECT COUNT(*) AS [TotalRooms] FROM ROOM\n"
                        + ")\n"
                        + "SELECT \n"
                        + "    CAST(\n"
                        + "        (1.0 * o.[TotalOccupiedDays]) / \n"
                        + "        (t.[TotalRooms] * DAY(EOMONTH(CONCAT(o.[Year], '-', o.[Month], '-01')))) * 100 \n"
                        + "        AS DECIMAL(5,2)\n"
                        + "    ) AS [OccupancyRatePercent]\n"
                        + "FROM OccupiedDays o\n"
                        + "CROSS JOIN TotalRooms t\n"
                        + "ORDER BY o.[Year], o.[Month];";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("OccupancyRatePercent");
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

    public double cancellationRate() {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "    COUNT(CASE WHEN Status = 'Canceled' THEN 1 END) * 100.0 / COUNT(*) AS [CancellationRate]\n"
                        + "FROM BOOKING\n"
                        + "GROUP BY YEAR(BookingDate), MONTH(BookingDate)";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("CancellationRate");
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

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import model.Room;
import utils.DBUtils;

public class RoomDAO {

    public Room getRoom(int id) {
        Room result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * \n"
                        + "FROM ROOM\n"
                        + "WHERE RoomID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    String roomNumber = table.getString("RoomNumber");
                    int roomTypeId = table.getInt("RoomTypeID");
                    String status = table.getString("Status");
                    result = new Room(id, roomNumber, roomTypeId, status);
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

    public ArrayList<Room> getAllRoom() {
        ArrayList<Room> result = new ArrayList<Room>();
        String sql = "SELECT [RoomID]\n"
                + "      ,[RoomNumber]\n"
                + "      ,[RoomTypeID]\n"
                + "      ,[Status]\n"
                + "  FROM [HotelManagement].[dbo].[ROOM]";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtils.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomTypeId(rs.getInt("RoomTypeID"));
                room.setStatus(rs.getString("Status"));

                result.add(room);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getAllRoom: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("General error in getAllRoom: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }

        return result;
    }

    public ArrayList<Room> getAvailableRooms(int roomTypeId, LocalDateTime checkInDate, LocalDateTime checkOutDate) {
        ArrayList<Room> result = new ArrayList<>();
        String sql = "SELECT r.RoomID, r.RoomNumber, r.RoomTypeID, r.Status\n"
                + "FROM ROOM r\n"
                + "JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                + "WHERE rt.RoomTypeID = ?\n"
                + "  AND r.RoomID NOT IN (\n"
                + "        SELECT b.RoomID\n"
                + "        FROM BOOKING b\n"
                + "        WHERE (b.CheckInDate < ?) AND (b.CheckOutDate > ?)\n"
                + "          AND b.Status IN ('Reserved', 'Checked-in')\n"
                + "    );";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtils.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, roomTypeId);
            ps.setTimestamp(2, java.sql.Timestamp.valueOf(checkOutDate));
            ps.setTimestamp(3, java.sql.Timestamp.valueOf(checkInDate));
            rs = ps.executeQuery();

            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setRoomTypeId(rs.getInt("RoomTypeID"));
                room.setStatus(rs.getString("Status"));

                result.add(room);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getAllRoom: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("General error in getAllRoom: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }

        return result;
    }

    public ArrayList<Room> getAvailableRoomsByType(String type, LocalDate checkIn, LocalDate checkOut) {
        ArrayList<Room> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT r.RoomID, r.RoomNumber\n"
                        + "  FROM ROOM r \n"
                        + "  JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "  WHERE rt.TypeName = ?"
                        + "  AND r.RoomID NOT IN (\n"
                        + "        SELECT b.RoomID\n"
                        + "        FROM BOOKING b\n"
                        + "        WHERE (b.CheckInDate < ?) AND (b.CheckOutDate > ?)\n"
                        + "    );";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, type);
                st.setDate(2, java.sql.Date.valueOf(checkOut));
                st.setDate(3, java.sql.Date.valueOf(checkIn));
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomId = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        Room room = new Room(roomId, roomNumber);
                        result.add(room);
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

    public int getAvailableRoomIdByType(String type, LocalDate checkIn, LocalDate checkOut) {
        Connection cn = null;
        int roomId = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 1 r.RoomID "
                        + "FROM ROOM r "
                        + "JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID "
                        + "WHERE rt.TypeName = ?"
                        + "  AND r.RoomID NOT IN (\n"
                        + "        SELECT b.RoomID\n"
                        + "        FROM BOOKING b\n"
                        + "        WHERE (b.CheckInDate < ?) AND (b.CheckOutDate > ?)\n"
                        + "    );";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, type);
                st.setDate(2, java.sql.Date.valueOf(checkOut));
                st.setDate(3, java.sql.Date.valueOf(checkIn));
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    roomId = table.getInt("RoomID");
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
        return roomId;
    }

    public int changeRoomStatus(String status, int roomId) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE ROOM SET Status = ? Where RoomID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, status);
                st.setInt(2, roomId);
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

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Room;
import utils.DBUtils;

public class RoomDAO {

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

    public int getAvailableRoomIdByType(String type) {
        Connection cn = null;
        int roomId = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 1 r.RoomID "
                        + "FROM ROOM r "
                        + "JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID "
                        + "WHERE rt.TypeName = ? AND r.Status = 'Available'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, type);
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
    
    public ArrayList<Room> getAvailableRoomsByType(String type) {
        ArrayList<Room> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "  SELECT r.RoomID, r.RoomNumber\n"
                        + "  FROM ROOM r \n"
                        + "  JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "  WHERE rt.TypeName = ? and r.Status = 'Available'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, type);
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
}

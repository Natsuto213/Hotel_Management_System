package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Room;
import utils.DBUtils;

public class RoomDAO {

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

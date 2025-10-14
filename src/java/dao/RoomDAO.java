package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DBUtils;

public class RoomDAO {

    public int getAvailableRoomIdByTypeId(int typeId) {
        Connection cn = null;
        int roomId = 0;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 1 r.RoomID "
                        + "FROM ROOM r "
                        + "JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID "
                        + "WHERE rt.RoomTypeID = ? AND r.Status = 'Available'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, typeId);
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

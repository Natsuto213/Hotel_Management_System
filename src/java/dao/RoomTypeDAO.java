/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.RoomType;
import utils.DBUtils;

/**
 *
 * @author votra
 */
public class RoomTypeDAO {

    public RoomType getRoomType(int roomid) {
        RoomType result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT rt.RoomTypeID, rt.TypeName, rt.Capacity, rt.PricePerNight\n"
                        + "FROM ROOM_TYPE rt \n"
                        + "JOIN ROOM r ON rt.RoomTypeID = r.RoomTypeID\n"
                        + "WHERE RoomID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, roomid);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    int roomTypeid = table.getInt("RoomTypeID");
                    String TypeName = table.getString("TypeName");
                    int capacity = table.getInt("Capacity");
                    double price = table.getDouble("Price");
                    result = new RoomType(roomTypeid, TypeName, capacity, price);
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

    public RoomType getRoomTypeById(int roomTypeId) {
        RoomType roomType = null;
        String sql = "SELECT [RoomTypeID]\n"
                + "      ,[TypeName]\n"
                + "      ,[Capacity]\n"
                + "      ,[PricePerNight]\n"
                + "  FROM [HotelManagement].[dbo].[ROOM_TYPE] WHERE [RoomTypeID] = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtils.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, roomTypeId);
            rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("RoomTypeID");
                String typeName = rs.getString("TypeName");
                int capacity = rs.getInt("Capacity");
                double pricePerNight = rs.getDouble("PricePerNight");
                roomType = new RoomType(id, typeName, capacity, pricePerNight);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getRoomTypeById: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("General error in getRoomTypeById: " + e.getMessage());
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

        return roomType;
    }

    public ArrayList<RoomType> getAllRoomType() {
        ArrayList<RoomType> result = new ArrayList<RoomType>();

        String sql = "SELECT [RoomTypeID]\n"
                + "      ,[TypeName]\n"
                + "      ,[Capacity]\n"
                + "      ,[PricePerNight]\n"
                + "  FROM [HotelManagement].[dbo].[ROOM_TYPE]";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtils.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("RoomTypeID");
                String typeName = rs.getString("TypeName");
                int capacity = rs.getInt("Capacity");
                double pricePerNight = rs.getDouble("PricePerNight");
                RoomType roomType = new RoomType(id, typeName, capacity, pricePerNight);

                result.add(roomType);
            }
        } catch (SQLException e) {
            System.err.println("Database error in getAllRoomType: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("General error in getAllRoomType: " + e.getMessage());
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
}

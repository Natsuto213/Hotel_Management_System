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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class HousekeepingDAO {

    public boolean updateRoomStatus(String roomNumber, String status, int staffId) {
        String sql = "UPDATE Room SET Status = ? WHERE RoomNumber = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, roomNumber);
            int rows = ps.executeUpdate();

            // Ghi log dọn phòng nếu trạng thái là "Clean"
            if (rows > 0 && status.equalsIgnoreCase("Clean")) {
                String logSQL = "INSERT INTO CleaningLog (RoomNumber, StaffId, CleaningDate, CleaningType, Status) VALUES (?, ?, GETDATE(), 'Regular', 'Completed')";
                try (PreparedStatement ps2 = conn.prepareStatement(logSQL)) {
                    ps2.setString(1, roomNumber);
                    ps2.setInt(2, staffId);
                    ps2.executeUpdate();
                }
            }

            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Map<String, Object>> getDailyCleaningReport() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT cl.CleaningDate, cl.RoomNumber, cl.CleaningType, s.FullName AS StaffName, cl.Status "
                   + "FROM CleaningLog cl JOIN Staff s ON cl.StaffId = s.StaffId "
                   + "WHERE CAST(cl.CleaningDate AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("date", rs.getString("CleaningDate"));
                row.put("room", rs.getString("RoomNumber"));
                row.put("type", rs.getString("CleaningType"));
                row.put("staff", rs.getString("StaffName"));
                row.put("status", rs.getString("Status"));
                list.add(row);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getPendingCleaningTasks() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT RoomNumber, Status, Priority, AssignedStaffId FROM CleaningTask WHERE Status = 'Pending'";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("room", rs.getString("RoomNumber"));
                row.put("status", rs.getString("Status"));
                row.put("priority", rs.getInt("Priority"));
                row.put("assigned", rs.getInt("AssignedStaffId"));
                list.add(row);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getRoomStatusReport() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.FullName AS StaffName, sl.ServiceName, COUNT(*) AS TotalCompleted, CAST(sl.ServiceDate AS DATE) AS Date " +
                     "FROM ServiceLog sl JOIN Staff s ON sl.StaffId = s.StaffId " +
                     "WHERE sl.Status = 'Completed' " +
                     "GROUP BY s.FullName, sl.ServiceName, CAST(sl.ServiceDate AS DATE)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("staff", rs.getString("StaffName"));
                row.put("service", rs.getString("ServiceName"));
                row.put("total", rs.getInt("TotalCompleted"));
                row.put("date", rs.getString("Date"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getMaintenanceIssues() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT RoomNumber, IssueDescription, ReportDate, Status, FixedBy FROM MaintenanceIssue";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("room", rs.getString("RoomNumber"));
                row.put("desc", rs.getString("IssueDescription"));
                row.put("date", rs.getString("ReportDate"));
                row.put("status", rs.getString("Status"));
                row.put("fixed", rs.getString("FixedBy"));
                list.add(row);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getStaffPerformance() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT s.FullName, COUNT(cl.RoomNumber) AS RoomsCleaned, "
                   + "SUM(CASE WHEN cl.CleaningType='Deep' THEN 1 ELSE 0 END) AS DeepCleanings, "
                   + "CAST(cl.CleaningDate AS DATE) AS Date "
                   + "FROM CleaningLog cl JOIN Staff s ON cl.StaffId = s.StaffId "
                   + "GROUP BY s.FullName, CAST(cl.CleaningDate AS DATE)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("staff", rs.getString("FullName"));
                row.put("rooms", rs.getInt("RoomsCleaned"));
                row.put("deep", rs.getInt("DeepCleanings"));
                row.put("date", rs.getString("Date"));
                list.add(row);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    

}

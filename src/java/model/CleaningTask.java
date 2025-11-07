/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class CleaningTask {
     private String roomNumber;
    private String staffName;
    private Timestamp assignedTime;
    private String status;

    public CleaningTask(String roomNumber, String staffName, Timestamp assignedTime, String status) {
        this.roomNumber = roomNumber;
        this.staffName = staffName;
        this.assignedTime = assignedTime;
        this.status = status;
    }

    public String getRoomNumber() { 
        return roomNumber; 
    }
    
    public String getStaffName() { 
        return staffName; 
    }
    
    public Timestamp getAssignedTime() { 
        return assignedTime; 
    }
    
    public String getStatus() { 
        return status; 
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class roomHousekeeping {

   private String roomNumber;
    private String roomType;
    private String status;
    private String cleanedBy;
    private Date lastCleaned;
    private String remarks;

    public roomHousekeeping() {}

    public roomHousekeeping(String roomNumber, String roomType, String status, String cleanedBy, Date lastCleaned, String remarks) {
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.status = status;
        this.cleanedBy = cleanedBy;
        this.lastCleaned = lastCleaned;
        this.remarks = remarks;
    }

    // Getter & Setter
    public String getRoomNumber() { 
        return roomNumber; 
    }
    
    public void setRoomNumber(String roomNumber) { 
        this.roomNumber = roomNumber; 
    }

    public String getRoomType() { 
        return roomType; 
    }
    
    public void setRoomType(String roomType) { 
        this.roomType = roomType; 
    }

    public String getStatus() { 
        return status; 
    }
    public void setStatus(String status) { 
        this.status = status; 
    }

    public String getCleanedBy() { 
        return cleanedBy; 
    }
    
    public void setCleanedBy(String cleanedBy) { 
        this.cleanedBy = cleanedBy; 
    }

    public Date getLastCleaned() { 
        return lastCleaned; 
    }
    
    public void setLastCleaned(Date lastCleaned) { 
        this.lastCleaned = lastCleaned; 
    }

    public String getRemarks() { 
        return remarks; 
    }
    
    public void setRemarks(String remarks) { 
        this.remarks = remarks; 
    }
}

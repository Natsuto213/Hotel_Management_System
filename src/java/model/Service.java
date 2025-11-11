package model;

import java.io.Serializable;
import java.sql.Date;
import java.text.DecimalFormat;

public class Service implements Serializable {

    private int serviceid;
    private String servicename;
    private String servicetype;
    private double price;

    private String guestName;
    private String roomNumber;
    private int quantity;
    private String status;
    private Date serviceDate;
    private String staffName;
    private String AssignedStaff;

    public Service() {
        this.serviceid = 0;
        this.servicename = "";
        this.servicetype = "";
        this.price = 0;
    }

    public Service(int serviceid, String servicename, String servicetype, double price) {
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.servicetype = servicetype;
        this.price = price;
    }

    public int getServiceid() {
        return serviceid;
    }

    public void setServiceid(int serviceid) {
        this.serviceid = serviceid;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public String getServicetype() {
        return servicetype;
    }

    public void setServicetype(String servicetype) {
        this.servicetype = servicetype;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getFormattedPrice() {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(this.price);
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
    
    public Date getServiceDate() {
        return serviceDate;
    }

    public void setServiceDate(Date serviceDate) {
        this.serviceDate = serviceDate;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getAssignedStaff() {
        return AssignedStaff;
    }

    public void setAssignedStaff(String AssignedStaff) {
        this.AssignedStaff = AssignedStaff;
    }
    
    

}

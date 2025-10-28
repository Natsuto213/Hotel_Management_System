
package model;

import java.io.Serializable;

public class Staff implements Serializable{

    private int staffID;
    private String fullname;
    private String username;
    private String passwordHash;
    private String phone;
    private String email;
    private String role;

    public Staff() {

    }

    public Staff(int staffID, String fullname, String username, String passwordHash, String phone, String email, String role) {
        this.staffID = staffID;
        this.fullname = fullname;
        this.username = username;
        this.passwordHash = passwordHash;
        this.phone = phone;
        this.email = email;
        this.role = role;
    }

    public Staff(String fullname, String username, String passwordHash, String phone, String email, String role) {
        this.fullname = fullname;
        this.username = username;
        this.passwordHash = passwordHash;
        this.phone = phone;
        this.email = email;
        this.role = role;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
}

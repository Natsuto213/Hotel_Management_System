/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author votra
 */
public class Guest {

    private int guestId;
    private String fullname;
    private String phone;
    private String email;
    private String passwordHash;
    private String address;
    private String idNumber;
    private Date dateOfBirth;

    public Guest() {
    }

    public Guest(int guestId, String fullname, String phone, String email, String passwordHash, String address, String idNumber, Date dateOfBirth) {
        this.guestId = guestId;
        this.fullname = fullname;
        this.phone = phone;
        this.email = email;
        this.passwordHash = passwordHash;
        this.address = address;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
    }

    public Guest(String fullname, String phone, String email, String address, String idNumber, Date dateOfBirth) {
        this.fullname = fullname;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
    }

    public int getGuestId() {
        return guestId;
    }

    public void setGuestId(int guestId) {
        this.guestId = guestId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullName) {
        this.fullname = fullName;
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

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passWordHash) {
        this.passwordHash = passWordHash;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

}

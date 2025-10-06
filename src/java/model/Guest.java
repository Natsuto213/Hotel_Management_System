/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author votra
 */
public class Guest {

    private int guestId;
    private String fullName;
    private String phone;
    private String email;
    private String passWordHash;
    private String address;
    private String idNumber;
    private Date dateOfBirth;

    public Guest() {
    }

    public Guest(int guestId, String fullName, String phone, String email, String passWordHash, String address, String idNumber, Date dateOfBirth) {
        this.guestId = guestId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.passWordHash = passWordHash;
        this.address = address;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
    }

    public Guest(String fullName, String phone, String email, String address, String idNumber, Date dateOfBirth) {
        this.fullName = fullName;
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public String getPassWordHash() {
        return passWordHash;
    }

    public void setPassWordHash(String passWordHash) {
        this.passWordHash = passWordHash;
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

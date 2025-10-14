/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author votra
 */
public class Guest {

    private int guestId;
    private String fullname;
    private String username;
    private String passwordHash;
    private String phone;
    private String email;
    private String address;
    private String idNumber;
    private LocalDate dateOfBirth;

    public Guest() {
    }

    public Guest(int guestId, String fullname, String username, String passwordHash, String phone, String email, String address, String idNumber, LocalDate dateOfBirth) {
        this.guestId = guestId;
        this.fullname = fullname;
        this.username = username;
        this.passwordHash = passwordHash;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
    }

    public Guest(String fullname, String username, String passwordHash, String phone, String email, String address, String idNumber, LocalDate dateOfBirth) {
        this.fullname = fullname;
        this.username = username;
        this.passwordHash = passwordHash;
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

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

}
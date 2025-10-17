package model;

import java.io.Serializable;
import java.time.LocalDate;

public class BookingDetail implements Serializable {

    private int bookingId;
    private int roomId;
    private String roomNumber;
    private String typeName;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private String status;

    public BookingDetail() {
    }

    public BookingDetail(int bookingId, int roomId, String roomNumber, String typeName, LocalDate checkInDate, LocalDate checkOutDate, String status) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.roomNumber = roomNumber;
        this.typeName = typeName;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public LocalDate getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDate checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDate getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDate checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   
}

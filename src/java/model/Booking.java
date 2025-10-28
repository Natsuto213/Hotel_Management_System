package model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Booking implements Serializable{

    private int bookingId;
    private int guestId;
    private int roomId;
    private LocalDateTime checkInDate;
    private LocalDateTime checkOutDate;
    private LocalDate BookingDate;
    private String status;

    public Booking() {
    }

    public Booking(int bookingId, int roomId, LocalDateTime checkInDate, LocalDateTime checkOutDate) {
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }
    
    public Booking(int bookingId, int guestId, int roomId, LocalDateTime checkInDate, LocalDateTime checkOutDate, LocalDate BookingDate, String status) {
        this.bookingId = bookingId;
        this.guestId = guestId;
        this.roomId = roomId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.BookingDate = BookingDate;
        this.status = status;
    }

    public Booking(int guestId, int roomId, LocalDateTime checkInDate, LocalDateTime checkOutDate, LocalDate bookingDate, String status) {
        this.guestId = guestId;
        this.roomId = roomId;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.BookingDate = bookingDate;
        this.status = status;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getGuestId() {
        return guestId;
    }

    public void setGuestId(int guestId) {
        this.guestId = guestId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public LocalDateTime getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDateTime checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDateTime getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDateTime checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public LocalDate getBookingDate() {
        return BookingDate;
    }

    public void setBookingDate(LocalDate BookingDate) {
        this.BookingDate = BookingDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

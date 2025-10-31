package model;

import java.io.Serializable;
import java.time.LocalDate;

public class BookingService implements Serializable {

    private int bookingserviceid;
    private int bookingid;
    private int serviceid;
    private int quantity;
    private LocalDate servicedate;
    private int status;

    public BookingService() {
        this.bookingserviceid = 0;
        this.bookingid = 0;
        this.serviceid = 0;
        this.quantity = 0;
        this.servicedate = LocalDate.now();
        this.status = 0;
    }

    public BookingService(int bookingid, int serviceid, int quantity, LocalDate servicedate, int status) {
        this.bookingid = bookingid;
        this.serviceid = serviceid;
        this.quantity = quantity;
        this.servicedate = servicedate;
        this.status = status;
    }
    
    public BookingService(int bookingserviceid, int bookingid, int serviceid, int quantity, LocalDate servicedate, int status) {
        this.bookingserviceid = bookingserviceid;
        this.bookingid = bookingid;
        this.serviceid = serviceid;
        this.quantity = quantity;
        this.servicedate = servicedate;
        this.status = status;
    }

    public int getBookingserviceid() {
        return bookingserviceid;
    }

    public void setBookingserviceid(int bookingserviceid) {
        this.bookingserviceid = bookingserviceid;
    }

    public int getBookingid() {
        return bookingid;
    }

    public void setBookingid(int bookingid) {
        this.bookingid = bookingid;
    }

    public int getServiceid() {
        return serviceid;
    }

    public void setServiceid(int serviceid) {
        this.serviceid = serviceid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDate getServicedate() {
        return servicedate;
    }

    public void setServicedate(LocalDate servicedate) {
        this.servicedate = servicedate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
    

}

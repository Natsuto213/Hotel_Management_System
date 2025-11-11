package model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.time.LocalDate;

public class BookingServiceDetail implements Serializable {

    private int bookingserviceid;
    private int bookingid;
    private int serviceid;

    private String servicename;
    private String servicetype;
    private int quantity;
    private LocalDate servicedate;
    private double price;

    private int status;
    private int totalUsed;

    public BookingServiceDetail() {

    }

    public BookingServiceDetail(int serviceid, String servicename, String servicetype, int totalUsed) {
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.servicetype = servicetype;
        this.totalUsed = totalUsed;
    }

    public BookingServiceDetail(int serviceid, String servicename, int quantity, LocalDate servicedate, double price) {
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.quantity = quantity;
        this.servicedate = servicedate;
        this.price = price;
    }

    public BookingServiceDetail(int bookingserviceid, int serviceid, String servicename, String servicetype, int quantity, LocalDate servicedate, double price, int status) {
        this.bookingserviceid = bookingserviceid;
        this.serviceid = serviceid;
        this.servicename = servicename;
        this.servicetype = servicetype;
        this.quantity = quantity;
        this.servicedate = servicedate;
        this.price = price;
        this.status = status;
    }

    public BookingServiceDetail(String servicename, String servicetype, int quantity, LocalDate servicedate, double price) {
        this.servicename = servicename;
        this.servicetype = servicetype;
        this.quantity = quantity;
        this.servicedate = servicedate;
        this.price = price;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getTotalUsed() {
        return totalUsed;
    }

    public void setTotalUsed(int totalUsed) {
        this.totalUsed = totalUsed;
    }

    public String getFormattedPrice() {
        DecimalFormat formatter = new DecimalFormat("#,###");
        return formatter.format(this.price);
    }
}

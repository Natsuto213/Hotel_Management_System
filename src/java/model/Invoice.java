package model;

import java.io.Serializable;
import java.time.LocalDate;

public class Invoice implements Serializable{

    private int invoiceId;
    private int bookingId;
    private LocalDate IssueDate;
    private int totalAmount;
    private String status;

    public Invoice() {
    }

    public Invoice(int bookingId, LocalDate IssueDate, int totalAmount, String status) {
        this.bookingId = bookingId;
        this.IssueDate = IssueDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public LocalDate getIssueDate() {
        return IssueDate;
    }

    public void setIssueDate(LocalDate IssueDate) {
        this.IssueDate = IssueDate;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}

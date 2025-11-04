package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import model.Invoice;

public class InvoiceDAO {

    public int addInvoice(Invoice invoice, Connection cn) {
        int result = 0;
        try {
            if (cn != null) {
                String sql = "INSERT INTO INVOICE(BookingID, IssueDate, TotalAmount, Status)\n"
                        + "VALUES (?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, invoice.getBookingId());
                st.setDate(2, java.sql.Date.valueOf(invoice.getIssueDate()));
                st.setDouble(3, invoice.getTotalAmount());
                st.setString(4, invoice.getStatus());
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}

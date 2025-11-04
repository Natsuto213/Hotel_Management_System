package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import model.Invoice;
import utils.DBUtils;

public class InvoiceDAO {

    public int addInvoice(Invoice invoice) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO INVOICE(BookingID, IssueDate, TotalAmount, Status)\n"
                        + "VALUE (?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, invoice.getBookingId());
                st.setDate(2, java.sql.Date.valueOf(invoice.getIssueDate()));
                st.setInt(3, invoice.getTotalAmount());
                st.setString(4, invoice.getStatus());
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}

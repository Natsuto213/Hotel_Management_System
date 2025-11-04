package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import model.Payment;
import utils.DBUtils;

public class PaymentDAO {
    
    public int addService(Payment payment) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO PAYMENT(BookingID, PaymentDate, Amount, PaymentMethod, Status)\n"
                        + "VALUE (?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, payment.getBookingId());
                st.setDate(2, java.sql.Date.valueOf(payment.getPaymentDate()));
                st.setInt(3, payment.getAmount());
                st.setString(4, payment.getPaymentMethod());
                st.setString(5, payment.getStatus());
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

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import model.Payment;

public class PaymentDAO {
    
    public int addService(Payment payment, Connection cn) {
        int result = 0;
        try {
            if (cn != null) {
                String sql = "INSERT INTO PAYMENT(BookingID, PaymentDate, Amount, PaymentMethod, Status)\n"
                        + "VALUES (?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, payment.getBookingId());
                st.setDate(2, java.sql.Date.valueOf(payment.getPaymentDate()));
                st.setDouble(3, payment.getAmount());
                st.setString(4, payment.getPaymentMethod());
                st.setString(5, payment.getStatus());
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}

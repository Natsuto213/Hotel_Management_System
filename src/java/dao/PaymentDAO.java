package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import model.Payment;
import utils.DBUtils;
import java.sql.ResultSet;
import java.time.LocalDate;

public class PaymentDAO {

    public Payment getPayment(int bookingid) {
        Payment result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM PAYMENT \n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingid);
                ResultSet table = st.executeQuery();
                if (table != null && table.next()) {
                    int paymentid = table.getInt("PaymentID");
                    LocalDate paymentDate = table.getDate("PaymentDate").toLocalDate();
                    double amount = table.getDouble("Amount");
                    String paymentMethod = table.getString("PaymentMethod");
                    String status = table.getString("Status");
                    result = new Payment(paymentid, bookingid, paymentDate, amount, paymentMethod, status);
                }
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

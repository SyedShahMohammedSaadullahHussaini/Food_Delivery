package com.foodexpress.updatedDAO;

import java.sql.*;
import com.foodexpress.updatedDTO.Payment;
import com.foodexpress.util.DBConnection;

public class PaymentDAO {

    // 1. Make Payment
    public boolean makePayment(Payment payment) {
        String sql = "INSERT INTO payment (order_id, payment_method, payment_status, amount_paid, transaction_time) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setString(3, payment.getPaymentStatus());
            ps.setBigDecimal(4, payment.getAmountPaid());
            ps.setTimestamp(5, payment.getTransactionTime() != null ? 
                                payment.getTransactionTime() : 
                                new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Get Payment by Order ID
    public Payment getPaymentByOrderId(int orderId) {
        String sql = "SELECT payment_id, order_id, payment_method, payment_status, amount_paid, transaction_time "
                   + "FROM payment WHERE order_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractPayment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Helper to map ResultSet to Payment object
    private Payment extractPayment(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setPaymentId(rs.getInt("payment_id"));
        p.setOrderId(rs.getInt("order_id"));
        p.setPaymentMethod(rs.getString("payment_method"));
        p.setPaymentStatus(rs.getString("payment_status"));
        p.setAmountPaid(rs.getBigDecimal("amount_paid"));
        p.setTransactionTime(rs.getTimestamp("transaction_time"));
        return p;
    }
}


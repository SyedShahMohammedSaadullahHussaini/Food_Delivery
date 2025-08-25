package com.foodexpress.updatedDAO;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.sql.Timestamp;

import com.foodexpress.updatedDTO.Delivery;
import com.foodexpress.util.DBConnection;

public class DeliveryDAO {

    // Assign a delivery
    public boolean assignDelivery(Delivery delivery) {
        String sql = "INSERT INTO delivery (order_id, delivery_person_name, delivery_person_phone, status, assigned_time) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, delivery.getOrderId());
            ps.setString(2, delivery.getDeliveryPersonName());
            ps.setString(3, delivery.getDeliveryPersonPhone());
            ps.setString(4, delivery.getStatus());
            ps.setTimestamp(5, Timestamp.valueOf(delivery.getAssignedTime()));

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update delivery status
    public boolean updateDeliveryStatus(int deliveryId, String status, LocalDateTime deliveredTime) {
        String sql = "UPDATE delivery SET status = ?, delivered_time = ? WHERE delivery_id = ?";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            if (deliveredTime != null) {
                ps.setTimestamp(2, Timestamp.valueOf(deliveredTime));
            } else {
                ps.setTimestamp(2, null);
            }
            ps.setInt(3, deliveryId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get delivery details by orderId
    public Delivery getDeliveryByOrderId(int orderId) {
        String sql = "SELECT * FROM delivery WHERE order_id = ?";
        Delivery delivery = null;

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                delivery = new Delivery();
                delivery.setDeliveryId(rs.getInt("delivery_id"));
                delivery.setOrderId(rs.getInt("order_id"));
                delivery.setDeliveryPersonName(rs.getString("delivery_person_name"));
                delivery.setDeliveryPersonPhone(rs.getString("delivery_person_phone"));
                delivery.setStatus(rs.getString("status"));
                delivery.setAssignedTime(rs.getTimestamp("assigned_time").toLocalDateTime());

                Timestamp deliveredTs = rs.getTimestamp("delivered_time");
                if (deliveredTs != null) {
                    delivery.setDeliveredTime(deliveredTs.toLocalDateTime());
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return delivery;
    }

    // Delete delivery by ID
    public boolean deleteDelivery(int deliveryId) {
        String sql = "DELETE FROM delivery WHERE delivery_id = ?";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, deliveryId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}


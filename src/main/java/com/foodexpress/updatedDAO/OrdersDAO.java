package com.foodexpress.updatedDAO;

import com.foodexpress.updatedDTO.Orders;
import com.foodexpress.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {

    // Insert new order
    public boolean addOrder(Orders order) {
        String sql = "INSERT INTO orders (uId, restaurant_id, total_amount, status, delivery_address_id) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            if (order.getuId() != null) {
                ps.setInt(1, order.getuId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }

            ps.setInt(2, order.getRestaurantId());
            ps.setBigDecimal(3, order.getTotalAmount());
            ps.setString(4, order.getStatus() != null ? order.getStatus() : "placed");

            if (order.getDeliveryAddressId() != null) {
                ps.setInt(5, order.getDeliveryAddressId());
            } else {
                ps.setNull(5, Types.INTEGER);
            }

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    order.setOrderId(rs.getInt(1));
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get order by ID
    public Orders getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Orders order = new Orders();
                order.setOrderId(rs.getInt("order_id"));
                order.setuId(rs.getObject("uId") != null ? rs.getInt("uId") : null);
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddressId(rs.getObject("delivery_address_id") != null ? rs.getInt("delivery_address_id") : null);
                order.setPlacedAt(rs.getTimestamp("placed_at").toLocalDateTime());
                order.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update order status
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all orders
    public List<Orders> getAllOrders() {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY placed_at DESC";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderId(rs.getInt("order_id"));
                order.setuId(rs.getObject("uId") != null ? rs.getInt("uId") : null);
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddressId(rs.getObject("delivery_address_id") != null ? rs.getInt("delivery_address_id") : null);
                order.setPlacedAt(rs.getTimestamp("placed_at").toLocalDateTime());
                order.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                list.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

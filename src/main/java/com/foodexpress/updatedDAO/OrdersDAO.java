package com.foodexpress.updatedDAO;

import com.foodexpress.updatedDTO.Orders;
import com.foodexpress.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {

    // Insert new order
    public boolean addOrder(Orders order) {
        String sql = "INSERT INTO orders (uId, restaurant_id, total_amount, order_status, payment_method, delivery_address) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getuId());
            ps.setInt(2, order.getRestaurantId());
            ps.setBigDecimal(3, order.getTotalAmount());
            ps.setString(4, order.getOrderStatus());
            ps.setString(5, order.getPaymentMethod());
            ps.setString(6, order.getDeliveryAddress());

            int rows = ps.executeUpdate();
            return rows > 0;

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
                order.setuId(rs.getInt("uId"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setOrderTime(rs.getTimestamp("order_time").toLocalDateTime());
                order.setDeliveryAddress(rs.getString("delivery_address"));
                return order;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update order status
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
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
        String sql = "SELECT * FROM orders ORDER BY order_time DESC";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderId(rs.getInt("order_id"));
                order.setuId(rs.getInt("uId"));
                order.setRestaurantId(rs.getInt("restaurant_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setOrderTime(rs.getTimestamp("order_time").toLocalDateTime());
                order.setDeliveryAddress(rs.getString("delivery_address"));
                list.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}


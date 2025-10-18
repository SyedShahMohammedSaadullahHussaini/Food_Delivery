package com.foodexpress.updatedDAO;

import com.foodexpress.updatedDTO.OrderItem;
import com.foodexpress.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {

    // Insert new order item
    public boolean addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_item (order_id, item_id, quantity, price_at_order) " +
                     "VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = VALUES(quantity), price_at_order = VALUES(price_at_order)";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getItemId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPriceAtOrder());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
 // Overloaded method for convenience
    public boolean addOrderItem(int orderId, OrderItem item) {
        item.setOrderId(orderId);
        return addOrderItem(item);
    }


    // Get items by order ID
    public List<OrderItem> getItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM order_item WHERE order_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderId(rs.getInt("order_id"));
                item.setItemId(rs.getInt("item_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPriceAtOrder(rs.getDouble("price_at_order"));
                list.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete all items for an order
    public boolean deleteItemsByOrderId(int orderId) {
        String sql = "DELETE FROM order_item WHERE order_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update item quantity (by order_id + item_id since composite PK)
    public boolean updateQuantity(int orderId, int itemId, int newQuantity) {
        String sql = "UPDATE order_item SET quantity = ? WHERE order_id = ? AND item_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newQuantity);
            ps.setInt(2, orderId);
            ps.setInt(3, itemId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

package com.foodexpress.updatedDAO;

import com.foodexpress.updatedDTO.OrderItem;
import com.foodexpress.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add/update cart item
    public boolean upsertCartItem(int uId, int restaurantId, OrderItem item) {
        String sql = "INSERT INTO cart_items (uId, restaurant_id, item_id, quantity, price_at_order) " +
                     "VALUES (?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = VALUES(quantity), price_at_order = VALUES(price_at_order)";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, uId);
            ps.setInt(2, restaurantId);
            ps.setInt(3, item.getItemId());
            ps.setInt(4, item.getQuantity());
            ps.setDouble(5, item.getPriceAtOrder());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Fetch cart items for user
    public List<OrderItem> getCartByUser(int uId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM cart_items WHERE uId = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, uId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderId(rs.getInt("cart_id")); // temp use
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

    // Delete one item
    public boolean deleteItem(int uId, int itemId) {
        String sql = "DELETE FROM cart_items WHERE uId = ? AND item_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, uId);
            ps.setInt(2, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Clear entire cart
    public boolean clearCart(int uId) {
        String sql = "DELETE FROM cart_items WHERE uId = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, uId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

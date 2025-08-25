package com.foodexpress.updatedDAO;

import java.sql.*;
import java.util.*;
import com.foodexpress.updatedDTO.MenuItems;
import com.foodexpress.util.DBConnection;

public class MenuDAO {

    // Add Menu Item
    public boolean addMenuItem(MenuItems item) {
        String sql = "INSERT INTO menu_item (restaurant_id, category_id, name, description, price, is_available, is_veg, image_url, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, item.getRestaurantId());
            ps.setInt(2, item.getCategoryId());
            ps.setString(3, item.getItemName());
            ps.setString(4, item.getDescription());
            ps.setBigDecimal(5, item.getPrice());
            ps.setBoolean(6, item.isAvailable());
            ps.setBoolean(7, item.isVeg());
            ps.setString(8, item.getImageUrl() != null ? item.getImageUrl() : "images/default-food.png");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get All Menu Items by Restaurant ID
    public List<MenuItems> getMenuByRestaurant(int restaurantId) {
        List<MenuItems> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_item WHERE restaurant_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractMenuItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Delete Menu Item by Item ID
    public boolean deleteMenuItem(int itemId) {
        String sql = "DELETE FROM menu_item WHERE item_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update Menu Item
    public boolean updateMenuItem(MenuItems item) {
        String sql = "UPDATE menu_item SET category_id = ?, name = ?, description = ?, price = ?, is_available = ?, is_veg = ?, image_url = ?, updated_at = NOW() WHERE item_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, item.getCategoryId());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setBigDecimal(4, item.getPrice());
            ps.setBoolean(5, item.isAvailable());
            ps.setBoolean(6, item.isVeg());
            ps.setString(7, item.getImageUrl() != null ? item.getImageUrl() : "images/default-food.png");
            ps.setInt(8, item.getItemId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Filter by Veg / Non-Veg
    public List<MenuItems> filterByVeg(boolean isVeg) {
        List<MenuItems> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_item WHERE is_veg = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setBoolean(1, isVeg);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractMenuItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper Method: Extract MenuItem from ResultSet
    private MenuItems extractMenuItem(ResultSet rs) throws SQLException {
        MenuItems item = new MenuItems();
        item.setItemId(rs.getInt("item_id"));
        item.setRestaurantId(rs.getInt("restaurant_id"));
        item.setCategoryId(rs.getInt("category_id"));
        item.setItemName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getBigDecimal("price"));
        item.setAvailable(rs.getBoolean("is_available"));
        item.setVeg(rs.getBoolean("is_veg"));
        item.setImageUrl(rs.getString("image_url"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        item.setUpdatedAt(rs.getTimestamp("updated_at"));
        return item;
    }
}

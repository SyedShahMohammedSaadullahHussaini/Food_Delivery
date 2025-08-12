package com.updatedDAO;



import java.sql.*;
import java.util.*;

import com.updatedDTO.MenuItems;
import com.util.DBConnection;

public class MenuDAO {

    // Add Menu Item
    public boolean addMenuItem(MenuItems item) {
        String sql = "INSERT INTO menu_items (restaurant_id, item_name, description, price, category, is_veg, rating) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, item.getRestaurantId());
            ps.setString(2, item.getItemName());
            ps.setString(3, item.getDescription());
            ps.setBigDecimal(4, item.getPrice());
            ps.setString(5, item.getCategory());
            ps.setBoolean(6, item.isVeg());
            ps.setBigDecimal(7, item.getRating());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get All Menu Items by Restaurant ID
    public List<MenuItems> getMenuByRestaurant(int restaurantId) {
        List<MenuItems> list = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE restaurant_id = ?";
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
        String sql = "DELETE FROM menu_items WHERE item_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Search by Food item or Restaurant name
    public List<MenuItems> searchItemsOrRestaurant(String keyword) {
        List<MenuItems> itemList = new ArrayList<>();
        String sql = "SELECT mi.* " +
                     "FROM menu_items mi " +
                     "JOIN restaurant r ON mi.restaurant_id = r.restaurant_id " +
                     "WHERE mi.item_name LIKE ? OR r.restaurant_name LIKE ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                itemList.add(extractMenuItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }

    // Search by category
    public List<MenuItems> filterByCategory(String category) {
        List<MenuItems> itemList = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE category = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                itemList.add(extractMenuItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }

    // Sorting the Items
    public List<MenuItems> sortItems(String criteria) {
        List<MenuItems> itemList = new ArrayList<>();
        String orderBy;
        switch (criteria.toLowerCase()) {
            case "price_asc": orderBy = "price ASC"; break;
            case "price_desc": orderBy = "price DESC"; break;
            case "rating_asc": orderBy = "rating ASC"; break;
            case "rating_desc": orderBy = "rating DESC"; break;
            default: orderBy = "item_name ASC";
        }
        String sql = "SELECT * FROM menu_items ORDER BY " + orderBy;
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                itemList.add(extractMenuItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }

    // Filter by Veg or Non-Veg
    public List<MenuItems> filterVegOrNonVeg(boolean isVeg) {
        List<MenuItems> itemList = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE is_veg = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setBoolean(1, isVeg);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                itemList.add(extractMenuItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }

    // Helper Method
    private MenuItems extractMenuItem(ResultSet rs) throws SQLException {
        MenuItems item = new MenuItems();
        item.setItemId(rs.getInt("item_id"));
        item.setRestaurantId(rs.getInt("restaurant_id"));
        item.setItemName(rs.getString("item_name"));
        item.setDescription(rs.getString("description"));
        item.setPrice(rs.getBigDecimal("price"));
        item.setCategory(rs.getString("category"));
        item.setVeg(rs.getBoolean("is_veg"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        item.setUpdatedAt(rs.getTimestamp("updated_at"));
        item.setRating(rs.getBigDecimal("rating"));
        return item;
    }
}


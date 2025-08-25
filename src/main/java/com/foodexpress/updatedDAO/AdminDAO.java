package com.foodexpress.updatedDAO;



import com.foodexpress.updatedDTO.Restaurant;
import com.foodexpress.updatedDTO.User;
import com.foodexpress.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setuId(rs.getInt("u_id"));
                u.setuName(rs.getString("u_name"));
                u.setuEmail(rs.getString("u_email"));
                u.setPassword(rs.getString("password"));
                u.setuPhone(rs.getString("u_phone"));
                u.setGender(rs.getString("gender"));
                u.setProfileImage(rs.getString("profile_image"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setUpdatedAt(rs.getTimestamp("updated_at"));
                u.setIsVerified(rs.getBoolean("is_verified"));
                u.setUserRole(rs.getString("user_role"));
                u.setStatus(rs.getString("status"));
                users.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Get all pending restaurants
    public List<Restaurant> getPendingRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE is_verified = false";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurantId(rs.getInt("restaurant_id"));
                r.setOwnerId(rs.getInt("owner_id"));
                r.setLocationId(rs.getObject("location_id") != null ? rs.getInt("location_id") : null);
                r.setRestaurantName(rs.getString("restaurant_name"));
                r.setAvgCostForTwo(rs.getBigDecimal("avg_cost_for_two"));
                r.setOpeningTime(rs.getTime("opening_time"));
                r.setClosingTime(rs.getTime("closing_time"));
                r.setStatus(rs.getString("status"));
                r.setLogo(rs.getString("logo"));
                r.setRating(rs.getBigDecimal("rating"));
                r.setVerified(rs.getBoolean("is_verified"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                r.setUpdatedAt(rs.getTimestamp("updated_at"));
                restaurants.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    // Approve a restaurant
    public boolean approveRestaurant(int restaurantId) {
        String sql = "UPDATE restaurants SET is_verified = true, status = 'active', updated_at = CURRENT_TIMESTAMP WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, restaurantId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Reject a restaurant
    public boolean rejectRestaurant(int restaurantId) {
        String sql = "UPDATE restaurants SET is_verified = false, status = 'rejected', updated_at = CURRENT_TIMESTAMP WHERE restaurant_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, restaurantId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Change user status (active/inactive/blocked)
    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE u_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

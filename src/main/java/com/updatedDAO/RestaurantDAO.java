package com.updatedDAO;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com. updatedDTO.Restaurant;
import com. util.DBConnection;

public class RestaurantDAO {

    // Add Restaurant
    public boolean addRestaurant(Restaurant r) {
        String iqry = "INSERT INTO restaurant (owner_id, location_id, restaurant_name, avg_cost_for_two, opening_time, closing_time, status, logo, rating, is_verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(iqry, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, r.getOwnerId()); // FK from users
            if (r.getLocationId() != null) {
                ps.setInt(2, r.getLocationId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            ps.setString(3, r.getRestaurantName());
            ps.setBigDecimal(4, r.getAvgCostForTwo());
            ps.setTime(5, r.getOpeningTime());
            ps.setTime(6, r.getClosingTime());
            ps.setString(7, r.getStatus());
            ps.setString(8, r.getLogo());
            ps.setBigDecimal(9, r.getRating());
            ps.setBoolean(10, r.isVerified());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Restaurant by ID
    public Restaurant getRestaurantById(int id) {
        String sqry = "SELECT * FROM restaurant WHERE restaurant_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sqry)) {
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractRestaurantFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update Restaurant
    public boolean updateRestaurant(Restaurant r) {
        String uqry = "UPDATE restaurant SET owner_id=?, location_id=?, restaurant_name=?, avg_cost_for_two=?, opening_time=?, closing_time=?, status=?, logo=?, rating=?, is_verified=? WHERE restaurant_id=?";

        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(uqry)) {

            ps.setInt(1, r.getOwnerId());
            if (r.getLocationId() != null) {
                ps.setInt(2, r.getLocationId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            ps.setString(3, r.getRestaurantName());
            ps.setBigDecimal(4, r.getAvgCostForTwo());
            ps.setTime(5, r.getOpeningTime());
            ps.setTime(6, r.getClosingTime());
            ps.setString(7, r.getStatus());
            ps.setString(8, r.getLogo());
            ps.setBigDecimal(9, r.getRating());
            ps.setBoolean(10, r.isVerified());
            ps.setInt(11, r.getRestaurantId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper
    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {
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
        return r;
    }
}


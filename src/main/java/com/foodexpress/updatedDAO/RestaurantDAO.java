package com.foodexpress.updatedDAO;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.foodexpress.updatedDTO.Restaurant;
import com.foodexpress.util.DBConnection;
import java.util.List;


public class RestaurantDAO {
	
	
	    public List<Restaurant> getAllRestaurants() {
	        List<Restaurant> restaurants = new ArrayList<>();
	        String sql = "SELECT r.*, rl.location_name, rl.address, rl.city, rl.pincode " +
	                     "FROM restaurant r " +
	                     "LEFT JOIN restaurant_location rl ON r.location_id = rl.location_id";

	        try (Connection conn = DBConnection.giveConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                Restaurant r = mapRestaurant(rs);
	                r.setCuisines(getCuisines(conn, r.getRestaurantId()));
	                restaurants.add(r);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return restaurants;
	    }

	    private Restaurant mapRestaurant(ResultSet rs) throws SQLException {
	        Restaurant r = new Restaurant();
	        // Core fields
	        r.setRestaurantId(rs.getInt("restaurant_id"));
	        r.setRestaurantName(rs.getString("restaurant_name"));
	        r.setLogo(rs.getString("logo"));
	        r.setRating(rs.getBigDecimal("rating"));
	        r.setAvgCostForTwo(rs.getBigDecimal("avg_cost_for_two"));
	        r.setOffer(rs.getString("offer"));
	        
	        
	        // Location fields
	        r.setLocationName(rs.getString("location_name"));
	        r.setCity(rs.getString("city"));
	        return r;
	    }

	    private List<String> getCuisines(Connection conn, int restaurantId) throws SQLException {
	        List<String> cuisines = new ArrayList<>();
	        String sql = "SELECT c.cuisine_name FROM cuisine c " +
	                     "JOIN restaurant_cuisine rc ON c.cuisine_id = rc.cuisine_id " +
	                     "WHERE rc.restaurant_id = ?";
	        
	        try (PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, restaurantId);
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                cuisines.add(rs.getString("cuisine_name"));
	            }
	        }
	        return cuisines;
	    }
	
	
	    
	  //Filter Restaurant by pure veg  
	    public List<Restaurant> getRestaurantsByVegOrNonVeg(String filter) {
	        List<Restaurant> restaurants = new ArrayList<>();
	        String sql = "SELECT r.*, rl.location_name, rl.address, rl.city, rl.pincode " +
	                     "FROM restaurant r " +
	                     "LEFT JOIN restaurant_location rl ON r.location_id = rl.location_id " +
	                     "WHERE r.veg_non_veg = '"+filter+"'";   

	        try (Connection conn = DBConnection.giveConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                Restaurant r = mapRestaurant(rs);
	                r.setCuisines(getCuisines(conn, r.getRestaurantId())); // fetch cuisines
	                restaurants.add(r);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return restaurants;
	    }

	//sorting Restaurant
	    public List<Restaurant> filterRestaurant(String sortBy) {
	        List<Restaurant> restaurants = new ArrayList<>();

	        String orderBy = "";
	        switch (sortBy) {
	            case "price_low":
	                orderBy = "ORDER BY r.avg_cost_for_two ASC";
	                break;
	            case "price_high":
	                orderBy = "ORDER BY r.avg_cost_for_two DESC";
	                break;
	            case "rating_high":
	                orderBy = "ORDER BY r.rating DESC";
	                break;
	            case "rating_low":
	                orderBy = "ORDER BY r.rating ASC";
	                break;
	            default:
	                orderBy = ""; // no sorting
	        }

	        String sql = "SELECT r.*, rl.location_name, rl.address, rl.city, rl.pincode " +
	                     "FROM restaurant r " +
	                     "LEFT JOIN restaurant_location rl ON r.location_id = rl.location_id " +
	                     orderBy;

	        try (Connection conn = DBConnection.giveConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                Restaurant r = mapRestaurant(rs);
	                r.setCuisines(getCuisines(conn, r.getRestaurantId()));
	                restaurants.add(r);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return restaurants;
	    }

	    
//****************************************************************************************************
	 // Combined Filter + Sort
//	    public List<Restaurant> getFilteredRestaurants(String sortBy, String filter, String cuisine) {
//	        List<Restaurant> restaurants = new ArrayList<>();
//
//	        // Base query
//	        StringBuilder sql = new StringBuilder(
//	            "SELECT r.*, rl.location_name, rl.address, rl.city, rl.pincode " +
//	            "FROM restaurant r " +
//	            "LEFT JOIN restaurant_location rl ON r.location_id = rl.location_id " +
//	            "LEFT JOIN restaurant_cuisine rc ON r.restaurant_id = rc.restaurant_id " +
//	            "LEFT JOIN cuisine c ON rc.cuisine_id = c.cuisine_id WHERE 1=1 "
//	        );
//
//	        // Apply Veg/Non-Veg filter
//	        if (filter != null && !filter.equalsIgnoreCase("all")) {
//	            sql.append(" AND r.veg_non_veg = ? "); // assuming restaurant table has 'type' column (veg/non-veg)
//	        }
//
//	        // Apply Cuisine filter
//	        if (cuisine != null && !cuisine.isEmpty()) {
//	            sql.append(" AND c.cuisine_name = ? ");
//	        }
//
//	        // Apply Sorting
//	        if (sortBy != null) {
//	            switch (sortBy) {
//	                case "price_low":
//	                    sql.append(" ORDER BY r.avg_cost_for_two ASC");
//	                    break;
//	                case "price_high":
//	                    sql.append(" ORDER BY r.avg_cost_for_two DESC");
//	                    break;
//	                case "rating_high":
//	                    sql.append(" ORDER BY r.rating DESC");
//	                    break;
//	                case "rating_low":
//	                    sql.append(" ORDER BY r.rating ASC");
//	                    break;
//	            }
//	        }
//
//	        try (Connection conn = DBConnection.giveConnection();
//	             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
//
//	            int index = 1;
//
//	            // Bind filter param
//	            if (filter != null && !filter.equalsIgnoreCase("all")) {
//	                ps.setString(index++, filter);
//	            }
//
//	            // Bind cuisine param
//	            if (cuisine != null && !cuisine.isEmpty()) {
//	                ps.setString(index++, cuisine);
//	            }
//
//	            ResultSet rs = ps.executeQuery();
//	            while (rs.next()) {
//	                Restaurant r = mapRestaurant(rs);
//	                r.setCuisines(getCuisines(conn, r.getRestaurantId()));
//	                restaurants.add(r);
//	            }
//
//	        } catch (SQLException e) {
//	            e.printStackTrace();
//	        }
//
//	        return restaurants;
//	    }
//*****************************************************************
	    
	 // Filtering + Sorting Restaurants
	    public List<Restaurant> getFilteredRestaurants(String sortBy, String filter, String cuisine) {
	        List<Restaurant> restaurants = new ArrayList<>();

	        StringBuilder sql = new StringBuilder(
	            "SELECT DISTINCT r.*, rl.location_name, rl.address, rl.city, rl.pincode " +
	            "FROM restaurant r " +
	            "LEFT JOIN restaurant_location rl ON r.location_id = rl.location_id " +
	            "LEFT JOIN restaurant_cuisine rc ON r.restaurant_id = rc.restaurant_id " +
	            "LEFT JOIN cuisine c ON rc.cuisine_id = c.cuisine_id " +
	            "WHERE 1=1 "
	        );

	        // Apply Veg / Non-Veg filter
	        if ("veg".equalsIgnoreCase(filter)) {
	            sql.append(" AND r.veg_non_veg = 'veg' ");
	        } else if ("non-veg".equalsIgnoreCase(filter)) {
	            sql.append(" AND r.veg_non_veg = 'non-veg' ");
	        } else if ("both".equalsIgnoreCase(filter)) {
	            sql.append(" AND r.veg_non_veg = 'both' ");
	        }

	        // Apply Cuisine filter
	        if (cuisine != null && !cuisine.isEmpty()) {
	            sql.append(" AND c.cuisine_name = ? ");
	        }

	        // Apply Sorting
	        if (sortBy != null) {
	            switch (sortBy) {
	                case "price_low":
	                    sql.append(" ORDER BY r.avg_cost_for_two ASC ");
	                    break;
	                case "price_high":
	                    sql.append(" ORDER BY r.avg_cost_for_two DESC ");
	                    break;
	                case "rating_high":
	                    sql.append(" ORDER BY r.rating DESC ");
	                    break;
	                case "rating_low":
	                    sql.append(" ORDER BY r.rating ASC ");
	                    break;
	                default:
	                    // No sorting
	                    break;
	            }
	        }

	        try (Connection conn = DBConnection.giveConnection();
	             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

	            int paramIndex = 1;
	            if (cuisine != null && !cuisine.isEmpty()) {
	                ps.setString(paramIndex++, cuisine);
	            }

	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                Restaurant r = mapRestaurant(rs);
	                r.setCuisines(getCuisines(conn, r.getRestaurantId()));
	                restaurants.add(r);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return restaurants;
	    }

	    
//*****************************************************************



    // Add Restaurant
    public boolean addRestaurant(Restaurant r) {
        String iqry = "INSERT INTO restaurant (owner_id, location_id, restaurant_name, avg_cost_for_two, opening_time, closing_time, status, logo, rating, is_verified,offer,veg_non_veg) VALUES (?,?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            ps.setString(11, r.getOffer());
            ps.setString(12, r.getVeg_non_veg());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Restaurant by ID
    public Restaurant getRestaurantById(int id) {
        String sqry = "SELECT r.*, rl.location_name, rl.address, rl.city, rl.pincode " +
                      "FROM restaurant r " +
                      "LEFT JOIN restaurant_location rl ON r.location_id = rl.location_id " +
                      "WHERE r.restaurant_id = ?";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sqry)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Restaurant r = extractRestaurantFromResultSet(rs); // reuse your method

                // Add location fields
                r.setLocationName(rs.getString("location_name"));
                r.setAddress(rs.getString("address"));
                r.setCity(rs.getString("city"));
                r.setPincode(rs.getString("pincode"));

                // Add cuisines
                r.setCuisines(getCuisines(conn, r.getRestaurantId()));

                return r;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }



    // Update Restaurant
    public boolean updateRestaurant(Restaurant r) {
        String uqry = "UPDATE restaurant SET owner_id=?, location_id=?, restaurant_name=?, avg_cost_for_two=?, opening_time=?, closing_time=?, status=?, logo=?, rating=?, is_verified=?,offer=?,veg_non_veg=? WHERE restaurant_id=?";

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
            ps.setString(11, r.getOffer());
            ps.setString(12, r.getVeg_non_veg());
            ps.setInt(13, r.getRestaurantId());

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
        r.setTelephone(rs.getString("tel_phone"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setUpdatedAt(rs.getTimestamp("updated_at"));
        r.setOffer(rs.getString("offer"));
        return r;
    }
}


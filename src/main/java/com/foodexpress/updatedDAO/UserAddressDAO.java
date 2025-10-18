package com.foodexpress.updatedDAO;

import com.foodexpress.updatedDTO.UserAddress;
import com.foodexpress.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserAddressDAO {

    // Insert new address
    public boolean addUserAddress(UserAddress address) throws SQLException {
        String sql = "INSERT INTO user_address (uid, label, address, city, pincode, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        	System.out.println("Entered adduserAdd method inside try");
            ps.setInt(1, address.getUid());
            ps.setString(2, address.getLabel());
            ps.setString(3, address.getAddress());
            ps.setString(4, address.getCity());
            ps.setString(5, address.getPincode());
            System.out.println("user address is saved");
            return ps.executeUpdate() > 0;
            
        }
    }

    // Get address by ID
    public UserAddress getAddressById(int addressId) throws SQLException {
        String sql = "SELECT * FROM user_address WHERE address_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserAddress(rs);
                }
            }
        }
        return null;
    }

    // Get all addresses of a user
    public List<UserAddress> getAddressesByUser(int uid) throws SQLException {
        List<UserAddress> list = new ArrayList<>();
        String sql = "SELECT * FROM user_address WHERE uid = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, uid);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(extractUserAddress(rs));
                }
            }
        }
        return list;
    }

    // Update an address
    public boolean updateUserAddress(UserAddress address) throws SQLException {
        String sql = "UPDATE user_address SET label = ?, address = ?, city = ?, pincode = ? WHERE address_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, address.getLabel());
            ps.setString(2, address.getAddress());
            ps.setString(3, address.getCity());
            ps.setString(4, address.getPincode());
            ps.setInt(5, address.getAddressId());
            return ps.executeUpdate() > 0;
        }
    }

    // Delete an address
    public boolean deleteUserAddress(int addressId) throws SQLException {
        String sql = "DELETE FROM user_address WHERE address_id = ?";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            return ps.executeUpdate() > 0;
        }
    }

    // Helper method
    private UserAddress extractUserAddress(ResultSet rs) throws SQLException {
        return new UserAddress(
                rs.getInt("address_id"),
                rs.getInt("uid"),
                rs.getString("label"),
                rs.getString("address"),
                rs.getString("city"),
                rs.getString("pincode"),
                rs.getTimestamp("created_at")
        );
    }
}

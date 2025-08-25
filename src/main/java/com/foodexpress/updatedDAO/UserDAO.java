package com.foodexpress.updatedDAO;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.foodexpress.updatedDTO.User;
import com.foodexpress.util.DBConnection;

public class UserDAO {

    // Insert into users table
    public boolean registerUser(User u) {
        String userQry = "INSERT INTO users (uName, uEmail, password, uPhone, gender, profile_image, user_role) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(userQry, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, u.getuName());
            ps.setString(2, u.getuEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getuPhone());
            ps.setString(5, u.getGender());
            ps.setString(6, u.getProfileImage());
            ps.setString(7, u.getUserRole());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                // get generated userId
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    int userId = rs.getInt(1);

                    // if address is provided, insert into user_address
                    if (u.getAddress() != null && u.getCity() != null && u.getPincode() != null) {
                        insertUserAddress(userId, u.getAddressLabel(), u.getAddress(), u.getCity(), u.getPincode());
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Insert into user_address table
    private void insertUserAddress(int userId, String label, String address, String city, String pincode) {
        String addrQry = "INSERT INTO user_address (uId, label, address, city, pincode) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.giveConnection();
             PreparedStatement ps = conn.prepareStatement(addrQry)) {

            ps.setInt(1, userId);
            ps.setString(2, label);
            ps.setString(3, address);
            ps.setString(4, city);
            ps.setString(5, pincode);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // User Login
    public User validateUser(String uEmail, String password) {
        String sqry = "SELECT * FROM users WHERE uEmail = ? AND password = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sqry)) {
            ps.setString(1, uEmail);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get user by ID
    public User getUserById(int userId) {
        String sqry = "SELECT * FROM users WHERE uId = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sqry)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next())
                return extractUserFromResultSet(rs);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update user basic info (not address)
    public boolean updateUser(User user) {
        String uqry = "UPDATE users SET uName = ?, uEmail = ?, uPhone = ?, gender = ?, profile_image = ?, status = ?, is_verified = ? WHERE uId = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(uqry)) {

            ps.setString(1, user.getuName());
            ps.setString(2, user.getuEmail());
            ps.setString(3, user.getuPhone());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getProfileImage());
            ps.setString(6, user.getStatus());
            ps.setBoolean(7, user.getIsVerified());
            ps.setInt(8, user.getuId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Helper method
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setuId(rs.getInt("uId"));
        user.setuName(rs.getString("uName"));
        user.setuEmail(rs.getString("uEmail"));
        user.setPassword(rs.getString("password"));
        user.setuPhone(rs.getString("uPhone"));
        user.setGender(rs.getString("gender"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        user.setIsVerified(rs.getBoolean("is_verified"));
        user.setUserRole(rs.getString("user_role"));
        user.setStatus(rs.getString("status"));
        return user;
    }
}

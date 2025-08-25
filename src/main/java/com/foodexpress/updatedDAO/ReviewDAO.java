package com.foodexpress.updatedDAO;



import java.util.List;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.foodexpress.updatedDTO.Review;
import com.foodexpress.util.DBConnection;

public class ReviewDAO {

    // 1. Insert Review
    public boolean addReview(Review r) {
        String sql = "INSERT INTO review (uId, item_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, r.getuId());
            ps.setInt(2, r.getItemId());
            ps.setBigDecimal(3, r.getRating());
            ps.setString(4, r.getComment());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Get Average Rating for an Item
    public BigDecimal getAverageRating(int itemId) {
        String sql = "SELECT AVG(rating) AS avg_rating FROM review WHERE item_id = ?";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("avg_rating") != null ? rs.getBigDecimal("avg_rating") : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    // 3. Get All Reviews for an Item
    public List<Review> getReviewsByItem(int itemId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM review WHERE item_id = ? ORDER BY review_time DESC";
        try (PreparedStatement ps = DBConnection.giveConnection().prepareStatement(sql)) {
            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reviews.add(extractReview(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Helper to Map ResultSet → Review Object
    private Review extractReview(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setReviewId(rs.getInt("review_id"));
        r.setuId(rs.getInt("uId"));
        r.setItemId(rs.getInt("item_id"));
        r.setRating(rs.getBigDecimal("rating"));
        r.setComment(rs.getString("comment"));
        r.setReview_time(rs.getTimestamp("review_time"));
        return r;
    }
}


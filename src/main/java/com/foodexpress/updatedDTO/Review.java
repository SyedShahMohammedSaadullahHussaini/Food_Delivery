package com.foodexpress.updatedDTO;



import java.math.BigDecimal;
import java.sql.Timestamp;

public class Review {

    private int reviewId;
    private int uId; // User ID (FK to users table)
    private int itemId; // FK to items table
    private BigDecimal rating;
    private String comment;
    private Timestamp review_time;

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getuId() {
        return uId;
    }
    public void setuId(int uId) {
        this.uId = uId;
    }

    public int getItemId() {
        return itemId;
    }
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public BigDecimal getRating() {
        return rating;
    }
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getReview_time() {
        return review_time;
    }
    public void setReview_time(Timestamp review_time) {
        this.review_time = review_time;
    }
}


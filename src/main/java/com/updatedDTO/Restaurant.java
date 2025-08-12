package com.updatedDTO;



import java.math.BigDecimal;
import java.sql.Time;
import java.sql.Timestamp;

public class Restaurant {

    private Integer restaurantId;
    private Integer ownerId;
    private Integer locationId; // nullable
    private String restaurantName;
    private BigDecimal avgCostForTwo;
    private Time openingTime;
    private Time closingTime;
    private String status;
    private String logo;
    private BigDecimal rating;
    private boolean isVerified;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Getters and Setters
    public Integer getRestaurantId() {
        return restaurantId;
    }
    public void setRestaurantId(Integer restaurantId) {
        this.restaurantId = restaurantId;
    }
    public Integer getOwnerId() {
        return ownerId;
    }
    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }
    public Integer getLocationId() {
        return locationId;
    }
    public void setLocationId(Integer locationId) {
        this.locationId = locationId;
    }
    public String getRestaurantName() {
        return restaurantName;
    }
    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }
    public BigDecimal getAvgCostForTwo() {
        return avgCostForTwo;
    }
    public void setAvgCostForTwo(BigDecimal avgCostForTwo) {
        this.avgCostForTwo = avgCostForTwo;
    }
    public Time getOpeningTime() {
        return openingTime;
    }
    public void setOpeningTime(Time openingTime) {
        this.openingTime = openingTime;
    }
    public Time getClosingTime() {
        return closingTime;
    }
    public void setClosingTime(Time closingTime) {
        this.closingTime = closingTime;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getLogo() {
        return logo;
    }
    public void setLogo(String logo) {
        this.logo = logo;
    }
    public BigDecimal getRating() {
        return rating;
    }
    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }
    public boolean isVerified() {
        return isVerified;
    }
    public void setVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}

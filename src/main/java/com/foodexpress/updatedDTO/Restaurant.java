package com.foodexpress.updatedDTO;

import java.math.BigDecimal;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

public class Restaurant {
    // Core database fields
    private Integer restaurantId;
    private Integer ownerId;
    private Integer locationId;
    private String restaurantName;
    private String telephone;
    private BigDecimal avgCostForTwo;
    private Time openingTime;
    private Time closingTime;
    private String status;
    private String logo;
    private BigDecimal rating;
    private boolean isVerified;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String veg_non_veg;
    private String offer;
    
   
	// Additional fields from joins
    private List<String> cuisines;
    private String locationName;
    private String address;
    private String city;
    private String pincode;
    
    // UI-specific fields
    private boolean promoted = false; // Default value
    private String deliveryTime = "30-45 mins"; // Default value
    
    
    
    // Standard getters/setters (omitted for brevity but MUST include all)
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
	public String getVeg_non_veg() {
		return veg_non_veg;
	}
	public void setVeg_non_veg(String veg_non_veg) {
		this.veg_non_veg = veg_non_veg;
	}
	public String getRestaurantName() {
		return restaurantName;
	}
	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
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
	public List<String> getCuisines() {
		return cuisines;
	}
	public void setCuisines(List<String> cuisines) {
		this.cuisines = cuisines;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getPincode() {
		return pincode;
	}
	public void setPincode(String pincode) {
		this.pincode = pincode;
	}
	public String getOffer() {
		return offer;
	}
	public void setOffer(String offer) {
		this.offer = offer;
	}
	public boolean isPromoted() {
		return promoted;
	}
	public void setPromoted(boolean promoted) {
		this.promoted = promoted;
	}
	public String getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

   
   
	
	 // JSP-specific getters
    public String getName() { return restaurantName; }
    public String getImageUrl() { return logo; }
    public String getTime() { return deliveryTime; }
    public String getPrice() { return "₹" + avgCostForTwo + " for two"; }
    public String getCuisine() { return cuisines != null ? String.join(", ", cuisines) : "Multi-cuisine"; }
    
    
//    public boolean isPromoted() { return promoted; }
//    public String getOffer() { return offer; }
   
   
}
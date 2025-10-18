package com.foodexpress.updatedDTO;

import java.util.Date;

public class UserAddress {
    private int addressId;
    private int uid;             // foreign key (user id)
    private String label;        // e.g. "Home", "Office"
    private String address;      // full address text
    private String city;
    private String pincode;
    private Date createdAt;

    // Constructors
    public UserAddress() {}

    public UserAddress(int addressId, int uid, String label, String address, String city, String pincode, Date createdAt) {
        this.addressId = addressId;
        this.uid = uid;
        this.label = label;
        this.address = address;
        this.city = city;
        this.pincode = pincode;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}

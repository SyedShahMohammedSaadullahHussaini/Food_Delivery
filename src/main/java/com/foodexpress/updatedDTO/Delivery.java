package com.foodexpress.updatedDTO;



import java.time.LocalDateTime;

public class Delivery {
    private int deliveryId;
    private int orderId;
    private String deliveryPersonName;
    private String deliveryPersonPhone;
    private String status; // assigned, picked_up, on_the_way, delivered, failed
    private LocalDateTime assignedTime;
    private LocalDateTime deliveredTime;

    public Delivery() {
    }

    public Delivery(int deliveryId, int orderId, String deliveryPersonName, String deliveryPersonPhone, String status,
                    LocalDateTime assignedTime, LocalDateTime deliveredTime) {
        this.deliveryId = deliveryId;
        this.orderId = orderId;
        this.deliveryPersonName = deliveryPersonName;
        this.deliveryPersonPhone = deliveryPersonPhone;
        this.status = status;
        this.assignedTime = assignedTime;
        this.deliveredTime = deliveredTime;
    }

    public int getDeliveryId() {
        return deliveryId;
    }

    public void setDeliveryId(int deliveryId) {
        this.deliveryId = deliveryId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getDeliveryPersonName() {
        return deliveryPersonName;
    }

    public void setDeliveryPersonName(String deliveryPersonName) {
        this.deliveryPersonName = deliveryPersonName;
    }

    public String getDeliveryPersonPhone() {
        return deliveryPersonPhone;
    }

    public void setDeliveryPersonPhone(String deliveryPersonPhone) {
        this.deliveryPersonPhone = deliveryPersonPhone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getAssignedTime() {
        return assignedTime;
    }

    public void setAssignedTime(LocalDateTime assignedTime) {
        this.assignedTime = assignedTime;
    }

    public LocalDateTime getDeliveredTime() {
        return deliveredTime;
    }

    public void setDeliveredTime(LocalDateTime deliveredTime) {
        this.deliveredTime = deliveredTime;
    }

   
    
}


package com.foodexpress.updatedDTO;

import java.math.BigDecimal;

public class OrderItem {
    private int orderItemId;     // order_item_id (PK)
    private int orderId;         // FK to orders
    private int itemId;          // FK to menu_item
    private int quantity;        // quantity
    private BigDecimal priceAtOrder; // price_at_order

    // Getters and Setters
    public int getOrderItemId() {
        return orderItemId;
    }
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getItemId() {
        return itemId;
    }
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPriceAtOrder() {
        return priceAtOrder;
    }
    public void setPriceAtOrder(BigDecimal priceAtOrder) {
        this.priceAtOrder = priceAtOrder;
    }
}

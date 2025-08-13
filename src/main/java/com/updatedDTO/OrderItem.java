package com.updatedDTO;
import java.math.BigDecimal;

public class OrderItem {
    private int itemId;
    private int orderId;
    private int menuItemId;
    private int quantity;
    private BigDecimal price;

    // Getters and Setters
    public int getItemId() {
        return itemId;
    }
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getMenuItemId() {
        return menuItemId;
    }
    public void setMenuItemId(int menuItemId) {
        this.menuItemId = menuItemId;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public BigDecimal getPrice() {
        return price;
    }
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}


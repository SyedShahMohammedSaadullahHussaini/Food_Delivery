package com.foodexpress.updatedDTO;



public class OrderItem {
    private int orderItemId;     // order_item_id (PK)
    private int orderId;         // FK to orders
    private int itemId;          // FK to menu_item
    private int quantity;        // quantity
    private double priceAtOrder; // price_at_order

    public OrderItem(int itemId2, String itemName, double itemPrice, int i) {
		// TODO Auto-generated constructor stub
	}
    
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

    public double getPriceAtOrder() {
        return priceAtOrder;
    }
    public void setPriceAtOrder(double priceAtOrder) {
        this.priceAtOrder = priceAtOrder;
    }
}

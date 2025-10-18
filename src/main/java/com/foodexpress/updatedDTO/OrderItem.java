package com.foodexpress.updatedDTO;


public class OrderItem {
    
    private int orderId;         // PK to order_item
    private int itemId;          // FK to menu_item
    private int quantity;        // quantity
    private double priceAtOrder; // price_at_order


	public OrderItem(int orderId, int itemId, int quantity, double priceAtOrder) {
		super();
		this.orderId = orderId;
		this.itemId = itemId;
		this.quantity = quantity;
		this.priceAtOrder = priceAtOrder;
	}


	public OrderItem() {
		super();
	}


	
	
	
	// Getters and Setters
    
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
    public void setPriceAtOrder(double bigDecimal) {
        this.priceAtOrder = bigDecimal;
    }
}

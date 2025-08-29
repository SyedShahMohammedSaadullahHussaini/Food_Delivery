package com.food.controller;

import com.foodexpress.updatedDTO.MenuItems;
import com.foodexpress.updatedDTO.OrderItem;
import com.foodexpress.util.DBConnection;
import com.foodexpress.updatedDAO.OrderItemDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {
	        
	        String action = request.getParameter("action");
	        HttpSession session = request.getSession();
	        
	        // Retrieve cart (Map<itemId, CartItem>)
	        Map<Integer, OrderItem> cart = (Map<Integer, OrderItem>) session.getAttribute("cart");
	        if (cart == null) {
	            cart = new HashMap<>();
	        }
	        
	        if ("add".equals(action)) {
	            int itemId = Integer.parseInt(request.getParameter("itemId"));
	            String itemName = request.getParameter("itemName");
	            double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));

	            // If item already exists, increase quantity
	            if (cart.containsKey(itemId)) {
	                OrderItem existing = cart.get(itemId);
	                existing.setQuantity(existing.getQuantity() + 1);
	            } else {
	                cart.put(itemId, new OrderItem(itemId, itemName, itemPrice, 1));
	            }
	            
	            session.setAttribute("cart", cart);
	            response.sendRedirect("menu.jsp"); // stay on menu page
	        }
	        else if ("placeOrder".equals(action)) {
	            int userId = (int) session.getAttribute("userId");
	            int restaurantId = (int) session.getAttribute("restaurantId");
	            
	            double totalAmount = cart.values().stream()
	                                     .mapToDouble(item -> item.getPriceAtOrder() * item.getQuantity())
	                                     .sum();

	            try (Connection conn = DBConnection.giveConnection()) {
	                conn.setAutoCommit(false);
	                
	                // Insert order
	                String orderSql = "INSERT INTO orders (uId, restaurant_id, total_amount, status) VALUES (?, ?, ?, 'placed')";
	                PreparedStatement ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
	                ps.setInt(1, userId);
	                ps.setInt(2, restaurantId);
	                ps.setDouble(3, totalAmount);
	                ps.executeUpdate();
	                
	                ResultSet rs = ps.getGeneratedKeys();
	                rs.next();
	                int orderId = rs.getInt(1);
	                
	                // Insert items
	                String itemSql = "INSERT INTO order_item (order_id, item_id, quantity, price_at_order) VALUES (?, ?, ?, ?)";
	                PreparedStatement psItem = conn.prepareStatement(itemSql);
	                for (OrderItem item : cart.values()) {
	                    psItem.setInt(1, orderId);
	                    psItem.setInt(2, item.getItemId());
	                    psItem.setInt(3, item.getQuantity());
	                    psItem.setDouble(4, item.getPriceAtOrder());
	                    psItem.addBatch();
	                }
	                psItem.executeBatch();
	                
	                conn.commit();
	                
	                // Clear cart
	                session.removeAttribute("cart");
	                
	                response.sendRedirect("orderSuccess.jsp");
	            } catch (Exception e) {
	                e.printStackTrace();
	                response.sendRedirect("error.jsp");
	            }
	        }
	    }
	}

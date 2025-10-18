//package com.food.controller;
//
//import com.foodexpress.updatedDTO.MenuItems;
//import com.foodexpress.updatedDTO.OrderItem;
//import com.foodexpress.updatedDTO.User;
//import com.foodexpress.util.DBConnection;
//import com.foodexpress.updatedDAO.OrderItemDAO;
//import com.foodexpress.updatedDAO.RestaurantDAO;
//import com.foodexpress.updatedDTO.Restaurant;
//
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//import java.io.IOException;
//import java.math.BigDecimal;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.Statement;
//import java.util.ArrayList;
//import java.util.Enumeration;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.eclipse.tags.shaded.org.apache.xalan.xsltc.compiler.sym;
//
//@WebServlet("/CartServlet")
//public class CartServlet extends HttpServlet {
//    
//	private static final long serialVersionUID = 1L;
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        
//    	HttpSession session = request.getSession(false);
//    	
//        if (session == null || session.getAttribute("currentUser") == null) {
//        	System.out.println("session null detected:"+session);
//        	response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//        	return;
//        }
//
//        // Fetch item and restaurant details
//        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
//        int itemId = Integer.parseInt(request.getParameter("itemId"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//        double price = Double.parseDouble(request.getParameter("price"));
//        
//        
//     // ✅ Check restaurant open/closed
//        RestaurantDAO restaurantDAO = new RestaurantDAO();
//        Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
//
//        if (restaurant == null || restaurant.getStatus() == null || restaurant.getStatus().toLowerCase().contains("close")) {
//            System.out.println("Blocked add-to-cart: Restaurant is closed");
//            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
//            response.getWriter().write("Restaurant is closed. Please try again later.");
//            return;
//        }
//
//        
//        
//        Enumeration<String> names = session.getAttributeNames();
//        while (names.hasMoreElements()) {
//            String name = names.nextElement();
//            System.out.println("Session attribute: " + name + " = " + session.getAttribute(name));
//        }
//
//        
//        
//        
//     // Get the current restaurantId stored in session (if any)
//        Integer currentRestaurantId = (Integer) session.getAttribute("currentRestaurantId");
//        System.out.println("current rest from session:"+currentRestaurantId);
//        
//        if (currentRestaurantId != null && !currentRestaurantId.equals(restaurantId)) {
//            // ❌ Different restaurant: reject the request
//            request.setAttribute("errorMessage", "You can order from only one restaurant per order.");
//            request.getRequestDispatcher("DisplayMenu?restaurantId=" + restaurantId).forward(request, response);
//            session.removeAttribute("cart");
//            return;
//        }
//        
//     // Update session restaurantId
//        session.setAttribute("currentRestaurantId", restaurantId);
//        
//        
//        
//        
//        // Working servlet
////        System.out.println("Menu item_id: "+itemId);
////        System.out.println("Restaurant_id: "+restaurantId);
////        System.out.println("selected qty: "+quantity);
//        
//        
//        
//        
//        // Example cart stored in session
//        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
//        
//        if (cart == null) { 
//            cart = new ArrayList<>();
//        }
//        
//        boolean itemExists = false;
//        for (OrderItem orderItem : cart) {
//            if (orderItem.getItemId() == itemId) {
//                itemExists = true;
//                if (quantity <= 0) {
//                    cart.remove(orderItem);
//                } else {
//                    orderItem.setQuantity(quantity);
//                }
//                break;
//            }
//        }
//        
//
//     // Add new item if not exists and quantity > 0
//        if (!itemExists && quantity > 0) {
//            OrderItem newItem = new OrderItem();
//            newItem.setItemId(itemId);
//            newItem.setQuantity(quantity);
//            newItem.setPriceAtOrder(price);
//            cart.add(newItem);
//        }
//
//        session.setAttribute("cart", cart);
//
//        // Debug: print cart contents
//        System.out.println("Cart contents:");
//        for (OrderItem orderItem : cart) {
//            System.out.println("Item ID: " + orderItem.getItemId() + ", Qty: " + orderItem.getQuantity());
//        }
//       
//        session.setAttribute("cart", cart);
//
//        // response.sendRedirect("cart.jsp");
//        
//    }
//}  
//// this is working gettig data from frontend to backend and sessing in console
//
//


package com.food.controller;

import com.foodexpress.updatedDTO.MenuItems;
import com.foodexpress.updatedDTO.OrderItem;
import com.foodexpress.updatedDTO.User;
import com.foodexpress.updatedDAO.RestaurantDAO;
import com.foodexpress.updatedDTO.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.json.JSONObject;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "User not logged in");
            out.print(json.toString());
            return;
        }

        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        // Check restaurant status
        RestaurantDAO restaurantDAO = new RestaurantDAO();
        Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);

        if (restaurant == null || restaurant.getStatus() == null || restaurant.getStatus().toLowerCase().contains("close")) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "Restaurant is closed. Please try again later.");
            out.print(json.toString());
            return;
        }

        // Check if user is ordering from a different restaurant
        Integer currentRestaurantId = (Integer) session.getAttribute("currentRestaurantId");
        if (currentRestaurantId != null && !currentRestaurantId.equals(restaurantId)) {
            session.removeAttribute("cart");
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "You can order from only one restaurant per order.");
            out.print(json.toString());
            return;
        }

        session.setAttribute("currentRestaurantId", restaurantId);

        // Get or create cart
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        double updatedSubtotal = 0;
        boolean itemExists = false;
        for (int i = 0; i < cart.size(); i++) {
            OrderItem orderItem = cart.get(i);
            if (orderItem.getItemId() == itemId) {
                itemExists = true;
                if (quantity <= 0) {
                    cart.remove(i);
                } else {
                    orderItem.setQuantity(quantity);
                    updatedSubtotal = orderItem.getPriceAtOrder() * quantity;
                }
                break;
            }
        }

        if (!itemExists && quantity > 0) {
            OrderItem newItem = new OrderItem();
            newItem.setItemId(itemId);
            newItem.setQuantity(quantity);
            newItem.setPriceAtOrder(price);
            cart.add(newItem);
            updatedSubtotal = price * quantity;
        }

        session.setAttribute("cart", cart);

        // Calculate totals
        double cartSubtotal = 0;
        for (OrderItem orderItem : cart) {
            cartSubtotal += orderItem.getPriceAtOrder() * orderItem.getQuantity();
        }

        double deliveryFee = 40;
        double taxes = 20;
        double cartDiscount = Math.round(cartSubtotal * 0.1); // 10% discount
        double cartTotal = cartSubtotal + deliveryFee + taxes - cartDiscount;

        // Return JSON response
        JSONObject json = new JSONObject();
        json.put("success", true);
        json.put("updatedSubtotal", updatedSubtotal); // subtotal of this item
        json.put("cartSubtotal", cartSubtotal);
        json.put("cartDiscount", cartDiscount);
        json.put("cartTotal", cartTotal);
        json.put("cartSize", cart.size());

        out.print(json.toString());
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect("cart.jsp");
    }
}

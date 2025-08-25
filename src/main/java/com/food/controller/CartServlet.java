package com.food.controller;

import com.foodexpress.updatedDTO.OrderItem;
import com.foodexpress.updatedDAO.OrderItemDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//
//        // Retrieve item details from request
//        String itemName = request.getParameter("itemName");
//        String itemPriceStr = request.getParameter("itemPrice");
//        BigDecimal itemPrice = new BigDecimal(itemPriceStr);
//
//        // Get existing cart or create new
//        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
//        if (cart == null) {
//            cart = new ArrayList<>();
//        }
//
//        // Check if item already exists in cart
//        boolean itemExists = false;
//        for (OrderItem orderItem : cart) {
//            if (orderItem.getItemName().equals(itemName)) {   // comparing by itemName
//                orderItem.setQuantity(orderItem.getQuantity() + 1);
//                itemExists = true;
//                break;
//            }
//        }
//
//        // If not exists, add new item
//        if (!itemExists) {
//            OrderItem newItem = new OrderItem();
//            newItem.setItemId(0); // not needed for session cart
//            newItem.setItemName(itemName);
//            newItem.setQuantity(1);
//            newItem.setPriceAtOrder(itemPrice);
//            cart.add(newItem);
//        }
//
//        // Save updated cart back to session
//        session.setAttribute("cart", cart);
//
//        // Stay on same page (don’t redirect to cart)
//        response.sendRedirect(request.getHeader("referer"));
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
//
//        if (cart == null) {
//            cart = new ArrayList<>();
//        }
//
//        // Forward cart to JSP for display
//        request.setAttribute("cart", cart);
//        request.getRequestDispatcher("cart.jsp").forward(request, response);
//    }

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session_cart = req.getSession();
		
		List<OrderItem> cartlist = new ArrayList<OrderItem>();
		cartlist.add(null);
//		if (cart == null || cart.isEmpty()) {
//            response.sendRedirect("viewCart.jsp"); // cart empty
//            return;
//        }
	}









}

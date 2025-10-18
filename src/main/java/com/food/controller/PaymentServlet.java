//package com.food.controller;
//
//import java.io.IOException;
//import java.math.BigDecimal;
//import java.util.List;
//
//import com.foodexpress.updatedDTO.OrderItem;
//import com.foodexpress.updatedDTO.Orders;
//import com.foodexpress.updatedDTO.Payment;
//import com.foodexpress.updatedDTO.User;
//import com.foodexpress.updatedDAO.OrderItemDAO;
//import com.foodexpress.updatedDAO.OrdersDAO;
//import com.foodexpress.updatedDAO.PaymentDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/payment")
//public class PaymentServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession(false);
//
//        if (session == null || session.getAttribute("cart") == null) {
//            response.sendRedirect("cart.jsp");
//            return;
//        }
//
//        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
//        User currentUser = (User) session.getAttribute("currentUser");
//        Integer restaurantId = (Integer) session.getAttribute("currentRestaurantId");
//
//        String paymentMethod = request.getParameter("paymentMethod"); // get selected payment method
//        System.out.println(paymentMethod);
//        String addressIdStr = request.getParameter("addressId");
//        Integer addressId = (addressIdStr != null && !addressIdStr.isEmpty()) ? Integer.parseInt(addressIdStr) : null;
//
//        // calculate totals
//        double subtotal = 0;
//        for (OrderItem item : cart) {
//            subtotal += item.getPriceAtOrder() * item.getQuantity();
//        }
//        double delivery = 40;
//        double taxes = 20;
//        double discount = Math.round(subtotal * 0.1);
//        double total = subtotal + delivery + taxes - discount;
//
//        // build Orders object
//        Orders order = new Orders();
//        order.setuId(currentUser != null ? currentUser.getuId() : null);
//        order.setRestaurantId(restaurantId != null ? restaurantId : 0);
//        order.setTotalAmount(BigDecimal.valueOf(total));
//        order.setStatus("placed");
//        order.setDeliveryAddressId(addressId);
//
//        OrdersDAO ordersDAO = new OrdersDAO();
//        boolean saved = ordersDAO.addOrder(order);
//
//        if (saved) {
//            int orderId = order.getOrderId(); // generated orderId
//
//            // save order items
//            OrderItemDAO orderItemsDAO = new OrderItemDAO();
//            for (OrderItem item : cart) {
//                orderItemsDAO.addOrderItem(orderId, item);
//            }
//
//            // save payment
//            Payment payment = new Payment();
//            payment.setOrderId(orderId);
//            if ("cash".equals(paymentMethod) || "upi".equals(paymentMethod) || "card".equals(paymentMethod) || "netbanking".equals(paymentMethod)) {
//                payment.setPaymentMethod(paymentMethod);
//            } else {
//                payment.setPaymentMethod("cash"); // fallback default
//            }
//            payment.setPaymentMethod(paymentMethod);
//            payment.setPaymentStatus("completed"); // you can adjust based on real payment gateway
//            payment.setAmountPaid(BigDecimal.valueOf(total));
//            payment.setTransactionTime(new java.sql.Timestamp(System.currentTimeMillis()));
//
//            PaymentDAO paymentDAO = new PaymentDAO();
//            paymentDAO.makePayment(payment); // save payment info in DB
//
//            // clear cart
//            session.removeAttribute("cart"); 
//            System.out.println("before reditecting to the ordersuccess page paymet is: "+paymentMethod);
//
//            // redirect to order success with orderId
//            response.sendRedirect("orderSuccess.jsp?orderId=" + orderId);
//
//        } else {
//            response.sendRedirect("paymentFailed.jsp");
//        }
//    }
//}

/* new payment servlet */


package com.food.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.foodexpress.updatedDTO.OrderItem;
import com.foodexpress.updatedDTO.Orders;
import com.foodexpress.updatedDTO.Payment;
import com.foodexpress.updatedDTO.User;
import com.foodexpress.updatedDAO.OrderItemDAO;
import com.foodexpress.updatedDAO.OrdersDAO;
import com.foodexpress.updatedDAO.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("cart") == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
        User currentUser = (User) session.getAttribute("currentUser");
        Integer restaurantId = (Integer) session.getAttribute("currentRestaurantId");

        // get selected payment method
        String paymentMethod = request.getParameter("paymentMethod");
        System.out.println("Selected payment method: " + paymentMethod);

        String addressIdStr = request.getParameter("addressId");
        Integer addressId = (addressIdStr != null && !addressIdStr.isEmpty()) ? Integer.parseInt(addressIdStr) : null;

        // calculate totals
        double subtotal = 0;
        for (OrderItem item : cart) {
            subtotal += item.getPriceAtOrder() * item.getQuantity();
        }
        double delivery = 40;
        double taxes = 20;
        double discount = Math.round(subtotal * 0.1);
        double total = subtotal + delivery + taxes - discount;

        // build Orders object
        Orders order = new Orders();
        order.setuId(currentUser != null ? currentUser.getuId() : null);
        order.setRestaurantId(restaurantId != null ? restaurantId : 0);
        order.setTotalAmount(BigDecimal.valueOf(total));
        order.setStatus("placed");
        order.setDeliveryAddressId(addressId);

        OrdersDAO ordersDAO = new OrdersDAO();
        boolean saved = ordersDAO.addOrder(order);

        if (saved) {
            int orderId = order.getOrderId(); // generated orderId

            // save order items
            OrderItemDAO orderItemsDAO = new OrderItemDAO();
            for (OrderItem item : cart) {
                orderItemsDAO.addOrderItem(orderId, item);
            }

            // save payment
            Payment payment = new Payment();
            payment.setOrderId(orderId);

            // validate payment method against ENUM in DB
            if ("cash".equalsIgnoreCase(paymentMethod) ||
                "upi".equalsIgnoreCase(paymentMethod) ||
                "card".equalsIgnoreCase(paymentMethod) ||
                "netbanking".equalsIgnoreCase(paymentMethod)) {
                payment.setPaymentMethod(paymentMethod.toLowerCase());
            } else {
                payment.setPaymentMethod("cash"); // fallback default
            }

            // status must also match ENUM
            payment.setPaymentStatus("completed"); 
            payment.setAmountPaid(BigDecimal.valueOf(total));
            payment.setTransactionTime(new java.sql.Timestamp(System.currentTimeMillis()));

            PaymentDAO paymentDAO = new PaymentDAO();
            boolean paymentSaved = paymentDAO.makePayment(payment);

            System.out.println("Payment saved? " + paymentSaved + " Method: " + payment.getPaymentMethod());

            // clear cart
            session.removeAttribute("cart"); 

            // redirect to order success with orderId
            response.sendRedirect("orderSuccess.jsp?orderId=" + orderId);

        } else {
            response.sendRedirect("paymentFailed.jsp");
        }
    }
}


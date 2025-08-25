//package com.food.controller;
//
//import java.io.IOException;
//import java.util.List;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import com.foodexpress.updatedDAO.RestaurantDAO;
//import com.foodexpress.updatedDTO.Restaurant;
//import com.foodexpress.updatedDTO.User;
//
//
//@WebServlet("/DisplayRestaurant")
//public class DisplayRestaurant extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    private RestaurantDAO restaurantDAO;
//
//    @Override
//    public void init() throws ServletException {
//        restaurantDAO = new RestaurantDAO(); // Initialize DAO once
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//    	        
//    	try {
////    		 User currentUser = (User) request.getSession().getAttribute("currentUser");
////    	        if (currentUser == null) {
////    	            response.sendRedirect("login.jsp");
////    	            return;
////    	        }
//    		
//    		
//            // 1. Read filter parameter from request
//            String filter = request.getParameter("filter");
//            String sortBy = request.getParameter("sortBy");
//          
//            List<Restaurant> restaurantList;
//            
//            
//
//            // 2. Decide which DAO method to call
//            if ("veg".equalsIgnoreCase(filter)) {
//                restaurantList = restaurantDAO.getRestaurantsByVegOrNonVeg(filter);
//            }else if ("non-veg".equalsIgnoreCase(filter)) {
//                restaurantList = restaurantDAO.getRestaurantsByVegOrNonVeg(filter);
//            } else {
//                restaurantList = restaurantDAO.getAllRestaurants(); // default
//            }
//
//            // 3. Set data for JSP
//            if (restaurantList == null || restaurantList.isEmpty()) {
//                request.setAttribute("message", "No restaurants found for this filter.");
//            } else {
//                request.setAttribute("restaurants", restaurantList);
//            }
//
//            // 4. Forward to JSP
//            RequestDispatcher rd = request.getRequestDispatcher("container.jsp");
//            rd.forward(request, response);
//
//        } catch (Exception e) {
//            e.printStackTrace(); 
//            request.setAttribute("error", "Failed to load restaurants. Try again later.");
//            request.getRequestDispatcher("error.jsp").forward(request, response);
//        }
//    }
//}


//*****************************************************************************************

package com.food.controller;

import com.foodexpress.updatedDAO.RestaurantDAO;
import com.foodexpress.updatedDTO.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/DisplayRestaurant")
public class DisplayRestaurant extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RestaurantDAO dao = new RestaurantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from filters
        String sortBy = request.getParameter("sortBy");       // price_low, rating_high, etc.
        String filter = request.getParameter("filter");       // veg, non-veg, all
        String cuisine = request.getParameter("cuisine");     // Pizza, Biryani, etc.

     // ✅ default values to avoid null issues
//        if (sortBy == null) sortBy = "";
//        if (filter == null) filter = "all";
//        if (cuisine == null) cuisine = "";
        
        // Call DAO with all 3 options
        List<Restaurant> list = dao.getFilteredRestaurants(sortBy, filter, cuisine);

        // Attach to request
        request.setAttribute("restaurants", list);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("container.jsp");
        rd.forward(request, response);
    }
}

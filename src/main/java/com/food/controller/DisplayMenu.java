package com.food.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

import com.foodexpress.updatedDAO.MenuDAO;
import com.foodexpress.updatedDAO.RestaurantDAO;
import com.foodexpress.updatedDTO.MenuItems;
import com.foodexpress.updatedDTO.Restaurant;

@WebServlet("/DisplayMenu")
public class DisplayMenu extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private MenuDAO menuDAO = new MenuDAO();
    private RestaurantDAO restaurantDAO = new RestaurantDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String restIdStr = request.getParameter("restaurantId");

        if (restIdStr != null && !restIdStr.isEmpty()) {
            try {
                int restaurantId = Integer.parseInt(restIdStr);

                // Fetch restaurant details
                Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
                if (restaurant == null) {
                    response.sendRedirect("container.jsp"); // restaurant not found
                    return;
                }

                // Fetch menu items for the restaurant
                List<MenuItems> menu = menuDAO.getMenuByRestaurant(restaurantId);

                // Only show available items
                menu.removeIf(item -> !item.isAvailable());

                // Add default image if image is missing
//                for (MenuItems item : menu) {
//                    if (item.getImageUrl() == null || item.getImageUrl().isEmpty()) {
//                        item.setImageUrl("images/default-food.png");
//                    }
//                }

                // Set attributes for JSP
                request.setAttribute("restaurant", restaurant);
                request.setAttribute("menuItems", menu);

                request.getRequestDispatcher("menu.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect("container.jsp"); // invalid restaurantId
            }
        } else {
            response.sendRedirect("container.jsp"); // no restaurantId
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

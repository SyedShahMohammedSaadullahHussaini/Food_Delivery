package com.food.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodexpress.updatedDAO.RestaurantDAO;
import com.foodexpress.updatedDTO.Restaurant;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO = new RestaurantDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword"); // coming from search input

        List<Restaurant> results = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            results = restaurantDAO.searchRestaurants(keyword.trim());
        }

        // Set results in request scope
        request.setAttribute("searchResults", results);
        request.setAttribute("keyword", keyword);

        // Forward to JSP page to display results
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // same flow for POST
    }
}

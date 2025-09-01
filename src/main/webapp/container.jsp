<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.foodexpress.updatedDTO.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <title>Food Delivery Restaurants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        /* Outer container */
        .outer {
            width: 100%;
            background: #fff; 
            padding: 12px 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            position: sticky; 
            top: 0;
            z-index: 1;
        }
        
      
        /* Filters bar */
        .filters-bar {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            padding: 10px 15px;
            background-color: #fff;
            position: sticky;
            top: 0;
        }

        .filters-bar select, .filters-bar button {
            border: 1px solid #ccc;
            border-radius: 0.8rem;
            padding: 10px 14px;
            font-size: 1rem;
            cursor: pointer;
        }

        /* Restaurant cards */
        .restaurant-card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            position: relative;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: #fff;
        }

        .restaurant-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .restaurant-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        /* Offer badge top-left */
        .offer-badge {
            position: absolute;
            top: 8px;
            left: 8px;
            background: #007bff;
            color: white;
            font-size: 0.8rem;
            padding: 3px 6px;
            border-radius: 4px;
        }

        .promoted-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            background: rgba(0,0,0,0.6);
            color: white;
            font-size: 0.7rem;
            padding: 3px 6px;
            border-radius: 4px;
        }

        .restaurant-details {
            padding: 12px 15px;
        }

        .restaurant-details h5 {
            margin-bottom: 4px;
        }

        .restaurant-details p {
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .restaurant-info {
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .rating {
            background: #48c479;
            color: #fff;
            padding: 2px 6px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
 <%@ include file="navbar.jsp" %>
 
<div class="outer">
    <form method="get" action="DisplayRestaurant" class="filters-bar">
        <select name="sortBy" onchange="this.form.submit()">
            <option value="">Sort By</option>
            <option value="price_low" <%= "price_low".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Price: Low to High</option>
            <option value="price_high" <%= "price_high".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Price: High to Low</option>
            <option value="rating_high" <%= "rating_high".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Rating: High to Low</option>
            <option value="rating_low" <%= "rating_low".equals(request.getParameter("sortBy")) ? "selected" : "" %>>Rating: Low to High</option>
        </select>

        <select name="filter" onchange="this.form.submit()">
            <option value="all" <%= ("all".equalsIgnoreCase(request.getParameter("filter")) || request.getParameter("filter") == null) ? "selected" : "" %>>Both</option>
            <option value="veg" <%= "veg".equalsIgnoreCase(request.getParameter("filter")) ? "selected" : "" %>>Pure Veg</option>
            <option value="non-veg" <%= "non-veg".equalsIgnoreCase(request.getParameter("filter")) ? "selected" : "" %>>Non-Veg</option>
        </select>

        <select name="cuisine" onchange="this.form.submit()">
            <option value="">Cuisines</option>
            <option value="Chinese" <%= "Chinese".equalsIgnoreCase(request.getParameter("cuisine")) ? "selected" : "" %>>Chinese</option>
            <option value="Italian" <%= "Italian".equalsIgnoreCase(request.getParameter("cuisine")) ? "selected" : "" %>>Italian</option>
            <option value="North Indian" <%= "North Indian".equalsIgnoreCase(request.getParameter("cuisine")) ? "selected" : "" %>>North Indian</option>
            <option value="South Indian" <%= "South Indian".equalsIgnoreCase(request.getParameter("cuisine")) ? "selected" : "" %>>South Indian</option>
        </select>
    </form>
</div>

<div class="container py-4">
    <h2 class="mb-4">Food Delivery Restaurants</h2>
    <div class="row">
        <%
            List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
            if (restaurants == null || restaurants.isEmpty()) {
        %>
            <div class="col-12 text-center py-5">
                <h4>No restaurants found.</h4>
            </div>
        <% 
            } else {
                for (Restaurant r : restaurants) { 
        %>
        <div class="col-md-4">
		    <a href="<%= request.getContextPath() %>/DisplayMenu?restaurantId=<%= r.getRestaurantId() %>" style="text-decoration:none; color:inherit;">
		        <div class="restaurant-card">
		            <% if (r.isPromoted()) { %>
		                <div class="promoted-badge">Promoted</div>
		            <% } %>
		            <% if (r.getOffer() != null && !r.getOffer().isEmpty()) { %>
		                <div class="offer-badge"><%= r.getOffer() %></div>
		            <% } %>
		            <img src="images/restaurants/<%= r.getLogo() %>" 
		                 onerror="this.onerror=null; this.src='images/restaurants/default-restaurant.png'"
		                 class="restaurant-image" alt="<%= r.getName() %>">
		            <div class="restaurant-details">
		                <h5><%= r.getName() %></h5>
		                <p class="text-muted"><%= r.getCuisine() %></p>
		                <div class="restaurant-info">
		                    <span class="rating"><%= r.getRating() %> ★</span>
		                    <span>₹<%= r.getPrice() %> for two</span>
		                    <span><%= r.getTime() %></span>
		                </div>
		            </div>
		        </div>
		    </a>
		</div>


        <% 
                } 
            } 
        %>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const cards = document.querySelectorAll('.restaurant-card');
        const observer = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('show');
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.2 });

        cards.forEach(card => observer.observe(card));
    });
</script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, demo.Restaurants" %>
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

        
        .filters-bar {
            /* position: sticky;
            top: 0;
            background-color: white;
            z-index: 1000;
            display: flex;
            gap: 10px;
            align-items: center;
            padding: 10px 15px;
            border-bottom: 1px solid #ddd;
            width: 100%;
            border-radius: 5px; */
            display: flex;
    flex-wrap: wrap;
    padding: 10px 15px;
    position: sticky;
    background-color: rgb(255, 255, 255);
    z-index: 2;
    transition: top 0.5s ease-in-out;
    height: 75px;
}

        .filters-bar button
         {
            /* adding: 6px 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    background-color: #f8f8f8;
    cursor: pointer; */
    border: 1px solid rgb(207, 207, 207);
    color: rgb(156, 156, 156);
    background-color: rgb(255, 255, 255);
    border-radius: 0.8rem;
    padding: 20px;
    display: flex;
	margin:5px;
    -webkit-box-align: center;
    align-items: center;
    cursor: pointer;
   
    font-size: 1.4rem;
    height: 50px;	

        }
        .filters-bar select{
        border: 1px solid rgb(207, 207, 207);
    color: rgb(156, 156, 156);
    background-color: rgb(255, 255, 255);
    border-radius: 0.8rem;
    
    display: flex;
	margin:5px;
    -webkit-box-align: center;
    align-items: center;
    cursor: pointer;
   
    font-size: 1.4rem;
    height: 50px;	
        }

        /* Restaurant cards */
        .restaurant-card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.6s ease, transform 0.6s ease, box-shadow 0.3s ease, scale 0.3s ease;
            background: white;
        }

        .restaurant-card.show {
            opacity: 1;
            transform: translateY(0);
        }

        .restaurant-card:hover {
            transform: translateY(-5px) scale(1.03);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            cursor: pointer;
        }

        .restaurant-image {
            height: 200px;
            object-fit: cover;
            width: 100%;
            transition: transform 0.3s ease;
        }

        .restaurant-card:hover .restaurant-image {
            transform: scale(1.05);
        }

        .offer-badge {
            position: absolute;
            bottom: 8px;
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
            left: 8px;
            background: rgba(0,0,0,0.6);
            color: white;
            font-size: 0.7rem;
            padding: 3px 6px;
            border-radius: 4px;
        }

        .rating {
            background: #48c479;
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.85rem;
        }
        .outer{
        position: sticky;
    	top: 0px;
    	background-color: rgb(255, 255, 255);
    	z-index: 3;
    	width:100%;
    }
    </style>
</head>
 <body >
<%@ include file="/Main/navbar.jsp" %>
   <div class="outer">
 <!-- Sticky Filters -->
    <div class="filters-bar">
        <button>Filters</button>
        <button>Pure Veg</button>
        <select>
            <option>Cuisines</option>
            <option>Biryani</option>
            <option>Burgers</option>
            <option>Pizza</option>
        </select>
    </div></div>
   
<div class="container py-4">
    <h2 class="mb-4">Food Delivery Restaurants </h2>
    <div class="row">
        <%
            List<Restaurants> restaurants = (List<Restaurants>) request.getAttribute("restaurants");
            if (restaurants != null) {
                for (Restaurants r : restaurants) {
        %>
        <div class="col-md-4">
            <div class="restaurant-card position-relative">
                <% if (r.isPromoted()) { %>
                    <div class="promoted-badge">Promoted</div>
                <% } %>
                <img src="<%= r.getImageUrl() %>" class="restaurant-image" alt="<%= r.getName() %>">
                <div class="offer-badge"><%= r.getOffer() %></div>
                <div class="p-3">
                    <h5 class="mb-1"><%= r.getName() %></h5>
                    <p class="text-muted mb-1" style="font-size: 0.9rem;"><%= r.getCuisine() %></p>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="rating"><%= r.getRating() %> ★</span>
                        <span class="text-muted" style="font-size: 0.85rem;"><%= r.getPrice() %></span>
                        <span class="text-muted" style="font-size: 0.85rem;"><%= r.getTime() %></span>
                    </div>
                </div>
            </div>
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
                        observer.unobserve(entry.target); // animation triggers only once
                    }
                });
            }, { threshold: 0.2 });

            cards.forEach(card => observer.observe(card));
        });
    </script>
</body>
</html>

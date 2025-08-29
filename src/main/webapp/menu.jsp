<%-- <%@ page contentType="text/html;charset=UTF-8" %> --%>
<%@ page import="java.util.*, com.foodexpress.updatedDTO.MenuItems, com.foodexpress.updatedDTO.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #fc8019;
            --primary-dark: #e06b00;
            --secondary: #2a2a2a;
            --light-bg: #f8f9fa;
            --card-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            --hover-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            padding-bottom: 50px;
        }
        
        .navbar-custom {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 12px 0;
        }
        
        .navbar-brand {
            font-weight: 700;
            color: var(--primary);
            font-size: 1.5rem;
        }
        
        .restaurant-header {
            max-width: 1200px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            display: flex;
            gap: 30px;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .restaurant-header:hover {
            box-shadow: var(--hover-shadow);
            transform: translateY(-5px);
        }
        
        .restaurant-image {
            width: 220px;
            height: 220px;
            object-fit: cover;
            border-radius: 16px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            flex-shrink: 0;
        }
        
        .restaurant-image:hover {
            transform: scale(1.03);
        }
        
        .restaurant-info h2 {
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--secondary);
        }
        
        .restaurant-meta {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .meta-icon {
            color: var(--primary);
            font-size: 1.1rem;
            width: 24px;
        }
        
        .rating-badge {
            background-color: #3d8f3d;
            color: white;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .status-open {
            background-color: #e6f7ee;
            color: #0c622d;
        }
        
        .status-closed {
            background-color: #feeaea;
            color: #d34040;
        }
        
        .offer-badge {
            background: linear-gradient(135deg, #ff9a00, #ff6a00);
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-top: 10px;
        }
        
        .menu-container {
            max-width: 1200px;
            margin: 30px auto;
        }
        
        .section-title {
            font-weight: 700;
            margin-bottom: 25px;
            color: var(--secondary);
            position: relative;
            padding-bottom: 10px;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background-color: var(--primary);
            border-radius: 2px;
        }
        
        .filter-container {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #ddd;
            border-radius: 30px;
            background: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .filter-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        
        .filter-btn.active {
            border-color: var(--primary);
            background-color: var(--primary);
            color: white;
        }
        
        .veg-icon, .nonveg-icon {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            display: inline-block;
        }
        
        .veg-icon {
            background-color: #0f9d58;
            border: 1px solid #0f9d58;
        }
        
        .nonveg-icon {
            background-color: #e74c3c;
            border: 1px solid #e74c3c;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        
        .menu-card {
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        
        .menu-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--hover-shadow);
        }
        
        .menu-item-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .menu-item-content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        
        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }
        
        .item-name {
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--secondary);
        }
        
        .item-price {
            font-weight: 700;
            color: var(--primary);
            font-size: 1.2rem;
        }
        
        .item-description {
            color: #666;
            margin-bottom: 20px;
            flex-grow: 1;
        }
        
        .item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .veg-indicator {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .add-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .add-btn:hover {
            background-color: var(--primary-dark);
            transform: scale(1.05);
        }
        
        .empty-menu {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
        }
        
        .empty-menu i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .empty-menu h4 {
            color: #888;
            font-weight: 600;
        }
        
        @media (max-width: 992px) {
            .restaurant-header {
                flex-direction: column;
                text-align: center;
                padding: 25px;
            }
            
            .restaurant-image {
                width: 100%;
                max-width: 300px;
            }
            
            .restaurant-meta {
                grid-template-columns: 1fr;
            }
            
            .meta-item {
                justify-content: center;
            }
        }
        
        @media (max-width: 768px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .filter-container {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-utensils me-2"></i>FoodExpress
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="DisplayRestaurant"><i class="fas fa-home me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-heart me-1"></i> Favorites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="CartServlet"><i class="fas fa-shopping-cart me-1"></i> Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="UserLogin"><i class="fas fa-user me-1"></i> Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

<%
    // JSP scope variables
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<MenuItems> menuItems = (List<MenuItems>) request.getAttribute("menuItems");

    String logo = (restaurant != null && restaurant.getLogo() != null && !restaurant.getLogo().isEmpty()) 
                  ? (request.getContextPath() + "/images/restaurants/" + restaurant.getLogo())
                  : (request.getContextPath() + "/images/restaurants/default-restaurant.png");
                  
    // Determine status badge class
    String statusClass = "status-open";
    String statusIcon = "fas fa-check-circle";
    if (restaurant != null && restaurant.getStatus() != null) {
        if (restaurant.getStatus().toLowerCase().contains("close")) {
            statusClass = "status-closed";
            statusIcon = "fas fa-times-circle";
        }
    }
%>

<% if (restaurant != null) { %>
<div class="restaurant-header">
    <img src="<%= logo %>" alt="Restaurant Image" class="restaurant-image">
    <div class="restaurant-info">
        <h2><%= restaurant.getRestaurantName() %></h2>
        <div class="restaurant-meta">
            <div class="meta-item">
                <div class="meta-icon"><i class="fas fa-map-marker-alt"></i></div>
                <div><%= restaurant.getCity() != null ? restaurant.getCity() : "N/A" %></div>
            </div>
            <div class="meta-item">
                <div class="meta-icon"><i class="fas fa-phone"></i></div>
                <div><%= restaurant.getTelephone() != null ? restaurant.getTelephone() : "N/A" %></div>
            </div>
            <div class="meta-item">
                <div class="meta-icon"><i class="fas fa-star"></i></div>
                <div>
                    <% if (restaurant.getRating() != null) { %>
                    <span class="rating-badge">
                        <i class="fas fa-star"></i> <%= restaurant.getRating() %>
                    </span>
                    <% } else { %>
                    N/A
                    <% } %>
                </div>
            </div>
            <div class="meta-item">
                <div class="meta-icon"><i class="fas fa-clock"></i></div>
                <div>
                    <span class="status-badge <%= statusClass %>">
                        <i class="<%= statusIcon %>"></i> <%= restaurant.getStatus() != null ? restaurant.getStatus() : "N/A" %>
                    </span>
                </div>
            </div>
        </div>
        <p class="mb-2"><strong>Address:</strong> <%= restaurant.getAddress() != null ? restaurant.getAddress() : "N/A" %></p>
        <p class="mb-2"><strong>Cuisines:</strong> <%= restaurant.getCuisine() != null ? restaurant.getCuisine() : "N/A" %></p>
        <% if (restaurant.getOffer() != null && !restaurant.getOffer().isEmpty()) { %>
        <div class="offer-badge">
            <i class="fas fa-gift"></i> <%= restaurant.getOffer() %>
        </div>
        <% } %>
    </div>
</div>
<% } %>

<div class="menu-container">
    <h2 class="section-title">Our Menu</h2>
    
    <!-- Filter buttons -->
    <div class="filter-container">
        <button class="filter-btn active" data-filter="all">
            <i class="fas fa-utensils"></i> All Items
        </button>
        <button class="filter-btn" data-filter="veg">
            <span class="veg-icon"></span> Vegetarian
        </button>
        <button class="filter-btn" data-filter="nonveg">
            <span class="nonveg-icon"></span> Non-Vegetarian
        </button>
    </div>
    
    <% if (menuItems == null || menuItems.isEmpty()) { %>
        <div class="empty-menu">
            <i class="fas fa-utensils"></i>
            <h4>No menu items available.</h4>
        </div>
    <% } else { %>
        <div class="menu-grid" id="menu-grid">
        <% for (MenuItems item : menuItems) { 
               String itemImage = (item.getImageUrl() != null && !item.getImageUrl().isEmpty())
                                  ? (request.getContextPath() + "/images/food/" + item.getImageUrl())
                                  : (request.getContextPath() + "/images/food/default-food.png");
               String itemType = item.isVeg() ? "veg" : "nonveg";
        %>
            <div class="menu-card" data-type="<%= itemType %>">
                <img src="<%= itemImage %>" alt="Item Image" class="menu-item-image">
                <div class="menu-item-content">
                    <div class="item-header">
                        <div class="item-name">
                            <%= item.getItemName() %>
                        </div>
                        <div class="item-price">Rs. <%= item.getPrice() %></div>
                    </div>
                    <p class="item-description"><%= item.getDescription() != null ? item.getDescription() : "No description available" %></p>
                    <div class="item-footer">
                        <div class="veg-indicator">
                            <% if(item.isVeg()){ %>
                                <span class="veg-icon"></span> Vegetarian
                            <% } else { %>
                                <span class="nonveg-icon"></span> Non-Vegetarian
                            <% } %>
                        </div>
                          <!-- Add to Cart Form -->
						<form action="CartServlet" method="post" style="display:inline;">
						    <input type="hidden" name="action" value="add">
						    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
						    <input type="hidden" name="itemName" value="<%= item.getItemName() %>">
						    <input type="hidden" name="itemPrice" value="<%= item.getPrice() %>">
						    <button type="submit" class="add-btn">
						        <i class="fas fa-plus"></i> Add
						    </button>
						</form>

                    </div>
                </div>
            </div>
        <% } // end for %>
        </div>
    <% } // end else %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const filterButtons = document.querySelectorAll('.filter-btn');
        const menuCards = document.querySelectorAll('.menu-card');
        
        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                filterButtons.forEach(btn => btn.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                const filter = this.getAttribute('data-filter');
                
                // Filter menu items
                menuCards.forEach(card => {
                    if (filter === 'all') {
                        card.style.display = 'flex';
                    } else {
                        if (card.getAttribute('data-type') === filter) {
                            card.style.display = 'flex';
                        } else {
                            card.style.display = 'none';
                        }
                    }
                });
            });
        });
        
        // Add to cart functionality
        const addButtons = document.querySelectorAll('.add-btn');
        addButtons.forEach(button => {
            button.addEventListener('click', function() {
                const card = this.closest('.menu-card');
                const itemName = card.querySelector('.item-name').textContent;
                const itemPrice = card.querySelector('.item-price').textContent;
                
                // Animation for adding to cart
                this.innerHTML = '<i class="fas fa-check"></i> Added';
                this.style.backgroundColor = '#0f9d58';
                
                // Reset button after 1.5 seconds
                setTimeout(() => {
                    this.innerHTML = '<i class="fas fa-plus"></i> Add';
                    this.style.backgroundColor = '';
                }, 1500);
                
                // Here you would typically send an AJAX request to add the item to cart
                console.log(`Added to cart: ${itemName} - ${itemPrice}`);
            });
        });
    });
</script>
</body>
</html>
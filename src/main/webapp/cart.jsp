<%-- <!-- New Cart page -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.MenuItems, com.foodexpress.updatedDTO.User"%>
<%@ page import="com.foodexpress.updatedDAO.MenuDAO"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart | FoodExpress</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary: #ff6b35; --secondary: #2ec4b6; --dark: #2a2a2a; --light: #f8f9fa; --gray: #6c757d; --success: #28a745; --danger: #dc3545; --warning: #ffc107; --border-radius: 12px; --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08); --transition: all 0.3s ease;
}

body {
	background: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; color: var(--dark);
}

.cart-container {
	max-width: 1200px;
	margin: 40px auto;
	padding: 0 15px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.header-title {
	font-size: 28px;
	font-weight: 700;
	color: var(--dark);
	display: flex;
	align-items: center;
	gap: 10px;
}

.restaurant-badge {
	background: var(--secondary);
	color: white;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 5px;
}

.card {
	border: none;
	border-radius: var(--border-radius);
	box-shadow: var(--box-shadow);
	overflow: hidden;
	margin-bottom: 24px;
	transition: var(--transition);
}

.card:hover {
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
}

.cart-item {
	display: flex;
	align-items: center;
	padding: 20px;
	border-bottom: 1px solid #eee;
	transition: var(--transition);
}

.cart-item:last-child {
	border-bottom: none;
}

.cart-item:hover {
	background-color: #fafafa;
}

.item-image {
	width: 100px;
	height: 100px;
	border-radius: 12px;
	object-fit: cover;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.item-details {
	flex: 1;
	padding: 0 20px;
}

.item-name {
	font-weight: 600;
	font-size: 18px;
	margin-bottom: 5px;
	color: var(--dark);
}

.item-description {
	color: var(--gray);
	font-size: 14px;
	margin-bottom: 8px;
}

.item-price {
	font-weight: 700;
	color: var(--primary);
	font-size: 18px;
}

.quantity-controls {
	display: flex;
	align-items: center;
	gap: 10px;
}

.quantity-btn {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #ddd;
	background: white;
	font-size: 16px;
	cursor: pointer;
	transition: var(--transition);
}

.quantity-btn:hover {
	background: var(--light);
	transform: scale(1.05);
}

.quantity-display {
	font-weight: 600;
	min-width: 40px;
	text-align: center;
}

.item-total {
	font-weight: 700;
	font-size: 18px;
	color: var(--dark);
	min-width: 100px;
	text-align: right;
}

.remove-item {
	color: var(--danger);
	background: none;
	border: none;
	font-size: 18px;
	cursor: pointer;
	opacity: 0.7;
	transition: var(--transition);
	padding: 8px;
	border-radius: 50%;
}

.remove-item:hover {
	opacity: 1;
	background: rgba(220, 53, 69, 0.1);
}

.summary-card {
	background: white;
	border-radius: var(--border-radius);
	padding: 25px;
	box-shadow: var(--box-shadow);
	position: sticky;
	top: 30px;
}

.summary-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 2px solid #f0f0f0;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

.summary-total {
	display: flex;
	justify-content: space-between;
	font-weight: 700;
	font-size: 20px;
	padding-top: 15px;
	margin-top: 15px;
	border-top: 2px solid #f0f0f0;
}

.checkout-btn {
	background: var(--primary);
	color: white;
	border: none;
	padding: 15px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 18px;
	width: 100%;
	margin-top: 20px;
	transition: var(--transition);
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
}

.checkout-btn:hover {
	background: #e55a2a;
	transform: translateY(-2px);
}

.continue-shopping {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	color: var(--primary);
	font-weight: 600;
	text-decoration: none;
	margin-top: 20px;
	transition: var(--transition);
}

.continue-shopping:hover {
	color: #e55a2a;
	gap: 12px;
}

.empty-cart {
	text-align: center;
	padding: 60px 20px;
}

.empty-cart-icon {
	font-size: 80px;
	color: #ddd;
	margin-bottom: 20px;
}

.empty-cart-title {
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 15px;
	color: var(--gray);
}

.empty-cart-text {
	color: var(--gray);
	margin-bottom: 30px;
	max-width: 500px;
	margin-left: auto;
	margin-right: auto;
}

.login-prompt {
	text-align: center;
	padding: 60px 20px;
}

.suggested-items {
	margin-top: 40px;
}

.suggested-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 2px solid #f0f0f0;
}

.suggested-item {
	background: white;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	transition: var(--transition);
	cursor: pointer;
	height: 100%;
}

.suggested-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.suggested-img {
	height: 150px;
	width: 100%;
	object-fit: cover;
}

.suggested-details {
	padding: 15px;
}

.suggested-name {
	font-weight: 600;
	margin-bottom: 5px;
}

.suggested-price {
	color: var(--primary);
	font-weight: 700;
}

.add-suggested-btn {
	background: var(--primary);
	color: white;
	border: none;
	border-radius: 6px;
	padding: 6px 12px;
	font-size: 14px;
	margin-top: 10px;
	transition: var(--transition);
}

.add-suggested-btn:hover {
	background: #e55a2a;
}

.discount-badge {
	background: var(--secondary);
	color: white;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	display: inline-block;
	margin-left: 10px;
}

@media ( max-width : 768px) {
	.cart-item {
		flex-direction: column;
		text-align: center;
		padding: 15px;
	}
	.item-details {
		padding: 15px 0;
	}
	.quantity-controls {
		margin: 15px 0;
	}
	.header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
}
</style>
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<div class="cart-container">
		<%
		User currentUser = (User) session.getAttribute("currentUser");
		List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
		String restaurantName = (String) session.getAttribute("restaurantName");
		%>

		<div class="header">
			<h1 class="header-title">
				<i class="fas fa-shopping-cart"></i> My Shopping Cart
				<%
				if (restaurantName != null && cart != null && !cart.isEmpty()) {
				%>
				<span class="restaurant-badge"> <i class="fas fa-store"></i>
					<%=restaurantName%>
				</span>
				<%
				}
				%>
			</h1>
			<a
				href="<%=request.getContextPath()%>/DisplayMenu?restaurantId=<%=session.getAttribute("currentRestaurantId")%>"
				class="continue-shopping"> <i class="fas fa-arrow-left"></i>
				Continue Shopping
			</a>
		</div>

		<%
		if (currentUser == null) {
		%>
		<div class="card login-prompt">
			<i class="fas fa-lock empty-cart-icon"></i>
			<h3 class="empty-cart-title">Authentication Required</h3>
			<p class="empty-cart-text">Please log in to view and manage your
				cart items.</p>
			<a href="login.jsp" class="btn btn-primary btn-lg"> <i
				class="fas fa-sign-in-alt"></i> Login to Continue
			</a>
		</div>
		<%
		} else if (cart == null || cart.isEmpty()) {
		%>
		<div class="card empty-cart">
			<i class="fas fa-shopping-cart empty-cart-icon"></i>
			<h3 class="empty-cart-title">Your cart is empty</h3>
			<p class="empty-cart-text">Looks like you haven't added any items
				to your cart yet. Start exploring our restaurants and delicious
				food!</p>
			<a href="Home.jsp" class="btn btn-primary btn-lg"> <i
				class="fas fa-utensils"></i> Browse Restaurants
			</a>

			<!-- Suggested items section -->
			<div class="suggested-items">
				<h4 class="suggested-title">Popular Choices</h4>
				<div class="row">
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/ff6b35/white?text=Burger"
								class="suggested-img" alt="Burger">
							<div class="suggested-details">
								<div class="suggested-name">Classic Burger</div>
								<div class="suggested-price">₹199</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/2ec4b6/white?text=Pizza"
								class="suggested-img" alt="Pizza">
							<div class="suggested-details">
								<div class="suggested-name">Margherita Pizza</div>
								<div class="suggested-price">₹299</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/ff9e00/white?text=Pasta"
								class="suggested-img" alt="Pasta">
							<div class="suggested-details">
								<div class="suggested-name">Creamy Pasta</div>
								<div class="suggested-price">₹249</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/e71d36/white?text=Salad"
								class="suggested-img" alt="Salad">
							<div class="suggested-details">
								<div class="suggested-name">Fresh Salad</div>
								<div class="suggested-price">₹179</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%
		} else {
		double grandTotal = 0;
		double subtotal = 0;
		%>
		<div class="row">
			<div class="col-lg-8">
				<div class="card">
					<%
					MenuDAO menuDAO = new MenuDAO();
					for (OrderItem item : cart) {
						MenuItems menuItem = menuDAO.getMenuItemById(item.getItemId());
						double itemTotal = item.getPriceAtOrder() * item.getQuantity();
						subtotal += itemTotal;
					%>
					<div class="cart-item" id="item-<%=item.getItemId()%>">
						<img src="<%=menuItem.getImageUrl()%>"
							onerror="this.src='https://via.placeholder.com/100x100/f8f9fa/6c757d?text=Food+Item'"
							class="item-image"
							alt="https://www.imagesarovar.in/wp-content/uploads/edd/2024/11/indian-dish-rajma-chawal-in-plate-png-vector-illustration-pre-ydl8824.jpg">
						<div class="item-details">
							<div class="item-name"><%=menuItem.getItemName()%></div>
							<div class="item-description"><%=menuItem.getDescription() != null ? menuItem.getDescription() : "Delicious food item"%></div>
							<div class="item-price">
								₹<%=item.getPriceAtOrder()%></div>
						</div>
						<div class="quantity-controls">
							<button class="quantity-btn"
								onclick="updateQuantity(<%=item.getItemId()%>, <%=item.getQuantity() - 1%>)">
								<i class="fas fa-minus"></i>
							</button>
							<span class="quantity-display"><%=item.getQuantity()%></span>
							<button class="quantity-btn"
								onclick="updateQuantity(<%=item.getItemId()%>, <%=item.getQuantity() + 1%>)">
								<i class="fas fa-plus"></i>
							</button>
						</div>
						<div class="item-total">
							₹<%=itemTotal%></div>
						<button class="remove-item"
							onclick="removeItem(<%=item.getItemId()%>)">
							<i class="fas fa-trash"></i>
						</button>
					</div>
					<%
					}
					%>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="summary-card">
					<h3 class="summary-title">Order Summary</h3>

					<div class="summary-item">
						<span>Subtotal (<%=cart.size()%> items)
						</span> <span>₹<%=subtotal%></span>
					</div>

					<div class="summary-item">
						<span>Delivery Fee</span> <span>₹40</span>
					</div>

					<div class="summary-item">
						<span>Taxes & Charges</span> <span>₹20</span>
					</div>

					<div class="summary-item">
						<span>Discount <span class="discount-badge">SAVE10</span></span> <span
							style="color: var(--success);">-₹<%=Math.round(subtotal * 0.1)%></span>
					</div>

					<div class="summary-total">
						<span>Total Amount</span> <span>₹<%=subtotal + 40 + 20 - Math.round(subtotal * 0.1)%></span>
					</div>

					<button class="checkout-btn" onclick="proceedToCheckout()">
						<i class="fas fa-lock"></i> Proceed to Checkout
					</button>

					<div class="text-center">
						<a
							href="<%=request.getContextPath()%>/DisplayMenu?restaurantId=<%=session.getAttribute("restaurantId")%>"
							class="continue-shopping"> <i class="fas fa-arrow-left"></i>
							Continue Shopping
						</a>
					</div>
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>

	<script>
        function updateQuantity(itemId, newQty) {
            if (newQty < 1) {
                removeItem(itemId);
                return;
            }
            
            fetch("CartServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "itemId=" + itemId + "&quantity=" + newQty + "&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
            })
            .then(res => {
                if (res.status === 401) {
                    alert("Please login to update your cart.");
                    window.location.href = "login.jsp";
                } else {
                    window.location.reload();
                }
            })
            .catch(err => {
                console.error("Error updating quantity:", err);
                alert("An error occurred while updating the quantity.");
            });
        }
        
        function removeItem(itemId) {
            if (!confirm("Are you sure you want to remove this item from your cart?")) return;
            
            fetch("CartServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "itemId=" + itemId + "&quantity=0&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
            })
            .then(res => {
                if (res.status === 200) {
                    // Smoothly remove the item from view
                    const itemElement = document.getElementById('item-' + itemId);
                    if (itemElement) {
                        itemElement.style.opacity = '0';
                        itemElement.style.transition = 'opacity 0.3s ease';
                        setTimeout(() => {
                            window.location.reload();
                        }, 300);
                    } else {
                        window.location.reload();
                    }
                } else if (res.status === 401) {
                    alert("Please login to modify your cart.");
                    window.location.href = "login.jsp";
                }
            })
            .catch(err => {
                console.error("Error removing item:", err);
                alert("An error occurred while removing the item.");
            });
        }
        
        function proceedToCheckout() {
            window.location.href = "payment.jsp";
        }
        
        // Add animation to cart items on page load
        document.addEventListener('DOMContentLoaded', function() {
            const cartItems = document.querySelectorAll('.cart-item');
            cartItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    item.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body> --%>


<!-- New Cart page -->

<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.MenuItems, com.foodexpress.updatedDTO.User"%>
<%@ page import="com.foodexpress.updatedDAO.MenuDAO"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart | FoodExpress</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary: #ff6b35;
	--secondary: #2ec4b6;
	--dark: #2a2a2a;
	--light: #f8f9fa;
	--gray: #6c757d;
	--success: #28a745;
	--danger: #dc3545;
	--warning: #ffc107;
	--border-radius: 12px;
	--box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
	--transition: all 0.3s ease;
}

body {
	background: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: var(--dark);
}

.cart-container {
	max-width: 1200px;
	margin: 40px auto;
	padding: 0 15px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.header-title {
	font-size: 28px;
	font-weight: 700;
	color: var(--dark);
	display: flex;
	align-items: center;
	gap: 10px;
}

.restaurant-badge {
	background: var(--secondary);
	color: white;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 5px;
}

.card {
	border: none;
	border-radius: var(--border-radius);
	box-shadow: var(--box-shadow);
	overflow: hidden;
	margin-bottom: 24px;
	transition: var(--transition);
}

.card:hover {
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
}

.cart-item {
	display: flex;
	align-items: center;
	padding: 20px;
	border-bottom: 1px solid #eee;
	transition: var(--transition);
}

.cart-item:last-child {
	border-bottom: none;
}

.cart-item:hover {
	background-color: #fafafa;
}

.item-image {
	width: 100px;
	height: 100px;
	border-radius: 12px;
	object-fit: cover;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.item-details {
	flex: 1;
	padding: 0 20px;
}

.item-name {
	font-weight: 600;
	font-size: 18px;
	margin-bottom: 5px;
	color: var(--dark);
}

.item-description {
	color: var(--gray);
	font-size: 14px;
	margin-bottom: 8px;
}

.item-price {
	font-weight: 700;
	color: var(--primary);
	font-size: 18px;
}

.quantity-controls {
	display: flex;
	align-items: center;
	gap: 10px;
}

.quantity-btn {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #ddd;
	background: white;
	font-size: 16px;
	cursor: pointer;
	transition: var(--transition);
}

.quantity-btn:hover {
	background: var(--light);
	transform: scale(1.05);
}

.quantity-display {
	font-weight: 600;
	min-width: 40px;
	text-align: center;
}

.item-total {
	font-weight: 700;
	font-size: 18px;
	color: var(--dark);
	min-width: 100px;
	text-align: right;
}

.remove-item {
	color: var(--danger);
	background: none;
	border: none;
	font-size: 18px;
	cursor: pointer;
	opacity: 0.7;
	transition: var(--transition);
	padding: 8px;
	border-radius: 50%;
}

.remove-item:hover {
	opacity: 1;
	background: rgba(220, 53, 69, 0.1);
}

.summary-card {
	background: white;
	border-radius: var(--border-radius);
	padding: 25px;
	box-shadow: var(--box-shadow);
	position: sticky;
	top: 30px;
}

.summary-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 2px solid #f0f0f0;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

.summary-total {
	display: flex;
	justify-content: space-between;
	font-weight: 700;
	font-size: 20px;
	padding-top: 15px;
	margin-top: 15px;
	border-top: 2px solid #f0f0f0;
}

.checkout-btn {
	background: var(--primary);
	color: white;
	border: none;
	padding: 15px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 18px;
	width: 100%;
	margin-top: 20px;
	transition: var(--transition);
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
}

.checkout-btn:hover {
	background: #e55a2a;
	transform: translateY(-2px);
}

.continue-shopping {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	color: var(--primary);
	font-weight: 600;
	text-decoration: none;
	margin-top: 20px;
	transition: var(--transition);
}

.continue-shopping:hover {
	color: #e55a2a;
	gap: 12px;
}

.empty-cart {
	text-align: center;
	padding: 60px 20px;
}

.empty-cart-icon {
	font-size: 80px;
	color: #ddd;
	margin-bottom: 20px;
}

.empty-cart-title {
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 15px;
	color: var(--gray);
}

.empty-cart-text {
	color: var(--gray);
	margin-bottom: 30px;
	max-width: 500px;
	margin-left: auto;
	margin-right: auto;
}

.login-prompt {
	text-align: center;
	padding: 60px 20px;
}

.suggested-items {
	margin-top: 40px;
}

.suggested-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 2px solid #f0f0f0;
}

.suggested-item {
	background: white;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	transition: var(--transition);
	cursor: pointer;
	height: 100%;
}

.suggested-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.suggested-img {
	height: 150px;
	width: 100%;
	object-fit: cover;
}

.suggested-details {
	padding: 15px;
}

.suggested-name {
	font-weight: 600;
	margin-bottom: 5px;
}

.suggested-price {
	color: var(--primary);
	font-weight: 700;
}

.add-suggested-btn {
	background: var(--primary);
	color: white;
	border: none;
	border-radius: 6px;
	padding: 6px 12px;
	font-size: 14px;
	margin-top: 10px;
	transition: var(--transition);
}

.add-suggested-btn:hover {
	background: #e55a2a;
}

.discount-badge {
	background: var(--secondary);
	color: white;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	display: inline-block;
	margin-left: 10px;
}

@media ( max-width : 768px) {
	.cart-item {
		flex-direction: column;
		text-align: center;
		padding: 15px;
	}
	.item-details {
		padding: 15px 0;
	}
	.quantity-controls {
		margin: 15px 0;
	}
	.header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
}
</style>
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<div class="cart-container">
		<%
		User currentUser = (User) session.getAttribute("currentUser");
		List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
		String restaurantName = (String) session.getAttribute("restaurantName");
		%>

		<div class="header">
			<h1 class="header-title">
				<i class="fas fa-shopping-cart"></i> My Shopping Cart
				<%
				if (restaurantName != null && cart != null && !cart.isEmpty()) {
				%>
				<span class="restaurant-badge"> <i class="fas fa-store"></i>
					<%=restaurantName%>
				</span>
				<%
				}
				%>
			</h1>
			<a
				href="<%=request.getContextPath()%>/DisplayMenu?restaurantId=<%=session.getAttribute("currentRestaurantId")%>"
				class="continue-shopping"> <i class="fas fa-arrow-left"></i>
				Continue Shopping
			</a>
		</div>

		<%
		if (currentUser == null) {
		%>
		<div class="card login-prompt">
			<i class="fas fa-lock empty-cart-icon"></i>
			<h3 class="empty-cart-title">Authentication Required</h3>
			<p class="empty-cart-text">Please log in to view and manage your
				cart items.</p>
			<a href="login.jsp" class="btn btn-primary btn-lg"> <i
				class="fas fa-sign-in-alt"></i> Login to Continue
			</a>
		</div>
		<%
		} else if (cart == null || cart.isEmpty()) {
		%>
		<div class="card empty-cart">
			<i class="fas fa-shopping-cart empty-cart-icon"></i>
			<h3 class="empty-cart-title">Your cart is empty</h3>
			<p class="empty-cart-text">Looks like you haven't added any items
				to your cart yet. Start exploring our restaurants and delicious
				food!</p>
			<a href="Home.jsp" class="btn btn-primary btn-lg"> <i
				class="fas fa-utensils"></i> Browse Restaurants
			</a>

			<!-- Suggested items section -->
			<div class="suggested-items">
				<h4 class="suggested-title">Popular Choices</h4>
				<div class="row">
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/ff6b35/white?text=Burger"
								class="suggested-img" alt="Burger">
							<div class="suggested-details">
								<div class="suggested-name">Classic Burger</div>
								<div class="suggested-price">₹199</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/2ec4b6/white?text=Pizza"
								class="suggested-img" alt="Pizza">
							<div class="suggested-details">
								<div class="suggested-name">Margherita Pizza</div>
								<div class="suggested-price">₹299</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/ff9e00/white?text=Pasta"
								class="suggested-img" alt="Pasta">
							<div class="suggested-details">
								<div class="suggested-name">Creamy Pasta</div>
								<div class="suggested-price">₹249</div>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-6 mb-4">
						<div class="suggested-item">
							<img
								src="https://via.placeholder.com/300x200/e71d36/white?text=Salad"
								class="suggested-img" alt="Salad">
							<div class="suggested-details">
								<div class="suggested-name">Fresh Salad</div>
								<div class="suggested-price">₹179</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%
		} else {
		double subtotal = 0;
		%>
		<div class="row">
			<div class="col-lg-8">
				<div class="card">
					<%
					MenuDAO menuDAO = new MenuDAO();
					for (OrderItem item : cart) {
						MenuItems menuItem = menuDAO.getMenuItemById(item.getItemId());
						double itemTotal = item.getPriceAtOrder() * item.getQuantity();
						subtotal += itemTotal;
					%>
					<div class="cart-item" id="cart-item-<%=item.getItemId()%>">
						<img src="<%=menuItem.getImageUrl()%>"
							onerror="this.src='https://via.placeholder.com/100x100/f8f9fa/6c757d?text=Food+Item'"
							class="item-image" alt="<%=menuItem.getItemName()%>">
						<div class="item-details">
							<div class="item-name"><%=menuItem.getItemName()%></div>
							<div class="item-description"><%=menuItem.getDescription() != null ? menuItem.getDescription() : "Delicious food item"%></div>
							<div class="item-price">
								₹<%=item.getPriceAtOrder()%></div>
						</div>
						<div class="quantity-controls">
							<button class="quantity-btn"
								onclick="updateQuantity(<%=item.getItemId()%>, <%=item.getQuantity() - 1%>)">
								<i class="fas fa-minus"></i>
							</button>
							<span class="quantity-display"
								id="quantity-<%=item.getItemId()%>"><%=item.getQuantity()%></span>
							<button class="quantity-btn"
								onclick="updateQuantity(<%=item.getItemId()%>, <%=item.getQuantity() + 1%>)">
								<i class="fas fa-plus"></i>
							</button>
						</div>
						<div class="item-total" id="subtotal-<%=item.getItemId()%>">
							₹<%=itemTotal%></div>
						<button class="remove-item"
							onclick="removeItem(<%=item.getItemId()%>)">
							<i class="fas fa-trash"></i>
						</button>
					</div>
					<%
					}
					%>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="summary-card">
					<h3 class="summary-title">Order Summary</h3>

					<div class="summary-item">
						<span>Subtotal (<%=cart.size()%> items)
						</span> <span id="cart-subtotal">₹<%=subtotal%></span>
					</div>

					<div class="summary-item">
						<span>Delivery Fee</span> <span>₹40</span>
					</div>

					<div class="summary-item">
						<span>Taxes & Charges</span> <span>₹20</span>
					</div>

					<div class="summary-item">
						<span>Discount <span class="discount-badge">SAVE10</span></span> <span
							style="color: var(--success);" id="cart-discount">-₹<%=Math.round(subtotal * 0.1)%></span>
					</div>

					<div class="summary-total">
						<span>Total Amount</span> <span id="cart-total">₹<%=subtotal + 40 + 20 - Math.round(subtotal * 0.1)%></span>
					</div>

					<button class="checkout-btn" onclick="proceedToCheckout()">
						<i class="fas fa-lock"></i> Proceed to Checkout
					</button>

					<div class="text-center">
						<a
							href="<%=request.getContextPath()%>/DisplayMenu?restaurantId=<%=session.getAttribute("restaurantId")%>"
							class="continue-shopping"> <i class="fas fa-arrow-left"></i>
							Continue Shopping
						</a>
					</div>
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>

	<script>
	function updateQuantity(itemId, newQty) {
	    if (newQty < 1) {
	        removeItem(itemId);
	        return;
	    }

	    fetch("CartServlet", { 
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "itemId=" + itemId + "&quantity=" + newQty + "&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
	    })
	    .then(res => res.json())
	    .then(data => {
	        if (data.success) {
	            document.getElementById("quantity-" + itemId).innerText = newQty;
	            document.getElementById("subtotal-" + itemId).innerText = "₹" + data.updatedSubtotal;
	            document.getElementById("cart-total").innerText = "₹" + data.updatedTotal;
	        } else {
	            alert("Failed to update quantity.");
	        }
	    })
	    .catch(err => {
	        console.error("Error updating quantity:", err);
	        alert("An error occurred while updating the quantity.");
	    });
	}

	function removeItem(itemId) {
	    if (!confirm("Are you sure you want to remove this item from your cart?")) return;

	    fetch("CartServlet", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "itemId=" + itemId + "&quantity=0&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
	    })
	    .then(res => res.json())
	    .then(data => {
	        if (data.success) {
	            const itemEl = document.getElementById("cart-item-" + itemId);
	            if (itemEl) itemEl.remove();
	            document.getElementById("cart-total").innerText = "₹" + data.updatedTotal;
	        } else {
	            alert("Failed to remove item.");
	        }
	    })
	    .catch(err => {
	        console.error("Error removing item:", err);
	        alert("An error occurred while removing the item.");
	    });
	}

	function proceedToCheckout() {
	    window.location.href = "payment.jsp";
	}
	
	function changeQuantity(itemId, delta) {
	    const qtyEl = document.getElementById('quantity-' + itemId);
	    let currentQty = parseInt(qtyEl.innerText);
	    let newQty = currentQty + delta;

	    if (newQty < 1) {
	        removeItem(itemId);
	        return;
	    }

	    // Update backend via fetch
	    fetch("CartServlet", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "itemId=" + itemId + "&quantity=" + newQty + "&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
	    })
	    .then(res => res.json())
	    .then(data => {
	        if(data.success){
	            qtyEl.innerText = newQty;
	            document.getElementById("subtotal-" + itemId).innerText = "₹" + data.updatedSubtotal;
	            document.getElementById("cart-total").innerText = "₹" + data.updatedTotal;
	        } else {
	            alert("Failed to update quantity");
	        }
	    })
	    .catch(err => console.error(err));
	}

	function removeItem(itemId) {
	    if(!confirm("Are you sure you want to remove this item?")) return;

	    fetch("CartServlet", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "itemId=" + itemId + "&quantity=0&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
	    })
	    .then(res => res.json())
	    .then(data => {
	        if(data.success){
	            document.getElementById("cart-item-" + itemId).remove();
	            document.getElementById("cart-total").innerText = "₹" + data.updatedTotal;
	        } else {
	            alert("Failed to remove item");
	        }
	    })
	    .catch(err => console.error(err));
	}

	function proceedToCheckout(){
	    window.location.href = "payment.jsp";
	}

	// Animation for cart items
	document.addEventListener('DOMContentLoaded', function() {
	    const cartItems = document.querySelectorAll('.cart-item');
	    cartItems.forEach((item, index) => {
	        item.style.opacity = '0';
	        item.style.transform = 'translateY(20px)';
	        setTimeout(() => {
	            item.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
	            item.style.opacity = '1';
	            item.style.transform = 'translateY(0)';
	        }, index * 100);
	    });
	});
	</script>
</body>
</html> --%>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.MenuItems, com.foodexpress.updatedDTO.User"%>
<%@ page import="com.foodexpress.updatedDAO.MenuDAO"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart | FoodExpress</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Keep your previous styles intact here */
:root {
	--primary: #ff6b35;
	--secondary: #2ec4b6;
	--dark: #2a2a2a;
	--light: #f8f9fa;
	--gray: #6c757d;
	--success: #28a745;
	--danger: #dc3545;
	--warning: #ffc107;
	--border-radius: 12px;
	--box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
	--transition: all 0.3s ease;
}

body {
	background: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: var(--dark);
}

.cart-container {
	max-width: 1200px;
	margin: 40px auto;
	padding: 0 15px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.header-title {
	font-size: 28px;
	font-weight: 700;
	color: var(--dark);
	display: flex;
	align-items: center;
	gap: 10px;
}

.restaurant-badge {
	background: var(--secondary);
	color: white;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 5px;
}

.card {
	border: none;
	border-radius: var(--border-radius);
	box-shadow: var(--box-shadow);
	overflow: hidden;
	margin-bottom: 24px;
	transition: var(--transition);
}

.card:hover {
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
}

.cart-item {
	display: flex;
	align-items: center;
	padding: 20px;
	border-bottom: 1px solid #eee;
	transition: var(--transition);
}

.cart-item:last-child {
	border-bottom: none;
}

.cart-item:hover {
	background-color: #fafafa;
}

.item-image {
	width: 100px;
	height: 100px;
	border-radius: 12px;
	object-fit: cover;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.item-details {
	flex: 1;
	padding: 0 20px;
}

.item-name {
	font-weight: 600;
	font-size: 18px;
	margin-bottom: 5px;
	color: var(--dark);
}

.item-description {
	color: var(--gray);
	font-size: 14px;
	margin-bottom: 8px;
}

.item-price {
	font-weight: 700;
	color: var(--primary);
	font-size: 18px;
}

.quantity-controls {
	display: flex;
	align-items: center;
	gap: 10px;
}

.quantity-btn {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #ddd;
	background: white;
	font-size: 16px;
	cursor: pointer;
	transition: var(--transition);
}

.quantity-btn:hover {
	background: var(--light);
	transform: scale(1.05);
}

.quantity-display {
	font-weight: 600;
	min-width: 40px;
	text-align: center;
}

.item-total {
	font-weight: 700;
	font-size: 18px;
	color: var(--dark);
	min-width: 100px;
	text-align: right;
}

.remove-item {
	color: var(--danger);
	background: none;
	border: none;
	font-size: 18px;
	cursor: pointer;
	opacity: 0.7;
	transition: var(--transition);
	padding: 8px;
	border-radius: 50%;
}

.remove-item:hover {
	opacity: 1;
	background: rgba(220, 53, 69, 0.1);
}

.summary-card {
	background: white;
	border-radius: var(--border-radius);
	padding: 25px;
	box-shadow: var(--box-shadow);
	position: sticky;
	top: 30px;
}

.summary-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 2px solid #f0f0f0;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

.summary-total {
	display: flex;
	justify-content: space-between;
	font-weight: 700;
	font-size: 20px;
	padding-top: 15px;
	margin-top: 15px;
	border-top: 2px solid #f0f0f0;
}

.checkout-btn {
	background: var(--primary);
	color: white;
	border: none;
	padding: 15px;
	border-radius: 12px;
	font-weight: 600;
	font-size: 18px;
	width: 100%;
	margin-top: 20px;
	transition: var(--transition);
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
}

.checkout-btn:hover {
	background: #e55a2a;
	transform: translateY(-2px);
}

.continue-shopping {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	color: var(--primary);
	font-weight: 600;
	text-decoration: none;
	margin-top: 20px;
	transition: var(--transition);
}

.continue-shopping:hover {
	color: #e55a2a;
	gap: 12px;
}

.empty-cart {
	text-align: center;
	padding: 60px 20px;
}

.empty-cart-icon {
	font-size: 80px;
	color: #ddd;
	margin-bottom: 20px;
}

.empty-cart-title {
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 15px;
	color: var(--gray);
}

.empty-cart-text {
	color: var(--gray);
	margin-bottom: 30px;
	max-width: 500px;
	margin-left: auto;
	margin-right: auto;
}

.login-prompt {
	text-align: center;
	padding: 60px 20px;
}

.suggested-items {
	margin-top: 40px;
}

.suggested-title {
	font-size: 22px;
	font-weight: 700;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 2px solid #f0f0f0;
}

.suggested-item {
	background: white;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	transition: var(--transition);
	cursor: pointer;
	height: 100%;
}

.suggested-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.suggested-img {
	height: 150px;
	width: 100%;
	object-fit: cover;
}

.suggested-details {
	padding: 15px;
}

.suggested-name {
	font-weight: 600;
	margin-bottom: 5px;
}

.suggested-price {
	color: var(--primary);
	font-weight: 700;
}

.add-suggested-btn {
	background: var(--primary);
	color: white;
	border: none;
	border-radius: 6px;
	padding: 6px 12px;
	font-size: 14px;
	margin-top: 10px;
	transition: var(--transition);
}

.add-suggested-btn:hover {
	background: #e55a2a;
}

.discount-badge {
	background: var(--secondary);
	color: white;
	padding: 4px 10px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	display: inline-block;
	margin-left: 10px;
}

@media ( max-width : 768px) {
	.cart-item {
		flex-direction: column;
		text-align: center;
		padding: 15px;
	}
	.item-details {
		padding: 15px 0;
	}
	.quantity-controls {
		margin: 15px 0;
	}
	.header {
		flex-direction: column;
		align-items: flex-start;
		gap: 15px;
	}
}
</style>
</head>
<body>
<%@ include file="navbar.jsp"%>

<div class="cart-container">
<%
User currentUser = (User) session.getAttribute("currentUser");
List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
String restaurantName = (String) session.getAttribute("restaurantName");
%>

<div class="header">
    <h1 class="header-title">
        <i class="fas fa-shopping-cart"></i> My Shopping Cart
        <% if (restaurantName != null && cart != null && !cart.isEmpty()) { %>
        <span class="restaurant-badge"> <i class="fas fa-store"></i> <%=restaurantName%> </span>
        <% } %>
    </h1>
    <a href="<%=request.getContextPath()%>/DisplayMenu?restaurantId=<%=session.getAttribute("currentRestaurantId")%>"
        class="continue-shopping"> <i class="fas fa-arrow-left"></i> Continue Shopping
    </a>
</div>

<%
if (currentUser == null) {
%>
<div class="card login-prompt">
    <i class="fas fa-lock empty-cart-icon"></i>
    <h3 class="empty-cart-title">Authentication Required</h3>
    <p class="empty-cart-text">Please log in to view and manage your cart items.</p>
    <a href="login.jsp" class="btn btn-primary btn-lg"> <i class="fas fa-sign-in-alt"></i> Login to Continue </a>
</div>
<%
} else if (cart == null || cart.isEmpty()) {
%>
<div class="card empty-cart">
    <i class="fas fa-shopping-cart empty-cart-icon"></i>
    <h3 class="empty-cart-title">Your cart is empty</h3>
    <p class="empty-cart-text">Looks like you haven't added any items to your cart yet. Start exploring our restaurants and delicious food!</p>
    <a href="Home.jsp" class="btn btn-primary btn-lg"> <i class="fas fa-utensils"></i> Browse Restaurants </a>
</div>
<%
} else {
double subtotal = 0;
MenuDAO menuDAO = new MenuDAO();
%>
<div class="row">
<div class="col-lg-8">
    <div class="card">
        <% for (OrderItem item : cart) {
            MenuItems menuItem = menuDAO.getMenuItemById(item.getItemId());
            double itemTotal = item.getPriceAtOrder() * item.getQuantity();
            subtotal += itemTotal;
        %>
        <div class="cart-item" id="cart-item-<%=item.getItemId()%>">
            <img src="<%=menuItem.getImageUrl()%>" 
                 onerror="this.src='https://via.placeholder.com/100x100/f8f9fa/6c757d?text=Food+Item'" 
                 class="item-image" alt="<%=menuItem.getItemName()%>">
            <div class="item-details">
                <div class="item-name"><%=menuItem.getItemName()%></div>
                <div class="item-description"><%=menuItem.getDescription() != null ? menuItem.getDescription() : "Delicious food item"%></div>
                <div class="item-price">₹<%=item.getPriceAtOrder()%></div>
            </div>
            <div class="quantity-controls">
                <button class="quantity-btn" onclick="changeQuantity(<%=item.getItemId()%>,-1)"><i class="fas fa-minus"></i></button>
                <span class="quantity-display" id="quantity-<%=item.getItemId()%>"><%=item.getQuantity()%></span>
                <button class="quantity-btn" onclick="changeQuantity(<%=item.getItemId()%>,1)"><i class="fas fa-plus"></i></button>
            </div>
            <div class="item-total" id="subtotal-<%=item.getItemId()%>">₹<%=itemTotal%></div>
            <button class="remove-item" onclick="removeItem(<%=item.getItemId()%>)"><i class="fas fa-trash"></i></button>
        </div>
        <% } %>
    </div>
</div>

<div class="col-lg-4">
    <div class="summary-card">
        <h3 class="summary-title">Order Summary</h3>
        <div class="summary-item">
            <span>Subtotal (<%=cart.size()%> items)</span> <span id="cart-subtotal">₹<%=subtotal%></span>
        </div>
        <div class="summary-item">
            <span>Delivery Fee</span> <span>₹40</span>
        </div>
        <div class="summary-item">
            <span>Taxes & Charges</span> <span>₹20</span>
        </div>
        <div class="summary-item">
            <span>Discount <span class="discount-badge">SAVE10</span></span> <span style="color: var(--success);" id="cart-discount">-₹<%=Math.round(subtotal * 0.1)%></span>
        </div>
        <div class="summary-total">
            <span>Total Amount</span> <span id="cart-total">₹<%=subtotal + 40 + 20 - Math.round(subtotal * 0.1)%></span>
        </div>
        <button class="checkout-btn" onclick="proceedToCheckout()"><i class="fas fa-lock"></i> Proceed to Checkout</button>
    </div>
</div>
</div>
<% } %>
</div>

<script>
function changeQuantity(itemId, delta) {
    const qtyEl = document.getElementById('quantity-' + itemId);
    let currentQty = parseInt(qtyEl.innerText);
    let newQty = currentQty + delta;

    if (newQty < 1) {
        removeItem(itemId);
        return;
    }

    // Update backend via fetch
    fetch("CartServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "itemId=" + itemId + "&quantity=" + newQty + "&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
    })
    .then(res => res.json())
    .then(data => {
        if(data.success){
            qtyEl.innerText = newQty;
            document.getElementById("subtotal-" + itemId).innerText = "₹" + data.updatedSubtotal;
            document.getElementById("cart-total").innerText = "₹" + data.updatedTotal;
        } else {
            alert("Failed to update quantity");
        }
    })
    .catch(err => console.error(err));
}

function removeItem(itemId) {
    if(!confirm("Are you sure you want to remove this item?")) return;

    fetch("CartServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "itemId=" + itemId + "&quantity=0&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
    })
    .then(res => res.json())
    .then(data => {
        if(data.success){
            document.getElementById("cart-item-" + itemId).remove();
            document.getElementById("cart-total").innerText = "₹" + data.updatedTotal;
        } else {
            alert("Failed to remove item");
        }
    })
    .catch(err => console.error(err));
}

function proceedToCheckout(){
    window.location.href = "payment.jsp";
}
</script>

</body>
</html>  --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.MenuItems, com.foodexpress.updatedDTO.User"%>
<%@ page import="com.foodexpress.updatedDAO.MenuDAO"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Cart | FoodExpress</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Keep your previous styles intact */
:root {
    --primary: #ff6b35;
    --secondary: #2ec4b6;
    --dark: #2a2a2a;
    --light: #f8f9fa;
    --gray: #6c757d;
    --success: #28a745;
    --danger: #dc3545;
    --warning: #ffc107;
    --border-radius: 12px;
    --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    --transition: all 0.3s ease;
}

body {
    background: #f8f9fa;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: var(--dark);
}

.cart-container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 15px;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.header-title {
    font-size: 28px;
    font-weight: 700;
    color: var(--dark);
    display: flex;
    align-items: center;
    gap: 10px;
}

.restaurant-badge {
    background: var(--secondary);
    color: white;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    gap: 5px;
}

.card {
    border: none;
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow);
    overflow: hidden;
    margin-bottom: 24px;
    transition: var(--transition);
}

.card:hover {
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
}

.cart-item {
    display: flex;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #eee;
    transition: var(--transition);
}

.cart-item:last-child {
    border-bottom: none;
}

.cart-item:hover {
    background-color: #fafafa;
}

.item-image {
    width: 100px;
    height: 100px;
    border-radius: 12px;
    object-fit: cover;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
}

.item-details {
    flex: 1;
    padding: 0 20px;
}

.item-name {
    font-weight: 600;
    font-size: 18px;
    margin-bottom: 5px;
    color: var(--dark);
}

.item-description {
    color: var(--gray);
    font-size: 14px;
    margin-bottom: 8px;
}

.item-price {
    font-weight: 700;
    color: var(--primary);
    font-size: 18px;
}

.quantity-controls {
    display: flex;
    align-items: center;
    gap: 10px;
}

.quantity-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #ddd;
    background: white;
    font-size: 16px;
    cursor: pointer;
    transition: var(--transition);
}

.quantity-btn:hover {
    background: var(--light);
    transform: scale(1.05);
}

.quantity-display {
    font-weight: 600;
    min-width: 40px;
    text-align: center;
}

.item-total {
    font-weight: 700;
    font-size: 18px;
    color: var(--dark);
    min-width: 100px;
    text-align: right;
}

.remove-item {
    color: var(--danger);
    background: none;
    border: none;
    font-size: 18px;
    cursor: pointer;
    opacity: 0.7;
    transition: var(--transition);
    padding: 8px;
    border-radius: 50%;
}

.remove-item:hover {
    opacity: 1;
    background: rgba(220, 53, 69, 0.1);
}

/* Order summary */
.summary-card {
    background: white;
    border-radius: var(--border-radius);
    padding: 25px;
    box-shadow: var(--box-shadow);
    position: sticky;
    top: 30px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
}

.summary-title {
    font-size: 22px;
    font-weight: 700;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;
}

.summary-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
}

.summary-total {
    display: flex;
    justify-content: space-between;
    font-weight: 700;
    font-size: 20px;
    padding-top: 15px;
    margin-top: 15px;
    border-top: 2px solid #f0f0f0;
}

.checkout-btn {
    background: var(--primary);
    color: white;
    border: none;
    padding: 15px;
    border-radius: 12px;
    font-weight: 600;
    font-size: 18px;
    width: 100%;
    margin-top: 20px;
    transition: var(--transition);
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
}

.checkout-btn:hover {
    background: #e55a2a;
    transform: translateY(-2px);
}

.continue-shopping {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: var(--primary);
    font-weight: 600;
    text-decoration: none;
    margin-top: 20px;
    transition: var(--transition);
}

.continue-shopping:hover {
    color: #e55a2a;
    gap: 12px;
}

/* Discount badge */
.discount-badge {
    background-color: #007bff;
    color: white;
    padding: 3px 8px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 600;
}

/* Empty cart and login prompt */
.empty-cart, .login-prompt {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 80px 20px;
    min-height: 300px;
    width: 100%;
}

.empty-cart-icon {
    font-size: 80px;
    color: #ddd;
    margin-bottom: 20px;
}

.empty-cart-title {
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 15px;
    color: var(--gray);
}

.empty-cart-text, .login-prompt p {
    color: var(--gray);
    max-width: 500px;
    margin: 0 auto 20px auto;
}

/* Buttons inside empty cart or login prompt */
.empty-cart a, .login-prompt a {
    margin-top: 15px;
}

/* Responsive */
@media (max-width: 768px) {
    .cart-item {
        flex-direction: column;
        text-align: center;
        padding: 15px;
    }
    .item-details { padding: 15px 0; }
    .quantity-controls { margin: 15px 0; }
    .header { flex-direction: column; align-items: flex-start; gap: 15px; }
    .summary-card { position: static; margin-top: 20px; }
}

</style>
</head>
<body>
<%@ include file="navbar.jsp"%>

<div class="cart-container">
<%
User currentUser = (User) session.getAttribute("currentUser");
List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
String restaurantName = (String) session.getAttribute("restaurantName");
%>

<div class="header">
    <h1 class="header-title">
        <i class="fas fa-shopping-cart"></i> My Shopping Cart
        <% if (restaurantName != null && cart != null && !cart.isEmpty()) { %>
        <span class="restaurant-badge"> <i class="fas fa-store"></i> <%=restaurantName%> </span>
        <% } %>
    </h1>
    <a href="<%=request.getContextPath()%>/DisplayMenu?restaurantId=<%=session.getAttribute("currentRestaurantId")%>"
        class="continue-shopping"> <i class="fas fa-arrow-left"></i> Continue Shopping
    </a>
</div>

<%
if (currentUser == null) {
%>
<div class="card login-prompt">
    <i class="fas fa-lock empty-cart-icon"></i>
    <h3 class="empty-cart-title">Authentication Required</h3>
    <p class="empty-cart-text">Please log in to view and manage your cart items.</p>
    <a href="login.jsp" class="btn btn-primary btn-lg"> <i class="fas fa-sign-in-alt"></i> Login to Continue </a>
</div>
<%
} else if (cart == null || cart.isEmpty()) {
%>
<div class="card empty-cart">
    <i class="fas fa-shopping-cart empty-cart-icon"></i>
    <h3 class="empty-cart-title">Your cart is empty</h3>
    <p class="empty-cart-text">Looks like you haven't added any items to your cart yet. Start exploring our restaurants and delicious food!</p>
    <a href="Home.jsp" class="btn btn-primary btn-lg"> <i class="fas fa-utensils"></i> Browse Restaurants </a>
</div>
<%
} else {
double subtotal = 0;
MenuDAO menuDAO = new MenuDAO();
%>
<div class="row">
<div class="col-lg-8">
    <div class="card" id="cart-items-container">
        <% for (OrderItem item : cart) {
            MenuItems menuItem = menuDAO.getMenuItemById(item.getItemId());
            double itemTotal = item.getPriceAtOrder() * item.getQuantity();
            subtotal += itemTotal;
        %>
        <div class="cart-item" id="cart-item-<%=item.getItemId()%>">
            <img src="<%=menuItem.getImageUrl()%>" 
                 onerror="this.src='https://via.placeholder.com/100x100/f8f9fa/6c757d?text=Food+Item'" 
                 class="item-image" alt="<%=menuItem.getItemName()%>">
            <div class="item-details">
                <div class="item-name"><%=menuItem.getItemName()%></div>
                <div class="item-description"><%=menuItem.getDescription() != null ? menuItem.getDescription() : "Delicious food item"%></div>
                <div class="item-price">₹<%=item.getPriceAtOrder()%></div>
            </div>
            <div class="quantity-controls">
                <button class="quantity-btn" onclick="changeQuantity(<%=item.getItemId()%>,-1)"><i class="fas fa-minus"></i></button>
                <span class="quantity-display" id="quantity-<%=item.getItemId()%>"><%=item.getQuantity()%></span>
                <button class="quantity-btn" onclick="changeQuantity(<%=item.getItemId()%>,1)"><i class="fas fa-plus"></i></button>
            </div>
            <div class="item-total" id="subtotal-<%=item.getItemId()%>">₹<%=itemTotal%></div>
            <button class="remove-item" onclick="removeItem(<%=item.getItemId()%>)"><i class="fas fa-trash"></i></button>
        </div>
        <% } %>
    </div>
</div>

<div class="col-lg-4">
    <div class="summary-card">
        <h3 class="summary-title">Order Summary</h3>
        <div class="summary-item">
            <span>Subtotal (<%=cart.size()%> items)</span> <span id="cart-subtotal">₹<%=subtotal%></span>
        </div>
        <div class="summary-item">
            <span>Delivery Fee</span> <span>₹40</span>
        </div>
        <div class="summary-item">
            <span>Taxes & Charges</span> <span>₹20</span>
        </div>
        <div class="summary-item">
            <span>Discount <span class="discount-badge">SAVE10</span></span> <span style="color: var(--success);" id="cart-discount">-₹<%=Math.round(subtotal * 0.1)%></span>
        </div>
        <div class="summary-total">
            <span>Total Amount</span> <span id="cart-total">₹<%=subtotal + 40 + 20 - Math.round(subtotal * 0.1)%></span>
        </div>
        <button class="checkout-btn" onclick="proceedToCheckout()"><i class="fas fa-lock"></i> Proceed to Checkout</button>
    </div>
</div>
</div>
<% } %>
</div>

<script>
function updateSummary(data) {
    document.getElementById("cart-subtotal").innerText = "₹" + data.cartSubtotal;
    document.getElementById("cart-discount").innerText = "-₹" + data.cartDiscount;
    document.getElementById("cart-total").innerText = "₹" + data.cartTotal;
}

function changeQuantity(itemId, delta) {
    const qtyEl = document.getElementById('quantity-' + itemId);
    let currentQty = parseInt(qtyEl.innerText);
    let newQty = currentQty + delta;

    if (newQty < 1) {
        removeItem(itemId);
        return;
    }

    fetch("CartServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "itemId=" + itemId + "&quantity=" + newQty + "&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
    })
    .then(res => res.json())
    .then(data => {
        if(data.success){
            qtyEl.innerText = newQty;
            document.getElementById("subtotal-" + itemId).innerText = "₹" + data.updatedSubtotal;
            updateSummary(data);
        } else {
            alert(data.message || "Failed to update quantity");
        }
    })
    .catch(err => console.error(err));
}

function removeItem(itemId) {
    if(!confirm("Are you sure you want to remove this item?")) return;

    fetch("CartServlet", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "itemId=" + itemId + "&quantity=0&restaurantId=<%=session.getAttribute("currentRestaurantId")%>&price=0"
    })
    .then(res => res.json())
    .then(data => {
        if(data.success){
            document.getElementById("cart-item-" + itemId).remove();
            updateSummary(data);

            // Check if cart is empty
            const container = document.getElementById("cart-items-container");
            if(container.children.length === 0){
                container.innerHTML = `<div class="card empty-cart">
                    <i class="fas fa-shopping-cart empty-cart-icon"></i>
                    <h3 class="empty-cart-title">Your cart is empty</h3>
                    <p class="empty-cart-text">Looks like you haven't added any items to your cart yet.</p>
                    <a href="Home.jsp" class="btn btn-primary btn-lg"><i class="fas fa-utensils"></i> Browse Restaurants</a>
                </div>`;
                document.querySelector(".summary-card").style.display = "none";
            }
        } else {
            alert(data.message || "Failed to remove item");
        }
    })
    .catch(err => console.error(err));
}

function proceedToCheckout(){
    window.location.href = "payment.jsp";
}
</script>

</body>
</html>





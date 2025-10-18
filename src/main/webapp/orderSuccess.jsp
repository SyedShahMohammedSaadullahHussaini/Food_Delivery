<%@ page import="com.foodexpress.updatedDAO.OrdersDAO, com.foodexpress.updatedDAO.OrderItemDAO, com.foodexpress.updatedDAO.UserAddressDAO, com.foodexpress.updatedDAO.PaymentDAO" %>
<%@ page import="com.foodexpress.updatedDTO.Orders, com.foodexpress.updatedDTO.OrderItem, com.foodexpress.updatedDTO.UserAddress, com.foodexpress.updatedDTO.Payment" %>
<%@ page import="java.util.List, java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String orderIdStr = request.getParameter("orderId");
    Orders order = null;
    List<OrderItem> orderItems = null;
    UserAddress deliveryAddress = null;
    Payment payment = null;

    if(orderIdStr != null) {
        OrdersDAO orderDao = new OrdersDAO();
        order = orderDao.getOrderById(Integer.parseInt(orderIdStr));

        if(order != null) {
            OrderItemDAO orderItemDao = new OrderItemDAO();
            orderItems = orderItemDao.getItemsByOrderId(order.getOrderId());

            UserAddressDAO addressDao = new UserAddressDAO();
            deliveryAddress = addressDao.getAddressById(order.getDeliveryAddressId());

            PaymentDAO paymentDao = new PaymentDAO();
            payment = paymentDao.getPaymentByOrderId(order.getOrderId());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Order Confirmed | FoodExpress</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary: #ff6b35;
        --primary-light: #ff8c5a;
        --primary-dark: #e55a2a;
        --secondary: #2d3748;
        --light-bg: #fff8f5;
        --card-bg: #ffffff;
        --text-dark: #2d3748;
        --text-light: #718096;
        --success: #10b981;
        --border-radius: 16px;
        --shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        --transition: all 0.3s ease;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        background: var(--light-bg);
        font-family: 'Poppins', sans-serif;
        color: var(--text-dark);
        line-height: 1.6;
        overflow-x: hidden;
    }
    
    .order-success-container {
        max-width: 1000px;
        margin: 0 auto;
        padding: 20px;
        animation: fadeIn 0.8s ease;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .success-card {
        background: var(--card-bg);
        border-radius: var(--border-radius);
        box-shadow: var(--shadow);
        overflow: hidden;
        margin-bottom: 30px;
        animation: cardSlideUp 0.6s ease 0.2s both;
    }
    
    @keyframes cardSlideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .success-header {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
        padding: 40px 30px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .success-header::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: rgba(255, 255, 255, 0.3);
    }
    
    .success-header::after {
        content: "";
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        animation: pulse 4s infinite linear;
    }
    
    @keyframes pulse {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    .success-icon {
        font-size: 80px;
        margin-bottom: 15px;
        display: inline-block;
        position: relative;
        z-index: 1;
        animation: bounce 1.5s ease infinite, iconGlow 2s ease infinite alternate;
    }
    
    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% { transform: translateY(0); } 
        40% { transform: translateY(-15px); }
        60% { transform: translateY(-7px); }
    }
    
    @keyframes iconGlow {
        from { filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.5)); }
        to { filter: drop-shadow(0 0 15px rgba(255, 255, 255, 0.8)); }
    }
    
    .success-title {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 10px;
        position: relative;
        z-index: 1;
    }
    
    .success-subtitle {
        font-size: 18px;
        opacity: 0.9;
        font-weight: 400;
        position: relative;
        z-index: 1;
    }
    
    .order-details-section {
        padding: 30px;
    }
    
    .section-title {
        font-size: 20px;
        font-weight: 600;
        color: var(--primary);
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #ffe6db;
        display: flex;
        align-items: center;
        animation: titleSlideIn 0.5s ease 0.4s both;
    }
    
    @keyframes titleSlideIn {
        from { opacity: 0; transform: translateX(-20px); }
        to { opacity: 1; transform: translateX(0); }
    }
    
    .section-title i {
        margin-right: 10px;
        font-size: 22px;
    }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .info-card {
        background: #fff9f5;
        border-radius: 12px;
        padding: 20px;
        border-left: 4px solid var(--primary);
        transition: var(--transition);
        animation: cardFadeIn 0.6s ease 0.6s both;
    }
    
    @keyframes cardFadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .info-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }
    
    .info-label {
        font-size: 14px;
        color: var(--text-light);
        margin-bottom: 5px;
    }
    
    .info-value {
        font-size: 18px;
        font-weight: 600;
        color: var(--text-dark);
    }
    
    .order-items-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        animation: tableFadeIn 0.7s ease 0.8s both;
    }
    
    @keyframes tableFadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .order-items-table thead {
        background: var(--primary);
        color: white;
    }
    
    .order-items-table th {
        padding: 15px;
        text-align: left;
        font-weight: 500;
    }
    
    .order-items-table td {
        padding: 15px;
        border-bottom: 1px solid #e2e8f0;
        transition: var(--transition);
    }
    
    .order-items-table tbody tr:last-child td {
        border-bottom: none;
    }
    
    .order-items-table tbody tr:nth-child(even) {
        background: #f8f9fa;
    }
    
    .order-items-table tbody tr:hover td {
        background: #fff3ec;
        transform: scale(1.01);
    }
    
    .total-row {
        background: #fff3ec !important;
        font-weight: 700;
    }
    
    .total-row td {
        border-top: 2px solid #ffd2b3;
        font-size: 18px;
        color: var(--primary-dark);
    }
    
    .address-section, .payment-section {
        background: #fff9f5;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
        border-left: 4px solid var(--primary);
        transition: var(--transition);
        animation: sectionFadeIn 0.6s ease 1s both;
    }
    
    @keyframes sectionFadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .address-section:hover, .payment-section:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }
    
    .address-title, .payment-title {
        font-weight: 600;
        margin-bottom: 10px;
        color: var(--primary);
        display: flex;
        align-items: center;
    }
    
    .address-title i, .payment-title i {
        margin-right: 8px;
    }
    
    .address-details p, .payment-details p {
        margin-bottom: 5px;
    }
    
    .action-buttons {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #e2e8f0;
        animation: buttonsFadeIn 0.6s ease 1.2s both;
    }
    
    @keyframes buttonsFadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .btn-primary-custom {
        background: var(--primary);
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 600;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        position: relative;
        overflow: hidden;
    }
    
    .btn-primary-custom::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: 0.5s;
    }
    
    .btn-primary-custom:hover::before {
        left: 100%;
    }
    
    .btn-primary-custom:hover {
        background: var(--primary-dark);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
    }
    
    .btn-outline-custom {
        background: transparent;
        color: var(--primary);
        border: 2px solid var(--primary);
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 600;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
    }
    
    .btn-outline-custom:hover {
        background: var(--primary);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
    }
    
    .btn-icon {
        margin-right: 8px;
    }
    
    .status-badge {
        display: inline-block;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 500;
    }
    
    .status-confirmed {
        background: #e1f7e3;
        color: #2e7d32;
    }
    
    .progress-container {
        margin: 30px 0;
        padding: 20px;
        background: white;
        border-radius: var(--border-radius);
        box-shadow: var(--shadow);
        animation: progressFadeIn 0.8s ease 1.4s both;
    }
    
    @keyframes progressFadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .progress-steps {
        display: flex;
        justify-content: space-between;
        position: relative;
        margin: 30px 0;
    }
    
    .progress-steps::before {
        content: '';
        position: absolute;
        top: 15px;
        left: 0;
        right: 0;
        height: 4px;
        background: #e2e8f0;
        z-index: 1;
    }
    
    .progress-bar {
        position: absolute;
        top: 15px;
        left: 0;
        height: 4px;
        background: var(--primary);
        z-index: 2;
        transition: width 1.5s ease;
        width: 0%;
    }
    
    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
        z-index: 3;
    }
    
    .step-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #e2e8f0;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
        transition: var(--transition);
    }
    
    .step.active .step-icon {
        background: var(--primary);
        color: white;
        transform: scale(1.1);
    }
    
    .step-label {
        font-size: 14px;
        font-weight: 500;
        text-align: center;
    }
    
    .estimated-time {
        text-align: center;
        font-size: 16px;
        margin-top: 10px;
        color: var(--text-light);
    }
    
    @media (max-width: 768px) {
        .info-grid {
            grid-template-columns: 1fr;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .btn-primary-custom, .btn-outline-custom {
            width: 100%;
            margin-bottom: 10px;
        }
        
        .order-items-table {
            display: block;
            overflow-x: auto;
        }
        
        .progress-steps {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .progress-steps::before {
            top: 0;
            left: 20px;
            bottom: 0;
            width: 4px;
            height: auto;
        }
        
        .progress-bar {
            top: 0;
            left: 20px;
            width: 4px;
            height: 0%;
        }
        
        .step {
            flex-direction: row;
            margin-bottom: 20px;
            width: 100%;
        }
        
        .step-icon {
            margin-right: 15px;
            margin-bottom: 0;
        }
    }
</style>
</head>
<body>

<div class="order-success-container">
    <div class="success-card">
        <div class="success-header">
            <i class="fas fa-check-circle success-icon"></i>
            <h1 class="success-title">Order Confirmed!</h1>
            <p class="success-subtitle">Thank you for your order. We're preparing it with care.</p>
        </div>
        
        <div class="order-details-section">
            <!-- Order Progress -->
            <div class="progress-container">
                <div class="section-title">
                    <i class="fas fa-truck"></i> Order Status
                </div>
                
                <div class="progress-steps">
                    <div class="progress-bar" id="progressBar"></div>
                    
                    <div class="step active">
                        <div class="step-icon">
                            <i class="fas fa-utensils"></i>
                        </div>
                        <div class="step-label">Preparing</div>
                    </div>
                    
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-concierge-bell"></i>
                        </div>
                        <div class="step-label">Ready</div>
                    </div>
                    
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <div class="step-label">On the way</div>
                    </div>
                    
                    <div class="step">
                        <div class="step-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="step-label">Delivered</div>
                    </div>
                </div>
                
                <div class="estimated-time">
                    <i class="far fa-clock"></i> Estimated delivery: 30-40 minutes
                </div>
            </div>
            
            <!-- Order Summary -->
            <div class="section-title">
                <i class="fas fa-receipt"></i> Order Summary
            </div>
            
            <div class="info-grid">
                <div class="info-card">
                    <div class="info-label">Order ID</div>
                    <div class="info-value">#<%= order != null ? order.getOrderId() : "" %></div>
                </div>
                
                <div class="info-card">
                    <div class="info-label">Order Date</div>
                    <div class="info-value"><%= order != null ? order.getPlacedAt().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")) : "" %></div>
                </div>
                
                <div class="info-card">
                    <div class="info-label">Total Amount</div>
                    <div class="info-value">₹<%= order != null ? order.getTotalAmount() : "" %></div>
                </div>
                
                <div class="info-card">
                    <div class="info-label">Status</div>
                    <div class="info-value">
                        <span class="status-badge status-confirmed">
                            <%= order != null ? order.getStatus() : "" %>
                        </span>
                    </div>
                </div>
            </div>
            
            <!-- Order Items -->
            <div class="section-title">
                <i class="fas fa-utensils"></i> Order Items
            </div>
            
            <table class="order-items-table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Quantity</th>
                        <th>Unit Price</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    double orderTotal = 0;
                    if(orderItems != null) {
                        for(OrderItem item : orderItems) {
                            double itemTotal = item.getQuantity() * item.getPriceAtOrder();
                            orderTotal += itemTotal;
                %>
                    <tr>
                        <td><%= item.getItemId() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>₹<%= item.getPriceAtOrder() %></td>
                        <td>₹<%= itemTotal %></td>
                    </tr>
                <%
                        }
                    }
                %>
                    <tr class="total-row">
                        <td colspan="3" style="text-align: right;">Total</td>
                        <td>₹<%= orderTotal %></td>
                    </tr>
                </tbody>
            </table>
            
            <!-- Delivery Address -->
            <div class="section-title">
                <i class="fas fa-map-marker-alt"></i> Delivery Address
            </div>
            
            <div class="address-section">
                <div class="address-title">
                    <i class="fas fa-home"></i> <%= deliveryAddress != null ? deliveryAddress.getLabel() : "" %>
                </div>
                <div class="address-details">
                    <p><%= deliveryAddress != null ? deliveryAddress.getAddress() : "" %></p>
                    <p><%= deliveryAddress != null ? deliveryAddress.getCity() + " - " + deliveryAddress.getPincode() : "" %></p>
                </div>
            </div>
            
            <!-- Payment Details -->
            <div class="section-title">
                <i class="fas fa-credit-card"></i> Payment Information
            </div>
            
            <div class="payment-section">
                <div class="payment-title">
                    <i class="fas fa-wallet"></i> Payment Method
                </div>
                <div class="payment-details">
                    <p><strong><%= payment != null ? payment.getPaymentMethod() : "" %></strong></p>
                    <p>Amount Paid: ₹<%= payment != null ? payment.getAmountPaid() : "" %></p>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="index.jsp" class="btn-primary-custom">
                    <i class="fas fa-home btn-icon"></i> Continue Shopping
                </a>
                <a href="#" class="btn-outline-custom" onclick="window.print()">
                    <i class="fas fa-print btn-icon"></i> Print Receipt
                </a>
                <a href="order-tracking.jsp?orderId=<%= order != null ? order.getOrderId() : "" %>" class="btn-outline-custom">
                    <i class="fas fa-shipping-fast btn-icon"></i> Track Order
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Animate progress bar
    document.addEventListener('DOMContentLoaded', function() {
        // Progress bar animation
        setTimeout(function() {
            document.getElementById('progressBar').style.width = '25%';
        }, 1000);
        
        // Simulate order progress (for demo purposes)
        let currentStep = 1;
        const steps = document.querySelectorAll('.step');
        const progressBar = document.getElementById('progressBar');
        
        function updateProgress() {
            if (currentStep < 4) {
                steps[currentStep].classList.add('active');
                progressBar.style.width = (currentStep * 25) + '%';
                currentStep++;
                
                if (currentStep < 4) {
                    setTimeout(updateProgress, 3000);
                }
            }
        }
        
        // Start progress simulation after a delay
        setTimeout(updateProgress, 4000);
        
        // Add hover effects to cards
        const cards = document.querySelectorAll('.info-card, .address-section, .payment-section');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });
</script>
</body>
</html>
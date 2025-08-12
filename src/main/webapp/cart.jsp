<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%
  List<String> cart = (List<String>) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Your Cart</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container mt-4">
    <h2>Your Cart</h2>
    <ul class="list-group mb-3">
      <% if (cart != null) {
        for (String item : cart) {
      %>
        <li class="list-group-item"><%= item %></li>
      <% }} else { %>
        <li class="list-group-item">Your cart is empty.</li>
      <% } %>
    </ul>
    <a href="order-summary.jsp" class="btn btn-primary">Proceed to Checkout</a>
  </div>
</body>
</html>

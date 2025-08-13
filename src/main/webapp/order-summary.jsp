<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%
  List<String> cart = (List<String>) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Order Summary</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container mt-4">
    <h2>Order Summary</h2>
    <ul class="list-group">
      <% if (cart != null) {
        for (String item : cart) {
      %>
        <li class="list-group-item"><%= item %></li>
      <% }} else { %>
        <li class="list-group-item">No items to show.</li>
      <% } %>
    </ul>
    <div class="mt-3">
      <h5>Thank you for your order!</h5>
    </div>
  </div>
</body>
</html>

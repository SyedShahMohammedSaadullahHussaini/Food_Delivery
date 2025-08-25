<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>My Cart</title>
</head>
<body>
    <h2>Your Cart</h2>
    <%
        Map<String, Map<String, String>> cart = (Map<String, Map<String, String>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Your cart is empty.</p>
    <%
        } else {
    %>
        <table border="1" cellpadding="10">
            <tr>
                <th>Item</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
            <%
                double grandTotal = 0;
                for (Map<String, String> item : cart.values()) {
                    String name = item.get("name");
                    double price = Double.parseDouble(item.get("price"));
                    int quantity = Integer.parseInt(item.get("quantity"));
                    double total = price * quantity;
                    grandTotal += total;
            %>
                <tr>
                    <td><%= name %></td>
                    <td>Rs. <%= price %></td>
                    <td><%= quantity %></td>
                    <td>Rs. <%= total %></td>
                </tr>
            <% } %>
            <tr>
                <td colspan="3" align="right"><strong>Grand Total</strong></td>
                <td><strong>Rs. <%= grandTotal %></strong></td>
            </tr>
        </table>
    <%
        }
    %>
</body>
</html>

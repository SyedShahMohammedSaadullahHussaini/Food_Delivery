<%@ page import="java.util.*, com.foodexpress.updatedDTO.Restaurant" %>
<%
    List<Restaurant> results = (List<Restaurant>) request.getAttribute("searchResults");
    String keyword = (String) request.getAttribute("keyword");
%>

<h2>Search Results for: "<%= keyword %>"</h2>

<% if (results == null || results.isEmpty()) { %>
    <p>No restaurants found.</p>
<% } else { %>
    <ul>
        <% for (Restaurant r : results) { %>
            <li>
                <b><%= r.getRestaurantName() %></b> 
                - Cuisine: <%= r.getCuisine() %> 
                - Offer: <%= r.getOffer() %>
            </li>
        <% } %>
    </ul>
<% } %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.foodexpress.updatedDTO.User"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Zomato Navbar with Location Dropdown</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Lexend:wght@400;600;700&display=swap"
      rel="stylesheet"
    />

    <style>
      body {
        margin: 0;
        font-family: "Lexend", sans-serif;
      }

      .navbar {
        padding-right: 0px;
        margin: 0;
        display: flex;
        flex-wrap: nowrap;
        height: 100%;
        justify-content: space-between;
        align-items: center;
        position: relative;
        z-index: 4;
        background-color: white;
        border-bottom: 1px solid #ddd;
        padding: 5px 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .logo {
        font-size: 40px;
        font-weight: bold;
        font-style: italic;
        color: #1c1c1c;
      }

      .search-container {
        margin-top: 10px;
        position: relative;
        z-index: 1000;
        height: 100%;
        display: flex;
        align-items: center;
        background-color: white;
        border-radius: 8px;
        border: 1px solid #ddd;
        padding: 8px 12px;
        width: 500px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      }

      .location {
        display: flex;
        align-items: center;
        margin-right: 10px;
        color: #e35d6a;
        font-size: 14px;
        border-right: 1px solid #ccc;
        padding-right: 10px;
        cursor: pointer;
        position: relative;
      }

      .location i {
        margin-right: 5px;
      }

      .dropdown {
        display: none;
        position: absolute;
        top: 40px;
        left: 0;
        background: white;
        border: 1px solid #ddd;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        z-index: 1000;
        width: 200px;
      }

      .dropdown div {
        padding: 10px;
        cursor: pointer;
        font-size: 14px;
      }

      .dropdown div:hover {
        background: #f5f5f5;
      }

      .search-input {
        display: flex;
        align-items: center;
        flex: 1;
        padding-left: 10px;
        color: gray;
      }

      .search-input input {
        border: none;
        outline: none;
        width: 100%;
        font-size: 14px;
      }

      .search-input button {
        border: none;
        background: none;
        cursor: pointer;
        font-size: 14px;
        color: #e35d6a;
        margin-left: 5px;
      }

      .auth-links a {
        margin-left: 20px;
        text-decoration: none;
        color: #555;
        font-size: 20px;
      }

      .auth-links a:hover {
        color: #000;
      }

      /* ------------------ User dropdown CSS ------------------ */
      .user-dropdown {
        position: relative;
        display: flex;
        align-items: center;
        cursor: pointer;
        margin-left: 20px;
        font-size: 16px;
        font-weight: 600;
        color: #333;
      }

      .user-name {
        padding: 8px 12px;
        border-radius: 6px;
        transition: background 0.2s;
      }

      .user-name:hover {
        background: #f5f5f5;
      }

      .user-menu {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 5px;
        background: white;
        border: 1px solid #ddd;
        border-radius: 6px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        min-width: 150px;
        z-index: 1000;
        flex-direction: column;
      }

      .user-menu a {
        padding: 10px 15px;
        display: block;
        text-decoration: none;
        color: #333;
        font-size: 14px;
      }

      .user-menu a:hover {
        background: #f5f5f5;
        color: #e35d6a;
      }
    </style>
  </head>
  <body>
    <jsp:include page="auth.jsp" />
    <!-- OTP Popup (included but hidden) -->
    <div id="otpContainer">
      <jsp:include page="otpverify.jsp" />
    </div>

    <div class="navbar">
      <div class="logo">FoodieExpress</div>

      <div class="search-container">
        <div class="location" id="locationSelector">
          <i class="fa-solid fa-location-dot"></i>
          <span id="selectedCity">Current Location</span>
          <i class="fa-solid fa-caret-down" style="margin-left: 5px"></i>

          <!-- Dropdown Menu -->
          <div class="dropdown" id="cityDropdown">
            <div onclick="selectCity('Bengaluru')">Bengaluru</div>
            <div onclick="selectCity('Delhi')">Delhi</div>
            <div onclick="selectCity('Mumbai')">Mumbai</div>
            <div onclick="selectCity('Ahmedabad')">Ahmedabad</div>
          </div>
        </div>
        <!-- Hello -->

        <form action="SearchServlet" method="get" style="flex:1; display:flex;">
          <div class="search-input">
            <i class="fa-solid fa-magnifying-glass" style="color: gray"></i>
            <input type="text" name="query" placeholder="Search for restaurant, cuisine or a dish" />
            <button type="submit">Search</button>
          </div>
        </form>
      </div>
      
      <%  
        User u = (User) session.getAttribute("currentUser");
        if (u == null) {
      %>       
        <div class="auth-links">
          <a href="javascript:void(0);" onclick="openModal('loginModal')">Log in</a>
          <a href="javascript:void(0);" onclick="openModal('signinModal')">Sign up</a>
        </div>
      <% 
        } else { 
          String uName = u.getuName(); 
      %>
        <div class="user-dropdown" id="userDropdown">
          <div class="user-name"><%= uName %> <i class="fa-solid fa-caret-down" style="margin-left:5px;"></i></div>
          <div class="user-menu" id="userMenu">
            <a href="profile.jsp">Profile</a>
            <a href="orders.jsp">Orders</a>
            <a href="logout">Logout</a>
          </div>
        </div>
      <% } %>
    </div>

    <script>
      // City dropdown
      const locationSelector = document.getElementById("locationSelector");
      const cityDropdown = document.getElementById("cityDropdown");
      const selectedCity = document.getElementById("selectedCity");

      locationSelector.addEventListener("click", () => {
        cityDropdown.style.display =
          cityDropdown.style.display === "block" ? "none" : "block";
      });

      function selectCity(city) {
        selectedCity.textContent = city;
        cityDropdown.style.display = "none";
      }

      // Close city dropdown if clicked outside
      document.addEventListener("click", (event) => {
        if (!locationSelector.contains(event.target)) {
          cityDropdown.style.display = "none";
        }
      });

      // User dropdown toggle on click
      const userDropdown = document.getElementById("userDropdown");
      const userMenu = document.getElementById("userMenu");

      if (userDropdown) {
        userDropdown.addEventListener("click", (e) => {
          e.stopPropagation();
          userMenu.style.display =
            userMenu.style.display === "flex" ? "none" : "flex";
        });
      }

      // Close user menu if clicked outside
      document.addEventListener("click", (event) => {
        if (userMenu && !userDropdown.contains(event.target)) {
          userMenu.style.display = "none";
        }
      });
    </script>
  </body>
</html>

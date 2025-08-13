<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
        /* position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        height: 75px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 15px 30px;
        background-color: white;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); */

        
        padding-right: 0px;
        margin: 0;
        display: flex;
        flex-wrap: nowrap;
        height: 100%;
        -webkit-box-pack: justify;
        justify-content: space-between;
        -webkit-box-align: center;
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
        position: relative;
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

      /* Dropdown */
      .dropdown {
        display: none;
        position: absolute;
        top: 40px;
        left: 0;
        background: white;
        border: 1px solid #ddd;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        border-radius: 6px;
        z-index: 10;
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

      .auth-links a {
        margin-left: 20px;
        text-decoration: none;
        color: #555;
        font-size: 20px;
      }

      .auth-links a:hover {
        color: #000;
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
          <span id="selectedCity">Siliguri</span>
          <i class="fa-solid fa-caret-down" style="margin-left: 5px"></i>

          <!-- Dropdown Menu -->
          <div class="dropdown" id="cityDropdown">
            <div onclick="selectCity('Delhi')">Delhi</div>
            <div onclick="selectCity('Mumbai')">Mumbai</div>
            <div onclick="selectCity('Kolkata')">Kolkata</div>
            <div onclick="selectCity('Bengaluru')">Bengaluru</div>
            <div onclick="selectCity('Chennai')">Chennai</div>
            <div onclick="selectCity('Siliguri')">Siliguri</div>
          </div>
        </div>

        <div class="search-input">
          <i class="fa-solid fa-magnifying-glass" style="color: gray"></i>
          <input
            type="text"
            placeholder="Search for restaurant, cuisine or a dish"
          />
        </div>
      </div>

      <div class="auth-links">
        <a href="javascript:void(0);" onclick="openModal('loginModal')">Log in</a>
        <a href="javascript:void(0);" onclick="openModal('signinModal')">Sign up</a>
      </div>
    </div>

    <script>
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

      // Close dropdown if clicked outside
      document.addEventListener("click", (event) => {
        if (!locationSelector.contains(event.target)) {
          cityDropdown.style.display = "none";
        }
      });
      
    </script>
  </body>
</html>

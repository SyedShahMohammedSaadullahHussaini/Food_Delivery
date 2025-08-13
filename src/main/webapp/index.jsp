
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>FoodieExpress - Home</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Lexend:wght@400;600;700&display=swap" rel="stylesheet">

  <style>
  body{
  font-family: 'Lexend', sans-serif;
  
  }
    .navbar {
      /* background-color: rgba(255, 255, 255, 0.5); */
      background-color:transparent;
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      z-index: 10;
  /*     backdrop-filter: blur(5px); */
    }
    .navbar .nav-link,
    .navbar .navbar-brand {
      color: white !important;
      font-weight: 500;
    }
    .navbar .nav-link:hover,
    .navbar .navbar-brand:hover {
      color: #FFD700 !important;
    }

    .hero-section {
      position: relative;
      height: 100vh;
      overflow: hidden;
    }

    .hero-section video {
      position: absolute;
      top: 50%;
      left: 50%;
      width: 100%;
      height: 100%;
      object-fit: cover;
      transform: translate(-50%, -50%);
      z-index: 1;
    }

    .hero-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(to bottom, rgba(0, 0, 0, 0.4), rgba(28, 28, 28, 1));
      z-index: 2;
    }

    .hero-content {
      position: relative;
      z-index: 3;
      color: white;
      text-align: center;
      top: 50%;
      transform: translateY(-50%);
      padding: 0 20px;
    }

    .hero-content h1 {
      font-size: 4rem;
      font-weight: bold;
    }

    .hero-content p {
      font-size: 1.5rem;
      margin-top: 1rem;
    }

    @media (max-width: 768px) {
      .hero-content h1 {
        font-size: 2.5rem;
      }

      .hero-content p {
        font-size: 1.2rem;
      }
    }

    .category-scroll {
      display: flex;
      gap: 24px;
      overflow-x: auto;
      padding: 24px;
      background: white;
      hieght:400px;
    }

    .category-item {
      text-align: center;
      width: 100px;
      flex-shrink: 0;
    }

    .category-item img {
      width: 80px;
      height: 80px;
      object-fit: cover;
      border-radius: 50%;
    }

    .restaurant-section {
      padding: 40px;
      background-color: white;
    }

    .restaurant-card {
      border-radius: 12px;
      overflow: hidden;
      background: white;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      transition: transform 0.2s;
    }

    .restaurant-card:hover {
      transform: scale(1.02);
    }
	.category-scroll::-webkit-scrollbar {
  display: none;
}
.category-scroll {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none;    /* Firefox */
  padding-top:0;
}
.restaurants-scroll::-webkit-scrollbar {
  display: none;
}
.restaurants-scroll {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none;    /* Firefox */
  padding-top:0;
}
	
    .restaurant-card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
    }

    .restaurant-card .info {
      padding: 16px;
    }

    .restaurant-card .info h5 {
      margin: 0;
      font-weight: 600;
    }

    .restaurant-card .info .rating {
      color: green;
      font-weight: 500;
    }

    footer {
      background: #2D2D2D;
      color: white;
      padding: 20px;
      text-align: center;
    }
    .btn-scroll {
     border-radius: 100%;
    height: 34px;
    width:32px;
    padding: 0px 8px 8px 4px;
    background: rgba(2, 6, 12, 0.15);
    }
    h4{
    text-align: center;}

    /* Hide scrollbars */
    .scroll-wrapper::-webkit-scrollbar {
      display: none;
    }
    .scroll-wrapper {
      -ms-overflow-style: none;
      scrollbar-width: none;
    }
    .scroll-section {
      position: relative;
    }

    .scroll-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem;
      background-color: white;
      padding-bottom: 0;
    }

    .scroll-buttons {
      display: flex;
      gap: 10px;
    }

    .scroll-wrapper {
      display: flex;
      overflow-x: auto;
      scroll-behavior: smooth;
      padding: 0 1rem 1rem;
      gap: 1rem;
      background-color: white;
    }

    .category-item img, .restaurant-card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
      border-radius: 10px;
    }
    .space{
    padding: 0px 200px;
    hieght:100px;
    }
    
    .modal {
        
        margin: auto;
        min-height: 150px;
        min-width: 20rem;
        border-radius: 0.6rem;
        transform: scale(1);
        box-shadow: rgba(28, 28, 28, 0.15) 0px 1.2rem 7rem;
        transition: transform 0.25s;
        display: flex; align-items: center; justify-content: center;
        position: fixed;
  z-index: 1000;
  left: 0; top: 0;
}

/* .modal-content {
  background-color: #fff;
  padding: 30px;
  border-radius: 8px;
  width: 300px;
  position: relative;
} */


.box{
width: calc(100% + 0.5rem);
    display: flex
;
    -webkit-box-pack: justify;
    justify-content: space-between;
    -webkit-box-align: center;
    align-items: center;
    margin: 0px;
}
model input{
padding: 1.3rem 1.2rem;
    height: 4.8rem;
    background: rgb(255, 255, 255);
    border: 0.1rem solid rgb(207, 207, 207);
    font-size: 18px;
    width: 100%;
    outline: none;
    box-sizing: border-box;
    border-radius: 0.6rem;
    color: rgb(28, 28, 28);
}
    
      

.restaurants-scroll::-webkit-scrollbar {
    display: none; /* Hide scrollbar */
}

.restaurant-card {
    flex: 0 0 auto;
    
    background: #fff8dc; /* Cornsilk from your palette */
    border-radius: 10px;
    padding: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    text-align: center;
}

.restaurant-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
    
}
.restaurants-scroll {
    display: flex;
    overflow-x: auto;
    scroll-behavior: smooth;
}
.restaurants-scroll::-webkit-scrollbar {
    display: none;
}

      
  </style>
</head>
<body>




 <!--  <!-- Navbar -->
  <!-- <nav class="navbar navbar-expand-lg px-4 py-3">
    <div class="container-fluid">
      <a class="navbar-brand" href="index.jsp">
        <i class="bi bi-basket-fill"></i> FoodieExpress
      </a>
      <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarContent">
        <ul class="navbar-nav mb-2 mb-lg-0 align-items-center">
          <li class="nav-item">
            <a onclick="openlogin()" class="nav-link" ><i class="bi bi-box-arrow-in-right"></i>Login</a>
          </li>
          <li class="nav-item">
            <a onclick="openModal()" class="nav-link" ><i class="bi bi-person-plus-fill"></i>Sign Up</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
              <i class="bi bi-three-dots-vertical"></i>More
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="#"><i class="bi bi-shop"></i>Become a Partner</a></li>
              <li><a class="dropdown-item" href="#"><i class="bi bi-graph-up"></i>Investor Relations</a></li>
              <li><a class="dropdown-item" href="#"><i class="bi bi-briefcase-fill"></i>Careers</a></li>
              <li><a class="dropdown-item" href="#"><i class="bi bi-question-circle"></i>Help</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </nav>  -->

  <!-- Hero Section with Video -->
  <section class="hero-section">
    <video autoplay muted loop playsinline>
      <source src="https://b.zmtcdn.com/data/file_assets/2627bbed9d6c068e50d2aadcca11ddbb1743095810.mp4" type="video/mp4">
      Your browser does not support the video tag.
    </video>
    <div class="hero-overlay"></div>
    <div class="hero-content">
      <h1>FoodieExpress</h1>
      <h1>Delicious Food Delivered</h1>
      <p>Experience the best meals from top restaurants at your doorstep.</p>
		<a href="sendrest">Explore</a>
    </div>
  </section>

  
  <!-- Food Categories -->
<section class="space">
  <div class="scroll-header bg-white">
    <h4 class="fw-bold text-center">What's on your mind?</h4>
    <div class="scroll-buttons">
      <button class="btn btn-light btn-scroll" onclick="scrollLeft('categoryScroll')">&larr;</button>
      <button class="btn btn-light btn-scroll" onclick="scrollRight('categoryScroll')">&rarr;</button>
    </div>
  </div>
  <div class="category-scroll" id="categoryScroll">
    <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/6ef07bda-b707-48ea-9b14-2594071593d1_Dosa.png" alt="Dosa"></div>
    <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/6ef07bda-b707-48ea-9b14-2594071593d1_Idli.png" alt="Idli"></div>
    <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/8f508de7-e0ac-4ba8-b54d-def9db98959e_Salad-1.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2025/1/24/05a939eb-fd4e-4308-b989-d1c54f4421b3_northindian1.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/6ef07bda-b707-48ea-9b14-2594071593d1_Pizzas.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/17/58760e8e-324f-479e-88fa-31800120ea38_Rolls1.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/8f508de7-e0ac-4ba8-b54d-def9db98959e_burger.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2025/1/24/897bc750-6b57-4e7d-9365-87c1ab2c6d7e_Chinese2.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/8f508de7-e0ac-4ba8-b54d-def9db98959e_cake.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/8f508de7-e0ac-4ba8-b54d-def9db98959e_Pure%20Veg.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2025/1/24/186ebf5c-d9ad-4d2b-a2b0-77795e19241f_Salad2.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/6ef07bda-b707-48ea-9b14-2594071593d1_Paratha.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/f1263395-5d4a-4775-95dc-80ab6f3bbd89_pasta.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/6ef07bda-b707-48ea-9b14-2594071593d1_Noodles.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/8f508de7-e0ac-4ba8-b54d-def9db98959e_chocolate%20icecream.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/f1263395-5d4a-4775-95dc-80ab6f3bbd89_shawarma.png" alt="Biryani"></div>
        <div class="category-item"><img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/MERCHANDISING_BANNERS/IMAGES/MERCH/2024/7/2/8f508de7-e0ac-4ba8-b54d-def9db98959e_Shake.png" alt="Biryani"></div>
    </div>
</section>

<!-- Separator Line -->
<hr style="border: none; height: 1px; background-color: rgba(0, 0, 0, 0.25); margin: 0 24px;" />

  <!-- Restaurant Cards -->
  <section class="container my-5">
  
    <h2 class="mb-4">Top Restaurants</h2>
<div class="scroll-buttons">
      <button class="btn btn-light btn-scroll" onclick="scrollLeftRestaurant('restaurants-scroll')">&larr;</button>
      <button class="btn btn-light btn-scroll" onclick="scrollRightRestaurant('restaurants-scroll')">&rarr;</button>
    </div>
    <div class="restaurants-scroll" id="restaurants-scroll">
        <!-- Example restaurant card -->
        <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
              <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Pizza Hut</h5>
      <div class="rating">⭐ 4.3 • 35-40 mins</div>
      <p class="text-muted small mb-1">Pizzas</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
    <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Theobroma</h5>
      <div class="rating">⭐ 4.7 • 15-20 mins</div>
      <p class="text-muted small mb-1">Desserts, Bakery, Beverages</p>
      <p class="text-muted small">Ashok Nagar</p>
      <div class="small text-success fw-bold">25% OFF</div>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Burger King</h5>
      <div class="rating">⭐ 4.4 • 35-40 mins</div>
      <p class="text-muted small mb-1">Burgers, American</p>
      <p class="text-muted small">Shivaji Nagar</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
<img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
            <h5>Baskin Robbins - Ice Cream Desserts</h5>
      <div class="rating">⭐ 4.8 • 30-35 mins</div>
      <p class="text-muted small mb-1">Desserts, Ice Cream</p>
      <p class="text-muted small">Residency Road</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>WeFit - Protein Bowls, Salads & Sandwiches</h5>
      <div class="rating">⭐ 4.8 • 20-30 mins</div>
      <p class="text-muted small mb-1">Healthy Food, Salads, Keto, Snacks</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>NH1 Bowls - Highway To North</h5>
      <div class="rating">⭐ 4.6 • 20-30 mins</div>
      <p class="text-muted small mb-1">North Indian, Punjabi, Home Food</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Subway</h5>
      <div class="rating">⭐ 4.4 • 20-25 mins</div>
      <p class="text-muted small mb-1">Sandwich, Salads, Wrap, Healthy Food</p>
      <p class="text-muted small">Vittal Mallya Road</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
     <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>McDonald's</h5>
      <div class="rating">⭐ 4.4 • 20-25 mins</div>
      <p class="text-muted small mb-1">Burgers, Beverages, Cafe, Desserts</p>
      <p class="text-muted small">Ashok Nagar</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>KFC</h5>
      <div class="rating">⭐ 4.4 • 30-35 mins</div>
      <p class="text-muted small mb-1">Burgers, Fast Food, Rolls & Wraps</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Daily Kitchen - Everyday Homely Meals</h5>
      <div class="rating">⭐ 4.4 • 20-30 mins</div>
      <p class="text-muted small mb-1">Home Food, Indian, North Indian, Thalis</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Bakingo</h5>
      <div class="rating">⭐ 4.6 • 25-30 mins</div>
      <p class="text-muted small mb-1">Bakery, Desserts, Beverages, Snacks</p>
      <p class="text-muted small">Vasanth Nagar</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Burgerama</h5>
      <div class="rating">⭐ 4.3 • 35-40 mins</div>
      <p class="text-muted small mb-1">Burger</p>
      <p class="text-muted small">R.T. Nagar</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Zed The Baker</h5>
      <div class="rating">⭐ 4.4 • 35-40 mins</div>
      <p class="text-muted small mb-1">Desserts, European</p>
      <p class="text-muted small">Church Street</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
      <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>SMOOR</h5>
      <div class="rating">⭐ 4.6 • 30-35 mins</div>
      <p class="text-muted small mb-1">Asian, Burgers, Italian, Thai, Sushi, Salads, Pastas, Pizzas, Mexican, Chinese</p>
      <p class="text-muted small">Lavelle Road</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
<img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>BOX8 - Desi Meals</h5>
      <div class="rating">⭐ 4.6 • 20-30 mins</div>
      <p class="text-muted small mb-1">North Indian, Biryani, Thalis, Home Food</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
<img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>      <h5>ZAZA Mughal Biryani</h5>
      <div class="rating">⭐ 4.4 • 20-30 mins</div>
      <p class="text-muted small mb-1">Biryani, North Indian, Awadhi</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
<img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>      <h5>LeanCrust Pizza - ThinCrust Experts</h5>
      <div class="rating">⭐ 4.6 • 20-30 mins</div>
      <p class="text-muted small mb-1">Pizzas, Italian, Desserts</p>
      <p class="text-muted small">Central Bangalore</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
<img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>      <h5>Truffles</h5>
      <div class="rating">⭐ 4.6 • 25-30 mins</div>
      <p class="text-muted small mb-1">American, Desserts, Continental, Italian</p>
      <p class="text-muted small">St. Marks Road</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
    <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Sweet Chariot</h5>
      <div class="rating">⭐ 4.7 • 35-40 mins</div>
      <p class="text-muted small mb-1">Desserts</p>
      <p class="text-muted small">Ashok Nagar</p>
    </div>

    <div class="restaurant-card border rounded bg-white p-2" style="min-width: 250px;">
    <img src="https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/RX_THUMBNAIL/IMAGES/VENDOR/2025/6/9/c68665d3-1a31-4b58-baf5-81ba0a0945fb_10575.JPG" alt="Burger King" class="img-fluid rounded-top">
      <div class="small text-danger fw-bold">ITEMS AT ₹99</div>
      <h5>Glen's Bakehouse</h5>
      <div class="rating">⭐ 4.7 • 30-35 mins</div>
      <p class="text-muted small mb-1">Desserts, Bakery, Beverages, Continental, Italian</p>
      <p class="text-muted small">Ashok Nagar</p>
    </div>

        <!-- Add more restaurant cards here -->
    </div>
</section>


  <!-- Footer -->
  <footer>
    &copy; 2025 FoodieExpress. Built with ❤️ for food lovers.
  </footer>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  function scrollLeft(id) {
    document.getElementById(id).scrollBy({ left: -200, behavior: 'smooth' });
  }
  function scrollRight(id) {
    document.getElementById(id).scrollBy({ left: 200, behavior: 'smooth' });
  }
</script>
 <script>
  function scrollLeftRestaurant(id) {
    document.getElementById(id).scrollBy({ left: -200, behavior: 'smooth' });
  }
  function scrollRightRestaurant(id) {
    document.getElementById(id).scrollBy({ left: 200, behavior: 'smooth' });
  }
</script>
<script>
  function openModal() {
    document.getElementById("signinModal").style.display = "flex";
  }

  function closeModal() {
    document.getElementById("signinModal").style.display = "none";
  }
  
  function openlogin() {
	    document.getElementById("open-login").style.display = "flex";
	  }

	  function closelogin() {
	    document.getElementById("open-login").style.display = "none";
	  }

  function handleGoogleLogin() {
    alert("You clicked Google Sign-In. You can implement Google OAuth here.");
    // Redirect to your OAuth servlet or Google flow here
  }
  
//Close main signup modal
  function closeModal() {
    document.getElementById('signinModal').style.display = 'none';
  }

  // Close OTP modal
  function closeOtpModal() {
    document.getElementById('otpModal').style.display = 'none';
  }

  // Show OTP modal after sign up form submit
  document.getElementById('signupForm').addEventListener('submit', function (e) {
    e.preventDefault();

    // Hide Sign Up modal
    closeModal();

    // Show OTP modal
    document.getElementById('otpModal').style.display = 'block';

    // You can also send the form data here via AJAX to your SignupServlet before showing OTP modal
  });

  // Auto move focus in OTP inputs
  document.querySelectorAll('.otp-box').forEach((input, index, inputs) => {
    input.addEventListener('input', () => {
      if (input.value.length === 1 && index < inputs.length - 1) {
        inputs[index + 1].focus();
      }
    });
  });
  function showOtpPopup() {
	    document.getElementById('otpPopup').classList.add('active');
	}
</script>

</body>
</html> 

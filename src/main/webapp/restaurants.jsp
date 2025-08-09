<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Restaurants - FoodieExpress</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container mt-4">
    <h2 class="text-center mb-4">Available Restaurants</h2>
    <div class="row">
      <div class="col-md-4 mb-3">
        <div class="card">
          <img src="images/restaurant1.jpg" class="card-img-top" alt="...">
          <div class="card-body text-center">
            <h5 class="card-title">Tasty Bites</h5>
            <a href="menu.jsp" class="btn btn-primary">View Menu</a>
          </div>
        </div>
      </div>
      <!-- Repeat above block for more restaurants -->
    </div>
  </div>
</body>
</html>

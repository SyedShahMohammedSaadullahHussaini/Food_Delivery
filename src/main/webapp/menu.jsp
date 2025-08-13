<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Menu - Tasty Bites</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container mt-4">
    <h2 class="text-center mb-4">Menu - Tasty Bites</h2>
    <form method="post" action="order">
      <div class="row">
        <div class="col-md-6">
          <div class="card mb-3">
            <div class="card-body">
              <h5 class="card-title">Veg Burger</h5>
              <p class="card-text">Price: ₹120</p>
              <input type="checkbox" name="items" value="Veg Burger"> Add to Cart
            </div>
          </div>
        </div>
        <!-- More items -->
      </div>
      <div class="text-center">
        <button type="submit" class="btn btn-success">Place Order</button>
      </div>
    </form>
  </div>
</body>
</html>

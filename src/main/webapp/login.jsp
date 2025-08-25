<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - FoodieExpress</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <div class="card shadow">
          <div class="card-header bg-dark text-white text-center">
            <h3>Login</h3>
          </div>
          <div class="card-body">
            <form method="post" action="/UserLogin">
              <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required>
              </div>
              <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required>
              </div>
              <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
            <c:if test="${not empty errorMessage}">
   				 <p style="color:red;">${errorMessage}</p>
			</c:if>
          </div>
          <div class="card-footer text-center">
            Don't have an account? <a href="signup.jsp">Sign up</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>

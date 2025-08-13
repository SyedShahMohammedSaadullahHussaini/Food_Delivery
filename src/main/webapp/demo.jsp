<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.login-title {
        text-align: center;
        font-weight: bold;
        margin-bottom: 20px;
      }
      .login-container {
       /*  background: rgba(255, 255, 255, 0.95);
        padding: 0px 2.4rem 2.4rem;
        border-radius: 15px;
        height:500px;
       width: 100%;
       max-width: 550px;
       margin-left: 500px; 
       transition: transform 0.25s;
       transform: scale(1);
        box-shadow: rgba(28, 28, 28, 0.15) 0px 1.2rem 7rem;  */
     
  padding: 3rem 2.4rem;
  border-radius: 15px;
  height: auto;
min-height: unset; /* removes the force */

  width: 100%;
  max-width: 550px;
  margin: 50px auto; 
  transition: transform 0.25s;
  transform: scale(1);
  box-shadow: rgba(28, 28, 28, 0.15) 0px 1.2rem 7rem;
  background: rgba(255, 255, 255, 0.95);
}
.close {
  
  margin-left:100%;
  margin-bottom:10px;
  
  font-size: 22px;
  cursor: pointer;
}



       
      }
      .signup-title {
        text-align: center;
        font-weight: bold;
        margin-bottom: 20px;
      }
      .btn-custom {
        background-color: #ff6347;
        color: white;
      }
      .btn-custom:hover {
        background-color: #e5533f;
      }
      .restaurants-scroll {
    display: flex;
    overflow-x: auto;
    gap: 15px;
    padding-bottom: 10px;
    scroll-behavior: smooth;
}
.otp-box {
    width: 50px;
    height: 50px;
    text-align: center;
    font-size: 1.5rem;
  }
  .signup-container {
        background: rgba(255, 255, 255, 0.95);
        padding: 0px 2.4rem 2.4rem;
        border-radius: 15px;
       /*  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);  */
       width: 100%;
       max-width: 550px;
       
       transition: transform 0.25s;
       transform: scale(1);
        box-shadow: rgba(28, 28, 28, 0.15) 0px 1.2rem 7rem; 
      
       
      }
</style>
</head>
<body>
<!-- Sign In Popup Modal -->
<div id="signinModal" class="modal" style="display:none;">
  <div class="signup-container">
    
         <span class="close" onclick="closeModal()">&times;</span>
    
    <h2 class="signup-title">Create Your Account</h2>
    <form action="SignupServlet" method="post">
   
        <div class="mb-3">
          <label for="name" class="form-label">Full Name</label>
          <input
            type="text"
            name="name"
            id="name"
            class="form-control"
            placeholder="Enter full name"
            required
          />
        </div>

        <div class="mb-3">
          <label for="email" class="form-label">Email Address</label>
          <input
            type="email"
            name="email"
            id="email"
            class="form-control"
            placeholder="Enter email"
            required
          />
        </div>

        <div class="mb-3">
          <label for="phone" class="form-label">Phone Number</label>
          <input
            type="text"
            name="phone"
            id="phone"
            class="form-control"
            placeholder="Enter phone number"
            required
          />
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Create Password</label>
          <input
            type="password"
            name="password"
            id="password"
            class="form-control"
            placeholder="Enter password"
            required
          />
        </div>

        <div class="mb-3">
          <label for="confirmPassword" class="form-label"
            >Confirm Password</label
          >
          <input
            type="password"
            name="confirmPassword"
            id="confirmPassword"
            class="form-control"
            placeholder="Confirm password"
            required
          />
        </div>

        <div class="d-grid">
          <button type="submit" class="btn btn-custom">Sign Up</button>
        </div>
      </form>

      <p class="text-center mt-3">
        Already have an account?
        <a href="login.jsp" class="text-decoration-none">Sign In</a>
      </p>
    </div>

    
   <!--  <hr>

    Custom Google Sign-in Button
    <button onclick="handleGoogleLogin()" style="background-color:#DB4437; color:white; border:none; padding:10px 20px; border-radius:5px;">
      Sign in with Google
    </button> -->
  </div>
</div>


<!-- OTP Popup Modal -->
<div id="otpPopup" class="modal" style="display:none;">
  <div class="signup-container">
    <span class="close" onclick="closeOtpModal()">&times;</span>
    <h2 class="signup-title">Verify OTP</h2>
    <p class="text-center">We sent a 6-digit OTP to your email.</p>

    <form id="otpForm" method="post" action="VerifyOtpServlet">
      <div style="display: flex; justify-content: center; gap: 10px; margin: 20px 0;">
        <input type="text" name="otp1" maxlength="1" class="form-control otp-box" required />
        <input type="text" name="otp2" maxlength="1" class="form-control otp-box" required />
        <input type="text" name="otp3" maxlength="1" class="form-control otp-box" required />
        <input type="text" name="otp4" maxlength="1" class="form-control otp-box" required />
        <input type="text" name="otp5" maxlength="1" class="form-control otp-box" required />
        <input type="text" name="otp6" maxlength="1" class="form-control otp-box" required />
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-custom">Verify OTP</button>
      </div>
    </form>
  </div>
</div>






<!-- Login IN Pop Up -->
<div id="open-login" class="modal" style="display:none;">
  <div class="login-container">
    
         <span class="close" onclick="closelogin()">&times;</span>
    
    <h2 class="login-title">Login</h2>
    <form action="SignupServlet" method="post">
   
        

        <div class="mb-3">
          <label for="email" class="form-label">Email Address</label>
          <input
            type="email"
            name="email"
            id="email"
            class="form-control"
            placeholder="Enter email"
            required
          />
        </div>


        <div class="mb-3">
          <label for="confirmPassword" class="form-label"
            > Password</label
          >
          <input
            type="password"
            name="confirmPassword"
            id="confirmPassword"
            class="form-control"
            placeholder="Confirm password"
            required
          />
        </div>

        <div class="d-grid">
          <button type="submit" class="btn btn-custom">Login</button>
        </div>
      </form>

      <p class="text-center mt-3">
        New Here?
        <a href="login.jsp" class="text-decoration-none">Sign Up</a>
      </p>
    </div>

    
   <!--  <hr>

    Custom Google Sign-in Button
    <button onclick="handleGoogleLogin()" style="background-color:#DB4437; color:white; border:none; padding:10px 20px; border-radius:5px;">
      Sign in with Google
    </button> -->
  </div>
</div>

</body>
</html>
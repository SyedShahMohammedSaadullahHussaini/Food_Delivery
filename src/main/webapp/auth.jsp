<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.modal {
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.6);
  display: none;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}
.modal-content {
  background: white;
  padding: 2rem;
  border-radius: 15px;
  max-width: 550px;
  width: 100%;
  box-shadow: rgba(28, 28, 28, 0.15) 0px 1.2rem 7rem;
}
.close {
  float: right;
  font-size: 22px;
  cursor: pointer;
}
.btn-custom {
  background-color: #ff6347;
  color: white;
}
.btn-custom:hover {
  background-color: #e5533f;
}
</style>

<!-- Signup Modal -->
<div id="signinModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('signinModal')">&times;</span>
    <h2 class="text-center">Create Your Account</h2>
    <form  method="get" onsubmit="return openModal('otpmodel')">
      <input type="text" name="name" placeholder="Full Name" class="form-control mb-3" required>
      <input type="email" name="email" placeholder="Email" class="form-control mb-3" required>
      <input type="text" name="phone" placeholder="Phone Number" class="form-control mb-3" required>
      <input type="password" name="password" placeholder="Password" class="form-control mb-3" required>
      <input type="password" name="confirmPassword" placeholder="Confirm Password" class="form-control mb-3" required>
      <button  type="submit"  class="btn btn-custom w-100"   >Sign Up</button>
    </form>
    <p class="text-center mt-3">
      Already have an account?
      <a href="javascript:void(0);" onclick="switchModal('signinModal','loginModal')">Login</a>
    </p>
  </div>
</div>

<!-- Login Modal -->
<div id="loginModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('loginModal')">&times;</span>
    <h2 class="text-center">Login</h2>
    <form action="LoginServlet" method="post">
      <input type="email" name="email" placeholder="Email" class="form-control mb-3" required>
      <input type="password" name="password" placeholder="Password" class="form-control mb-3" required>
      <button type="submit"  class="btn btn-custom w-100">Login</button>
    </form>
    <p class="text-center mt-3">
      New here?
      <a href="javascript:void(0);" onclick="switchModal('loginModal','signinModal')">Sign Up</a>
    </p>
  </div>
</div>

<script>
function openModal(id) {
  document.getElementById(id).style.display = "flex";
}
function closeModal(id) {
  document.getElementById(id).style.display = "none";
}
function switchModal(hideId, showId) {
  closeModal(hideId);
  openModal(showId);
}
window.onclick = function(e) {
  document.querySelectorAll('.modal').forEach(modal => {
    if (e.target === modal) modal.style.display = "none";
  });
};
</script>

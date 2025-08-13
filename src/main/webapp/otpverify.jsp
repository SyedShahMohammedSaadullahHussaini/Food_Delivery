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
  max-width: 400px;
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
.resend-otp {
  display: block;
  margin-top: 10px;
  text-align: center;
  color: #ff6347;
  cursor: pointer;
}
.resend-otp:hover {
  text-decoration: underline;
}
</style>

<!-- OTP Verification Modal -->
<div id="otpModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('otpModal')">&times;</span>
    <h2 class="text-center">OTP Verification</h2>
    <p class="text-center">We have sent a 6-digit OTP to your registered email/phone.</p>
    
    <form action="register" method="post">
      <input type="text" name="otp" placeholder="Enter OTP" maxlength="6" class="form-control mb-3" required>
      <button type="submit" class="btn btn-custom w-100">Verify OTP</button>
    </form>

    <a class="resend-otp" href="ResendOtpServlet">Resend OTP</a>
  </div>
</div>

<script>
function openModal(id) {
  document.getElementById(id).style.display = "flex";
}
function closeModal(id) {
  document.getElementById(id).style.display = "none";
}
window.onclick = function(e) {
  document.querySelectorAll('.modal').forEach(modal => {
    if (e.target === modal) modal.style.display = "none";
  });
};
</script>

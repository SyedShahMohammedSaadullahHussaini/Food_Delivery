package com.food.controller;

import java.io.IOException;
import java.time.Instant;

import com.User.dto.User;
import com.food.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verifyOtp")
public class VerifyOtp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserDAO dao;

	@Override
	public void init() throws ServletException {
		dao = new UserDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect("Userregister.jsp?error=Session expired.");
			return;
		}
		
		
		// Checking the OTP from user
		Instant otpGeneratedTime = (Instant) session.getAttribute("otpGeneratedTime");
		if (otpGeneratedTime == null || Instant.now().isAfter(otpGeneratedTime.plusSeconds(60))) {
			session.invalidate();
			response.sendRedirect("Userregister.jsp?error=OTP expired. Please register again.");
			return;
		}

		// User entered OTP
		String otpStr = request.getParameter("otp1")
		        + request.getParameter("otp2")
		        + request.getParameter("otp3")
		        + request.getParameter("otp4")
		        + request.getParameter("otp5")
		        + request.getParameter("otp6");
		
		// Check OTP match
		int expectedOtp = (int) session.getAttribute("otp");
		int enteredOtp = Integer.parseInt(otpStr);

		if (enteredOtp == expectedOtp) {
			User user = new User(
						(String) session.getAttribute("userId"), 
						(String) session.getAttribute("name"),
						(String) session.getAttribute("email"), 
						(String) session.getAttribute("phoneNo"),
						(String) session.getAttribute("password"), 
						(String) session.getAttribute("address"),
						(String) session.getAttribute("city"), 
						(String) session.getAttribute("state")
					);

			boolean registered = dao.registerUser(user);

			if (registered) {

				session.removeAttribute("otp");
				session.removeAttribute("otpGeneratedTime");

				session.setAttribute("loggedInUser", user);

				response.sendRedirect("home.jsp");

			} else {
				response.sendRedirect("Userregister.jsp?error=Registration failed.");
			}
		} else {
			response.sendRedirect("Userregister.jsp?error=Invalid OTP. Try again..");
			session.invalidate();
			
		}
	}
}

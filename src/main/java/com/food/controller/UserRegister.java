package com.food.controller;

import java.io.IOException;

import com.food.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/register")
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserDAO dao;
	
	@Override
	public void init() throws ServletException {
		dao=new UserDAO();
	}
	
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("userId");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phoneNo");
		String pass = request.getParameter("password");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		
        int otp = (int)(Math.random() * 900000) + 100000;
        
        
        

        
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);        
        session.setAttribute("email", email);
        
        session.setAttribute("userId", uid);
        session.setAttribute("name", name);
        session.setAttribute("phoneNo", phone);
        session.setAttribute("password", pass);
        session.setAttribute("address", address);
        session.setAttribute("city", city);
        session.setAttribute("state", state);

        String subject = "Your OTP for Registration";
        String message = ""
        		+ "<!DOCTYPE html>\r\n"
        		+ "<html>\r\n"
        		+ "<head>\r\n"
        		+ "    <meta charset=\"UTF-8\">\r\n"
        		+ "    <style>\r\n"
        		+ "        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }\r\n"
        		+ "        .container {\r\n"
        		+ "            max-width: 500px;\r\n"
        		+ "            margin: auto;\r\n"
        		+ "            background: white;\r\n"
        		+ "            padding: 20px;\r\n"
        		+ "            border-radius: 8px;\r\n"
        		+ "            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);\r\n"
        		+ "        }\r\n"
        		+ "        h2 { color: #333; }\r\n"
        		+ "        .otp {\r\n"
        		+ "            font-size: 24px;\r\n"
        		+ "            font-weight: bold;\r\n"
        		+ "            color: #ff6600;\r\n"
        		+ "            padding: 10px;\r\n"
        		+ "            background: #f9f9f9;\r\n"
        		+ "            border-radius: 5px;\r\n"
        		+ "            display: inline-block;\r\n"
        		+ "        }\r\n"
        		+ "        p { color: #555; }\r\n"
        		+ "        .footer {\r\n"
        		+ "            margin-top: 20px;\r\n"
        		+ "            font-size: 12px;\r\n"
        		+ "            color: #888;\r\n"
        		+ "        }\r\n"
        		+ "    </style>\r\n"
        		+ "</head>\r\n"
        		+ "<body>\r\n"
        		+ "    <div class=\"container\">\r\n"
        		+ "        <h2>Hello, "+name+"!</h2>\r\n"
        		+ "        <p>Thank you for registering with <strong>Foodie Express</strong>.</p>\r\n"
        		+ "        <p>Your One-Time Password (OTP) for completing your registration is:</p>\r\n"
        		+ "        <p class=\"otp\">"+otp+"</p>\r\n"
        		+ "        <p>This OTP is valid for <strong>5 minutes</strong>. Please do not share it with anyone.</p>\r\n"
        		+ "        <div class=\"footer\">\r\n"
        		+ "            <p>If you didn’t request this, please ignore this email.</p>\r\n"
        		+ "            <p>© 2025 Food Delivery App. All rights reserved.</p>\r\n"
        		+ "        </div>\r\n"
        		+ "    </div>\r\n"
        		+ "</body>\r\n"
        		+ "</html>\r\n"
        		+ "  ".formatted(name, otp);
        boolean mailSent =  SendMail.send(email, subject, message);
       
        if (mailSent) {
            // Redirect to OTP verification page
            response.sendRedirect("otpverify.jsp");
        } else {
            response.getWriter().println("Failed to send OTP. Please try again.");
        }

//		User user = new User(uid, name, email, phone, pass, address, city, state);
//		boolean registered = dao.registerUser(user);
//		
//		if(registered) {
//			response.sendRedirect("userlogin.jsp");
//		}
		
	}

}

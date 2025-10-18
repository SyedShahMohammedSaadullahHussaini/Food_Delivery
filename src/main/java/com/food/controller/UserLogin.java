package com.food.controller;

import java.io.IOException;

import com.foodexpress.updatedDAO.UserDAO;
import com.foodexpress.updatedDTO.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private UserDAO dao;
    
    @Override
    public void init() throws ServletException {
    	dao=new UserDAO();
    }
    
    
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		System.out.println("Login email: "+email);
		String pass = request.getParameter("password");
		System.out.println("Login pass: "+pass);
		
		
		User user = dao.validateUser(email, pass);
		
		
        if (user != null) {
        	System.out.println("logged in user: "+user.getuName());
            //login success -> store user in session
        	System.out.println("user is not null ");
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            // Forward to DisplayRestaurant servlet
            response.sendRedirect(request.getContextPath() + "/DisplayRestaurant");
            System.out.println("succefully sent to displayrrest");

            
        } else {
            //  login failed --> show error
        	System.out.println("else exed user obj is null");
            request.setAttribute("errorMessage", "Invalid Email or Password");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
	}

}

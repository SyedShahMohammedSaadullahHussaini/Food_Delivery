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
    
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String pass = request.getParameter("password");
		
		
		User user = dao.validateUser(email, pass);

		
        if (user != null) {
            //login success -> store user in session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            // Forward to DisplayRestaurant servlet
            RequestDispatcher rd = request.getRequestDispatcher("/DisplayRestaurant");
            
            rd.forward(request, response);

//            response.sendRedirect("DisplayRestaurant");
            
        } else {
            //  login failed --> show error
            request.setAttribute("errorMessage", "Invalid Email or Password");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
	}

}

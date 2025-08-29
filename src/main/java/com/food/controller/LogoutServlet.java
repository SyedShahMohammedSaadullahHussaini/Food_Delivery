package com.food.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ✅ Invalidate session → removes currentUser and all attributes
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate();
        }

        // ✅ Redirect back to home page (or login page)
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}

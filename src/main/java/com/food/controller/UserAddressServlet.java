package com.food.controller;

import com.foodexpress.updatedDAO.UserAddressDAO;
import com.foodexpress.updatedDTO.User;
import com.foodexpress.updatedDTO.UserAddress;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/addAddress")
public class UserAddressServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String label = request.getParameter("label");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");

        UserAddress newAddr = new UserAddress();
        newAddr.setUid(currentUser.getuId());
        newAddr.setLabel(label);
        newAddr.setAddress(address);
        newAddr.setCity(city);
        newAddr.setPincode(pincode);

        try {
            UserAddressDAO dao = new UserAddressDAO();
            dao.addUserAddress(newAddr);
            System.out.println("address added");
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to payment.jsp to refresh the address list
        response.sendRedirect("payment.jsp");
    }
}

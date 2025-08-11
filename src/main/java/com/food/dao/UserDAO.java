package com.food.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.User.dto.User;
import com.food.util.DBConnection;

public class UserDAO {
	
//	User registration
	public boolean registerUser(User u) {
		System.out.println("User Registration method");
		
		String user = "INSERT INTO fda.users (id, name, email, phoneno, password, address, city, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		try (Connection con = DBConnection.giveConnection(); PreparedStatement pstmt = con.prepareStatement(user);){
			
			pstmt.setString(1, u.getUserId());
			pstmt.setString(2, u.getName());
			pstmt.setString(3, u.getEmail());
			pstmt.setString(4, u.getPhoneNo());
			pstmt.setString(5, u.getPassword());
			pstmt.setString(6, u.getAddress());
			pstmt.setString(7, u.getCity());
			pstmt.setString(8, u.getState());
			
			int i = pstmt.executeUpdate();
			if(i>0) {
				System.out.println("User registered");
				return true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
		
	}
	
//	User login
	public User loginUser(String email, String pass) {
System.out.println("User Login method");
		
		String login = "SELECT * FROM fda.users where email=? AND password=?";
		
		try (Connection con = DBConnection.giveConnection(); PreparedStatement pstmt = con.prepareStatement(login);){
			pstmt.setString(1, email);
			pstmt.setString(2, pass);
			
			ResultSet res = pstmt.executeQuery();
			
			if(res.next()) {
				User u = new User();
				u.setUserId(res.getString(1));
				u.setName(res.getString(2));
				u.setEmail(res.getString(3));
				u.setPhoneNo(res.getString(4));
				u.setPassword(res.getString(5));
				u.setAddress(res.getString(6));
				u.setCity(res.getString(7));
				u.setState(res.getString(8));
				return u;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
}

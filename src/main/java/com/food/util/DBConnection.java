package com.food.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection giveConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
//			String url="jdbc:mysql://172.26.46.248/foodexpress";
//			String user="root";
//			String pass="9600tharun"; mian DB
			
//			Testing email
			String url="jdbc:mysql://172.26.46.248/fda";
			String user="root";
			String pass="MySql@!vinay_06";
			
			Connection c = DriverManager.getConnection(url,user,pass);
			System.out.println("connected to DB");
			return c;
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}

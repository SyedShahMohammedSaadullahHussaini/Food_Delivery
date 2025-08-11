package com.User.dto;

public class User {
	
	private String UserId;                   // Unique customer ID
    private String name;                   // Full name of the customer
    private String email;                  // Email for communication and login
    private String phoneNo;                // Contact number
    private String password;               // Hashed password for login
    private String address;                // Default delivery address
    private String city;
    private String state;
//    private String profileImageUrl;
    
    
    
    
	public User(String userId, String name, String email, String phoneNo, String password, String address,
			String city, String state) {
		super();
		this.UserId = userId;
		this.name = name;
		this.email = email;
		this.phoneNo = phoneNo;
		this.password = password;
		this.address = address;
		this.city = city;
		this.state = state;
	}


	


	public User() {
		super();
	}




	public String getUserId() {
		return UserId;
	}




	public void setUserId(String userId) {
		UserId = userId;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getPhoneNo() {
		return phoneNo;
	}




	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}




	public String getPassword() {
		return password;
	}




	public void setPassword(String password) {
		this.password = password;
	}




	public String getAddress() {
		return address;
	}




	public void setAddress(String address) {
		this.address = address;
	}




	public String getCity() {
		return city;
	}




	public void setCity(String city) {
		this.city = city;
	}




	public String getState() {
		return state;
	}




	public void setState(String state) {
		this.state = state;
	}
        
}



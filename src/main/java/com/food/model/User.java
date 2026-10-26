package com.food.model;

public class User {
	private int userId;
    private String name;
    private String password;
    private String email;
    private String address;
    private String role;

    public User() {
        super();
    }
    
    

	public User(String name, String password, String email, String address, String role) {
		super();
		this.name = name;
		this.password = password;
		this.email = email;
		this.address = address;
		this.role = role;
	}



	public User(int userId, String name, String password, String email, String address, String role) {
		super();
		this.userId = userId;
		this.name = name;
		this.password = password;
		this.email = email;
		this.address = address;
		this.role = role;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", name=" + name + ", password=" + password + ", email=" + email
				+ ", address=" + address + ", role=" + role + "]";
	}

   
}
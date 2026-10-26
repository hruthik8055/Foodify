package com.food.model;

public class CartItem {

	private int menuId;
	private int restaurantId;
	private String name;
	private double price;
	private int qty;
	
	
	
	public CartItem() {
		super();
	}


	public CartItem(int menuId, int restaurantId, String name, double price, int qyt) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.name = name;
		this.price = price;
		this.qty = qyt;
	}


	public int getMenuId() {
		return menuId;
	}


	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}


	public int getRestaurantId() {
		return restaurantId;
	}


	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public double getPrice() {
		return price;
	}


	public void setPrice(double price) {
		this.price = price;
	}


	public int getQty() {
		return qty;
	}


	public void setQty(int qyt) {
		this.qty = qyt;
	}


	@Override
	public String toString() {
		return "CartItem [menuId=" + menuId + ", restaurantId=" + restaurantId + ", name=" + name + ", price=" + price
				+ ", qyt=" + qty + "]";
	}
	
	public double getTotalPrice() 
	{
		return qty*price;
		
	}
	
	
	
	
}

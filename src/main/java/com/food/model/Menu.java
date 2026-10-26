package com.food.model;

public class Menu {

	private int menuId;
	private int restaurantId;
	private String ItemName;
	private String description;
	private double price;
	private double rating;
	private boolean isAvailable;
	private String imagePath;

	public Menu() {
		super();
	}

	public Menu(int menuId, int restaurantId, String name, String description,
			double price, double rating, boolean isAvailable, String imagePath) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.ItemName = name;
		this.description = description;
		this.price = price;
		this.rating = rating;
		this.isAvailable = isAvailable;
		this.imagePath = imagePath;
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

	public String getItemName() {
		return ItemName;
	}

	public void setItemName(String name) {
		this.ItemName = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	@Override
	public String toString() {
		return "Menu [menuId=" + menuId
				+ ", restaurantId=" + restaurantId
				+ ", ItemName=" + ItemName
				+ ", description=" + description
				+ ", price=" + price
				+ ", rating=" + rating
				+ ", isAvailable=" + isAvailable
				+ ", imagePath=" + imagePath + "]";
	}
}
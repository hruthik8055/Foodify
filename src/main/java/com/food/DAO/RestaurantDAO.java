package com.food.DAO;

import java.util.List;

import com.food.model.Restaurant;

public interface RestaurantDAO {

	void addRestautantDAO(Restaurant restaurant);
	Restaurant getRestaursnt(int restaurantId);
	void updateRestaurant(Restaurant restaurant);
	void deleteRestaursnt(int restaurantId);
	List<Restaurant> getAllRestaurant();
	int getRestaurantIdByAdmin(int adminUserId);
	List<Restaurant> getActiveRestaurants();
}

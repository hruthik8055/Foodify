package com.food.DAO;

import java.util.List;
import com.food.model.Menu;

public interface MenuDAO {

    // Existing methods — keep these for current Foodify functionality
    void addMenu(Menu menu);

    Menu getMenu(int menuId);

    void updateMenu(Menu menu);

    void deleteMenu(int menuId);

    List<Menu> getAllMenu();

    List<Menu> getAllMenuByRestaurant(int restaurantId);


    // New methods — secure Restaurant Admin operations

    // Add a menu item to the admin's assigned restaurant
    boolean addMenuForRestaurant(Menu menu, int restaurantId);

    // Retrieve a menu item only if it belongs to the assigned restaurant
    Menu getMenuForRestaurant(int menuId, int restaurantId);

    // Update a menu item only if it belongs to the assigned restaurant
    boolean updateMenuForRestaurant(Menu menu, int restaurantId);

    // Delete a menu item only if it belongs to the assigned restaurant
    boolean deleteMenuForRestaurant(int menuId, int restaurantId);
}
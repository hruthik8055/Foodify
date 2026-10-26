package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.MenuDAO;
import com.food.model.Menu;
import com.food.util.DBConnectionUtil;

public class MenuDAOImpl implements MenuDAO {

    // ==========================================
    // EXISTING METHODS
    // ==========================================

    @Override
    public void addMenu(Menu menu) {

        String sql = "INSERT INTO Menu "
                + "(RestaurantID, ItemName, Description, Price, Rating, IsAvailable, ImagePath) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setDouble(5, menu.getRating());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setString(7, menu.getImagePath());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Failed to add menu item.", e);
        }
    }

    @Override
    public Menu getMenu(int menuId) {

        String sql = "SELECT * FROM Menu WHERE MenuID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, menuId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractMenuFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve menu item.", e);
        }

        return null;
    }

    @Override
    public void updateMenu(Menu menu) {

        String sql = "UPDATE Menu SET "
                + "RestaurantID = ?, "
                + "ItemName = ?, "
                + "Description = ?, "
                + "Price = ?, "
                + "Rating = ?, "
                + "IsAvailable = ?, "
                + "ImagePath = ? "
                + "WHERE MenuID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, menu.getRestaurantId());
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setDouble(5, menu.getRating());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setString(7, menu.getImagePath());
            pstmt.setInt(8, menu.getMenuId());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Failed to update menu item.", e);
        }
    }

    @Override
    public void deleteMenu(int menuId) {

        String sql = "DELETE FROM Menu WHERE MenuID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, menuId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Failed to delete menu item.", e);
        }
    }

    @Override
    public List<Menu> getAllMenu() {

        List<Menu> menus = new ArrayList<>();

        String sql = "SELECT * FROM Menu";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                menus.add(extractMenuFromResultSet(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Failed to retrieve menu items.", e);
        }

        return menus;
    }

    @Override
    public List<Menu> getAllMenuByRestaurant(int restaurantId) {

        List<Menu> menus = new ArrayList<>();

        String sql = "SELECT * FROM Menu WHERE RestaurantID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, restaurantId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    menus.add(extractMenuFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Failed to retrieve menu items for restaurant.", e);
        }

        return menus;
    }


    // ==========================================
    // NEW SECURE RESTAURANT ADMIN METHODS
    // ==========================================

    // 1. Add a menu item to the assigned restaurant.
    // restaurantId must come from the authenticated session.
    @Override
    public boolean addMenuForRestaurant(Menu menu, int restaurantId) {

        String sql = "INSERT INTO Menu "
                + "(RestaurantID, ItemName, Description, Price, Rating, IsAvailable, ImagePath) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Use the trusted restaurantId argument, not menu.getRestaurantId().
            pstmt.setInt(1, restaurantId);
            pstmt.setString(2, menu.getItemName());
            pstmt.setString(3, menu.getDescription());
            pstmt.setDouble(4, menu.getPrice());
            pstmt.setDouble(5, menu.getRating());
            pstmt.setBoolean(6, menu.isAvailable());
            pstmt.setString(7, menu.getImagePath());

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Failed to add menu item for this restaurant.", e);
        }
    }


    // 2. Retrieve a menu item only if it belongs to this restaurant.
    @Override
    public Menu getMenuForRestaurant(int menuId, int restaurantId) {

        String sql = "SELECT * FROM Menu "
                + "WHERE MenuID = ? AND RestaurantID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, menuId);
            pstmt.setInt(2, restaurantId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractMenuFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Failed to retrieve the restaurant's menu item.", e);
        }

        // No matching item, or the item belongs to another restaurant.
        return null;
    }


    // 3. Update only a menu item belonging to this restaurant.
    @Override
    public boolean updateMenuForRestaurant(Menu menu, int restaurantId) {

        String sql = "UPDATE Menu SET "
                + "ItemName = ?, "
                + "Description = ?, "
                + "Price = ?, "
                + "Rating = ?, "
                + "IsAvailable = ?, "
                + "ImagePath = ? "
                + "WHERE MenuID = ? AND RestaurantID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, menu.getItemName());
            pstmt.setString(2, menu.getDescription());
            pstmt.setDouble(3, menu.getPrice());
            pstmt.setDouble(4, menu.getRating());
            pstmt.setBoolean(5, menu.isAvailable());
            pstmt.setString(6, menu.getImagePath());
            pstmt.setInt(7, menu.getMenuId());

            // Ownership check: the item must belong to this restaurant.
            pstmt.setInt(8, restaurantId);

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Failed to update this restaurant's menu item.", e);
        }
    }


    // 4. Delete only a menu item belonging to this restaurant.
    @Override
    public boolean deleteMenuForRestaurant(int menuId, int restaurantId) {

        String sql = "DELETE FROM Menu "
                + "WHERE MenuID = ? AND RestaurantID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, menuId);
            pstmt.setInt(2, restaurantId);

            // Returns false if no matching item belongs to this restaurant.
            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Failed to delete this restaurant's menu item.", e);
        }
    }


    // ==========================================
    // RESULT SET EXTRACTION
    // ==========================================

    private Menu extractMenuFromResultSet(ResultSet rs)
            throws SQLException {

        Menu menu = new Menu();

        menu.setMenuId(rs.getInt("MenuID"));
        menu.setRestaurantId(rs.getInt("RestaurantID"));
        menu.setItemName(rs.getString("ItemName"));
        menu.setDescription(rs.getString("Description"));
        menu.setPrice(rs.getDouble("Price"));
        menu.setRating(rs.getDouble("Rating"));
        menu.setAvailable(rs.getBoolean("IsAvailable"));
        menu.setImagePath(rs.getString("ImagePath"));

        return menu;
    }
}
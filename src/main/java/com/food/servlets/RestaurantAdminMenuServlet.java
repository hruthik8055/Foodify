package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAO.MenuDAO;
import com.food.DAOImpl.MenuDAOImpl;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/restaurantAdminMenu")
public class RestaurantAdminMenuServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAOImpl();
    }

    // ==========================================
    // CHECK RESTAURANT ADMIN AUTHENTICATION
    // ==========================================

    private Integer getAuthorizedRestaurantId(
            HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect("login.html");
            return null;
        }

        Object roleObject = session.getAttribute("role");
        Object restaurantIdObject = session.getAttribute("restaurantId");

        if (!(roleObject instanceof String)
                || ! "RESTAURANT_ADMIN".equalsIgnoreCase((String) roleObject)) {

            resp.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only Restaurant Admins can access this page."
            );

            return null;
        }

        if (!(restaurantIdObject instanceof Integer)
                || ((Integer) restaurantIdObject) <= 0) {

            resp.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "No valid restaurant is assigned to this admin."
            );

            return null;
        }

        // This ID comes from the authenticated server-side session.
        return (Integer) restaurantIdObject;
    }


    // ==========================================
    // GET: DISPLAY RESTAURANT MENU
    // ==========================================

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        Integer restaurantId = getAuthorizedRestaurantId(req, resp);

        if (restaurantId == null) {
            return;
        }

        try {
            List<Menu> menus =
                    menuDAO.getAllMenuByRestaurant(restaurantId);

            req.setAttribute("menus", menus);

            // Display the admin dashboard.
            req.getRequestDispatcher("/admin-dashboard.jsp")
                    .forward(req, resp);

        } catch (RuntimeException e) {
            throw new ServletException(
                    "Unable to load this restaurant's menu.", e);
        }
    }


    // ==========================================
    // POST: ADD, UPDATE OR DELETE MENU ITEMS
    // ==========================================

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        Integer restaurantId = getAuthorizedRestaurantId(req, resp);

        if (restaurantId == null) {
            return;
        }

        String action = req.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Missing menu action."
            );
            return;
        }

        try {

            switch (action.trim().toLowerCase()) {

                case "add":
                    addMenuItem(req, restaurantId);
                    break;

                case "update":
                    updateMenuItem(req, restaurantId);
                    break;

                case "delete":
                    deleteMenuItem(req, restaurantId);
                    break;

                default:
                    resp.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid menu action."
                    );
                    return;
            }

            // Redirect after POST to avoid accidental form resubmission.
            resp.sendRedirect(
                    req.getContextPath()
                            + "/restaurantAdminMenu?success=1"
            );

        } catch (IllegalArgumentException e) {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    e.getMessage()
            );

        } catch (RuntimeException e) {

            throw new ServletException(
                    "Unable to process the menu operation.", e);
        }
    }


    // ==========================================
    // ADD MENU ITEM
    // ==========================================

    private void addMenuItem(
            HttpServletRequest req,
            int restaurantId) {

        String itemName = req.getParameter("itemName");
        String description = req.getParameter("description");
        String priceValue = req.getParameter("price");
        String ratingValue = req.getParameter("rating");
        String imagePath = req.getParameter("imagePath");
        String availableValue = req.getParameter("isAvailable");

        if (itemName == null || itemName.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Menu item name is required.");
        }

        if (itemName.trim().length() > 100) {
            throw new IllegalArgumentException(
                    "Menu item name cannot exceed 100 characters.");
        }

        if (description != null && description.length() > 255) {
            throw new IllegalArgumentException(
                    "Description cannot exceed 255 characters.");
        }

        if (imagePath != null && imagePath.length() > 255) {
            throw new IllegalArgumentException(
                    "Image path cannot exceed 255 characters.");
        }

        double price = parseNonNegativeDouble(priceValue, "price");
        double rating = parseNonNegativeDouble(ratingValue, "rating");

        if (rating > 5) {
            throw new IllegalArgumentException(
                    "Rating must be between 0 and 5.");
        }

        boolean isAvailable =
                availableValue == null
                        || Boolean.parseBoolean(availableValue);

        Menu menu = new Menu();

        // Never accept the restaurant ID from the form.
        menu.setItemName(itemName.trim());
        menu.setDescription(description);
        menu.setPrice(price);
        menu.setRating(rating);
        menu.setAvailable(isAvailable);
        menu.setImagePath(imagePath);

        boolean added =
                menuDAO.addMenuForRestaurant(menu, restaurantId);

        if (!added) {
            throw new RuntimeException(
                    "The menu item could not be added.");
        }
    }


    // ==========================================
    // UPDATE MENU ITEM
    // ==========================================

    private void updateMenuItem(
            HttpServletRequest req,
            int restaurantId) {

        int menuId = parsePositiveInt(
                req.getParameter("menuId"), "menu ID");

        // Verify that the item belongs to this admin's restaurant.
        Menu existingMenu =
                menuDAO.getMenuForRestaurant(menuId, restaurantId);

        if (existingMenu == null) {
            throw new IllegalArgumentException(
                    "Menu item not found in your restaurant.");
        }

        String itemName = req.getParameter("itemName");
        String description = req.getParameter("description");
        String priceValue = req.getParameter("price");
        String ratingValue = req.getParameter("rating");
        String imagePath = req.getParameter("imagePath");
        String availableValue = req.getParameter("isAvailable");

        if (itemName == null || itemName.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Menu item name is required.");
        }

        if (itemName.trim().length() > 100) {
            throw new IllegalArgumentException(
                    "Menu item name cannot exceed 100 characters.");
        }

        if (description != null && description.length() > 255) {
            throw new IllegalArgumentException(
                    "Description cannot exceed 255 characters.");
        }

        if (imagePath != null && imagePath.length() > 255) {
            throw new IllegalArgumentException(
                    "Image path cannot exceed 255 characters.");
        }

        double price = parseNonNegativeDouble(priceValue, "price");
        double rating = parseNonNegativeDouble(ratingValue, "rating");

        if (rating > 5) {
            throw new IllegalArgumentException(
                    "Rating must be between 0 and 5.");
        }

        boolean isAvailable =
                availableValue == null
                        || Boolean.parseBoolean(availableValue);

        Menu menu = new Menu();

        menu.setMenuId(menuId);
        menu.setItemName(itemName.trim());
        menu.setDescription(description);
        menu.setPrice(price);
        menu.setRating(rating);
        menu.setAvailable(isAvailable);
        menu.setImagePath(imagePath);

        // The DAO checks MenuID AND RestaurantID.
        boolean updated =
                menuDAO.updateMenuForRestaurant(menu, restaurantId);

        if (!updated) {
            throw new IllegalArgumentException(
                    "Menu item could not be updated. "
                    + "It may no longer belong to your restaurant.");
        }
    }


    // ==========================================
    // DELETE MENU ITEM
    // ==========================================

    private void deleteMenuItem(
            HttpServletRequest req,
            int restaurantId) {

        int menuId = parsePositiveInt(
                req.getParameter("menuId"), "menu ID");

        // The DAO deletes only if both IDs match.
        boolean deleted =
                menuDAO.deleteMenuForRestaurant(menuId, restaurantId);

        if (!deleted) {
            throw new IllegalArgumentException(
                    "Menu item not found in your restaurant "
                    + "or it could not be deleted.");
        }
    }


    // ==========================================
    // INPUT VALIDATION HELPERS
    // ==========================================

    private int parsePositiveInt(String value, String fieldName) {

        try {
            int number = Integer.parseInt(value);

            if (number <= 0) {
                throw new IllegalArgumentException(
                        fieldName + " must be a positive number.");
            }

            return number;

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(
                    "Invalid " + fieldName + ".");
        }
    }


    private double parseNonNegativeDouble(
            String value,
            String fieldName) {

        try {
            double number = Double.parseDouble(value);

            if (!Double.isFinite(number) || number < 0) {
                throw new IllegalArgumentException(
                        fieldName + " must be a valid non-negative number.");
            }

            return number;

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(
                    "Invalid " + fieldName + ".");
        }
    }
}
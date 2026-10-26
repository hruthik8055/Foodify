package com.food.servlets;

import java.io.IOException;

import com.food.DAO.RestaurantDAO;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/superAdminRestaurant")
public class SuperAdminRestaurantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"SUPER_ADMIN".equals(session.getAttribute("role"))) {

            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Only Super Admin can perform this action."
            );
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addRestaurant(request);

            } else if ("update".equals(action)) {
                updateRestaurant(request);

            } else if ("toggleStatus".equals(action)) {
                toggleRestaurantStatus(request);

            } else {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid restaurant action."
                );
                return;
            }

            response.sendRedirect(
                request.getContextPath()
                    + "/superAdminDashboard?success="
                    + action
            );

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Please enter valid numeric values."
            );

        } catch (IllegalArgumentException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                e.getMessage()
            );

        } catch (RuntimeException e) {

            throw new ServletException(
                "Unable to process the restaurant operation.", e
            );
        }
    }

    private void addRestaurant(HttpServletRequest request) {

        String name = required(request, "name");
        String cuisine = required(request, "cuisineType");
        String address = required(request, "address");

        int deliveryTime = Integer.parseInt(
            required(request, "deliveryTime")
        );

        double rating = Double.parseDouble(
            required(request, "rating")
        );

        validate(name, cuisine, address, deliveryTime, rating);

        Restaurant restaurant = new Restaurant();

        restaurant.setName(name);
        restaurant.setCuisineType(cuisine);
        restaurant.setAddress(address);
        restaurant.setDeliveryTime(deliveryTime);
        restaurant.setRating(rating);
        restaurant.setImagePath(optional(request, "imagePath"));
        restaurant.setActive(true);

        /*
         * AdminUserID is not assigned here.
         * Your DAO/database must allow an unassigned admin,
         * or this restaurant must be assigned a valid admin.
         */
        restaurantDAO.addRestautantDAO(restaurant);
    }

    private void updateRestaurant(HttpServletRequest request) {

        int restaurantId = positiveId(
            request.getParameter("restaurantId")
        );

        Restaurant existing =
            restaurantDAO.getRestaursnt(restaurantId);

        if (existing == null) {
            throw new IllegalArgumentException(
                "Restaurant not found."
            );
        }

        String name = required(request, "name");
        String cuisine = required(request, "cuisineType");
        String address = required(request, "address");

        int deliveryTime = Integer.parseInt(
            required(request, "deliveryTime")
        );

        double rating = Double.parseDouble(
            required(request, "rating")
        );

        validate(name, cuisine, address, deliveryTime, rating);

        existing.setName(name);
        existing.setCuisineType(cuisine);
        existing.setAddress(address);
        existing.setDeliveryTime(deliveryTime);
        existing.setRating(rating);
        existing.setImagePath(optional(request, "imagePath"));

        // Preserve the existing admin assignment and active status.
        restaurantDAO.updateRestaurant(existing);
    }

    private void toggleRestaurantStatus(HttpServletRequest request) {

        int restaurantId = positiveId(
            request.getParameter("restaurantId")
        );

        Restaurant existing =
            restaurantDAO.getRestaursnt(restaurantId);

        if (existing == null) {
            throw new IllegalArgumentException(
                "Restaurant not found."
            );
        }

        existing.setActive(!existing.isActive());

        restaurantDAO.updateRestaurant(existing);
    }

    private String required(HttpServletRequest request, String field) {

        String value = request.getParameter(field);

        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(
                field + " is required."
            );
        }

        return value.trim();
    }

    private String optional(HttpServletRequest request, String field) {

        String value = request.getParameter(field);

        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        return value.trim();
    }

    private int positiveId(String value) {

        int id = Integer.parseInt(value);

        if (id <= 0) {
            throw new IllegalArgumentException(
                "Invalid restaurant ID."
            );
        }

        return id;
    }

    private void validate(String name, String cuisine, String address,
                          int deliveryTime, double rating) {

        if (name.length() > 100 ||
            cuisine.length() > 100 ||
            address.length() > 255) {

            throw new IllegalArgumentException(
                "One or more fields exceed the allowed length."
            );
        }

        if (deliveryTime <= 0) {
            throw new IllegalArgumentException(
                "Delivery time must be greater than zero."
            );
        }

        if (!Double.isFinite(rating) || rating < 0 || rating > 5) {
            throw new IllegalArgumentException(
                "Rating must be between 0 and 5."
            );
        }
    }
}
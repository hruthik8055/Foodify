package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAO.RestaurantDAO;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.DAO.UserDAO;
import com.food.DAOImpl.UserDAOImpl;
import com.food.model.Restaurant;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/superAdminDashboard")
public class SuperAdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAOImpl();
        userDAO = new UserDAOImpl();
    }

    private boolean isSuperAdmin(HttpServletRequest request,
                                 HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"SUPER_ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect(
                request.getContextPath() + "/login.html"
            );

            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isSuperAdmin(request, response)) {
            return;
        }

        try {
            // Fetch all restaurants.
            List<Restaurant> restaurants =
                    restaurantDAO.getAllRestaurant();

            // Fetch all users.
            List<User> users = userDAO.getAllUser();

            int totalRestaurants = restaurants.size();
            int activeRestaurants = 0;
            int restaurantAdmins = 0;
            int customers = 0;

            // Calculate restaurant statistics.
            for (Restaurant restaurant : restaurants) {
                if (restaurant.isActive()) {
                    activeRestaurants++;
                }
            }

            // Calculate user statistics.
            for (User user : users) {

                if ("RESTAURANT_ADMIN".equals(user.getRole())) {
                    restaurantAdmins++;
                } else if ("CUSTOMER".equals(user.getRole())) {
                    customers++;
                }
            }

            // Pass data to the JSP.
            request.setAttribute("restaurants", restaurants);
            request.setAttribute("totalRestaurants", totalRestaurants);
            request.setAttribute("activeRestaurants", activeRestaurants);
            request.setAttribute("totalCustomers", customers);
            request.setAttribute("totalRestaurantAdmins", restaurantAdmins);

            // Display the dashboard.
            request.getRequestDispatcher(
                "/super-admin-dashboard.jsp"
            ).forward(request, response);

        } catch (RuntimeException e) {
            throw new ServletException(
                "Unable to load the Super Admin Dashboard.", e
            );
        }
    }
}
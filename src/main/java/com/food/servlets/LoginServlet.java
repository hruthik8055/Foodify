
package com.food.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {

            resp.sendRedirect("login.html?error=empty");
            return;
        }

        UserDAOImpl userDAOImpl = new UserDAOImpl();

        // Retrieve user by email
        User user = userDAOImpl.getUserByEmail(email.trim());

        // Check whether the user exists
        if (user == null || user.getPassword() == null) {
            resp.sendRedirect("login.html?error=invalid");
            return;
        }

        // Verify password
        if (!BCrypt.checkpw(password, user.getPassword())) {
            resp.sendRedirect("login.html?error=invalid");
            return;
        }

        // Prevent session fixation after authentication
        HttpSession oldSession = req.getSession(false);

        if (oldSession != null) {
            oldSession.invalidate();
        }

        HttpSession session = req.getSession(true);

        // Store authenticated user
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("role", user.getRole());

        String role = user.getRole();

        if ("CUSTOMER".equalsIgnoreCase(role)) {

            // Existing customer flow
            resp.sendRedirect("restaurant");

        } else if ("RESTAURANT_ADMIN".equalsIgnoreCase(role)) {

            // Find the restaurant assigned to this admin
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

            int restaurantId =
                    restaurantDAO.getRestaurantIdByAdmin(user.getUserId());

            if (restaurantId == -1) {
                session.invalidate();

                resp.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "No restaurant is assigned to this admin."
                );
                return;
            }

            // Store the assigned restaurant ID in the session
            session.setAttribute("restaurantId", restaurantId);

            resp.sendRedirect("admin-dashboard.jsp");

        } else if ("SUPER_ADMIN".equalsIgnoreCase(role)) {

            // Super Admin dashboard
            resp.sendRedirect("super-admin-dashboard.jsp");

        } else {

            // Reject unknown roles
            session.invalidate();

            resp.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Invalid user role."
            );
        }
    }
}

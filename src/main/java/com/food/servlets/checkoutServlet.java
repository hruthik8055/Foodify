
package com.food.servlets;

import java.io.IOException;
import java.sql.Date;

import com.food.DAOImpl.OrderDAOImpl;
import com.food.DAOImpl.OrderItemDAOImpl;
import com.food.DAOImpl.UserDAOImpl;

import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Order;
import com.food.model.OrderItem;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/checkoutServlet")
public class checkoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 1. Check whether a session exists
        if (session == null) {
            resp.sendRedirect("login.html");
            return;
        }

        // 2. Check whether the user is logged in
        User user = (User) session.getAttribute("user");

        System.out.println("Checkout servlet reached.");
        System.out.println("Session user: " + user);

        if (user == null) {
            System.out.println("No logged-in user. Redirecting to login.");
            resp.sendRedirect("login.html");
            return;
        }

        // 3. Verify that the user exists in the database
        UserDAOImpl userDAOImpl = new UserDAOImpl();

        User dbUser = userDAOImpl.getUserByEmail(user.getEmail());

        System.out.println("Checking email: " + user.getEmail());
        System.out.println("Database user: " + dbUser);

        if (dbUser == null) {
            System.out.println("User not found in database.");

            session.removeAttribute("user");

            resp.sendRedirect("register.html");
            return;
        }

        // Use the verified database user
        user = dbUser;

        System.out.println("User verified successfully.");

        // 4. Retrieve cart and restaurant details
        Integer restaurantId =
                (Integer) session.getAttribute("restaurantId");

        Cart cart = (Cart) session.getAttribute("cart");

        // 5. Validate cart
        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        // 6. Validate restaurant ID
        if (restaurantId == null) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        // 7. Validate grand total
        Object totalObject = session.getAttribute("grandTotal");

        if (!(totalObject instanceof Number)) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        double grandTotal = ((Number) totalObject).doubleValue();

        if (grandTotal < 0) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        // 8. Validate payment method
        String payment = req.getParameter("payment");

        if (payment == null || payment.trim().isEmpty()) {
            resp.sendRedirect("checkout.jsp");
            return;
        }

        // 9. Create order
        int userId = user.getUserId();

        Order order = new Order(
                userId,
                restaurantId,
                new Date(System.currentTimeMillis()),
                grandTotal,
                "Pending",
                payment
        );

        OrderDAOImpl orderDAOImpl = new OrderDAOImpl();

        int orderId = orderDAOImpl.addOrders(order);

        System.out.println("Generated order ID: " + orderId);

        // 10. Continue only if order creation succeeded
        if (orderId <= 0) {
            resp.sendRedirect("cart.jsp");
            return;
        }

        // 11. Save order items
        OrderItemDAOImpl orderItemDAOImpl =
                new OrderItemDAOImpl();

        for (CartItem cartItem : cart.getItems().values()) {

            int menuId = cartItem.getMenuId();
            int qty = cartItem.getQty();

            double itemTotal = cartItem.getTotalPrice();

            OrderItem orderItem = new OrderItem(
                    orderId,
                    menuId,
                    qty,
                    itemTotal
            );

            orderItemDAOImpl.addOrderItems(orderItem);
        }

        // 12. Clear checkout-related session attributes
        session.removeAttribute("restaurantId");
        session.removeAttribute("cart");
        session.removeAttribute("grandTotal");

        // 13. Redirect to order confirmation
        resp.sendRedirect("orderConfirmation.html");
    }
}

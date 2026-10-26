package com.food.servlets;

import java.io.IOException;
import java.util.List;

import com.food.DAOImpl.OrderDAOImpl;
import com.food.DAOImpl.UserDAOImpl;
import com.food.model.Order;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect("login.html");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            resp.sendRedirect("login.html");
            return;
        }

        // Verify the user against the database.
        UserDAOImpl userDAO = new UserDAOImpl();
        User user = userDAO.getUserByEmail(sessionUser.getEmail());

        if (user == null) {
            session.removeAttribute("user");
            resp.sendRedirect("login.html");
            return;
        }

        // Fetch only this user's orders.
        OrderDAOImpl orderDAO = new OrderDAOImpl();
        List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());

        req.setAttribute("orders", orders);

        req.getRequestDispatcher("/my-orders.jsp")
           .forward(req, resp);
    }
}
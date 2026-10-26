package com.food.servlets;

import java.io.IOException;

import com.food.DAOImpl.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

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

        UserDAOImpl userDAO = new UserDAOImpl();

        User user = userDAO.getUserByEmail(sessionUser.getEmail());

        if (user == null) {
            session.removeAttribute("user");
            resp.sendRedirect("login.html");
            return;
        }

        // Keep the session synchronized with the database user.
        session.setAttribute("user", user);

        req.setAttribute("user", user);

        req.getRequestDispatcher("/profile.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

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

        String name = req.getParameter("name");
        String address = req.getParameter("address");

        if (name == null || name.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            resp.sendRedirect("profile?error=required");
            return;
        }

        name = name.trim();
        address = address.trim();

        if (name.length() > 100 || address.length() > 255) {
            resp.sendRedirect("profile?error=length");
            return;
        }

        UserDAOImpl userDAO = new UserDAOImpl();

        // Load the current database record before modifying it.
        User user = userDAO.getUserByEmail(sessionUser.getEmail());

        if (user == null) {
            session.removeAttribute("user");
            resp.sendRedirect("login.html");
            return;
        }

        // Change only the two fields the user is allowed to edit.
        user.setName(name);
        user.setAddress(address);

        userDAO.updateUser(user);

        // Reload the record so the session reflects the database.
        User updatedUser = userDAO.getUserByEmail(user.getEmail());

        if (updatedUser == null) {
            resp.sendRedirect("profile?error=update");
            return;
        }

        session.setAttribute("user", updatedUser);

        resp.sendRedirect("profile?success=updated");
    }
}
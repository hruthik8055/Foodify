package com.food.servlets;

import java.io.IOException;
import java.util.Set;

import com.food.DAOImpl.ContactDAOImpl;
import com.food.model.ContactMessage;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final Set<String> VALID_CATEGORIES = Set.of(
            "Order Issue",
            "Payment Issue",
            "Account Issue",
            "Technical Issue",
            "Feedback",
            "Other"
    );

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || !(session.getAttribute("user") instanceof User)) {
            resp.sendRedirect("login.html");
            return;
        }

        req.getRequestDispatcher("/contact.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || !(session.getAttribute("user") instanceof User)) {
            resp.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("user");

        String name = trim(req.getParameter("name"));
        String email = trim(req.getParameter("email"));
        String category = trim(req.getParameter("category"));
        String subject = trim(req.getParameter("subject"));
        String message = trim(req.getParameter("message"));

        String error = null;

        if (name.isEmpty() || email.isEmpty() || category.isEmpty()
                || subject.isEmpty() || message.isEmpty()) {

            error = "Please complete all fields before submitting.";

        } else if (name.length() > 100 || email.length() > 100
                || subject.length() > 150 || message.length() > 5000) {

            error = "One or more fields exceed the permitted length.";

        } else if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {

            error = "Please enter a valid email address.";

        } else if (!VALID_CATEGORIES.contains(category)) {

            error = "Please select a valid contact category.";

        } else if (user.getUserId() <= 0) {

            error = "Your account could not be verified. Please log in again.";

        }

        if (error != null) {
            req.setAttribute("errorMessage", error);
            req.setAttribute("formName", name);
            req.setAttribute("formEmail", email);
            req.setAttribute("formCategory", category);
            req.setAttribute("formSubject", subject);
            req.setAttribute("formMessage", message);

            req.getRequestDispatcher("/contact.jsp").forward(req, resp);
            return;
        }

        ContactMessage contactMessage = new ContactMessage(
                user.getUserId(),
                name,
                email,
                category,
                subject,
                message
        );

        ContactDAOImpl contactDAO = new ContactDAOImpl();

        if (contactDAO.addContactMessage(contactMessage)) {

            req.setAttribute(
                    "successMessage",
                    "Thank you for contacting Foodify! Your message has been submitted successfully."
            );

        } else {

            req.setAttribute(
                    "errorMessage",
                    "We couldn't submit your message right now. Please try again."
            );

            req.setAttribute("formName", name);
            req.setAttribute("formEmail", email);
            req.setAttribute("formCategory", category);
            req.setAttribute("formSubject", subject);
            req.setAttribute("formMessage", message);
        }

        req.getRequestDispatcher("/contact.jsp").forward(req, resp);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
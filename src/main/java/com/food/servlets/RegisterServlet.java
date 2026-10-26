package com.food.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.food.DAOImpl.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("Register servlet hit");
        
        
       
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String role = req.getParameter("role");

        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Address: " + address);
        System.out.println("Role: " + role);

        String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(12));

        User user = new User(name, hashpw, email, address, role);

        UserDAOImpl userDAOImpl = new UserDAOImpl();

        int result = userDAOImpl.addUser(user);

        System.out.println("DAO result: " + result);

        if (result == 1) {
            System.out.println("User registered successfully");
            resp.sendRedirect("login.html");
        } else {
            System.out.println("User registration failed");
            resp.sendRedirect("register.html");
        }
    }
}
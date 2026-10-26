package com.food.servlets;

import java.io.IOException;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.model.Restaurant;
import java.util.List;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/Menu")
public class MenuServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		Restaurant restaurant = new RestaurantDAOImpl().getRestaursnt(restaurantId);
		if (restaurant == null || !restaurant.isActive()) {
		    resp.sendRedirect(req.getContextPath() + "/restaurant");
		    return;
		}
		
		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		List<Menu> allMenuByRestaurant = menuDAOImpl.getAllMenuByRestaurant(restaurantId);
		
		
		req.setAttribute("allMenuByRestaurant", allMenuByRestaurant);
		
		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
		
		rd.forward(req, resp);
	}
	
	
}

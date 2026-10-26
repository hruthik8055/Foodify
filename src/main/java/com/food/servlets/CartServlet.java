package com.food.servlets;

import java.io.IOException;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.model.Restaurant;

import com.food.DAOImpl.MenuDAOImpl;
import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Menu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cartServlet")
public class CartServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		
		
		
		int newRestaurantId = Integer.parseInt(req.getParameter("restaurantId"));
		
		Integer restaurantId=(Integer)session.getAttribute("restaurantId");
		
		
		if(cart ==  null || restaurantId != newRestaurantId ) 
		{
			
		 cart=new Cart();
		 session.setAttribute("cart", cart);
		 session.setAttribute("restaurantId", newRestaurantId);
		}
	
		
		String action = req.getParameter("action");
		
		if(action.equals("add")) {
			addItemsToCart(req,cart);
			
		}
		else if(action.equals("update")) {
			updateItemToCart(req,cart);
			
		}
		else  if(action.equals("delete")){
			removeItemToCart(req,cart);
			
		}
		RequestDispatcher rd = req.getRequestDispatcher("cart.jsp");
		rd.forward(req, resp);
	}

	private void removeItemToCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		cart.remove(menuId);
		
	}

	private void updateItemToCart(HttpServletRequest req, Cart cart) {
		// TODO Auto-generated method stub
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		
		cart.updateItem(menuId,quantity);
		
	}

	private void addItemsToCart(HttpServletRequest req, Cart cart) {
		int menuId = Integer.parseInt(req.getParameter("menuId"));
		int qty = Integer.parseInt(req.getParameter("qty"));
		
		MenuDAOImpl menuDAOImpl = new MenuDAOImpl();
		Menu menu = menuDAOImpl.getMenu(menuId);
		Restaurant restaurant = new RestaurantDAOImpl().getRestaursnt(menu.getRestaurantId());
		if (restaurant == null || !restaurant.isActive()) {
		    return; // restaurant was deactivated by admin
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("restaurantId", menu.getRestaurantId());
		
		CartItem cartItem = new CartItem(menu.getMenuId(),
				menu.getRestaurantId(),
				menu.getItemName(),
				menu.getPrice(),
				qty);
		
		cart.addItem(cartItem);
		
	}

}

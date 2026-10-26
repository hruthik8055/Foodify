package com.food.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {

	Map<Integer,CartItem> items;

	public Cart() {
		 items = new HashMap<Integer, CartItem>();
	}

	public Map<Integer, CartItem> getItems() {
		return items;
	}

	public void addItem(CartItem cartItem) {
		
		int menuId = cartItem.getMenuId();
		
		if(items.containsKey(menuId)) {
			CartItem existinCartItem = items.get(menuId);
			existinCartItem.setQty(existinCartItem.getQty()+1);
		}
		else {
			
			items.put(menuId, cartItem);
		}
		
		
		
		
	}

	public void updateItem(int menuId, int quantity) {
		
		if(items.containsKey(menuId)) {
			
			CartItem cartItem = items.get(menuId);
			
			if(quantity < 1) {
				
				items.remove(menuId);
			}
			else {
				
				cartItem.setQty(quantity);
				items.put(menuId, cartItem);
				
			}
			
		}
		
	}

	public void remove(int menuId) {
		
		items.remove(menuId);
		
		
	}

	
	
	
	
	
	
	
	
}

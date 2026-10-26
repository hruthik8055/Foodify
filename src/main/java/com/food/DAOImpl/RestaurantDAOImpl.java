package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.RestaurantDAO;
import com.food.model.Restaurant;
import com.food.util.DBConnectionUtil;

public class RestaurantDAOImpl implements RestaurantDAO{

	@Override
	public void addRestautantDAO(Restaurant restaurant) {
	    String sql = "INSERT INTO restaurant (name, cuisineType, deliveryTime, address, adminUserId, rating, isActive, imagePath) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DBConnectionUtil.getConnections();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, restaurant.getName());
	        pstmt.setString(2, restaurant.getCuisineType());
	        pstmt.setInt(3, restaurant.getDeliveryTime());
	        pstmt.setString(4, restaurant.getAddress());

	        if (restaurant.getAdminUserId() > 0) {
	            pstmt.setInt(5, restaurant.getAdminUserId());
	        } else {
	            pstmt.setNull(5, java.sql.Types.INTEGER);
	        }

	        pstmt.setDouble(6, restaurant.getRating());
	        pstmt.setBoolean(7, restaurant.isActive());
	        pstmt.setString(8, restaurant.getImagePath());
	        pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public Restaurant getRestaursnt(int restaurantId) {
		String sql="SELECT * FROM Restaurant WHERE RestaurantID = ?";
		Restaurant restaurant=null;
		
				try (Connection conn = DBConnectionUtil.getConnections();
						PreparedStatement pstmt=conn.prepareStatement(sql)) {
					
					pstmt.setInt(1, restaurantId);
					
					try (ResultSet rs = pstmt.executeQuery()) {
						if(rs.next()) {
							restaurant=extractRestaurantFromResultSet(rs);
							
						}
					}
					
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return restaurant;
				
	}

	@Override
	public void updateRestaurant(Restaurant restaurant) {

	    String sql = "UPDATE Restaurant SET Name = ?, cuisineType = ?, " +
	                 "deliveryTime = ?, address = ?, adminUserId = ?, " +
	                 "rating = ?, isActive = ?, imagePath = ? " +
	                 "WHERE RestaurantID = ?";

	    try (Connection conn = DBConnectionUtil.getConnections();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, restaurant.getName());
	        pstmt.setString(2, restaurant.getCuisineType());
	        pstmt.setInt(3, restaurant.getDeliveryTime());
	        pstmt.setString(4, restaurant.getAddress());
	        pstmt.setInt(5, restaurant.getAdminUserId());
	        pstmt.setDouble(6, restaurant.getRating());
	        pstmt.setBoolean(7, restaurant.isActive());
	        pstmt.setString(8, restaurant.getImagePath());
	        pstmt.setInt(9, restaurant.getRestaurantId());

	        int rowsUpdated = pstmt.executeUpdate();

	        if (rowsUpdated == 0) {
	            System.out.println("No restaurant found with ID: "
	                               + restaurant.getRestaurantId());
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public void deleteRestaursnt(int restaurantId) {
		
		String sql="DELETE FROM restaurant WHERE RestaurantID=?";
		try (Connection conn = DBConnectionUtil.getConnections();
				
				PreparedStatement pstmt = conn.prepareStatement(sql)
				) {
			pstmt.setInt(1,restaurantId );
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<Restaurant> getAllRestaurant() {
		
		List<Restaurant> restaurants=new ArrayList<>();
		String sql="SELECT * FROM Restaurant";
		
		try (Connection conn = DBConnectionUtil.getConnections();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs=pstmt.executeQuery()) {
			
			
			while(rs.next()) {
				Restaurant restaurant = extractRestaurantFromResultSet(rs);
				restaurants.add(restaurant);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return restaurants;
	}
	
	private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {

	    Restaurant restaurant = new Restaurant();

	    restaurant.setRestaurantId(rs.getInt("RestaurantID"));
	    restaurant.setName(rs.getString("Name"));
	    restaurant.setCuisineType(rs.getString("CuisineType"));
	    restaurant.setDeliveryTime(rs.getInt("DeliveryTime"));
	    restaurant.setAddress(rs.getString("Address"));
	    restaurant.setAdminUserId(rs.getInt("AdminUserID"));
	    restaurant.setRating(rs.getDouble("Rating"));
	    restaurant.setActive(rs.getBoolean("IsActive"));
	    restaurant.setImagePath(rs.getString("ImagePath"));

	    return restaurant;
	}
	
	@Override
	public int getRestaurantIdByAdmin(int adminUserId) {

	    String sql =
	            "SELECT RestaurantID FROM Restaurant WHERE AdminUserID = ?";

	    try (Connection conn = DBConnectionUtil.getConnections();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, adminUserId);

	        try (ResultSet rs = pstmt.executeQuery()) {

	            if (rs.next()) {
	                return rs.getInt("RestaurantID");
	            }
	        }

	    } catch (SQLException e) {
	        throw new RuntimeException(
	                "Failed to retrieve the restaurant assigned to the admin.",
	                e
	        );
	    }

	    return -1;
	}
	@Override
	public List<Restaurant> getActiveRestaurants() {

	    List<Restaurant> restaurants = new ArrayList<>();
	    String sql = "SELECT * FROM Restaurant WHERE IsActive = 1";

	    try (Connection conn = DBConnectionUtil.getConnections();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            restaurants.add(extractRestaurantFromResultSet(rs));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return restaurants;
	}

	
}

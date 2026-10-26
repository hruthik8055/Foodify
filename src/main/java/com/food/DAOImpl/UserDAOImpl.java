package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.UserDAO;
import com.food.model.User;
import com.food.util.DBConnectionUtil;

public class UserDAOImpl implements UserDAO {

	@Override
	public int addUser(User user) {

	    String sql = "INSERT INTO `User` (Name, Password, Email, Address, Role) "
	               + "VALUES (?, ?, ?, ?, ?)";

	    try (Connection con = DBConnectionUtil.getConnections();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, user.getName());
	        ps.setString(2, user.getPassword());
	        ps.setString(3, user.getEmail());
	        ps.setString(4, user.getAddress());
	        ps.setString(5, user.getRole());

	        int result = ps.executeUpdate();

	        return result;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return 0;
	}

	@Override
	public User getUser(String email) {

		String sql = "SELECT * FROM User WHERE Email = ?";
		User user = null;

		try (Connection conn = DBConnectionUtil.getConnections();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, email);

			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {

					user = extractUserFromResultSet(rs);

				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}
	
	
	
	@Override
	public User getUserByEmail(String email) {

	    String sql = "SELECT * FROM `User` WHERE Email = ?";

	    try (Connection con = DBConnectionUtil.getConnections();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, email);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {

	                User user = new User();

	                user.setUserId(rs.getInt("UserID"));
	                user.setName(rs.getString("Name"));
	                user.setPassword(rs.getString("Password"));
	                user.setEmail(rs.getString("Email"));
	                user.setAddress(rs.getString("Address"));
	                user.setRole(rs.getString("Role"));

	                return user;
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return null;
	}
	


	@Override
	public void updateUser(User user) {

		String sql = "UPDATE User SET Name = ?, Password = ?, Address = ?, Role = ? WHERE Email = ?";

		try (Connection conn = DBConnectionUtil.getConnections();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getAddress());
			pstmt.setString(4, user.getRole());
			pstmt.setString(5, user.getEmail());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	@Override
	public void deleteUser(String email) {

		String sql = "DELETE FROM User WHERE Email = ?";

		try (Connection conn = DBConnectionUtil.getConnections();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, email);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	@Override
	public List<User> getAllUser() {

		List<User> users = new ArrayList<>();

		String sql = "SELECT * FROM User";

		try (Connection conn = DBConnectionUtil.getConnections();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {

				User user = extractUserFromResultSet(rs);

				users.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return users;
	}


	private User extractUserFromResultSet(ResultSet rs) throws SQLException {

		User user = new User();

		user.setName(rs.getString("Name"));
		user.setPassword(rs.getString("Password"));
		user.setEmail(rs.getString("Email"));
		user.setAddress(rs.getString("Address"));
		user.setRole(rs.getString("Role"));

		return user;
	}

}

package com.food.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.food.DAO.OrderItemDAO;
import com.food.model.OrderItem;
import com.food.util.DBConnectionUtil;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public void addOrderItems(OrderItem orderItem) {

        String sql = "INSERT INTO OrderItem "
                + "(OrderID, MenuID, Quantity, ItemTotal) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getItemTotal());

            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {

        String sql = "SELECT * FROM OrderItem WHERE OrderItemID = ?";
        OrderItem orderItem = null;

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderItemId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    orderItem = extractOrderItemFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItem;
    }

    @Override
    public List<OrderItem> getAllOrderItems() {

        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM OrderItem";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {

        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM OrderItem WHERE OrderID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    orderItems.add(extractOrderItemFromResultSet(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public void deleteOrderItemsByOrder(int orderId) {

        String sql = "DELETE FROM OrderItem WHERE OrderID = ?";

        try (Connection conn = DBConnectionUtil.getConnections();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private OrderItem extractOrderItemFromResultSet(ResultSet rs)
            throws SQLException {

        OrderItem orderItem = new OrderItem();

        orderItem.setOrderItemId(rs.getInt("OrderItemID"));
        orderItem.setOrderId(rs.getInt("OrderID"));
        orderItem.setMenuId(rs.getInt("MenuID"));
        orderItem.setQuantity(rs.getInt("Quantity"));
        orderItem.setItemTotal(rs.getDouble("ItemTotal"));

        return orderItem;
    }
}

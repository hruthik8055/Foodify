
package com.food.DAO;

import java.util.List;
import com.food.model.Order;

public interface OrderDAO {

    int addOrders(Order order);

    Order getOrder(int orderId);

    List<Order> getAllOrders();

    List<Order> getOrdersByUser(int userId);

    void updateOrderStatus(int orderId, String status);
}

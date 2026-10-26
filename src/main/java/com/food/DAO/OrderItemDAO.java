
package com.food.DAO;

import java.util.List;
import com.food.model.OrderItem;

public interface OrderItemDAO {

    void addOrderItems(OrderItem orderItem);

    OrderItem getOrderItem(int orderItemId);

    List<OrderItem> getAllOrderItems();

    List<OrderItem> getOrderItemsByOrder(int orderId);

    void deleteOrderItemsByOrder(int orderId);
}

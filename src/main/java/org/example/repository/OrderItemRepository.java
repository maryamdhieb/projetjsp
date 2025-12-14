package org.example.repository;
import org.example.DBConnection;
import org.example.model.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;


public class OrderItemRepository {

    public void saveItems(int orderId, List<CartItem> cart) {

        String sql = """
            INSERT INTO order_items (order_id, product_id, quantity, price)
            VALUES (?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (CartItem item : cart) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProduct().getId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getPrice());
                ps.addBatch();
            }
            ps.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

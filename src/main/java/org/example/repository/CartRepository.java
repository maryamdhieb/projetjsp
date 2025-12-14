package org.example.repository;

import jakarta.servlet.http.HttpSession;
import org.example.DBConnection;
import org.example.model.CartItem;
import org.example.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class CartRepository {

    public List<CartItem> getCart(HttpSession session) {

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    public void addToCart(HttpSession session, Product product) {

        List<CartItem> cart = getCart(session);

        for (CartItem item : cart) {
            if (item.getProduct().getId() == product.getId()) {
                item.increment();
                saveToDB(session.getId(), item);
                session.setAttribute("cartCount", getCartCount(cart));
                return;
            }
        }

        CartItem item = new CartItem(product);
        cart.add(item);
        saveToDB(session.getId(), item);

        session.setAttribute("cartCount", getCartCount(cart));
    }

    private void saveToDB(String sessionId, CartItem item) {

        double unitPrice = item.getProduct().getEffectivePrice();

        String sql = """
            INSERT INTO cart (session_id, product_id, quantity, unit_price, total_price)
            VALUES (?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
            quantity = quantity + 1,
            total_price = unit_price * quantity
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sessionId);
            ps.setInt(2, item.getProduct().getId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, unitPrice);
            ps.setDouble(5, unitPrice * item.getQuantity());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getCartCount(List<CartItem> cart) {
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }
}

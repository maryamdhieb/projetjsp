package org.example.repository;

import jakarta.servlet.http.HttpSession;
import org.example.model.CartItem;
import org.example.model.Category;
import org.example.model.Product;

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
                session.setAttribute("cartCount", getCartCount(cart));
                return;
            }
        }

        cart.add(new CartItem(product));
        session.setAttribute("cartCount", getCartCount(cart));
    }
    // Supprimer une  produits par id
    public void deleteProductCart(HttpSession session, int productId) {
        List<CartItem> cart = getCart(session);

        if (cart != null) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
        }
    }

        public int getCartCount(List<CartItem> cart) {
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }
}

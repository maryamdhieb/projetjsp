package org.example.service;

import jakarta.servlet.http.HttpSession;
import org.example.model.CartItem;
import org.example.model.Product;
import org.example.repository.CartRepository;
import org.example.repository.PromotionRepository;

import java.util.ArrayList;
import java.util.List;

public class CartService {

    private CartRepository cartRepository = new CartRepository();
    private PromotionRepository promotionRepository = new PromotionRepository();

    public List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = cartRepository.getCart(session);

        // Réappliquer les promotions actives à chaque affichage
        for (CartItem item : cart) {
            applyPromotion(item.getProduct());
        }
        session.setAttribute("cart", cart); // Toujours "cart", pas "cartItems"
        session.setAttribute("cartCount", getCartCount(cart));
        return cart;
    }

    public void addProduct(HttpSession session, Product product) {
        applyPromotion(product); // Appliquer promo avant ajout
        cartRepository.addToCart(session, product);
    }

    public void updateQuantity(HttpSession session, int productId, int newQuantity) {
        List<CartItem> cart = getCart(session);

        if (newQuantity <= 0) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
        } else {
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(newQuantity);
                    break;
                }
            }
        }

        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", getCartCount(cart));
    }

    public void removeItem(HttpSession session, int productId) {
        updateQuantity(session, productId, 0);
    }

    private void applyPromotion(Product product) {
        var promo = promotionRepository.findActivePromotionByProduct(product.getId());
        if (promo != null) {
            double promoPrice;
            if ("percentage".equalsIgnoreCase(promo.getType())) {
                promoPrice = product.getPrice() * (1 - promo.getValue() / 100);
            } else { // fixed
                promoPrice = product.getPrice() - promo.getValue();
            }
            product.setPromo(true);
            product.setDiscount(promo.getValue());
            product.setPromoPrice(Math.max(0, promoPrice)); // éviter prix négatif
        } else {
            product.setPromo(false);
            product.setPromoPrice(null);
        }
    }

    public int getCartCount(List<CartItem> cart) {
        return cart.stream().mapToInt(CartItem::getQuantity).sum();
    }
}
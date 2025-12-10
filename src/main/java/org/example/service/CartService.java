package org.example.service;

import jakarta.servlet.http.HttpSession;
import org.example.model.Product;
import org.example.repository.CartRepository;

public class CartService {

    private CartRepository cartRepository = new CartRepository();

    public void addProduct(HttpSession session, Product product) {
        cartRepository.addToCart(session, product);
    }

    public Object getCart(HttpSession session) {
        return cartRepository.getCart(session);
    }
}

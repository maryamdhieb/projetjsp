package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.service.CartService;

import java.io.IOException;

@WebServlet("/updateCart")
public class UpdateCartController extends HttpServlet {

    private CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));

            if ("remove".equals(action)) {
                cartService.removeItem(req.getSession(), productId);
            } else {
                int newQuantity = Integer.parseInt(req.getParameter("newQuantity"));
                cartService.updateQuantity(req.getSession(), productId, newQuantity);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        resp.sendRedirect("cart");
    }
}
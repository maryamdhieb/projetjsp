package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Category;
import org.example.model.Product;
import org.example.service.CartService;
import org.example.service.CategoryService;

import java.io.IOException;

@WebServlet(name = "CartController", urlPatterns = {"/cart", "/addToCart"})
public class CartController extends HttpServlet {

    private CartService cartService;
    private CategoryService categoryService;

    @Override
    public void init() {
        cartService = new CartService();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getServletPath().equals("/cart")) {
            req.setAttribute("cartItems", cartService.getCart(req.getSession()));
            req.getRequestDispatcher("cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        if (req.getServletPath().equals("/addToCart")) {

            int productId = Integer.parseInt(req.getParameter("productId"));

            // Chercher dans toutes les catégories
            for (Category cat : categoryService.getAllCategories()) {
                for (Product p : cat.getProducts()) {
                    if (p.getId() == productId) {
                        cartService.addProduct(req.getSession(), p);
                        resp.sendRedirect("home");
                        return;
                    }
                }
            }
        }
    }
}

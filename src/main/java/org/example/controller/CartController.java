package org.example.controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.service.CartService;
import org.example.service.CategoryService;
import org.example.service.PromotionService;
import org.example.model.Category;
import org.example.model.Product;



import java.io.IOException;

@WebServlet(urlPatterns = {"/addToCart", "/cart"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)

public class CartController extends HttpServlet {

    private CartService cartService = new CartService();
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getServletPath();

        if ("/addToCart".equals(path)) {
            resp.sendRedirect("home");
            return;
        }

        if ("/cart".equals(path)) {
            req.setAttribute("cartItems", cartService.getCart(req.getSession()));
            try {
                req.getRequestDispatcher("/cart.jsp").forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if ("/addToCart".equals(req.getServletPath())) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));

                // Recherche du produit dans les catégories (ou mieux : utiliser ProductService)
                Product product = null;
                for (Category cat : categoryService.getAllCategories()) {
                    for (Product p : cat.getProducts()) {
                        if (p.getId() == productId) {
                            product = p;
                            break;
                        }
                    }
                    if (product != null) break;
                }

                if (product != null) {
                    cartService.addProduct(req.getSession(), product);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect("home");
        }
    }
}
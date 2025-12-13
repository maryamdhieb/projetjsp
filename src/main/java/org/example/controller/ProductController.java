package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.model.Product;
import org.example.service.ProductService;

import java.io.IOException;

@WebServlet(name = "ProductController", urlPatterns = "/products")
public class ProductController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String contextPath = request.getContextPath();

        try {
            if ("add".equals(action)) {

                String name = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String desc = request.getParameter("description");
                String imageUrl = request.getParameter("imageUrl");
                String quantityStr = request.getParameter("Quantity");
                String categoryIdStr = request.getParameter("categoryId");

                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                double quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Double.parseDouble(quantityStr) : 0.0;
                int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;

                Product product = new Product(0, name, price, desc, quantity, imageUrl, categoryId);
                productService.addProduct(product);

            } else if ("edit".equals(action)) {

                String idStr = request.getParameter("id");
                String newName = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String desc = request.getParameter("description");
                String imageUrl = request.getParameter("imageUrl");
                String quantityStr = request.getParameter("Quantity");
                String categoryIdStr = request.getParameter("categoryId");

                int id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;
                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                double quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Double.parseDouble(quantityStr) : 0.0;
                int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;

                Product updatedProduct = new Product(id, newName, price, desc, quantity, imageUrl, categoryId);
                productService.updateProduct(updatedProduct);

            } else if ("delete".equals(action)) {

                String idStr = request.getParameter("id");
                int productId = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;
                productService.deleteProduct(productId);
            }

            response.sendRedirect(contextPath + "/categories");

        } catch (NumberFormatException e) {
            // Gérer une entrée invalide
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre numérique invalide");
        } catch (Exception e) {
            // Gérer d'autres erreurs
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur");
        }
    }
}

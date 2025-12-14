package org.example.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.model.Product;
import org.example.service.ProductService;
import jakarta.servlet.annotation.MultipartConfig;
import java.sql.Connection;
import org.example.DBConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


import java.io.IOException;
import java.io.InputStream;

@WebServlet(name = "ProductController", urlPatterns = "/products")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
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
                Part imagePart = request.getPart("image");
                byte[] image = getImageBytes(imagePart);
                String quantityStr = request.getParameter("Quantity");
                String categoryIdStr = request.getParameter("categoryId");

                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                double quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Double.parseDouble(quantityStr) : 0.0;
                int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;

                Product product = new Product(0, name, price, desc, quantity, image, categoryId);
                productService.addProduct(product);

            } else if ("edit".equals(action)) {

                String idStr = request.getParameter("id");
                String newName = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String desc = request.getParameter("description");
                Part imagePart = request.getPart("image");
                byte[] image = getImageBytes(imagePart);
                String quantityStr = request.getParameter("Quantity");
                String categoryIdStr = request.getParameter("categoryId");

                int id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : 0;
                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                double quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Double.parseDouble(quantityStr) : 0.0;
                int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 0;

                Product updatedProduct = new Product(id, newName, price, desc, quantity, image, categoryId);
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
    private byte[] getImageBytes(Part part) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        try (InputStream inputStream = part.getInputStream()) {
            return inputStream.readAllBytes();
        }
    }
    // Diminuer le stock
    public boolean decreaseStock(int productId, int quantity) {
        String sql = "UPDATE product SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

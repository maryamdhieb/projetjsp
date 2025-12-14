package org.example.service;

import org.example.model.Product;
import org.example.repository.ProductRepository;
import org.example.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class ProductService {

    private final ProductRepository productRepository = new ProductRepository();

    public void addProduct(Product p) {
        productRepository.addProduct(p);
    }

    public void updateProduct(Product p) {
        productRepository.updateProduct(p);
    }

    public void deleteProduct(int id) {
        productRepository.deleteProduct(id);
    }

    public Object getAllProducts() {
        return productRepository.getAllProducts();
    }

    public Product getProductById(int id) {
        Product product = null;

        String sql = "SELECT id, name, price, description, quantity, image, promo, discount, promo_price, category_id FROM product WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getDouble("quantity"),
                            rs.getBytes("image"),
                            rs.getBoolean("promo"),
                            rs.getDouble("discount"),
                            rs.getDouble("promo_price"),
                            rs.getInt("category_id")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }
}

package org.example.repository;

import org.example.model.Product;
import org.example.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProductRepository {

    // Ajouter un produit en BD
    public void addProduct(Product p) {
        String sql = "INSERT INTO product (name, price, description, quantity, image, category_id) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getQuantity());
            ps.setBytes(5, p.getImage());
            ps.setInt(6, p.getCategoryId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // Modifier un produit dans la BD
    public void updateProduct(Product product) {

        String sql = "UPDATE product SET name=?, price=?, description=?, quantity=?, image=?, category_id=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getQuantity());
            ps.setBytes(5, product.getImage());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erreur UPDATE product : " + e.getMessage());
        }
    }

    // Supprimer un produit dans la BD
    public void deleteProduct(int productId) {

        String sql = "DELETE FROM product WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erreur DELETE product : " + e.getMessage());
        }
    }

    public Object getAllProducts() {
        return null;

    }
    public boolean decreaseStock(int productId, int quantity) {
        String sql = "UPDATE product SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";

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

        return false; // en cas d'erreur
    }
}

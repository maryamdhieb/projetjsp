package org.example.repository;

import org.example.model.Category;
import org.example.model.Product;
import org.example.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryRepository {

    public CategoryRepository() {}

    // Récupérer toutes les catégories avec leurs produits
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();

        String sqlCategory = "SELECT * FROM category";
        String sqlProduct = "SELECT * FROM product WHERE category_id = ?";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rsCategory = stmt.executeQuery(sqlCategory)) {

            while (rsCategory.next()) {

                int catId = rsCategory.getInt("id");
                String name = rsCategory.getString("name");
                String description = rsCategory.getString("description");
                byte [] image = rsCategory.getBytes("image");
                List<Product> products = new ArrayList<>();

                try (PreparedStatement ps = conn.prepareStatement(sqlProduct)) {
                    ps.setInt(1, catId);
                    try (ResultSet rsProd = ps.executeQuery()) {
                        while (rsProd.next()) {
                            Product product = new Product(
                                    rsProd.getInt("id"),
                                    rsProd.getString("name"),
                                    rsProd.getDouble("price"),
                                    rsProd.getString("description"),
                                    rsProd.getDouble("quantity"),
                                    rsProd.getBytes("image"),
                                    rsProd.getInt("category_id")
                            );
                            products.add(product);
                        }
                    }
                }

                Category category = new Category(
                        catId,
                        name,
                        description,
                        image,
                        products
                );

                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    // Ajouter une catégorie
    public void addCategory(Category category) {

        String sql = "INSERT INTO category (name, description, image) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setBytes(3, category.getImage());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    category.setId(rs.getInt(1));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Supprimer une catégorie par id
    public void deleteCategory(int id) {

        String sql = "DELETE FROM category WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Modifier une catégorie
    public boolean updateCategory(int id, Category updatedCategory) {

        String sql = "UPDATE category SET name = ?, description = ?, image = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, updatedCategory.getName());
            ps.setString(2, updatedCategory.getDescription());
            ps.setBytes(3, updatedCategory.getImage());
            ps.setInt(4, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


}

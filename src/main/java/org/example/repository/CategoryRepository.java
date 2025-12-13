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
                String imageUrl = rsCategory.getString("imageUrl");

                // ----- Charger produits -----
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
                                    rsProd.getString("imageUrl"),
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
                        imageUrl,
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

        String sql = "INSERT INTO category (name, description, imageUrl) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImageUrl());
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

        String sql = "UPDATE category SET name = ?, description = ?, imageUrl = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, updatedCategory.getName());
            ps.setString(2, updatedCategory.getDescription());
            ps.setString(3, updatedCategory.getImageUrl());
            ps.setInt(4, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Récupérer toutes les catégories avec leurs produits (même méthode que getAllCategories)
    public List<Category> getAllCategoriesWithProducts() {
        List<Category> categories = new ArrayList<>();
        String sqlCategories = "SELECT * FROM category ORDER BY id";
        String sqlProducts = "SELECT * FROM product WHERE category_id = ?";
        try (Connection conn = DBConnection.getConnection();
             Statement stmtCategories = conn.createStatement();
             ResultSet rsCategories = stmtCategories.executeQuery(sqlCategories)) {

            while (rsCategories.next()) {
                int categoryId = rsCategories.getInt("id");
                String name = rsCategories.getString("name");
                String description = rsCategories.getString("description");
                String imageUrl = rsCategories.getString("imageUrl");

                // Récupérer les produits pour cette catégorie
                List<Product> products = new ArrayList<>();
                try (PreparedStatement psProducts = conn.prepareStatement(sqlProducts)) {
                    psProducts.setInt(1, categoryId);
                    try (ResultSet rsProducts = psProducts.executeQuery()) {
                        while (rsProducts.next()) {
                            Product product = new Product(
                                    rsProducts.getInt("id"),
                                    rsProducts.getString("name"),
                                    rsProducts.getDouble("price"),
                                    rsProducts.getString("description"),
                                    rsProducts.getDouble("quantity"),
                                    rsProducts.getString("imageUrl"),
                                    rsProducts.getBoolean("promo"),
                                    rsProducts.getDouble("discount"),
                                    rsProducts.getDouble("promoPrice"),
                                    rsProducts.getInt("category_id")
                            );
                            products.add(product);
                        }
                    }
                }

                Category category = new Category(
                        categoryId,
                        name,
                        description,
                        imageUrl,
                        products
                );
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;

    }
}

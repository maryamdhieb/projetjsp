package org.example.repository;

import org.example.DBConnection;
import org.example.model.Product;
import org.example.model.Promotion;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PromotionRepository {

    public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM promotion ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Promotion p = new Promotion(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("value"),
                        rs.getString("type"),
                        rs.getObject("startDate", LocalDate.class),
                        rs.getObject("endDate", LocalDate.class)
                );
                promotions.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }

    public int addPromotionAndReturnId(Promotion promo) {
        String sql = "INSERT INTO promotion (name, description, type, value, startDate, endDate) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, promo.getName());
            ps.setString(2, promo.getDescription());
            ps.setString(3, promo.getType());

            ps.setDouble(4, promo.getValue());
            ps.setObject(5, promo.getStartDate());
            ps.setObject(6, promo.getEndDate());


            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void linkPromotionToProducts(int promotionId, List<Integer> productIds) {
        if (productIds == null || productIds.isEmpty()) return;

        String sql = "INSERT IGNORE INTO product_promotion (product_id, promotion_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (Integer productId : productIds) {
                ps.setInt(1, productId);
                ps.setInt(2, promotionId);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePromotion(int id) {
        String sql = "DELETE FROM promotion WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePromotionWithProducts(Promotion promo, List<Integer> productIds) {
        String sqlUpdatePromo = "UPDATE promotion SET name=?, description=?, type=?, value=?, startDate=?, endDate=? WHERE id=?";
        String sqlDeleteLinks = "DELETE FROM product_promotion WHERE promotion_id=?";
        String sqlInsertLinks = "INSERT INTO product_promotion (promotion_id, product_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdatePromo)) {
                psUpdate.setString(1, promo.getName());
                psUpdate.setString(2, promo.getDescription());
                psUpdate.setString(3, promo.getType());
                psUpdate.setDouble(4, promo.getValue());
                psUpdate.setObject(5, promo.getStartDate());
                psUpdate.setObject(6, promo.getEndDate());
                psUpdate.setInt(7, promo.getId());
                psUpdate.executeUpdate();
            }

            try (PreparedStatement psDelete = conn.prepareStatement(sqlDeleteLinks)) {
                psDelete.setInt(1, promo.getId());
                psDelete.executeUpdate();
            }

            if (productIds != null && !productIds.isEmpty()) {
                try (PreparedStatement psInsert = conn.prepareStatement(sqlInsertLinks)) {
                    for (Integer prodId : productIds) {
                        psInsert.setInt(1, promo.getId());
                        psInsert.setInt(2, prodId);
                        psInsert.addBatch();
                    }
                    psInsert.executeBatch();
                }
            }

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getProductsForPromotion(int promotionId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM product p " +
                "JOIN product_promotion pp ON p.id = pp.product_id " +
                "WHERE pp.promotion_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, promotionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getDouble("price"),
                            rs.getString("description"),
                            rs.getDouble("quantity"),
                            rs.getString("imageUrl"),
                            rs.getInt("category_id")
                    );
                    products.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();}
        return products;
    }

}
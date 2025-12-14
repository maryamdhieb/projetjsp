package org.example.repository;
import org.example.model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import org.example.DBConnection;

public class OrderRepository {

    public int saveOrder(Order order) {
        String sql = """
            INSERT INTO orders
            (user_id, nom, prenom, adresse, ville, telephone, paiement, total)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getNom());
            ps.setString(3, order.getPrenom());
            ps.setString(4, order.getAdresse());
            ps.setString(5, order.getVille());
            ps.setString(6, order.getTelephone());
            ps.setString(7, order.getPaiement());
            ps.setDouble(8, order.getTotal());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // ID commande
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}

package org.example.repository;

import org.example.DBConnection;
import org.example.model.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;

public class UserRepository {

    private List<User> users = new LinkedList<>();

    // Constructeur : récupère tous les utilisateurs depuis la base
    public UserRepository() {
        String sqlquery = "SELECT * FROM user";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sqlquery)) {

            while (rs.next()) {
                User user = new User(
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("name"),
                        rs.getString("role")
                );
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Recherche utilisateur par email et mot de passe
    public Optional<User> findUserByEmailAndPwd(String email, String pwd) {
        Predicate<User> matchCredentials = user -> user.getEmail().equals(email) && user.getPassword().equals(pwd);
        return users.stream().filter(matchCredentials).findFirst();
    }
}

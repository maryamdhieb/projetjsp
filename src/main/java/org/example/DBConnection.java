package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/sportdata?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; // ton user MySQL
    private static final String PASSWORD = "Root123"; // ton mot de passe

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // charge le driver MySQL
        } catch (ClassNotFoundException e) {

            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

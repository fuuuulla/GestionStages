package com.stages.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/stages_db?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";  // Laissez vide pour XAMPP
    
    public static Connection getConnection() throws SQLException { // DAO utilise cette méthode pour controller l'erreur
        try { // Charger le driver MySQL
        	
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL introuvable", e);
        }
    }
    
    // Méthode de test
    public static void main(String[] args) { // test de connexion local
        try {
            Connection conn = getConnection(); 
            System.out.println("✅ Connexion réussie à la base de données !"); 
            conn.close();
        } catch (SQLException e) {
            System.out.println("❌ Erreur de connexion : " + e.getMessage()); 
        }
    }
}

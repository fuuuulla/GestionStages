package com.stages.dao;

import com.stages.model.User;
import com.stages.util.DatabaseConnection;
import java.sql.*;

public class UserDAO {
    
    public User authenticate(String email, String password) { // tapez email et password pour authentifier
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        
        try (Connection conn = DatabaseConnection.getConnection(); // tfth triq l mysql	
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User(); // si trouvé, on crée un objet User vide et on le remplit
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setPrenom(rs.getString("prenom"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public java.util.List<User> getAllUsers() { // recupérer tous les utilisateurs
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM users";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setPrenom(rs.getString("prenom"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                list.add(user); // Important : on ajoute chaque personne à la liste
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
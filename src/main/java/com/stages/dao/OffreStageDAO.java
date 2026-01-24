package com.stages.dao;

import com.stages.model.OffreStage;
import com.stages.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OffreStageDAO {
    
    public List<OffreStage> getAllOffres() {
        List<OffreStage> offres = new ArrayList<>();
        String sql = "SELECT * FROM offres_stage ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                OffreStage offre = new OffreStage();
                offre.setId(rs.getInt("id"));
                offre.setTitre(rs.getString("titre"));
                offre.setEntreprise(rs.getString("entreprise"));
                offre.setDescription(rs.getString("description"));
                offre.setDuree(rs.getString("duree"));
                offre.setLieu(rs.getString("lieu"));
                offre.setDateDebut(rs.getDate("date_debut"));
                offres.add(offre);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return offres;
    }
}

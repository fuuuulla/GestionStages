package com.stages.dao;

import com.stages.model.Candidature; 
import com.stages.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CandidatureDAO {
	
    
    public boolean postuler(int etudiantId, int offreId) {
        if (hasAlreadyApplied(etudiantId, offreId)) {
            return false;
        }
        
        String sql = "INSERT INTO candidatures (etudiant_id, offre_id) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, etudiantId);
            stmt.setInt(2, offreId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private boolean hasAlreadyApplied(int etudiantId, int offreId) {
        String sql = "SELECT COUNT(*) FROM candidatures WHERE etudiant_id = ? AND offre_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, etudiantId);
            stmt.setInt(2, offreId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Candidature> getAllCandidatures() {
        List<Candidature> candidatures = new ArrayList<>();
        String sql = "SELECT c.id, c.etudiant_id, c.offre_id, c.statut, c.date_candidature, " +
                     "u.nom, u.prenom, o.titre, o.entreprise " +
                     "FROM candidatures c " +
                     "JOIN users u ON c.etudiant_id = u.id " +
                     "JOIN offres_stage o ON c.offre_id = o.id " +
                     "ORDER BY c.date_candidature DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Candidature c = new Candidature();
                c.setId(rs.getInt("id"));
                c.setEtudiantId(rs.getInt("etudiant_id"));
                c.setOffreId(rs.getInt("offre_id"));
                c.setStatut(rs.getString("statut"));
                c.setDateCandidature(rs.getTimestamp("date_candidature"));
                
                // IMPORTANT : Récupérer le nom et prénom depuis la requête SQL
                c.setNomEtudiant(rs.getString("nom"));
                c.setPrenomEtudiant(rs.getString("prenom"));
                c.setTitreOffre(rs.getString("titre"));
                c.setEntreprise(rs.getString("entreprise"));
                
                candidatures.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return candidatures;
    }
    
    public boolean updateStatut(int candidatureId, String statut) {
        String sql = "UPDATE candidatures SET statut = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, statut);
            stmt.setInt(2, candidatureId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<Candidature> getCandidaturesByEtudiant(int etudiantId) {
        List<Candidature> candidatures = new ArrayList<>();
        String sql = "SELECT c.id, c.offre_id, c.statut, c.date_candidature, " +
                     "o.titre, o.entreprise " +
                     "FROM candidatures c " +
                     "JOIN offres_stage o ON c.offre_id = o.id " +
                     "WHERE c.etudiant_id = ? " +
                     "ORDER BY c.date_candidature DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, etudiantId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Candidature c = new Candidature();
                c.setId(rs.getInt("id"));
                c.setOffreId(rs.getInt("offre_id"));
                c.setStatut(rs.getString("statut"));
                c.setDateCandidature(rs.getTimestamp("date_candidature"));
                c.setTitreOffre(rs.getString("titre"));
                c.setEntreprise(rs.getString("entreprise"));
                candidatures.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return candidatures;
    }
}
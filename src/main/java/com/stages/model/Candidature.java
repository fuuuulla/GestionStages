package com.stages.model;

import java.sql.Timestamp; // Importation de la classe Timestamp pour gérer les dates et heures

public class Candidature { 
    private int id;
    private int etudiantId;
    private int offreId;
    private String statut;
    private Timestamp dateCandidature;
    
    private String nomEtudiant;
    private String prenomEtudiant;
    private String titreOffre;
    private String entreprise;

    public Candidature() {} 

    public int getId() { 
        return id;
    }

    public void setId(int id) { 
        this.id = id; 
    }

    public int getEtudiantId() {
        return etudiantId;
    }

    public void setEtudiantId(int etudiantId) {
        this.etudiantId = etudiantId;
    }

    public int getOffreId() {
        return offreId;
    }

    public void setOffreId(int offreId) {
        this.offreId = offreId;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Timestamp getDateCandidature() {
        return dateCandidature;
    }

    public void setDateCandidature(Timestamp dateCandidature) {
        this.dateCandidature = dateCandidature;
    }

    public String getNomEtudiant() {
        return nomEtudiant;
    }

    public void setNomEtudiant(String nomEtudiant) {
        this.nomEtudiant = nomEtudiant;
    }

    public String getPrenomEtudiant() {
        return prenomEtudiant;
    }

    public void setPrenomEtudiant(String prenomEtudiant) {
        this.prenomEtudiant = prenomEtudiant;
    }

    public String getTitreOffre() {
        return titreOffre;
    }

    public void setTitreOffre(String titreOffre) {
        this.titreOffre = titreOffre;
    }

    public String getEntreprise() {
        return entreprise;
    }

    public void setEntreprise(String entreprise) {
        this.entreprise = entreprise;
    }
}

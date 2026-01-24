package com.stages.servlet;

import com.stages.dao.OffreStageDAO;
import com.stages.dao.CandidatureDAO;
import com.stages.model.OffreStage;
import com.stages.model.Candidature;
import com.stages.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/etudiant/offres")
public class OffresServlet extends HttpServlet {
    private OffreStageDAO offreDAO = new OffreStageDAO();
    private CandidatureDAO candidatureDAO = new CandidatureDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // Récupérer toutes les offres
        List<OffreStage> offres = offreDAO.getAllOffres();
        request.setAttribute("offres", offres);
        
        // Récupérer les candidatures de l'étudiant pour afficher les notifications
        List<Candidature> mesCandidatures = candidatureDAO.getCandidaturesByEtudiant(user.getId());
        request.setAttribute("mesCandidatures", mesCandidatures);
        
        request.getRequestDispatcher("/WEB-INF/views/etudiant/offres.jsp").forward(request, response);
    }
}
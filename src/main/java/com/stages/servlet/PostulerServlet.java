package com.stages.servlet;

import com.stages.dao.CandidatureDAO;
import com.stages.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/etudiant/postuler")
public class PostulerServlet extends HttpServlet {
    private CandidatureDAO candidatureDAO = new CandidatureDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int offreId = Integer.parseInt(request.getParameter("offreId"));

        boolean success = candidatureDAO.postuler(user.getId(), offreId);

        if (success) {
            session.setAttribute("message", "Candidature envoyée avec succès !");
        } else {
            session.setAttribute("error", "Vous avez déjà postulé à cette offre.");
        }

        response.sendRedirect(request.getContextPath() + "/etudiant/offres");
    }
}
package com.stages.servlet;

import com.stages.dao.CandidatureDAO;
import com.stages.model.Candidature;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/insfp/dashboard")
public class InsfpDashboardServlet extends HttpServlet {
    private CandidatureDAO candidatureDAO = new CandidatureDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"insfp".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupérer TOUTES les candidatures (comme l'admin)
        List<Candidature> candidatures = candidatureDAO.getAllCandidatures();
        request.setAttribute("candidatures", candidatures);
        
        request.getRequestDispatcher("/WEB-INF/views/insfp/dashboard.jsp").forward(request, response);
    }
}
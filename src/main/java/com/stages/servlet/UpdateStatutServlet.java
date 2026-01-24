package com.stages.servlet;

import com.stages.dao.CandidatureDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/update-statut")
public class UpdateStatutServlet extends HttpServlet {
    private CandidatureDAO candidatureDAO = new CandidatureDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int candidatureId = Integer.parseInt(request.getParameter("candidatureId"));
        String statut = request.getParameter("statut");

        candidatureDAO.updateStatut(candidatureId, statut);

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
package com.stages.servlet;

import com.stages.dao.UserDAO;
import com.stages.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login") 
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
     
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.authenticate(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard");
            } else {
                response.sendRedirect("etudiant/offres");
            }
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
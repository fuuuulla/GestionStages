package com.stages.servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter({"/etudiant/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        String requestURI = httpRequest.getRequestURI();

        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        
        if (requestURI.contains("/admin/") && !"admin".equals(role)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/etudiant/offres");
            return;
        }
        
        if (requestURI.contains("/etudiant/") && !"etudiant".equals(role)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
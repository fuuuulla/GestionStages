package com.stages.servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter({"/etudiant/*", "/admin/*", "/insfp/*"})
public class AuthFilter implements Filter {


	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	        throws IOException, ServletException {

	    HttpServletRequest req = (HttpServletRequest) request;
	    HttpServletResponse res = (HttpServletResponse) response;
	    HttpSession session = req.getSession(false);

	    if (session == null || session.getAttribute("user") == null) {
	        res.sendRedirect(req.getContextPath() + "/login");
	        return;
	    }

	    String role = (String) session.getAttribute("role");
	    String uri = req.getRequestURI();
	    String ctx = req.getContextPath();

	    // ADMIN
	    if (uri.startsWith(ctx + "/admin") && !"admin".equals(role)) {
	        redirectByRole(req, res, role);
	        return;
	    }

	    // ETUDIANT
	    if (uri.startsWith(ctx + "/etudiant") && !"etudiant".equals(role)) {
	        redirectByRole(req, res, role);
	        return;
	    }

	    // INSFP
	    if (uri.startsWith(ctx + "/insfp") && !"insfp".equals(role)) {
	        redirectByRole(req, res, role);
	        return;
	    }

	    chain.doFilter(request, response);
	}

	private void redirectByRole(HttpServletRequest req, HttpServletResponse res, String role)
	        throws IOException {

	    String ctx = req.getContextPath();

	    switch (role) {
	        case "admin":
	            res.sendRedirect(ctx + "/admin/dashboard");
	            break;
	        case "etudiant":
	            res.sendRedirect(ctx + "/etudiant/offres");
	            break;
	        case "insfp":
	            res.sendRedirect(ctx + "/insfp/dashboard");
	            break;
	        default:
	            res.sendRedirect(ctx + "/login");
	    }
	}
}

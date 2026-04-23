package com.crop.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // ✅ Allowed pages (no login required)
        boolean isLoginPage = uri.endsWith("login.jsp");
        boolean isLoginAction = uri.contains("login");
        boolean isRegister = uri.contains("register");

        // ✅ Static resources (IMPORTANT)
        boolean isResource = uri.contains("/css/")
                || uri.contains("/js/")
                || uri.contains("/images/")
                || uri.contains(".css")
                || uri.contains(".js");

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (loggedIn || isLoginPage || isLoginAction || isRegister || isResource) {
            chain.doFilter(request, response);
        } else {
            // 🔥 Correct redirect with context path
            res.sendRedirect(contextPath + "/views/login.jsp");
        }
    }
}
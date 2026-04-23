package com.crop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.service.UserService;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        // ✅ Get form data
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // ✅ Validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            res.sendRedirect(req.getContextPath() + "/views/register.jsp?error=empty");
            return;
        }

        UserService service = new UserService();

        try {
            // ✅ Register user
            boolean isRegistered = service.register(username.trim(), password.trim());

            if (isRegistered) {
                // ✅ Success → login page
                res.sendRedirect(req.getContextPath() + "/views/login.jsp?success=1");
            } else {
                // ❌ Fail (maybe duplicate)
                res.sendRedirect(req.getContextPath() + "/views/register.jsp?error=exists");
            }

        } catch (Exception e) {
            e.printStackTrace();

            // ❌ Server error
            res.sendRedirect(req.getContextPath() + "/views/register.jsp?error=server");
        }
    }
}
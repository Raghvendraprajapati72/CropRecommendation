package com.crop.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.service.UserService;
import com.crop.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // ✅ NULL + EMPTY CHECK
        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {

            res.sendRedirect(req.getContextPath() + "/views/login.jsp?error=1");
            return;
        }

        username = username.trim();

        // ✅ SERVICE CALL (password verify)
        UserService service = new UserService();
        String role = service.login(username, password);

        if (role != null) {

            try {
                // 🔥 DB से email fetch करो
                Connection con = DBConnection.getConnection();

                PreparedStatement ps = con.prepareStatement(
                    "SELECT email FROM users WHERE username=?"
                );
                ps.setString(1, username);

                ResultSet rs = ps.executeQuery();

                String email = null;

                if (rs.next()) {
                    email = rs.getString("email");
                }

                // ✅ SESSION CREATE
                HttpSession session = req.getSession();
                session.setAttribute("user", username);
                session.setAttribute("role", role);
                session.setAttribute("email", email);  // 🔥 ADDED

                session.setMaxInactiveInterval(30 * 60);

                System.out.println("✅ Login Success: " + username);

                // ✅ ROLE BASED REDIRECT
                if ("admin".equalsIgnoreCase(role)) {
                    res.sendRedirect(req.getContextPath() + "/views/admin.jsp");
                } else {
                    res.sendRedirect(req.getContextPath() + "/views/FarmerDashboard.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
                res.sendRedirect(req.getContextPath() + "/views/error.jsp");
            }

        } else {

            System.out.println("❌ Login Failed: " + username);

            res.sendRedirect(req.getContextPath() + "/views/login.jsp?error=1");
        }
    }
}
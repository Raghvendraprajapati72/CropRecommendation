package com.crop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.util.DBConnection;

@WebServlet("/submit-help")   // ✅ FIXED URL
public class HelpServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String query = req.getParameter("query");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO help_requests(username, query, status) VALUES (?, ?, ?)"
            );

            // ✅ SESSION USER
            HttpSession session = req.getSession();
            String username = (String) session.getAttribute("user");

            if (username == null) {
                username = "Guest";
            }

            ps.setString(1, username);
            ps.setString(2, query);
            ps.setString(3, "Pending");   // ✅ ADD STATUS

            ps.executeUpdate();

            // ✅ CORRECT REDIRECT
            res.sendRedirect(req.getContextPath() + "/views/help.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/views/help.jsp?error=1");
        }
    }
}
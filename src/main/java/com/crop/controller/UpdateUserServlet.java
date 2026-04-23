package com.crop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.util.DBConnection;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        // 🔒 Admin check
        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !role.equals("admin")) {
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
            return;
        }

        String id = req.getParameter("id");
        String username = req.getParameter("username");

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET username=? WHERE id=?"
            );
        ) {

            ps.setString(1, username);
            ps.setInt(2, Integer.parseInt(id));

            ps.executeUpdate();

            // ✅ back to admin page
            res.sendRedirect(req.getContextPath() + "/admin");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/views/error.jsp");
        }
    }
}
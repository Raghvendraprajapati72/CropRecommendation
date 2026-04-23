package com.crop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.util.DBConnection;

@WebServlet("/toggleUser")
public class ToggleUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/plain");

        try {

            // ✅ session check (security)
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                res.getWriter().write("unauthorized");
                return;
            }

            int id = Integer.parseInt(req.getParameter("id"));

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                    "UPDATE users SET status = IF(status='active','blocked','active') WHERE id=?"
                 )) {

                ps.setInt(1, id);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    res.getWriter().write("success");
                } else {
                    res.getWriter().write("error");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("error");
        }
    }
}
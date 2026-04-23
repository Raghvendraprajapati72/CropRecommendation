package com.crop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.util.DBConnection;   // ✅ THIS WAS MISSING

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE help_requests SET status='Resolved' WHERE id=?"
            );

            ps.setInt(1, id);
            ps.executeUpdate();

            res.sendRedirect(req.getContextPath() + "/views/admin-queries.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
package com.crop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.util.DBConnection;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
            return;
        }

        String user = (String) session.getAttribute("user");
        String currentPass = req.getParameter("currentPassword");
        String newPass = req.getParameter("newPassword");

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=?"
            );
            ps.setString(1, user);
            ps.setString(2, currentPass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                PreparedStatement update = con.prepareStatement(
                    "UPDATE users SET password=? WHERE username=?"
                );
                update.setString(1, newPass);
                update.setString(2, user);
                update.executeUpdate();

                session.setAttribute("msg", "Password Updated Successfully");

            } else {
                session.setAttribute("error", "Current Password Incorrect");
            }

            res.sendRedirect(req.getContextPath() + "/views/settings.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Something went wrong");
            res.sendRedirect(req.getContextPath() + "/views/settings.jsp");
        }
    }
}
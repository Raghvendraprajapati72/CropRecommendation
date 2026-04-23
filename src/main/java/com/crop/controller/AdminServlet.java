package com.crop.controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.util.DBConnection;
import com.crop.model.User;
import com.crop.model.HelpRequest;
import com.crop.dao.HelpDAO;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔒 ADMIN SECURITY
        if (session == null || session.getAttribute("role") == null ||
                !"admin".equals(session.getAttribute("role"))) {

            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
            return;
        }

        String view = req.getParameter("view");

        // ============================
        // 👤 USERS VIEW
        // ============================
        if ("users".equalsIgnoreCase(view)) {

            req.setAttribute("showUsers", true);

            List<User> userList = new ArrayList<>();

            try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM users ORDER BY id DESC");
                ResultSet rs = ps.executeQuery()
            ) {

                while (rs.next()) {
                    User u = new User();

                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setRole(rs.getString("role"));

                    String status = rs.getString("status");
                    u.setStatus(status != null ? status : "active");

                    userList.add(u);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            req.setAttribute("users", userList);
        }

        // ============================
        // 📩 HELP REQUESTS VIEW
        // ============================
        else if ("help".equalsIgnoreCase(view)) {

            req.setAttribute("showHelp", true);

            HelpDAO dao = new HelpDAO();
            List<HelpRequest> helpList = dao.getAll();

            if (helpList == null) {
                helpList = new ArrayList<>();
            }

            req.setAttribute("helpList", helpList);
        }

        // ============================
        // 📊 DASHBOARD (DEFAULT)
        // ============================
        else {

            req.setAttribute("showDashboard", true);

            int totalUsers = 0;
            int adminCount = 0;
            int userCount = 0;
            int helpCount = 0;

            try (Connection con = DBConnection.getConnection()) {

                // 🔥 TOTAL USERS
                PreparedStatement ps1 = con.prepareStatement("SELECT role FROM users");
                ResultSet rs1 = ps1.executeQuery();

                while (rs1.next()) {
                    totalUsers++;
                    String role = rs1.getString("role");

                    if ("admin".equalsIgnoreCase(role)) {
                        adminCount++;
                    } else {
                        userCount++;
                    }
                }

                // 🔥 HELP REQUEST COUNT
                PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM help_requests");
                ResultSet rs2 = ps2.executeQuery();

                if (rs2.next()) {
                    helpCount = rs2.getInt(1);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            // ✅ SEND TO JSP
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("adminCount", adminCount);
            req.setAttribute("userCount", userCount);
            req.setAttribute("helpCount", helpCount);
        }

        // ============================
        // 🚀 FORWARD
        // ============================
        req.getRequestDispatcher("/views/admin.jsp").forward(req, res);
    }
}
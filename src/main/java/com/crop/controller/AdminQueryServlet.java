package com.crop.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.dao.HelpDAO;
import com.crop.model.HelpRequest;

@WebServlet("/adminQueries")
public class AdminQueryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {

            // ✅ Session check (admin only)
            HttpSession session = req.getSession(false);
            String user = (session != null) ? (String) session.getAttribute("user") : null;

            if (user == null) {
                res.sendRedirect("login.jsp");
                return;
            }

            // ✅ GET DATA FROM DAO
            HelpDAO dao = new HelpDAO();
            List<HelpRequest> list = dao.getAll();

            // ✅ SET DATA
            req.setAttribute("queries", list);

            // ✅ FORWARD TO JSP
            RequestDispatcher rd =
                    req.getRequestDispatcher("/views/admin-queries.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("Error loading queries");
        }
    }
}
package com.crop.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import com.crop.dao.HistoryDAO;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String user = (session != null) ? (String) session.getAttribute("user") : null;

        HistoryDAO dao = new HistoryDAO();

        // 🔥 DEBUG
        System.out.println("Fetching history for user: " + user);

        // ✅ GET DATA
        req.setAttribute("historyList", dao.getHistory());

        // ✅ FORWARD
        RequestDispatcher rd = req.getRequestDispatcher("/views/history.jsp");
        rd.forward(req, res);
    }
}
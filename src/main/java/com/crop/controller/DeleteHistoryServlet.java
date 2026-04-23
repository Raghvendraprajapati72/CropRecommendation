package com.crop.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crop.util.DBConnection;

@WebServlet("/deleteHistory")
public class DeleteHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM history WHERE id=?"
                 )) {

                ps.setInt(1, id);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    res.getWriter().write("success");
                } else {
                    res.getWriter().write("fail");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("error");
        }
    }
}
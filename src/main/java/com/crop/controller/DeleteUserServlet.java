package com.crop.controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.crop.dao.UserDAO;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setContentType("text/plain");

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            UserDAO dao = new UserDAO();
            boolean success = dao.deleteUser(id);

            if (success) {
                res.getWriter().write("success");
            } else {
                res.getWriter().write("fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().write("error");
        }
    }
}
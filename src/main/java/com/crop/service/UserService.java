package com.crop.service;

import com.crop.dao.UserDAO;
import com.crop.util.PasswordUtil;

public class UserService {

    private UserDAO dao = new UserDAO();

    // ✅ REGISTER
    public boolean register(String username, String password) {

        try {
            username = username.trim();
            password = password.trim();

            // 🔥 Check if user exists
            if (dao.userExists(username)) {
                System.out.println("❌ USER ALREADY EXISTS");
                return false;
            }

            return dao.register(username, password);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ LOGIN (🔥 FULLY UPDATED)
    public String login(String username, String password) {

        try {
            username = username.trim();
            password = password.trim();

            System.out.println("Entered username: " + username);

            // 🔥 NOW get password + role + status
            String data = dao.getPasswordAndRole(username);

            if (data != null) {

                String[] parts = data.split("::");

                String dbPass = parts[0];
                String role = parts[1];
                String status = parts[2]; // 🔥 NEW

                // 🚫 BLOCK CHECK
                if ("blocked".equalsIgnoreCase(status)) {
                    System.out.println("🚫 USER BLOCKED");
                    return "blocked";
                }

                // 🔐 PASSWORD CHECK
                if (PasswordUtil.checkPassword(password, dbPass)) {
                    System.out.println("✅ LOGIN SUCCESS");
                    return role; // admin / user
                } else {
                    System.out.println("❌ PASSWORD MISMATCH");
                }

            } else {
                System.out.println("❌ USER NOT FOUND");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
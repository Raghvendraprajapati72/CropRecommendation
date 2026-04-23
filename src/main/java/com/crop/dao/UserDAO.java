package com.crop.dao;

import java.sql.*;
import java.util.*;
import com.crop.util.DBConnection; // ❗ ensure this exists
import com.crop.model.User;
import com.crop.util.PasswordUtil;

public class UserDAO {

    // ✅ GET ALL USERS (🔥 STATUS ADDED)
    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT id, username, role, status FROM users ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status")); // 🔥 IMPORTANT

                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ REGISTER USER
    public boolean register(String username, String password) {

        String sql = "INSERT INTO users(username, password, role, status) VALUES (?, ?, 'user', 'active')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            // 🔐 HASH PASSWORD
            String hashed = PasswordUtil.hashPassword(password);
            ps.setString(2, hashed);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ CHECK USER EXISTS
    public boolean userExists(String username) {

        String sql = "SELECT 1 FROM users WHERE username=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ LOGIN (🔥 PASSWORD + ROLE + STATUS)
    public String getPasswordAndRole(String username) {

        String sql = "SELECT password, role, status FROM users WHERE username=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");

                return password + "::" + role + "::" + status; // 🔥 IMPORTANT
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ✅ DELETE USER (AJAX)
    public boolean deleteUser(int id) {

        String sql = "DELETE FROM users WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ✅ UPDATE USER
    public boolean updateUser(int id, String username) {

        String sql = "UPDATE users SET username=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 🔥 OPTIONAL: GET USER BY ID
    public User getUserById(int id) {

        String sql = "SELECT * FROM users WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));

                return u;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
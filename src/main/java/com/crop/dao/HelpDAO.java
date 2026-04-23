package com.crop.dao;

import java.sql.*;
import java.util.*;

import com.crop.model.HelpRequest;
import com.crop.util.DBConnection;

public class HelpDAO {

    // ✅ GET ALL
    public List<HelpRequest> getAll() {

        List<HelpRequest> list = new ArrayList<>();

        String sql = "SELECT * FROM help_requests ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                HelpRequest h = new HelpRequest();

                h.setId(rs.getInt("id"));
                h.setUsername(rs.getString("username"));
                h.setQuery(rs.getString("query"));
                h.setStatus(rs.getString("status"));

                // ✅ FIXED LINE
                h.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
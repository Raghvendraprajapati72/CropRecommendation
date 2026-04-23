package com.crop.dao;

import java.sql.*;
import java.util.*;

import com.crop.model.History;
import com.crop.util.DBConnection;

public class HistoryDAO {

    public List<History> getHistory() {

        List<History> list = new ArrayList<>();

        String sql = "SELECT * FROM history ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                History h = new History();

                h.setId(rs.getInt("id"));
                h.setCrop(rs.getString("crop"));
                h.setSoil(rs.getString("soil"));
                h.setTemperature(rs.getDouble("temperature"));
                h.setHumidity(rs.getDouble("humidity"));
                h.setResult(rs.getString("result"));

                // ✅ SAFE date handling
                Timestamp ts = rs.getTimestamp("date");
                if (ts != null) {
                    h.setDate(ts.toString());
                }

                list.add(h);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
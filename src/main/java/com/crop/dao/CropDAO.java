package com.crop.dao;

import java.sql.*;

public class CropDAO {

    public static void saveData(double n, double p, double k,
                               double temp, double humidity,
                               double ph, double rain,
                               String crop) {

        String sql = "INSERT INTO crop_data(n,p,k,temp,humidity,ph,rain,crop) VALUES (?,?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, n);
            ps.setDouble(2, p);
            ps.setDouble(3, k);
            ps.setDouble(4, temp);
            ps.setDouble(5, humidity);
            ps.setDouble(6, ph);
            ps.setDouble(7, rain);
            ps.setString(8, crop);

            ps.executeUpdate();

            System.out.println("✅ Data Inserted");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
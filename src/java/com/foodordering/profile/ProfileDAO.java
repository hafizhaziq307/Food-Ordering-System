/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.profile;

/**
 *
 * @author ASUS
 */
import com.foodordering.database.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ProfileDAO {

    private final Connection conn;
    private int result;

    public ProfileDAO() {
        conn = DBConnection.getConnection();
    }

    public int addProfile(Profile profile) {
        try {
            String Query = "INSERT INTO customer_tbl(cust_name, cust_password, cust_email, cust_address, cust_phone_number) VALUES (?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getPassword());
            ps.setString(3, profile.getEmail());
            ps.setString(4, profile.getAddress());
            ps.setString(5, profile.getPhoneno());

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public Profile retrieveProfile(int id) {
        Profile profile = new Profile();

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM customer_tbl WHERE cust_id= '" + id + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                profile.setId(rs.getInt(1));
                profile.setName(rs.getString(2));
                profile.setPassword(rs.getString(3));
                profile.setEmail(rs.getString(4));
                profile.setAddress(rs.getString(5));
                profile.setPhoneno(rs.getString(6));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return profile;
    }

    public int checkProfile(String email, String password) {
        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM customer_tbl WHERE cust_email= '" + email + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                if (email.equals(rs.getString(4)) && password.equals(rs.getString(3))) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

}

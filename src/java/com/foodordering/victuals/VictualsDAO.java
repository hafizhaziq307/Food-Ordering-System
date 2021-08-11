/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.victuals;

import com.foodordering.database.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class VictualsDAO {

    private final Connection conn;
    private int result;

    public VictualsDAO() {
        conn = DBConnection.getConnection();
    }

    public int addVictuals(Victuals victuals) {
        try {
            String Query = "INSERT INTO victuals_tbl(vname, vprice, vimage, vtype) VALUES (?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setString(1, victuals.getName());
            ps.setDouble(2, victuals.getPrice());
            ps.setString(3, victuals.getImage());
            ps.setString(4, victuals.getType());

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public int updateVictuals(Victuals victuals) {
        try {
            String Query = "UPDATE victuals_tbl SET vname=?, vprice=?, vimage=?, vtype=? WHERE vcode=?";

            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setString(1, victuals.getName());
            ps.setDouble(2, victuals.getPrice());
            ps.setString(3, victuals.getImage());
            ps.setString(4, victuals.getType());
            ps.setInt(5, victuals.getCode());

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public int deleteVictuals(int code) {
        try {
            String Query = "DELETE FROM victuals_tbl WHERE vcode=?";
            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setInt(1, code);

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public List<Victuals> retrieveAllVictuals() {
        List<Victuals> victualsAll = new ArrayList<>();

        Victuals victuals;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM victuals_tbl";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                victuals = new Victuals();
                victuals.setCode(rs.getInt(1));
                victuals.setName(rs.getString(2));
                victuals.setPrice(rs.getDouble(3));
                victuals.setImage(rs.getString(4));
                victuals.setType(rs.getString(5));

                victualsAll.add(victuals);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return victualsAll;

    }
    
    public List<Victuals> retrieveAllVictualsRice() {
        List<Victuals> victualsAll = new ArrayList<>();

        Victuals victuals;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM victuals_tbl WHERE vname LIKE 'Nasi%'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                victuals = new Victuals();
                victuals.setCode(rs.getInt(1));
                victuals.setName(rs.getString(2));
                victuals.setPrice(rs.getDouble(3));
                victuals.setImage(rs.getString(4));
                victuals.setType(rs.getString(5));

                victualsAll.add(victuals);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return victualsAll;

    }
    
    public List<Victuals> retrieveAllVictualsMee() {
        List<Victuals> victualsAll = new ArrayList<>();

        Victuals victuals;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM victuals_tbl WHERE vname LIKE 'Mee%'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                victuals = new Victuals();
                victuals.setCode(rs.getInt(1));
                victuals.setName(rs.getString(2));
                victuals.setPrice(rs.getDouble(3));
                victuals.setImage(rs.getString(4));
                victuals.setType(rs.getString(5));

                victualsAll.add(victuals);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return victualsAll;

    }
    
    public List<Victuals> retrieveAllVictualsBeverage() {
        List<Victuals> victualsAll = new ArrayList<>();

        Victuals victuals;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM victuals_tbl WHERE vtype='drink'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                victuals = new Victuals();
                victuals.setCode(rs.getInt(1));
                victuals.setName(rs.getString(2));
                victuals.setPrice(rs.getDouble(3));
                victuals.setImage(rs.getString(4));
                victuals.setType(rs.getString(5));

                victualsAll.add(victuals);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return victualsAll;

    }
    

    public Victuals retrieveVictuals(int code) {
        Victuals victuals = new Victuals();

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM victuals_tbl WHERE vcode='" + code + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                victuals.setCode(rs.getInt(1));
                victuals.setName(rs.getString(2));
                victuals.setPrice(rs.getDouble(3));
                victuals.setImage(rs.getString(4));
                victuals.setType(rs.getString(5));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return victuals;
    }
}

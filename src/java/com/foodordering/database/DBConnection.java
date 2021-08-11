/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class DBConnection implements java.io.Serializable {

    private static Connection connection;

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");

            String myUrl = "jdbc:mysql://localhost/foodordering";
            connection = DriverManager.getConnection(myUrl, "root", "");

        } catch (ClassNotFoundException | SQLException e) {
            e.getMessage();
        }
        return connection;

    }

    public void closeConnection() {
        try {
            connection.close();

        } catch (SQLException e) {
            e.getMessage();
        }
    }
}

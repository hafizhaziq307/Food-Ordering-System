/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.cart;

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
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private final Connection conn;
    private int result;

    public CartDAO() {
        conn = DBConnection.getConnection();
    }

    public int addCart(List<Cart> allCart) {
        try {
            String Query = "INSERT INTO cart_tbl (cust_id, qty, vcode) VALUES (?,?,?)";

            for (int i = 0; i < allCart.size(); i++) {

                PreparedStatement ps = conn.prepareStatement(Query);
                ps.setInt(1, allCart.get(0).getCustId());
                ps.setInt(2, allCart.get(0).getQty());
                ps.setInt(3, allCart.get(i).getCode());
                result = ps.executeUpdate();

            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;

    }

    public int updateAllCart(List<Cart> allCart) {
        try {
            String Query = "UPDATE cart_tbl SET qty=? WHERE cart_id=?";

            for (int i = 0; i < allCart.size(); i++) {

                PreparedStatement ps = conn.prepareStatement(Query);
                ps.setInt(1, allCart.get(i).getQty());
                ps.setInt(2, allCart.get(i).getCartId());
                result = ps.executeUpdate();

            }

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public int updateCart(Cart cart) {
        try {
            String Query = "UPDATE cart_tbl SET qty=? WHERE cart_id=? AND cust_id=?";

            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setInt(1, cart.getQty());
            ps.setInt(2, cart.getCartId());
            ps.setInt(3, cart.getCustId());

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public int deleteCart(int id, int cust_id) {
        try {
            String Query = "DELETE FROM cart_tbl WHERE cart_id=? AND cust_id=?";
            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setInt(1, id);
            ps.setInt(2, cust_id);

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public int deleteAllCart(int custId) {
        try {
            String Query = "DELETE FROM cart_tbl WHERE cust_id=?";
            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setInt(1, custId);

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("exception is: " + e.getMessage());
        }
        return result;

    }

    public List<Cart> retrieveAllCart(int cust_id) {
        List<Cart> cartAll = new ArrayList<>();

        Cart cart;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM cart_tbl WHERE cust_id='" + cust_id + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                cart = new Cart();
                cart.setCartId(rs.getInt(1));
                cart.setCustId(rs.getInt(2));
                cart.setQty(rs.getInt(3));
                cart.setCode(rs.getInt(4));

                cartAll.add(cart);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cartAll;

    }

    public Cart retrieveCart(int code,int cust_id) {
        Cart cart = new Cart();

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM cart_tbl WHERE vcode='" + code + "' AND cust_id='" + cust_id + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                cart.setCartId(rs.getInt(1));
                cart.setCustId(rs.getInt(2));
                cart.setQty(rs.getInt(3));
                cart.setCode(rs.getInt(4));
                
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cart;
    }

    public boolean checkCart(int code, int cust_id) {
        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM cart_tbl WHERE vcode='" + code + "' AND cust_id='" + cust_id + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}

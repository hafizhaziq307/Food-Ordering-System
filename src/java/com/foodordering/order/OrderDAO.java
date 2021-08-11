/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.order;

/**
 *
 * @author ASUS
 */
import com.foodordering.cart.Cart;
import com.foodordering.database.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private final Connection conn;
    private int result;

    public OrderDAO() {
        conn = DBConnection.getConnection();
    }

    public int addOrder(List<Order> allOrder) {
        try {
            String Query = "INSERT INTO order_tbl (table_num,cust_id,qty,vcode,order_date,order_status) VALUES (?,?,?,?,?,?)";

            for (int i = 0; i < allOrder.size(); i++) {

                PreparedStatement ps = conn.prepareStatement(Query);

                ps.setInt(1, allOrder.get(i).getTableno());
                ps.setInt(2, allOrder.get(i).getCustid());
                ps.setInt(3, allOrder.get(i).getQty());
                ps.setInt(4, allOrder.get(i).getCode());
                ps.setString(5, "null");
                ps.setString(6, "Unpaid");

                result = ps.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("");
        }
        return result;

    }

    public int updateOrder(List<Order> allOrder) {
        try {
            String Query = "UPDATE order_tbl SET order_date=?,order_status=? WHERE order_id=? AND cust_id=?";

            for (int i = 0; i < allOrder.size(); i++) {

                PreparedStatement ps = conn.prepareStatement(Query);

                ps.setString(1, allOrder.get(i).getOrderdate());
                ps.setString(2, "Paid");
                ps.setInt(3, allOrder.get(i).getOrderid());
                ps.setInt(4, allOrder.get(i).getCustid());

                result = ps.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("");
        }
        return result;

    }

    public int deleteAllOrder(int custId) {
        try {
            String Query = "DELETE FROM order_tbl WHERE cust_id=? AND order_status=?";
            PreparedStatement ps = conn.prepareStatement(Query);
            ps.setInt(1, custId);
            ps.setString(2, "Unpaid");

            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Exception is: " + e.getMessage());
        }
        return result;

    }

    public List<Order> retrieveAllOrder(int cust_id) {
        List<Order> orderAll = new ArrayList<>();

        Order order;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM order_tbl WHERE cust_id='" + cust_id + "' AND order_status='Unpaid'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                order = new Order();

                order.setOrderid(rs.getInt(1));
                order.setTableno(rs.getInt(2));
                order.setOrderdate(rs.getString(3));
                order.setCustid(rs.getInt(4));
                order.setQty(rs.getInt(5));
                order.setCode(rs.getInt(6));
                order.setOrderstatus(rs.getString(7));

                orderAll.add(order);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return orderAll;

    }

    public Order retrieveOrder(int order_id) {
        Order order = new Order();

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM order_tbl WHERE order_id='" + order_id + "'";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                order.setOrderid(rs.getInt(1));
                order.setTableno(rs.getInt(2));
                order.setOrderdate(rs.getString(3));
                order.setCustid(rs.getInt(4));
                order.setQty(rs.getInt(5));
                order.setCode(rs.getInt(6));
                order.setOrderstatus(rs.getString(7));

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return order;
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.foodordering.payment;

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

public class PaymentDAO {

    private final Connection conn;
    private int result;

    public PaymentDAO() {
        conn = DBConnection.getConnection();
    }

    public int addPayment(List<Payment> allPayment) {
        try {
            String Query = "INSERT INTO payment_tbl(payment_image, order_id,totalprice) VALUES (?,?,?)";

            for (int i = 0; i < allPayment.size(); i++) {
                PreparedStatement ps = conn.prepareStatement(Query);

                ps.setString(1, allPayment.get(i).getPayimage());
                ps.setInt(2, allPayment.get(i).getOrderid());
                ps.setDouble(3, allPayment.get(i).getTotalPrice());
                
                result = ps.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("Exception is: " + e.getMessage());
        }
        return result;

    }
    
    public List<Payment> retrieveAllPayment() {
        List<Payment> paymentAll = new ArrayList<>();

        Payment payment;

        try {
            Statement myStatement = conn.createStatement();
            String Query = "SELECT * FROM payment_tbl;";
            ResultSet rs = myStatement.executeQuery(Query);

            while (rs.next()) {
                payment = new Payment();
                
                payment.setPayid(rs.getInt(1));
                payment.setPayimage(rs.getString(2));
                payment.setTotalPrice(rs.getDouble(3));
                payment.setOrderid(rs.getInt(4));

                paymentAll.add(payment);

            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return paymentAll;

    }
}

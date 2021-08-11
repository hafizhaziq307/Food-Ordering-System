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
public class Payment {

    private int payid;
    private String payimage;
    private int orderid;
    private double totalPrice;

    public void setPayid(int payid) {
        this.payid = payid;
    }

    public void setPayimage(String payimage) {
        this.payimage = payimage;
    }

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getPayid() {
        return payid;
    }

    public String getPayimage() {
        return payimage;
    }

    public int getOrderid() {
        return orderid;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
}

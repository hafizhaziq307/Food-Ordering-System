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
public class Order {

    private int orderid;
    private int tableno;
    private String orderdate;
    private int custid;
    private int qty;
    private int code;
    private String orderstatus;

    public void setOrderid(int orderid) {
        this.orderid = orderid;
    }

    public void setTableno(int tableno) {
        this.tableno = tableno;
    }

    public void setOrderdate(String orderdate) {
        this.orderdate = orderdate;
    }

    public void setCustid(int custid) {
        this.custid = custid;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setOrderstatus(String orderstatus) {
        this.orderstatus = orderstatus;
    }
     

    public int getOrderid() {
        return orderid;
    }

    public int getTableno() {
        return tableno;
    }

    public String getOrderdate() {
        return orderdate;
    }

    public int getCustid() {
        return custid;
    }

    public int getQty() {
        return qty;
    }

    public int getCode() {
        return code;
    }

    public String getOrderstatus() {
        return orderstatus;
    }
    
    
    

}

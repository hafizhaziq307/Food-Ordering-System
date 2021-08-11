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
public class Cart {
    private int cartId;
    private int custId;
    private int qty;
    private int code;

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public void setCustId(int custId) {
        this.custId = custId;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public int getCartId() {
        return cartId;
    }

    public int getCustId() {
        return custId;
    }

    public int getQty() {
        return qty;
    }

    public int getCode() {
        return code;
    }
    
    
    
}

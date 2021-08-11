package com.foodordering.profile;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ASUS
 */
public class Profile {

    private int id;
    private String name;
    private String password;
    private String email;
    private String address;
    private String phoneno;

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }
    
    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public String getPhoneno() {
        return phoneno;
    }

}

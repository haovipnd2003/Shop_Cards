/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.text.NumberFormat;
import java.util.Locale;

/**
 *
 * @author Admin
 */
public class Account {
    String id,user,pass,email,address, isAdmin,isActive;
    String phone;
    double balance;

    public Account(String id, String user, String pass, String email, String address, String isAdmin, String isActive, String phone) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.email = email;
        this.address = address;
        this.isAdmin = isAdmin;
        this.isActive = isActive;
        this.phone = phone;
        
    }

    public Account(String id, String user, String pass, String email, String address, String isAdmin, String isActive, String phone, double balance) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.email = email;
        this.address = address;
        this.isAdmin = isAdmin;
        this.isActive = isActive;
        this.phone = phone;
        this.balance = balance;
    }

    public String getIsActive() {
        return isActive;
    }

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
    

    public String getBalance() {
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return currencyFormatter.format(this.balance);
    }
    public double getRawBalance() {
        return this.balance;
    }
    public void setRawBalance(double balance) {
        this.balance = balance;
    }
    public void setBalance(double balance) {
        this.balance = balance;
    }

    public Account(String id, String user, String pass, String email, String isAdmin, double balance) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.email = email;
        
        this.isAdmin = isAdmin;
       
        this.balance = balance;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Account(String id, String user, String pass, String email, String address, String isAdmin, String phone) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.email = email;
        this.address = address;
        this.isAdmin = isAdmin;
        this.phone = phone;
    }
   

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Account() {
    }

    public Account(String id, String user, String pass, String email, String isAdmin) {
        this.id = id;
        this.user = user;
        this.pass = pass;
        this.email = email;
        this.isAdmin = isAdmin;
    }

    public Account(String user, String pass, String email, String isAdmin) {
        this.user = user;
        this.pass = pass;
        this.email = email;
        this.isAdmin = isAdmin;
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }
   
    @Override
    public String toString() {
        return "Account{" + "id=" + id + ", user=" + user + ", pass=" + pass + ", email=" + email + ", isAdmin=" + isAdmin + '}';
    }
    
}

package entity;

import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

public class Order {

    private int id;
    private int userId;
    private double totalAmount;
    private Timestamp orderDate;
    private String status;
    private List<Product> products;
    private List<OrderDetail> orderDetails;
    private HttpSession session;

    public Order() {
    }

    public Order(int id, int userId, double totalAmount, Timestamp orderDate, String status) {
        this.id = id;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    public Order(int userId, double totalAmount, List<Product> products) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.products = products;
    }
     public void setSession(HttpSession session) {
        this.session = session;
    }

    public HttpSession getSession() {
        return this.session;
    }
    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
    
    public String getFormattedTotalAmount() {
        try {
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            return currencyFormatter.format(totalAmount);
        } catch (Exception e) {
            // Handle any exception that might occur during formatting
            return String.valueOf(totalAmount);
        }
    }
}

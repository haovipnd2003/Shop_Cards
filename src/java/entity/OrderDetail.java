package entity;

public class OrderDetail {
    private int id;
    private int orderId;
    private int cardId;
    private String productName;
    private String seri;
    private String cardNumber;

    public OrderDetail() {}

    public OrderDetail(int id, int orderId, int cardId, String productName, String seri, String cardNumber) {
        this.id = id;
        this.orderId = orderId;
        this.cardId = cardId;
        this.productName = productName;
        this.seri = seri;
        this.cardNumber = cardNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCardId() {
        return cardId;
    }

    public void setCardId(int cardId) {
        this.cardId = cardId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSeri() {
        return seri;
    }

    public void setSeri(String seri) {
        this.seri = seri;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

   
}
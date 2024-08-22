package entity;

import java.text.NumberFormat;
import java.util.Locale;

public class Product {
    String id, name, image, price, cateID, seri,cardNumber;
    int amount;
    private int isDelete;
    private String deleteAt;

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }

    public String getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(String deleteAt) {
        this.deleteAt = deleteAt;
    }

    public Product(String id, String name, String image, String price, String cateID, String seri, String cardNumber, int amount, int isDelete, String deleteAt) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.cateID = cateID;
        this.seri = seri;
        this.cardNumber = cardNumber;
        this.amount = amount;
        this.isDelete = isDelete;
        this.deleteAt = deleteAt;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Product(String id, String name, String image, String price, String cateID, String seri, String cardNumber, int amount) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.cateID = cateID;
        this.seri = seri;
        this.cardNumber = cardNumber;
        this.amount = amount;
    }

    
    public Product(String id, String name, String image, String price, String cateID, int amount) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.cateID = cateID;
        this.amount = amount;
    }
    
    public Product() {
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

    public Product(String id, String name, String image, String price, String isDelete, String cateID) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.cateID = cateID;
        this.isDelete = Integer.parseInt(isDelete);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPrice() {
        try {
            double priceValue = Double.parseDouble(price);
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            return currencyFormatter.format(priceValue);
        } catch (NumberFormatException e) {
            // Handle the case where the price is not a valid number
            return price;
        }
    }
    public double getRawPrice() {
    try {
        return Double.parseDouble(this.price);
    } catch (NumberFormatException e) {
        // Handle the case where the price is not a valid number
        return 0.0;
    }
}

    public void setPrice(String price) {
        this.price = price;
    }

    public String getCateID() {
        return cateID;
    }

    public void setCateID(String cateID) {
        this.cateID = cateID;
    }
    // Phương thức để lấy trạng thái
    public String getStatus() {
        return isDelete == 1 ? "UnAvailable" : "Available";
    }

    @Override
    public String toString() {
        return "Product{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", image='" + image + '\'' +
                ", price='" + getPrice() + '\'' + // Use formatted price
                ", cateID='" + cateID + '\'' +
                ", amount=" + amount +
                '}';
    }
}

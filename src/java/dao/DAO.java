/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Account;
import entity.Category;
import entity.DetailCard;
import entity.Order;
import entity.OrderDetail;
import entity.Post;
import entity.Product;
import entity.TransactionHistory;

import entity.hashpassword;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DAO extends DBContext {

    public DAO() {
        connectDB();
    }
    //Khai báo các thành phần sử lí DB
    Connection cnn;//Kết nối DB;
    PreparedStatement stm;// Thực hiện các câu lệnh SQL
    ResultSet rs;//Lưu trữ và xử lí dữ liệu lấy về từ select

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("Connect Success");
        } else {
            System.out.println("Connect Fail");
        }
    }

    public Account login(String user) {

        try {
            String query = "select * from Account where user = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, user);

            rs = stm.executeQuery();

            while (rs.next()) {
                return new Account(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(14),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(13),
                        rs.getDouble(15));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public Account getAccountById(String id) {
        String sql = "SELECT * "
                + "  FROM Account"
                + "  where id = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Account a = new Account();
                a.setId(rs.getString("id"));
                a.setUser(rs.getString("user"));
                a.setBalance(rs.getDouble("balance"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setAddress(rs.getString("address"));
                a.setPhone(rs.getString("phone"));
                a.setIsAdmin(rs.getString("isAdmin"));

                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateInfo(Double balance, String phone, String address, String role, String id) {
        try {
            String sql = "UPDATE account SET balance = ?, phone = ?, address = ?, isAdmin = ? WHERE id = ?";
            stm = cnn.prepareStatement(sql);

            stm.setDouble(1, balance);
            stm.setString(2, phone);
            stm.setString(3, address);
            stm.setInt(4, Integer.parseInt(role));
            stm.setInt(5, Integer.parseInt(id));
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<Account> getAccount() {
        String sql = "SELECT id, user, email, pass, isAdmin,isActive FROM Account";
        ArrayList<Account> list = new ArrayList<>();
        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Account c = new Account();
                c.setId(rs.getString(1));
                c.setUser(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setPass(rs.getString(4));
                c.setIsAdmin(rs.getString(5));
                c.setIsActive(rs.getString(6));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void addAccount(Account c) {
        String sql = "INSERT INTO Account (user, pass, email, isAdmin, isActive) VALUES (?, ?, ?, ?,1)";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, c.getUser());
            stm.setString(2, c.getPass());
            stm.setString(3, c.getEmail());
            stm.setString(4, c.getIsAdmin());

            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public boolean isAccountExists(String account) {
        try {
            String strSQL = "SELECT COUNT(*) FROM ACCOUNT WHERE email = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, account);
            rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count >= 1;
            }
        } catch (Exception e) {
            System.out.println("isAccountExists: " + e.getMessage());
            return true; // Return true in case of an exception (to indicate account exists or an error occurred)
        }
        return false; // Return false if no exception occurred (account doesn't exist)
    }

    public void update(String email, String password) {
        try {
            String strSQL = "update Account set pass=? where email=?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, password);
            stm.setString(2, email);
            stm.execute();
        } catch (Exception e) {
            System.out.println("update: " + e.getMessage());
        }
    }

    public void delete(String id) {
        String sql = "DELETE FROM Account WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, Integer.parseInt(id));
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Account> getAllAcc() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM Account";
        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getString("id"));
                a.setUser(rs.getString("user"));
                a.setBalance(rs.getDouble("balance"));
                a.setEmail(rs.getString("email"));
                a.setPass(rs.getString("pass"));
                a.setIsAdmin(rs.getString("isAdmin"));
                a.setIsActive(rs.getString("isActive"));
                a.setPhone(rs.getString("phone"));
                a.setAddress(rs.getString("address"));
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean changeUserStatus(String userId, String newUserStatus) {
        String sql = "UPDATE Account SET isActive = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, newUserStatus);
            stm.setString(2, userId);
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

//    public void updateRole(int role, int id) {
//        String sql = "UPDATE Account SET isAdmin = ? WHERE id = ?";
//        try {
//            stm = cnn.prepareStatement(sql);
//            stm.setInt(1, role);
//            stm.setInt(2, id);
//            stm.executeUpdate();
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//    }
    public ArrayList<Product> getAllProduct() {
        ArrayList<Product> data = new ArrayList<>();
        try {
            String strSQL = "select * from Product where isDelete = 0";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                String price = String.valueOf(rs.getInt(4));
                String isDelete = rs.getString(5);
                String cateID = String.valueOf(rs.getInt(6));

                Product p = new Product(id, name, image, price, isDelete, cateID);
                data.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }

    public ArrayList<Category> getAllCategory() {
        ArrayList<Category> data = new ArrayList<>();
        try {
            String strSQL = "select * from Category order by id DESC";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String isDelete = rs.getString(6);
                Category c = new Category(id, name, isDelete);
                data.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }

    public ArrayList<Category> getAllAvailCategory() {
        ArrayList<Category> data = new ArrayList<>();
        try {
            String strSQL = "select * from Category where isDelete=1";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String isDelete = rs.getString(6);
                Category c = new Category(id, name, isDelete);
                data.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }

    public Product getLast() {
        try {
            String query = "SELECT * FROM product p join category c on p.cateID=c.id where c.isDelete='1' AND p.isDelete = '0' ORDER BY p.id DESC LIMIT 1";
            stm = cnn.prepareStatement(query);

            rs = stm.executeQuery();

            while (rs.next()) {
                return new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public int getTotalPage() {
        try {
            int productsPerPage = 6;
            String strSQL = "SELECT count(*) FROM Product p\n"
                    + "                    JOIN Category c ON p.cateID = c.id\n"
                    + "                    WHERE c.isDelete = '1' AND p.isDelete = '0'";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                double total = rs.getDouble(1);
                double countPage = total / productsPerPage;
                return (int) Math.ceil(countPage);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalPageByCateID(int cateID) {
        try {
            int productsPerPage = 6;
            String strSQL = "select count(*) from Product p join category c on p.cateID=c.id where cateID=? AND p.isDelete = '0'";
            stm = cnn.prepareStatement(strSQL);
            stm.setInt(1, cateID);
            rs = stm.executeQuery();
            while (rs.next()) {
                double total = rs.getDouble(1);
                double countPage = total / productsPerPage;
                return (int) Math.ceil(countPage);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Product> getProductsByPage(int page, int productsPerPage) {
        List<Product> list = new ArrayList<>();
        try {
            String query = """
                           SELECT * 
                           FROM Product p
                           JOIN Category c ON p.cateID = c.id
                           WHERE c.isDelete = '1'
                           AND p.isDelete = '0'
                           ORDER BY p.id 
                           LIMIT ? OFFSET ?""";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, productsPerPage);
            stm.setInt(2, (page - 1) * productsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategoryAndPriceRange(int cateID, int page, int productsPerPage, int minPrice, int maxPrice) {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM product WHERE isDelete = 0 AND cateID = ? AND price BETWEEN ? AND ? LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, cateID);
            stm.setInt(2, minPrice);
            stm.setInt(3, maxPrice);
            stm.setInt(4, productsPerPage);
            stm.setInt(5, (page - 1) * productsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategoryPage(int cateID, int page, int productsPerPage) {
        List<Product> list = new ArrayList<>();
        try {
            String query = """
                           SELECT * 
                           FROM Product p
                           JOIN Category c ON p.cateID = c.id
                           WHERE  c.id=? AND
                           c.isDelete = '1' 
                             AND p.isDelete = '0'
                           ORDER BY p.id 
                           LIMIT ? OFFSET ?""";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, cateID);
            stm.setInt(2, productsPerPage);
            stm.setInt(3, (page - 1) * productsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalPageByCategoryAndPriceRange(int cateID, int minPrice, int maxPrice) {
        int totalRecords = 0;
        int totalPages = 0;
        try {
            String query = "SELECT COUNT(*) FROM product WHERE isDelete = 0 AND cateID = ? AND price BETWEEN ? AND ?";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, cateID);
            stm.setInt(2, minPrice);
            stm.setInt(3, maxPrice);

            rs = stm.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt(1);
            }
            totalPages = (int) Math.ceil((double) totalRecords / 6);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalPages;
    }

    public List<Product> getProductsByPriceRange(int page, int productsPerPage, int minPrice, int maxPrice) {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM product WHERE isDelete = 0 AND price BETWEEN ? AND ? LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, minPrice);
            stm.setInt(2, maxPrice);
            stm.setInt(3, productsPerPage);
            stm.setInt(4, (page - 1) * productsPerPage);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("price"),
                        rs.getString("isDelete"),
                        rs.getString("cateID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalPageByPriceRange(int minPrice, int maxPrice) {
        int totalRecords = 0;
        int totalPages = 0;
        try {
            String query = "SELECT COUNT(*) FROM product WHERE price BETWEEN ? AND ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setInt(1, minPrice);
            stm.setInt(2, maxPrice);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt(1);
            }
            totalPages = (int) Math.ceil((double) totalRecords / 6);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalPages;
    }

    public Integer getCateIDByName(String catename) {
        try {
            String query = "SELECT * FROM Category where name=?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, catename);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Product getProductByID(String id) {
        try {
            String query = "select  * from product\n"
                    + "where id = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();

            while (rs.next()) {
                return new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5), 1);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public Category getCategoryByID(String id) {
        try {
            String query = "select  * from category\n"
                    + "where id = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();

            while (rs.next()) {
                return new Category(rs.getString(1),
                        rs.getString(2));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Product> SearchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE isDelete = 0 AND name LIKE ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + txtSearch + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Product b = new Product();
                b.setId(rs.getString("id"));
                b.setName(rs.getString("name"));
                b.setCateID(rs.getString("cateId"));
                b.setImage(rs.getString("image"));
                b.setPrice(rs.getString("price"));
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void deleteCard(String id) {
        String sql = "DELETE FROM Product WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertCard(String name, String image, String price, String cateID, String isDelete) {
        String sql = "INSERT INTO Product (name, image, price, cateID, isDelete) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, name);
            st.setString(2, image);
            st.setString(3, price);
            st.setString(4, cateID);
            st.setString(5, isDelete);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateCard(String name, String image, String price, String cateID, int bid) {
        String sql = "UPDATE Product SET name = ?, image = ?, price = ?, cateID = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, name);
            st.setString(2, image);
            st.setString(3, price);
            st.setString(4, cateID);
            st.setInt(5, bid);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Product> SearchProductByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String query = "select * from product\n"
                + "where isDelete = 0 AND name like ?";
        try {

            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + txtSearch + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Product getInventByID(int id) {
        Product p = new Product();
        String query = "SELECT p.name, i.amount,p.price FROM shopcards.inventory i join product p on i.productID = p.id where p.id =?";
        try {

            stm = cnn.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                p = new Product(id + "", rs.getString(1), "", rs.getInt(3) + "", "", rs.getInt(2));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return p;
    }

    public void updateInvent(int id, int amount) {
        String sql = "update inventory set amount = ? where productID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(2, id);
            st.setInt(1, amount);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertPayment(String id, long balance) {
        String sql = "UPDATE Account SET balance = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setLong(1, balance);
            st.setString(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean updateAccountBalance(Account account) {
        String sql = "UPDATE Account SET balance = ? WHERE id = ?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setDouble(1, account.getRawBalance());
            stm.setInt(2, Integer.parseInt(account.getId()));
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating account balance: " + e.getMessage());
            return false;
        }
    }

    public List<DetailCard> getAvailableCards(String productId, int amount) {
        List<DetailCard> cards = new ArrayList<>();
        String sql = "SELECT d.*, p.name AS productName FROM detailcard d "
                + "JOIN product p ON d.ProductId = p.id "
                + "WHERE d.ProductId = ? AND d.isDelete IS NULL "
                + "ORDER BY RAND() LIMIT ?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setInt(1, Integer.parseInt(productId));
            stm.setInt(2, amount);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                DetailCard card = new DetailCard();
                card.setId(rs.getInt("id"));
                card.setSeri(rs.getString("Seri"));
                card.setCardNumber(rs.getString("CardNumber"));
                card.setProductId(rs.getInt("ProductId"));
                card.setProductName(rs.getString("productName"));
                cards.add(card);
            }
        } catch (SQLException e) {
            System.out.println("Error getting available cards: " + e.getMessage());
        }
        return cards;
    }

    public int createOrder(int userId, double totalAmount) {
        String sql = "INSERT INTO orders (user_id, total_amount, order_date, status) VALUES (?, ?, NOW(), 'Completed')";
        try (PreparedStatement stm = cnn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stm.setInt(1, userId);
            stm.setDouble(2, totalAmount);
            stm.executeUpdate();
            ResultSet rs = stm.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error creating order: " + e.getMessage());
        }
        return -1;
    }

    public void addOrderDetail(int orderId, int cardId) {
        String sql = "INSERT INTO order_details (order_id, card_id) VALUES (?, ?)";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setInt(1, orderId);
            stm.setInt(2, cardId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error adding order detail: " + e.getMessage());
        }
    }

    public void updateCardStatus(int cardId, String status) {
        String sql = "UPDATE detailcard SET isDelete = 1, deleteAt = NOW() WHERE id = ?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setInt(1, cardId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating card status: " + e.getMessage());
        }
    }

    public boolean checkCardAvailability(String productId, int amount) {
        String sql = "SELECT COUNT(*) FROM detailcard WHERE ProductId = ? AND isDelete IS NULL";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setInt(1, Integer.parseInt(productId));
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int availableCards = rs.getInt(1);
                return availableCards >= amount;
            }
        } catch (SQLException e) {
            System.out.println("Error checking card availability: " + e.getMessage());
        }
        return false;
    }

    public List<Order> getOrdersForUser(int userId, int page, int ordersPerPage) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.id, o.user_id, o.order_date, o.total_amount, o.status "
                + "FROM orders o "
                + "WHERE o.user_id = ? "
                + "ORDER BY o.order_date DESC "
                + "LIMIT ? OFFSET ?";

        try (
                PreparedStatement ps = cnn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, ordersPerPage);
            ps.setInt(3, (page - 1) * ordersPerPage);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(userId);
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setOrderDetails(getOrderDetails(order.getId()));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    private List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> details = new ArrayList<>();
        String query = "SELECT od.card_id, d.Seri, d.CardNumber, p.name AS product_name "
                + "FROM order_details od "
                + "JOIN detailcard d ON od.card_id = d.id "
                + "JOIN product p ON d.ProductId = p.id "
                + "WHERE od.order_id = ?";

        try (
                PreparedStatement ps = cnn.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setCardId(rs.getInt("card_id"));
                detail.setProductName(rs.getString("product_name"));
                detail.setSeri(rs.getString("Seri"));
                detail.setCardNumber(rs.getString("CardNumber"));
                details.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return details;
    }

    public int getTotalOrdersForUser(int userId) {
        String query = "SELECT COUNT(DISTINCT id) FROM orders WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getAvailableProductCount(String productId) {
        String sql = "SELECT COUNT(*) FROM detailcard WHERE ProductId = ? AND isDelete IS NULL";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setInt(1, Integer.parseInt(productId));
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error checking product availability: " + e.getMessage());
        }
        return 0;
    }

    public ArrayList<Product> getInventProduct() {
        ArrayList<Product> data = new ArrayList<>();
        try {
            String strSQL = "SELECT p.id, p.name, p.image, p.price, c.name, "
                    + "(SELECT COUNT(*) FROM detailcard d WHERE d.ProductId = p.id AND d.isDelete IS NULL) as cardCount "
                    + "FROM product p "
                    + "JOIN category c ON p.cateID = c.id "
                    + "ORDER BY p.id ASC";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                String price = String.valueOf(rs.getInt(4));
                String nameC = rs.getString(5);
                int amount = rs.getInt(6); // This is now the count of available cards

                Product p = new Product(id, name, image, price, nameC, amount);
                data.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }

    public ArrayList<Product> getInventProductByID(int idp) {
        ArrayList<Product> data = new ArrayList<>();
        String strSQL = "SELECT p.id, p.name product, p.image, d.Seri, d.CardNumber, p.price, c.name category, d.isDelete, d.deleteAt "
                + "FROM shopcards.product p "
                + "JOIN shopcards.inventory i ON i.productID = p.id "
                + "JOIN shopcards.category c ON p.cateID = c.id "
                + "JOIN shopcards.detailcard d ON p.id = d.ProductId "
                + "WHERE p.id = ?";
        try (PreparedStatement stm = cnn.prepareStatement(strSQL)) {
            stm.setInt(1, idp);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                String seri = rs.getString(4);
                String cardNumber = rs.getString(5);
                String price = String.valueOf(rs.getInt(6));
                String nameC = rs.getString(7);
                int isDelete = rs.getInt(8);
                String deleteAt = rs.getString(9);
                Product p = new Product(id, name, image, price, nameC, seri, cardNumber, 1, isDelete, deleteAt);
                data.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }

    public Product getInventId(int idp) {
        Product p = new Product();
        String strSQL = "Select p.id, p.name, p.image, c.name,i.amount  from shopcards.product p join shopcards.inventory i on i.productID = p.id join shopcards.category c on p.cateID = c.id where p.id = ?";
        try (PreparedStatement stm = cnn.prepareStatement(strSQL)) {
            stm.setInt(1, idp);
            rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                String nameC = rs.getString(4);
                int amount = rs.getInt(5);

                p = new Product(id + "", name, image, "3", nameC, amount);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return p;
    }

    public void updateInventById(int a, int b) {
        String sql = "UPDATE shopcards.inventory set amount = ? where productId = ?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setInt(1, a);
            stm.setInt(2, b);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public ArrayList<DetailCard> getAllDetailCard() {
        ArrayList<DetailCard> detail = new ArrayList<>();
        try {
            String strSQL = "SELECT * FROM shopcards.detailcard;";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String Seri = rs.getString(1);
                String Cardnumber = rs.getString(2);
                int productid = rs.getInt(3);

                DetailCard dc = new DetailCard(productid, Seri, Cardnumber, productid);
                detail.add(dc);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return detail;
    }

    public void addDetailCard(String seri, String cardnumber, int productId) {
        String sql = "insert into shopcards.detailcard (detailcard.Seri, detailcard.CardNumber, detailcard.ProductId) values (?,?,?)";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, seri);
            stm.setString(2, cardnumber);
            stm.setInt(3, productId);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Account> SearchByUser(String txtSearch) {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM Account WHERE user LIKE ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + txtSearch + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Account b = new Account();
                b.setId(rs.getString("id"));
                b.setUser(rs.getString("user"));
                b.setEmail(rs.getString("email"));
                b.setAddress(rs.getString("address"));
                b.setPhone(rs.getString("phone"));
                b.setIsAdmin(rs.getString("isAdmin"));
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean changeProductStatus(String productId, String newStatus) {
        String sql = "UPDATE Product SET isDelete = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, newStatus);
            stm.setString(2, productId);
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public List<Product> getAllProductsByPage(int page, int productsPerPage) {
        List<Product> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM Product ORDER BY id LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, productsPerPage);
            stm.setInt(2, (page - 1) * productsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Product> getAllProductStatus() {
        ArrayList<Product> data = new ArrayList<>();
        try {
            String strSQL = "select * from Product";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String image = rs.getString(3);
                String price = String.valueOf(rs.getInt(4));
                String cateID = String.valueOf(rs.getInt(5));
                String isDelete = String.valueOf(rs.getInt(9));

                Product p = new Product(id, name, image, price, isDelete, cateID);
                data.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }

    public boolean isCardExists(String seri, String cardNumber) {
        String sql = "SELECT COUNT(*) FROM shopcards.detailcard WHERE Seri = ? OR CardNumber = ?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, seri);
            stm.setString(2, cardNumber);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void updateProfile(String phone, String address, String id) {
        try {
            String sql = "UPDATE account SET phone = ?, address = ? WHERE id = ?";
            stm = cnn.prepareStatement(sql);

            stm.setString(1, phone);
            stm.setString(2, address);
            stm.setInt(3, Integer.parseInt(id));
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updatePassword(String id, String password) {
        try {
            String strSQL = "update Account set pass=? where id=?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, password);
            stm.setString(2, id);
            stm.execute();
        } catch (Exception e) {
            System.out.println("update: " + e.getMessage());
        }
    }

    public boolean checkIfCategoryExists(String categoryName) {
        boolean exists = false;
        String query = "SELECT * FROM Category WHERE name = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, categoryName);
            rs = stm.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    public void editCategory(int categoryId, String newName, int delete) {
        String sql = "UPDATE category SET name = ?, isDelete = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, newName);
            stm.setInt(2, delete);
            stm.setInt(3, categoryId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error updating category: " + ex.getMessage());
        }
    }

    public void addCategory(String name) {
        String sql = "INSERT INTO category (name,isDelete) VALUES (?,1)";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, name);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean isTransactionProcessed(String transactionId) {
        String query = "SELECT COUNT(*) FROM transactions WHERE transaction_id = ?";
        try (PreparedStatement stm = cnn.prepareStatement(query)) {
            stm.setString(1, transactionId);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void markTransactionAsProcessed(String transactionId) {
        String query = "INSERT INTO transactions (transaction_id) VALUES (?)";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, transactionId);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String query = "UPDATE orders SET status = ? WHERE id = ?";
        try (
                PreparedStatement ps = cnn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<TransactionHistory> getTransactionHistory(int userId) {
        List<TransactionHistory> transactions = new ArrayList<>();
        try {
            String query = "SELECT * FROM transaction_history WHERE user_id = ? ORDER BY transaction_date DESC";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            while (rs.next()) {
                TransactionHistory transaction = new TransactionHistory(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("amount"),
                    rs.getString("type"),
                    rs.getString("description"),
                    rs.getTimestamp("transaction_date")
                );
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    public void addTransaction(int userId, double amount, String type, String description) {
        try {
            String query = "INSERT INTO transaction_history (user_id, amount, type, description) VALUES (?, ?, ?, ?)";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, userId);
            stm.setDouble(2, amount);
            stm.setString(3, type);
            stm.setString(4, description);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Post> getAvailablePost() {
        ArrayList<Post> data = new ArrayList<>();
        try {
            String strSQL = "select * from Post where isActive = 1";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String createdBy = rs.getString(2);
                String title = rs.getString(3);
                String paragraph = rs.getString(4);
                String image = rs.getString(5);
                int isActive = rs.getInt(6);

                Post p = new Post(id, title, paragraph, image, createdBy, isActive);
                data.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }
    
    public Post getPostById(String id) {
        try {
            String query = "select  * from post\n"
                    + "where id = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();

            while (rs.next()) {
                return new Post(rs.getString(1),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(2),
                        rs.getInt(6));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    public ArrayList<Post> getAllPost() {
        ArrayList<Post> data = new ArrayList<>();
        try {
            String strSQL = "select * from Post";
            stm = cnn.prepareStatement(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString(1);
                String createdBy = rs.getString(2);
                String title = rs.getString(3);
                String paragraph = rs.getString(4);
                String image = rs.getString(5);
                int isActive = rs.getInt(6);

                Post p = new Post(id, title, paragraph, image, createdBy, isActive);
                data.add(p);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return data;
    }
    
    public boolean changePostStatus(String postId, String newStatus) {
        String sql = "UPDATE Post SET isActive = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, newStatus);
            stm.setString(2, postId);
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }
    
    public void createPost(String title, String paragraph, String image) {
        String sql = "INSERT INTO Post (title, paragraph, image, isActive) VALUES (?, ?, ?, 1)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, title);
            st.setString(2, paragraph);
            st.setString(3, image);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deletePost(String id) {
        String sql = "DELETE FROM Post WHERE id = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void updatePost(String title, String image, String paragraph, int bid) {
        String sql = "UPDATE Post SET title = ?, image = ?, paragraph = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setString(1, title);
            st.setString(2, image);
            st.setString(3, paragraph);
            st.setInt(4, bid);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}

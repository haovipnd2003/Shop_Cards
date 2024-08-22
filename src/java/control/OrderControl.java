package control;

import dao.DAO;
import entity.Account;
import entity.Order;
import entity.Product;
import entity.OrderProcessor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderControl", urlPatterns = {"/order"})
public class OrderControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("acc");

        if (account == null) {
            session.setAttribute("returnUrl", "order");
            String script = "<script>"
                    + "alert('Please login to continue payment.');"
                    + "window.location='login';"
                    + "</script>";
            response.getWriter().println(script);
            return;
        }

        Cookie arr[] = request.getCookies();
        List<Product> list = new ArrayList<>();
        DAO dao = new DAO();
        for (Cookie o : arr) {
            if (o.getName().equals("id")) {
                String txt[] = o.getValue().split("-");
                for (String s : txt) {
                    list.add(dao.getProductByID(s));
                }
            }
        }

        if (list.isEmpty()) {
            String script = "<script>alert('You have not added products to your cart.'); window.location='home';</script>";
            response.getWriter().println(script);
            return;
        }

        double totalAmount = 0;
        boolean allCardsAvailable = true;
        String unavailableProduct = "";
        for (Product p : list) {
            totalAmount += parsePrice(p.getPrice()) * p.getAmount();
            if (!dao.checkCardAvailability(p.getId(), p.getAmount())) {
                allCardsAvailable = false;
                unavailableProduct = p.getName();
                break;
            }
        }

        if (!allCardsAvailable) {
            String script = "<script>alert('Not enough tags in stock for the product: " + unavailableProduct + "'); window.location='home';</script>";
            response.getWriter().println(script);
            return;
        }

        if (account.getRawBalance() < totalAmount) {
            String script = "<script>alert('Account balance is not enough for payment. Please deposit money into your account!'); window.location='print';</script>";
            response.getWriter().println(script);
            return;
        }

        double newBalance = account.getRawBalance() - 0.95 * totalAmount;
        account.setBalance(newBalance);
        boolean updateSuccess = dao.updateAccountBalance(account);

        if (!updateSuccess) {
            String script = "<script>alert('An error occurred while updating the balance. Please try again.'); window.location='home';</script>";
            response.getWriter().println(script);
            return;
        }

        session.setAttribute("acc", account);

        Order order = new Order(Integer.parseInt(account.getId()), totalAmount, list);
        order.setSession(session);
        OrderProcessor.addOrder(order);

        for (Cookie cookie : arr) {
            if (cookie.getName().equals("id")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }

        response.sendRedirect("ProcessingOrder.jsp");
    }

    private double parsePrice(String price) {
        String cleanPrice = price.replaceAll("[^\\d.]", "");
        cleanPrice = cleanPrice.replace(".", "").replace(",", ".");
        return Double.parseDouble(cleanPrice);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Account;
import java.io.PrintWriter;
import entity.Config;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author acer
 */
@WebServlet(name = "VNPayReturn", urlPatterns = {"/vnpay_return"})
public class VNPayReturn extends HttpServlet {

    private void payment(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = Config.hashAllFields(fields);
        if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                HttpSession session = request.getSession();
                Account acc = (Account) session.getAttribute("acc");
                String id = request.getParameter("vnp_TxnRef");
                String moneyStr = request.getParameter("vnp_Amount");
                long money = Long.parseLong(moneyStr);
                DAO d = new DAO();

                if (!d.isTransactionProcessed(id)) {
                    int userId = Integer.parseInt(acc.getId());
                    long updateBalance = (long) (acc.getRawBalance() + money / 100);
                    d.insertPayment(acc.getId(), updateBalance);
                    d.markTransactionAsProcessed(id); // Mark transaction as processed
                    // Add this line to record the transaction
                    d.addTransaction(userId, money / 100, "DEPOSIT", "Deposit money via VNPay - Transaction #" + id);

                    // Update balance in session
                    acc.setRawBalance(updateBalance);
                    session.setAttribute("acc", acc);

                    request.setAttribute("amount", money / 100);
                    request.getRequestDispatcher("StatusTransaction.jsp").forward(request, resp);
                } else {
                    // Transaction already processed
                    request.setAttribute("message", "Transaction has already been processed.");
                    request.getRequestDispatcher("StatusTransaction.jsp").forward(request, resp);
                }

            } else {
                resp.getWriter().print("Transaction is not successful");
            }

        } else {
            resp.getWriter().print("invalid signature");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        payment(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        payment(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

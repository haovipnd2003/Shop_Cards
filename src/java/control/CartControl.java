/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Long
 */
@WebServlet(name = "CartControl", urlPatterns = {"/cart"})
public class CartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        DAO dao = new DAO();
        int availableCount = dao.getAvailableProductCount(id);

        Cookie[] cookies = request.getCookies();
        String cartItems = "";
        Cookie cartCookie = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    cartItems = cookie.getValue();
                    cartCookie = cookie;
                    break;
                }
            }
        }

        List<String> items = new ArrayList<>(Arrays.asList(cartItems.split("-")));
        int currentCount = Collections.frequency(items, id);

        PrintWriter out = response.getWriter();
        if (currentCount < availableCount) {
            if (cartItems.isEmpty()) {
                cartItems = id;
            } else {
                cartItems += "-" + id;
            }

            if (cartCookie == null) {
                cartCookie = new Cookie("id", cartItems);
            } else {
                cartCookie.setValue(cartItems);
            }
            cartCookie.setMaxAge(60 * 60 * 24);
            response.addCookie(cartCookie);
            // Send the updated cart count along with the success message
            int cartCount = cartItems.split("-").length;
            out.print("success|" + cartCount);
        } else {
            out.print("failure");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

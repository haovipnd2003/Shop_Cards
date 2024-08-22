/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author admin
 */
@WebServlet(name = "AddDetailCard", urlPatterns = {"/addDetailCard"})
public class AddDetailCard extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddDetailCard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddDetailCard at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
//        try {
//            int id = Integer.parseInt(request.getParameter("id"));
//            request.setAttribute("idP", id);
//        } catch (Exception e) {
//            System.out.println(e);
//        }
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
        try {
            String seri = request.getParameter("seri");
            String cardnumber = request.getParameter("numbercard");
            int id = Integer.parseInt(request.getParameter("id"));
            DAO d = new DAO();

            // Check if seri or card number is empty
            if (seri == null || seri.trim().isEmpty() || cardnumber == null || cardnumber.trim().isEmpty()) {
                response.sendRedirect("detailInvent?id=" + id + "&error=empty");
                return;
            }

            // Check if seri or card number already exists
            if (d.isCardExists(seri, cardnumber)) {
                response.sendRedirect("detailInvent?id=" + id + "&error=exists");
                return;
            }

            // If all checks pass, add the card
            d.addDetailCard(seri, cardnumber, id);
            response.sendRedirect("detailInvent?id=" + id + "&success=true");
        } catch (Exception e) {
            System.out.println(e);
            response.sendRedirect("error.jsp");
        }
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

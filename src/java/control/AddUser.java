/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Account;
import entity.SendEmail;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import entity.hashpassword;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddUser", urlPatterns = {"/adduser"})
public class AddUser extends HttpServlet {

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
            out.println("<title>Servlet AddUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUser at " + request.getContextPath() + "</h1>");
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

        
        DAO dao = new DAO();
        String name = request.getParameter("user");
        String email = request.getParameter("email");
        String pass1 = request.getParameter("password");
        String pass2 = request.getParameter("confirmpassword");
        String role = request.getParameter("role");
        request.setAttribute("user", name);
        request.setAttribute("email", email);
        request.setAttribute("password", pass1);
        request.setAttribute("confirmpassword", pass2);
        String message = " ";
        request.getSession().setAttribute("message", message);

        // Validate email format
        if (!isValidEmail(email)) {
            request.setAttribute("err", "Invalid email format!");
            request.getRequestDispatcher("usermanager").forward(request, response);
            return;
        }
        // Check for empty fields
        if (name.isEmpty() || email.isEmpty() || pass1.isEmpty() || pass2.isEmpty()) {
            request.setAttribute("err", "All fields must be filled!");
            request.getRequestDispatcher("usermanager").forward(request, response);
            return;
        }

        // Check if email or username already exists
        ArrayList<Account> listAcc = dao.getAccount();
        for (Account u : listAcc) {
            if (email.equals(u.getEmail())) {
                message = "Email already exists!";
//                request.setAttribute("err", "Email already exists!");
                request.getSession().setAttribute("message", message);
                response.sendRedirect("usermanager");
                return;
            }
            if (name.equals(u.getUser())) {
                message = "Username already exists!";
                request.getSession().setAttribute("message", message);
                response.sendRedirect("usermanager");
                return;
            }
        }

        // Create new account
        pass1 = hashpassword.toSHA1(pass1);
        Account u = new Account(name, pass1, email, role);
//        Account u = new Account("", name, pass1, email, role);
        DAO d = new DAO();
        d.addAccount(u);
        message = "Account created successfully!";
        request.getSession().setAttribute("message", message);
        response.sendRedirect("usermanager");
    }

    public boolean validPass(String pass) {
        String check = "^(?=.*[A-Z])(?=.*\\d)(?=.*[-!@#$%^&*()_+|~=`{}\\[\\]:\";'<>?,./]).{6,}$";
        Pattern pattern = Pattern.compile(check);
        Matcher matcher = pattern.matcher(pass);
        return matcher.matches();
    }

    public boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
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

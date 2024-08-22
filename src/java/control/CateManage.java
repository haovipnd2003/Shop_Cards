/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Category;
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
 * @author acer
 */
@WebServlet(name = "CateManage", urlPatterns = {"/category"})
public class CateManage extends HttpServlet {

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
            out.println("<title>Servlet CateManage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CateManage at " + request.getContextPath() + "</h1>");
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
        DAO d = new DAO();
        List<Category> list = d.getAllCategory();

        request.setAttribute("list", list);
        request.getRequestDispatcher("ManageCategory.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        DAO d = new DAO();
        if ("addCategory".equals(action)) {
            String category = request.getParameter("categoryName");

            if (!d.checkIfCategoryExists(category)) {
                d.addCategory(category);
                request.setAttribute("success", "Added successfully");
            } else {
                request.setAttribute("cate", category);
                request.setAttribute("error", "Category already exists!");
            }
        } else if ("editCategory".equals(action)) {
             int categoryId = Integer.parseInt(request.getParameter("id"));
        String newName = request.getParameter("name");
        String isDeleteParam = request.getParameter("isDelete");
        int isDelete = isDeleteParam != null ? 1 : 0; // Assuming isDelete is a checkbox

        // Check if the name has changed and it's not an existing category
        if (!d.checkIfCategoryExists(newName) || d.getCategoryByID(Integer.toString(categoryId)).getName().equals(newName)) {
            d.editCategory(categoryId, newName, isDelete);
            request.setAttribute("success", "Category updated successfully");
        } else {
            request.setAttribute("error", "Category already exists");
            // Pass the original data back to the edit form
            request.setAttribute("id", categoryId);
            request.setAttribute("name", newName);
            request.setAttribute("isDelete", isDeleteParam);
        }
        }

        doGet(request, response); // Redirect to doGet to refresh the category list
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

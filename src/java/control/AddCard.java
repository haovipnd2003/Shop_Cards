package control;

import dao.DAO;
import entity.Account;
import entity.Product;
import entity.Category;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddCard", urlPatterns = {"/addcard"})
public class AddCard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCard at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String cateID = request.getParameter("category");
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String price = request.getParameter("price");
        String isDelete = "0";
        DAO b = new DAO();
        // Check for empty fields
        if (name.isEmpty() || image.isEmpty() || price.isEmpty()) {
            request.getSession().setAttribute("message1", "All fields must be filled!");
            response.sendRedirect("manager");
            return;
        }
        // Check if email or username already exists
        ArrayList<Product> listPro = b.getAllProductStatus();
        for (Product u : listPro) {
            if (name.equals(u.getName())) {
                request.getSession().setAttribute("message1", "Card name already exists");
                response.sendRedirect("manager");
                return;
            }}

            // Check if price is not negative
            if (Integer.parseInt(price) < 0) {
                request.getSession().setAttribute("message1", "Price must be greater or equal to 0");
                response.sendRedirect("manager");
                return;
            }

            // Create new card
            b.insertCard(name, image, price, cateID, isDelete);
            request.getSession().setAttribute("message1", "Card created successfully!");
            response.sendRedirect("manager");

        }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

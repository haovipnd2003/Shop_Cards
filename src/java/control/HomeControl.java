/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DAO;
import entity.Category;
import entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Admin
 */
@WebServlet(name = "HomeControl", urlPatterns = {"/home"})
public class HomeControl extends HttpServlet {
    private static final int PRODUCTS_PER_PAGE = 6; // Set the number of products per page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clearFilters = request.getParameter("clearFilters");
        if ("true".equals(clearFilters)) {
            // Clear any server-side session attributes if necessary
            HttpSession session = request.getSession();
            session.setAttribute("selectedCategoryName", "");
        session.setAttribute("selectedPrice", "");
            
            // Redirect to home without the clearFilters parameter
            response.sendRedirect("home");
            return;
        }
        DAO dao = new DAO();
        String catename = request.getParameter("catename");
        String priceParam = request.getParameter("price");
        String pageParam = request.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

        List<Product> listP;
        int totalPages;

        int minPrice = 0;
        int maxPrice = Integer.MAX_VALUE;
        
        if (priceParam != null && !priceParam.isEmpty()) {
            int price = Integer.parseInt(priceParam);
            switch (price) {
                case 100:
                    maxPrice = 100000;
                    break;
                case 200:
                    minPrice = 100000;
                    maxPrice = 200000;
                    break;
                case 500:
                    minPrice = 200000;
                    maxPrice = 500000;
                    break;
            }
        }

        if (catename != null && !catename.isEmpty()) {
            int categoryId = dao.getCateIDByName(catename);
            listP = dao.getProductsByCategoryPage(categoryId, page, PRODUCTS_PER_PAGE);
            totalPages = dao.getTotalPageByCateID(categoryId); //double check
        } else {
            listP = dao.getProductsByPage(page, PRODUCTS_PER_PAGE);
            totalPages = dao.getTotalPage();
        }

        Map<String, Boolean> productAvailability = new HashMap<>();
        for (Product product : listP) {
            int availableCount = dao.getAvailableProductCount(product.getId());
            productAvailability.put(product.getId(), availableCount > 0);
        }

        List<Category> listC = dao.getAllAvailCategory();
        Product last = dao.getLast();

        request.setAttribute("productAvailability", productAvailability);
        request.setAttribute("listP", listP);
        request.setAttribute("listC", listC);
        request.setAttribute("p", last);
        request.setAttribute("selectedCategoryName", catename);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("selectedPriceRange", priceParam);

        request.getRequestDispatcher("Home.jsp").forward(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

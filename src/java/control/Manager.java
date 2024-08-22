package control;

import dao.DAO;
import entity.Product;
import entity.Category;
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
 * @author lenam
 */
@WebServlet(name = "Manager", urlPatterns = {"/manager"})
public class Manager extends HttpServlet {

    private static final int PRODUCTS_PER_PAGE = 6; // Set the number of products per page

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Manager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Manager at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        HttpSession sess = request.getSession();
        sess.removeAttribute("selectedCategoryName");
        request.removeAttribute("selectedCategoryName");

        // Get the current page number from the request, default to 1 if not provided
        String pageParam = request.getParameter("page");
        int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

        List<Product> listP = dao.getAllProductStatus();
        Map<String, Boolean> productAvailability = new HashMap<>();
        for (Product product : listP) {
            int availableCount = dao.getAvailableProductCount(product.getId());
            productAvailability.put(product.getId(), availableCount > 0);
        }
        request.setAttribute("productAvailability", productAvailability);
        List<Category> listC = dao.getAllCategory();
        Product last = dao.getLast();
        int totalPages = dao.getTotalPage();

        request.setAttribute("listB", listP);
        request.setAttribute("listC", listC);
        request.setAttribute("p", last);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

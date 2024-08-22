
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
import java.util.List;


@WebServlet(name = "UpdateCard", urlPatterns = {"/updatecard"})
public class UpdateCard extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Profile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Profile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        DAO b = new DAO();
        Product listB = b.getProductByID(id);
        List<Category> listC = b.getAllCategory();
        Category listS = b.getCategoryByID(listB.getCateID());

        request.setAttribute("listS", listS);
        request.setAttribute("listB", listB);
        request.setAttribute("listC", listC);
        request.getRequestDispatcher("updatecard.jsp").forward(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        String category = request.getParameter("category");
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String price = request.getParameter("price");


        DAO b = new DAO();
        int bid = Integer.parseInt(id);
            
          b.updateCard(name, image, price, category, bid);

        response.sendRedirect("manager");
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

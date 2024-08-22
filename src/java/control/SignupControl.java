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
 * Servlet implementation class SignupControl
 */
@WebServlet(name = "SignupControl", urlPatterns = {"/signup"})
public class SignupControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignupControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
    private static final ExecutorService executorService = Executors.newFixedThreadPool(10);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        String name = request.getParameter("user");
        String email = request.getParameter("email");
        String pass1 = request.getParameter("password");
        String pass2 = request.getParameter("repass");
        String captcha = request.getParameter("captcha");
        HttpSession session = request.getSession();
        String captchaExpected = (String) session.getAttribute("captcha");
        request.setAttribute("user", name);
        request.setAttribute("email", email);
        request.setAttribute("password", pass1);
        request.setAttribute("confirmpassword", pass2);
        // Validate CAPTCHA
        if (captcha == null || !captcha.equals(captchaExpected)) {
            request.setAttribute("err", "Invalid CAPTCHA!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
        if (name.contains(" ")) {
            request.setAttribute("err", "Username cannot contain spaces!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
        // Validate email format
        if (!isValidEmail(email)) {
            request.setAttribute("err", "Invalid email format!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
        // Check for empty fields
        if (name.isEmpty() || email.isEmpty() || pass1.isEmpty() || pass2.isEmpty()) {
            request.setAttribute("err", "All fields must be filled!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Check if email or username already exists
        ArrayList<Account> list = dao.getAccount();
        for (Account u : list) {
            if (email.equals(u.getEmail())) {
                request.setAttribute("err", "Email already exists!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            if (name.equals(u.getUser())) {
                request.setAttribute("err", "Username already exists!");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
        }
        // Create new account
        pass1 = hashpassword.toSHA1(pass1);
        Account u = new Account(name, pass1, email, "0");
        session.setAttribute("newUser", u);
//        request.setAttribute("success", "Account created successfully!Please Signin <a href=\"login\">here</a>");
        SendEmail sm = new SendEmail();
        String code = sm.getRandom();
        User user = new User(email, code);
        session.setAttribute("authcode", user);
        session.setAttribute("otpExpiryTime", System.currentTimeMillis() + 30 * 1000);

        executorService.submit(() -> {
            boolean test = sm.sendEmail(user);
            if (test) {
                session.setAttribute("message", "An OTP has been sent to " + email + ". Please check your inbox.");
            } else {
                session.setAttribute("message", "Failed to send the OTP. Please try again.");
            }
        });

        request.getRequestDispatcher("EnterOtp_reg.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Signup Servlet";
    }
}

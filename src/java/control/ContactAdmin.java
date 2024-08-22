package control;

import entity.Account;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@WebServlet(name = "ContactAdmin", urlPatterns = {"/contact"})
public class ContactAdmin extends HttpServlet {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_AUTH_USER = "webbanthe@gmail.com";
    private static final String SMTP_AUTH_PWD = "dyrl uqci javs xmmg";
//    private static final long EMAIL_INTERVAL = 5 * 60 * 1000; // 5 phút tính bằng milliseconds

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("ContactAdmin.jsp");
    }

    private static final int THREAD_POOL_SIZE = 10;
    private final ExecutorService executorService = Executors.newFixedThreadPool(THREAD_POOL_SIZE);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        // Lấy session hiện tại của người dùng
        // Lấy session hiện tại của người dùng
        HttpSession session = request.getSession();
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Gửi email
        String resultMessage;
            try {
                executorService.submit(() -> {
                    try {
                        sendEmail(subject, email, message);
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                });
                response.sendRedirect("StatusContact.jsp");
            } catch (Exception e) {
                resultMessage = "There was an error sending your message. Please try again later.";
                e.printStackTrace();
            }
           
    }

    private void sendEmail(String subject, String email, String message) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
            }
        });

        Message mimeMessage = new MimeMessage(session);
        mimeMessage.setFrom(new InternetAddress(SMTP_AUTH_USER));
        mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SMTP_AUTH_USER));
        mimeMessage.setSubject(subject);
        mimeMessage.setText("Email: " + email + "\n" + "Message: " + message);

        Transport.send(mimeMessage);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        String userEmail=acc.getEmail();
        request.setAttribute("userEmail", userEmail);
        request.getRequestDispatcher("ContactAdmin.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        // Shutdown the executor service when the servlet is destroyed
        executorService.shutdown();
        super.destroy();
    }
}

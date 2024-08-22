package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.awt.geom.AffineTransform;
import java.util.Random;
import javax.imageio.ImageIO;

@WebServlet(name = "CaptchaServlet", urlPatterns = {"/captcha"})
public class CaptchaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int width = 200;
        int height = 80;

        // Create a blank image
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = bufferedImage.createGraphics();

        // Set background to a complex pattern
        drawComplexBackground(g2d, width, height);

        // Generate and draw random lines and shapes
        drawRandomLinesAndShapes(g2d, width, height);

        // Set rendering hints for better text quality
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);

        // Generate random CAPTCHA string
        String captcha = generateCaptcha(5);
        HttpSession session = request.getSession();
        session.setAttribute("captcha", captcha);
        session.setAttribute("captchaGeneratedTime", System.currentTimeMillis());

        // Draw distorted CAPTCHA text with high contrast colors
        drawDistortedText(g2d, captcha, width, height);

        // Release resources
        g2d.dispose();

        // Set response content type to PNG
        response.setContentType("image/png");
        response.setHeader("Cache-Control", "no-cache");

        // Write image to response
        ImageIO.write(bufferedImage, "png", response.getOutputStream());
    }

    private void drawComplexBackground(Graphics2D g2d, int width, int height) {
        Random random = new Random();
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                g2d.setColor(new Color(random.nextInt(256), random.nextInt(256), random.nextInt(256)));
                g2d.fillRect(i, j, 1, 1);
            }
        }
    }

    private void drawRandomLinesAndShapes(Graphics2D g2d, int width, int height) {
        Random random = new Random();
        for (int i = 0; i < 20; i++) { // Draw 20 random lines and shapes
            g2d.setColor(new Color(random.nextInt(256), random.nextInt(256), random.nextInt(256)));
            if (i % 2 == 0) {
                int x1 = random.nextInt(width);
                int y1 = random.nextInt(height);
                int x2 = random.nextInt(width);
                int y2 = random.nextInt(height);
                g2d.drawLine(x1, y1, x2, y2);
            } else {
                int x = random.nextInt(width);
                int y = random.nextInt(height);
                int w = random.nextInt(30);
                int h = random.nextInt(30);
                g2d.fillOval(x, y, w, h);
            }
        }
    }

    private String generateCaptcha(int length) {
        String chars = "0123456789";
        Random random = new Random();
        StringBuilder captcha = new StringBuilder();
        for (int i = 0; i < length; i++) {
            captcha.append(chars.charAt(random.nextInt(chars.length())));
        }
        return captcha.toString();
    }

    private void drawDistortedText(Graphics2D g2d, String text, int width, int height) {
        Random random = new Random();
        int x = 10;
        int y = height / 2 + 20;
        
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);

            // Apply random font and size to each character
            Font font = new Font("Arial", Font.BOLD, 40 + random.nextInt(20));
            g2d.setFont(font);

            // Set a high contrast color for each character
            g2d.setColor(new Color(random.nextInt(50), random.nextInt(50), random.nextInt(50)));

            // Apply more significant rotation and distortion to each character
            AffineTransform originalTransform = g2d.getTransform();
            double angle = (random.nextDouble() - 0.5) * 0.7; // random angle between -0.35 and 0.35 radians
            g2d.rotate(angle, x, y);

            // Apply scaling and shearing
            double scaleX = 1 + (random.nextDouble() - 0.5) * 0.3; // scale between 0.85 and 1.15
            double scaleY = 1 + (random.nextDouble() - 0.5) * 0.3; // scale between 0.85 and 1.15
            double shearX = (random.nextDouble() - 0.5) * 0.3; // shear between -0.15 and 0.15
            double shearY = (random.nextDouble() - 0.5) * 0.3; // shear between -0.15 and 0.15
            g2d.shear(shearX, shearY);
            g2d.scale(scaleX, scaleY);

            // Draw the character with additional offset
            int offsetX = (int) (Math.sin(i * 0.3) * 10);
            int offsetY = (int) (Math.cos(i * 0.3) * 10);
            g2d.drawString(String.valueOf(c), x + offsetX, y + offsetY);

            // Restore the original transform
            g2d.setTransform(originalTransform);

            // Move to the next character position
            x += g2d.getFontMetrics().charWidth(c) + 10;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Captcha Servlet";
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CaptchaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CaptchaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}

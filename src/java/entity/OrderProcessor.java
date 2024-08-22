package entity;

import dao.DAO;
import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

public class OrderProcessor implements Runnable {

    private static final Queue<Order> orderQueue = new ConcurrentLinkedQueue<>();
    private static boolean isRunning = false;

    @Override
    public void run() {
        while (true) {
            Order order = orderQueue.poll();
            if (order != null) {
                processOrder(order);
            } else {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void addOrder(Order order) {
        orderQueue.add(order);
        if (!isRunning) {
            isRunning = true;
            new Thread(new OrderProcessor()).start();
        }
    }

    private void processOrder(Order order) {
        try {
            Thread.sleep(300);

            DAO dao = new DAO();
            int orderId = dao.createOrder(order.getUserId(), order.getTotalAmount());
            List<DetailCard> purchasedCards = new ArrayList<>();

            for (Product p : order.getProducts()) {
                List<DetailCard> cards = dao.getAvailableCards(p.getId(), p.getAmount());
                purchasedCards.addAll(cards);
                for (DetailCard card : cards) {
                    dao.addOrderDetail(orderId, card.getId());
                    dao.updateCardStatus(card.getId(), "Sold");
                }
            }

            dao.updateOrderStatus(orderId, "Completed");
            // Add transaction record
            dao.addTransaction(order.getUserId(), order.getTotalAmount()*0.95, "WITHDRAW", "Purchase - Order #" + orderId);
            HttpSession session = order.getSession();
            if (session != null) {
                session.setAttribute("purchasedCards", purchasedCards);
                session.setAttribute("orderProcessed", true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

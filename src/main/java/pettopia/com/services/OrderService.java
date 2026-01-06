package pettopia.com.services;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pettopia.com.entities.*;
import pettopia.com.repositories.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.math.RoundingMode;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;
    private final OrderStatusRepository orderStatusRepository;
    private final CustomerService customerService;

    private final pettopia.com.config.JwtUtil jwtUtil;

    private Customer getCustomerFromEmail(String email) {
        return customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Customer not found: " + email));
    }

    private String extractToken(String tokenOrHeader) {
        if (tokenOrHeader == null || tokenOrHeader.isBlank()) {
            throw new RuntimeException("JWT token is missing");
        }
        tokenOrHeader = tokenOrHeader.trim();
        if (tokenOrHeader.startsWith("Bearer ")) {
            return tokenOrHeader.substring(7).trim();
        }
        return tokenOrHeader;
    }

    public Order finalizeCart(String token, int pointsToUse) {
        token = token.trim();
        String email = jwtUtil.extractEmail(token);
        Customer customer = getCustomerFromEmail(email);

        Cart cart = cartRepository.findByCustomer(customer)
                .orElseThrow(() -> new RuntimeException("Cart not found for customer"));

        if (cart.getCartItems().isEmpty()) {
            throw new RuntimeException("Cart is empty. Cannot finalize order.");
        }

        Order order = new Order();
        order.setCustomer(customer);
        order.setOrderDate(LocalDateTime.now());
        order.setPaymentMethod("Credit Card");

        OrderStatus defaultStatus = orderStatusRepository.findById(1L)
                .orElseThrow(() -> new RuntimeException("Default order status not found"));
        order.setOrderStatus(defaultStatus);

        orderRepository.save(order);

        List<OrderItem> orderItems = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem cartItem : cart.getCartItems()) {
            Product product = cartItem.getProduct();

            if (cartItem.getQuantity() > product.getStockQuantity()) {
                throw new RuntimeException("Not enough stock for product: " + product.getName());
            }

            product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
            productRepository.save(product);

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setProduct(product);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getPrice());

            orderItems.add(orderItem);
        }

        order.setOrderItems(orderItems);

        total = orderItems.stream()
                .map(i -> i.getPrice().multiply(BigDecimal.valueOf(i.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        int availablePoints = customerService
                .getRewardHistory(email)
                .getTotalPoints();

        int maxByTotal = total.intValue();
        int usablePoints = Math.max(0,
                Math.min(pointsToUse, Math.min(availablePoints, maxByTotal))
        );

        BigDecimal finalTotal = total;

        if (usablePoints > 0) {
            finalTotal = total.subtract(BigDecimal.valueOf(usablePoints));
            if (finalTotal.compareTo(BigDecimal.ZERO) < 0) {
                finalTotal = BigDecimal.ZERO;
            }

            customerService.redeemPoints(
                    email,
                    usablePoints,
                    "Used at checkout for order " + order.getOrderId()
            );
        }

        order.setTotal(finalTotal);
        orderRepository.save(order);

        int pointsEarned = total
                .divide(BigDecimal.valueOf(50), RoundingMode.DOWN)
                .intValue();

        if (pointsEarned > 0) {
            customerService.earnPoints(
                    customer.getCustomerId(),
                    pointsEarned,
                    "Order purchase"
            );
        }

        cart.getCartItems().clear();
        cartRepository.save(cart);

        return order;
    }

    public List<Order> getCustomerOrders(String tokenOrHeader) {
        String token = extractToken(tokenOrHeader);
        String email = jwtUtil.extractEmail(token);
        Customer customer = getCustomerFromEmail(email);
        return orderRepository.findOrdersByCustomerId(customer.getCustomerId());
    }
}


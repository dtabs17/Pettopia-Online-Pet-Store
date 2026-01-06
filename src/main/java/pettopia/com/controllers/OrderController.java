package pettopia.com.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import pettopia.com.dtos.RedeemRequestDTO;
import pettopia.com.entities.Order;
import pettopia.com.services.OrderService;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping("/finalize")
    public Order finalizeCart(@RequestHeader("Authorization") String token, @RequestBody(required = false) RedeemRequestDTO redeemRequest) {
        int pointsToUse = (redeemRequest != null) ? redeemRequest.getPoints() : 0;
        return orderService.finalizeCart(token, pointsToUse);
    }

    @GetMapping("/my-orders")
    public List<Order> getMyOrders(@RequestHeader("Authorization") String token) {
        return orderService.getCustomerOrders(token);
    }
}

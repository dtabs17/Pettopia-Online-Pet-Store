package pettopia.com.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import pettopia.com.entities.Cart;
import pettopia.com.services.CartService;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    private String extractEmail() {
        return SecurityContextHolder.getContext().getAuthentication().getName();
    }

    @GetMapping
    public Cart getCart() {
        String email = extractEmail();
        System.out.println("EMAIL AHHH " + email);
        return cartService.getCart(email).getCart();
    }

    @PostMapping("/add")
    public Cart addToCart(@RequestParam Integer productId,
                          @RequestParam Integer quantity) {
        String email = extractEmail();
        return cartService.addToCart(email, productId, quantity);
    }

    @PutMapping("/update")
    public Cart updateItem(@RequestParam Integer productId,
                           @RequestParam Integer quantity) {
        String email = extractEmail();
        return cartService.updateItem(email, productId, quantity);
    }

    @DeleteMapping("/remove/{productId}")
    public Cart removeItem(@PathVariable Integer productId) {
        String email = extractEmail();
        return cartService.removeItem(email, productId);
    }

    @DeleteMapping("/clear")
    public void clearCart() {
        String email = extractEmail();
        System.out.println("GOT THE EMAIL " + email);
        cartService.clearCart(email);
    }
}

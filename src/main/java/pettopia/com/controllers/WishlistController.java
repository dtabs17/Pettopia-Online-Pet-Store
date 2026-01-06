package pettopia.com.controllers;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import pettopia.com.entities.Product;
import pettopia.com.services.WishlistService;

import java.util.List;

@RestController
@RequestMapping("/api/wishlist")
@RequiredArgsConstructor
public class WishlistController {

    private final WishlistService wishlistService;

    @GetMapping
    public List<Product> getWishlist(@RequestHeader("Authorization") String token) {
        return wishlistService.getWishlist(token);
    }

    @GetMapping("/check")
    public boolean check(@RequestHeader("Authorization") String token,
                         @RequestParam Integer productId) {
        return wishlistService.isInWishlist(token, productId);
    }

    @PostMapping("/add")
    public Product add(@RequestHeader("Authorization") String token,
                       @RequestParam Integer productId) {
        return wishlistService.addToWishlist(token, productId);
    }

    @DeleteMapping("/remove")
    public void remove(@RequestHeader("Authorization") String token,
                       @RequestParam Integer productId) {
        wishlistService.removeFromWishlist(token, productId);
    }
}

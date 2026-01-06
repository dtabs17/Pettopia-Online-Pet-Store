package pettopia.com.services;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pettopia.com.entities.*;
import pettopia.com.repositories.*;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class WishlistService {

    private final WishlistRepository wishlistRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;
    private final pettopia.com.config.JwtUtil jwtUtil;

    private Customer getCustomerFromToken(String tokenOrHeader) {
        String token = tokenOrHeader == null ? null : tokenOrHeader.trim();
        if (token != null && token.startsWith("Bearer ")) token = token.substring(7).trim();
        String email = jwtUtil.extractEmail(token);
        return customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Customer not found: " + email));
    }

    public List<Product> getWishlist(String tokenOrHeader) {
        Customer customer = getCustomerFromToken(tokenOrHeader);
        return wishlistRepository.findByCustomer(customer)
                .stream()
                .map(Wishlist::getProduct)
                .collect(Collectors.toList());
    }

    public boolean isInWishlist(String tokenOrHeader, Integer productId) {
        Customer customer = getCustomerFromToken(tokenOrHeader);
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found: " + productId));
        return wishlistRepository.findByCustomerAndProduct(customer, product).isPresent();
    }

    @Transactional
    public Product addToWishlist(String tokenOrHeader, Integer productId) {
        Customer customer = getCustomerFromToken(tokenOrHeader);
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found: " + productId));

        // ensure not duplicated
        if (wishlistRepository.findByCustomerAndProduct(customer, product).isPresent()) {
            return product;
        }

        Wishlist w = new Wishlist();
        w.setCustomer(customer);
        w.setProduct(product);
        wishlistRepository.save(w);
        return product;
    }

    @Transactional
    public void removeFromWishlist(String tokenOrHeader, Integer productId) {
        Customer customer = getCustomerFromToken(tokenOrHeader);
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found: " + productId));
        wishlistRepository.deleteByCustomerAndProduct(customer, product);
    }
}

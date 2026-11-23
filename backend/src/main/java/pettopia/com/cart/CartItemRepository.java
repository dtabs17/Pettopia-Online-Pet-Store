package pettopia.com.cart;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.product.Product;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Integer> {
    Optional<CartItem> findByCartAndProduct(Cart cart, Product product);
    List<CartItem> findByProduct(Product product);
}

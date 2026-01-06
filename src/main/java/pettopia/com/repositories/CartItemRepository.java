package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.entities.CartItem;
import pettopia.com.entities.Cart;
import pettopia.com.entities.Product;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Integer> {
    Optional<CartItem> findByCartAndProduct(Cart cart, Product product);
    List<CartItem> findByProduct(Product product);
}

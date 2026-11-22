package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.entities.Cart;
import pettopia.com.entities.Customer;

import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Integer> {
    Optional<Cart> findByCustomer(Customer customer);
}

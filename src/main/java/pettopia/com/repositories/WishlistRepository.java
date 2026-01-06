package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pettopia.com.entities.Wishlist;
import pettopia.com.entities.Customer;
import pettopia.com.entities.Product;

import java.util.List;
import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Integer> {
    List<Wishlist> findByCustomer(Customer customer);

    Optional<Wishlist> findByCustomerAndProduct(Customer customer, Product product);

    void deleteByCustomerAndProduct(Customer customer, Product product);
}

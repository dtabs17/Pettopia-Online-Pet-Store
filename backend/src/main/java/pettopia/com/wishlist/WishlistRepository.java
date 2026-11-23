package pettopia.com.wishlist;

import pettopia.com.customer.Customer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pettopia.com.product.Product;

import java.util.List;
import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Integer> {
    List<Wishlist> findByCustomer(Customer customer);

    Optional<Wishlist> findByCustomerAndProduct(Customer customer, Product product);

    void deleteByCustomerAndProduct(Customer customer, Product product);
}

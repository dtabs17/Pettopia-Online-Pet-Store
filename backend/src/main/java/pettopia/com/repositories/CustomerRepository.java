package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.entities.Customer;

import java.util.Optional;

public interface CustomerRepository extends JpaRepository<Customer, Integer> {
    Optional<Customer> findByEmail(String email);
}

package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pettopia.com.entities.Order;
import pettopia.com.entities.Customer;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    @Query("SELECT o FROM Order o WHERE o.customer.customerId = :custId")
    List<Order> findOrdersByCustomerId(@Param("custId") Integer custId);
}
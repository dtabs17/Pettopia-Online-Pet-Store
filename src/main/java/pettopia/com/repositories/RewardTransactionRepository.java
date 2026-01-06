package pettopia.com.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.entities.Customer;
import pettopia.com.entities.RewardTransaction;

import java.util.List;

public interface RewardTransactionRepository extends JpaRepository<RewardTransaction, Long> {
    List<RewardTransaction> findByCustomerOrderByCreatedAtDesc(Customer customer);

}

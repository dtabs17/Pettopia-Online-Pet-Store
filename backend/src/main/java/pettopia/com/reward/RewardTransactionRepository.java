package pettopia.com.reward;

import org.springframework.data.jpa.repository.JpaRepository;
import pettopia.com.entities.Customer;
import pettopia.com.reward.RewardTransaction;

import java.util.List;

public interface RewardTransactionRepository extends JpaRepository<RewardTransaction, Long> {
    List<RewardTransaction> findByCustomerOrderByCreatedAtDesc(Customer customer);

}

package pettopia.com.reward;

import org.springframework.stereotype.Service;
import pettopia.com.customer.Customer;
import pettopia.com.customer.CustomerRepository;
import pettopia.com.reward.dto.RewardSummaryDTO;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class RewardService {

    private final CustomerRepository customerRepository;
    private final RewardTransactionRepository rewardTransactionRepository;

    public RewardService(
            CustomerRepository customerRepository,
            RewardTransactionRepository rewardTransactionRepository) {
        this.customerRepository = customerRepository;
        this.rewardTransactionRepository = rewardTransactionRepository;
    }

    public void earnPoints(Integer customerId, int points, String source) {
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        int currentPoints = rewardTransactionRepository.findByCustomerOrderByCreatedAtDesc(customer)
                .stream()
                .mapToInt(RewardTransaction::getPoints)
                .sum();

        int newTotal = currentPoints + points;
        customer.setRewardPoints(newTotal);
        customerRepository.save(customer);

        RewardTransaction transaction = RewardTransaction.builder()
                .customer(customer)
                .points(points)
                .transactionType(RewardTransaction.TransactionType.EARN)
                .source(source)
                .build();

        rewardTransactionRepository.save(transaction);
    }

    public RewardSummaryDTO getRewardHistory(String customerEmail) {
        Customer customer = customerRepository.findByEmail(customerEmail)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<RewardTransaction> transactions =
                rewardTransactionRepository.findByCustomerOrderByCreatedAtDesc(customer);

        int totalPoints = transactions.stream()
                .mapToInt(RewardTransaction::getPoints)
                .sum();

        return new RewardSummaryDTO(totalPoints, transactions);
    }

    public RewardSummaryDTO redeemPoints(String customerEmail, int points, String reason) {
        Customer customer = customerRepository.findByEmail(customerEmail)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        int currentPoints = rewardTransactionRepository.findByCustomerOrderByCreatedAtDesc(customer)
                .stream()
                .mapToInt(RewardTransaction::getPoints)
                .sum();

        if (points > currentPoints) {
            throw new RuntimeException("Not enough points to redeem");
        }

        RewardTransaction transaction = new RewardTransaction();
        transaction.setCustomer(customer);
        transaction.setPoints(-points);
        transaction.setTransactionType(RewardTransaction.TransactionType.REDEEM);
        transaction.setSource("Manual redemption");
        transaction.setReason(reason);
        transaction.setCreatedAt(LocalDateTime.now());

        rewardTransactionRepository.save(transaction);

        return getRewardHistory(customerEmail);
    }
}

package pettopia.com.reward;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import pettopia.com.customer.Customer;
import pettopia.com.customer.CustomerRepository;
import pettopia.com.reward.dto.RewardSummaryDTO;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class RewardServiceTest {

    private CustomerRepository customerRepository;
    private RewardTransactionRepository transactionRepository;
    private RewardService rewardService;
    private Customer customer;

    @BeforeEach
    void setUp() {
        customerRepository = mock(CustomerRepository.class);
        transactionRepository = mock(RewardTransactionRepository.class);

        rewardService = new RewardService(
                customerRepository,
                transactionRepository
        );

        customer = new Customer();
        customer.setCustomerId(1);
        customer.setEmail("test@example.com");
    }

    private RewardTransaction transaction(int points) {
        RewardTransaction transaction = new RewardTransaction();
        transaction.setCustomer(customer);
        transaction.setPoints(points);
        return transaction;
    }

    @Test
    void earnPointsUpdatesBalanceAndRecordsTransaction() {
        when(customerRepository.findById(1))
                .thenReturn(Optional.of(customer));

        when(transactionRepository.findByCustomerOrderByCreatedAtDesc(customer))
                .thenReturn(List.of(transaction(50)));

        rewardService.earnPoints(1, 20, "Order purchase");

        assertEquals(70, customer.getRewardPoints());

        verify(customerRepository).save(customer);

        verify(transactionRepository).save(argThat(saved ->
                saved.getCustomer() == customer
                        && saved.getPoints() == 20
                        && saved.getTransactionType()
                            == RewardTransaction.TransactionType.EARN
                        && "Order purchase".equals(saved.getSource())
        ));
    }

    @Test
    void getRewardHistoryCalculatesTotalPoints() {
        when(customerRepository.findByEmail("test@example.com"))
                .thenReturn(Optional.of(customer));

        List<RewardTransaction> transactions = List.of(
                transaction(100),
                transaction(-30),
                transaction(20)
        );

        when(transactionRepository.findByCustomerOrderByCreatedAtDesc(customer))
                .thenReturn(transactions);

        RewardSummaryDTO summary =
                rewardService.getRewardHistory("test@example.com");

        assertEquals(90, summary.getTotalPoints());
        assertEquals(transactions, summary.getTransactions());
    }

    @Test
    void redeemPointsRecordsNegativeTransaction() {
        when(customerRepository.findByEmail("test@example.com"))
                .thenReturn(Optional.of(customer));

        when(transactionRepository.findByCustomerOrderByCreatedAtDesc(customer))
                .thenReturn(
                        List.of(transaction(100)),
                        List.of(transaction(100), transaction(-30))
                );

        RewardSummaryDTO summary = rewardService.redeemPoints(
                "test@example.com",
                30,
                "Reward redemption"
        );

        verify(transactionRepository).save(argThat(saved ->
                saved.getCustomer() == customer
                        && saved.getPoints() == -30
                        && saved.getTransactionType()
                            == RewardTransaction.TransactionType.REDEEM
                        && "Manual redemption".equals(saved.getSource())
                        && "Reward redemption".equals(saved.getReason())
        ));

        assertEquals(70, summary.getTotalPoints());
    }

    @Test
    void redeemPointsRejectsInsufficientBalance() {
        when(customerRepository.findByEmail("test@example.com"))
                .thenReturn(Optional.of(customer));

        when(transactionRepository.findByCustomerOrderByCreatedAtDesc(customer))
                .thenReturn(List.of(transaction(20)));

        RuntimeException exception = assertThrows(
                RuntimeException.class,
                () -> rewardService.redeemPoints(
                        "test@example.com", 50, "Reward redemption"
                )
        );

        assertEquals("Not enough points to redeem",
                exception.getMessage());

        verify(transactionRepository, never())
                .save(any(RewardTransaction.class));
    }

    @Test
    void earnPointsRejectsUnknownCustomer() {
        when(customerRepository.findById(999))
                .thenReturn(Optional.empty());

        RuntimeException exception = assertThrows(
                RuntimeException.class,
                () -> rewardService.earnPoints(999, 20, "Order purchase")
        );

        assertEquals("Customer not found", exception.getMessage());

        verify(customerRepository, never()).save(any(Customer.class));
        verify(transactionRepository, never())
                .save(any(RewardTransaction.class));
    }
}

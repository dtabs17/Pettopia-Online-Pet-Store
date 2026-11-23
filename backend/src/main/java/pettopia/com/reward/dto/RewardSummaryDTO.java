package pettopia.com.reward.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import pettopia.com.reward.RewardTransaction;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RewardSummaryDTO {
    private int totalPoints;
    private List<RewardTransaction> transactions;
}

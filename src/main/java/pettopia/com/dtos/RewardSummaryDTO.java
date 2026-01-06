package pettopia.com.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import pettopia.com.entities.RewardTransaction;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RewardSummaryDTO {
    private int totalPoints;
    private List<RewardTransaction> transactions;
}

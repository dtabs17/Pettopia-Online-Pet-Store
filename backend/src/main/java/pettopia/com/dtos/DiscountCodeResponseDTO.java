package pettopia.com.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import pettopia.com.entities.DiscountCode;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@AllArgsConstructor
public class DiscountCodeResponseDTO {

    private Integer discountId;
    private String code;
    private String description;
    private DiscountCode.DiscountType discountType;
    private BigDecimal discountValue;
    private LocalDate startDate;
    private LocalDate expiryDate;
    private Integer usageLimit;
    private Integer usedCount;
    private Boolean active;
}

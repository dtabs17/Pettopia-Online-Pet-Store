package pettopia.com.dtos;

import lombok.Data;
import pettopia.com.entities.DiscountCode;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class DiscountCodeRequestDTO {

    private String code;
    private String description;
    private DiscountCode.DiscountType discountType;
    private BigDecimal discountValue;
    private LocalDate startDate;
    private LocalDate expiryDate;
    private Integer usageLimit;
}

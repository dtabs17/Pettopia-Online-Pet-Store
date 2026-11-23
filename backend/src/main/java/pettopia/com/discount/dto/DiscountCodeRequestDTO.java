package pettopia.com.discount.dto;

import pettopia.com.discount.DiscountCode;

import lombok.Data;

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

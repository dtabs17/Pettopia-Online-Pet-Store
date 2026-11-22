package pettopia.com.product.dto;

import java.math.BigDecimal;

public record ProductSearchDTO(
        Integer productId,
        String name,
        String description,
        BigDecimal price,
        String thumbUrl
) {}
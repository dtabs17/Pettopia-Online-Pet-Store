package pettopia.com.dtos;

import java.math.BigDecimal;

public record ProductSearchDTO(
        Integer productId,
        String name,
        String description,
        BigDecimal price,
        String thumbUrl
) {}
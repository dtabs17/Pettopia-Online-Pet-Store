package pettopia.com.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
public class ProductResponseDTO {
    private Integer productId;
    private String name;
    private String description;
    private BigDecimal price;
    private BigDecimal discountPrice;
    private Integer stockQuantity;
    private Boolean isActive;
    private Boolean discontinued;
    private String thumbUrl;
    private List<String> imageGallery;
    private LocalDate dateAdded;
    private Integer categoryId;
    private String categoryName;
}

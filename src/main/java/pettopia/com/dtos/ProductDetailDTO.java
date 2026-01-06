package pettopia.com.dtos;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDetailDTO {

    private Integer productId;
    private String name;
    private String description;
    private BigDecimal price;
    private BigDecimal discountPrice;
    private Integer stockQuantity;
    private LocalDate dateAdded;
    private String thumbUrl;
    private List<String> imageGallery;
    private List<String> categoryHierarchy;
    private List<ReviewDTO> reviews;
    private List<DiscountCodeDTO> activeDiscounts;
}

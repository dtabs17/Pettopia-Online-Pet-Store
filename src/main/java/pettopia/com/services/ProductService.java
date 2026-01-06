package pettopia.com.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import pettopia.com.dtos.DiscountCodeDTO;
import pettopia.com.dtos.ProductDetailDTO;
import pettopia.com.dtos.ReviewDTO;
import pettopia.com.entities.Category;
import pettopia.com.entities.Product;
import pettopia.com.repositories.DiscountCodeRepository;
import pettopia.com.repositories.ProductRepository;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final DiscountCodeRepository discountCodeRepository;

    public ProductService(ProductRepository productRepository, DiscountCodeRepository discountCodeRepository) {
        this.productRepository = productRepository;
        this.discountCodeRepository = discountCodeRepository;
    }

    public List<Product> searchProducts(String category, BigDecimal minPrice, BigDecimal maxPrice, String keyword) {
        String categoryName = (category != null && !category.isEmpty()) ? category : null;
        String key = (keyword != null && !keyword.isEmpty()) ? keyword : null;

        return productRepository.searchProducts(key, minPrice, maxPrice, categoryName);
    }

    public ProductDetailDTO getProductDetail(Integer productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        List<String> images = new ArrayList<>();
        if (product.getImageGallery() != null && !product.getImageGallery().isEmpty()) {
            ObjectMapper mapper = new ObjectMapper();
            try {
                images = Arrays.asList(mapper.readValue(product.getImageGallery(), String[].class));
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }

        List<String> categories = new ArrayList<>();
        Category cat = product.getCategory();
        while (cat != null) {
            categories.add(0, cat.getName());
            cat = null;
        }

        List<ReviewDTO> reviews = product.getReviews().stream()
                .map(r -> new ReviewDTO(
                        r.getCustomer().getFirstName() + " " + r.getCustomer().getLastName(),
                        r.getRating(),
                        r.getComment()
                ))
                .collect(Collectors.toList());

        List<DiscountCodeDTO> discounts = discountCodeRepository.findActiveByProductId(productId).stream()
                .map(d -> new DiscountCodeDTO(d.getCode(), d.getDiscountType().name(), d.getDiscountValue()))
                .collect(Collectors.toList());

        return new ProductDetailDTO(
                product.getProductId(),
                product.getName(),
                product.getDescription(),
                product.getPrice(),
                product.getDiscountPrice(),
                product.getStockQuantity(),
                product.getDateAdded(),
                product.getThumbUrl(),
                images,
                categories,
                reviews,
                discounts
        );
    }

}

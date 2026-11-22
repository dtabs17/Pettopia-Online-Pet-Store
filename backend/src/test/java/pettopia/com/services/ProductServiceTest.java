package pettopia.com.services;

import org.junit.jupiter.api.Test;

import pettopia.com.product.Product;
import pettopia.com.product.ProductRepository;
import pettopia.com.product.ProductService;
import pettopia.com.product.dto.ProductSearchDTO;
import pettopia.com.repositories.DiscountCodeRepository;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

class ProductServiceTest {

    @Test
    void searchProductsReturnsExpectedDTOFields() {
        ProductRepository productRepository = mock(ProductRepository.class);
        DiscountCodeRepository discountRepository = mock(DiscountCodeRepository.class);

        ProductService service = new ProductService(productRepository, discountRepository);

        Product product = mock(Product.class);

        when(product.getProductId()).thenReturn(1);
        when(product.getName()).thenReturn("Dog Food");
        when(product.getDescription()).thenReturn("Premium dog food");
        when(product.getPrice()).thenReturn(new BigDecimal("49.99"));
        when(product.getThumbUrl()).thenReturn("/images/dog.jpg");

        when(productRepository.searchProducts(null, null, null, null))
                .thenReturn(List.of(product));

        List<ProductSearchDTO> results =
                service.searchProducts(null, null, null, null);

        assertEquals(1, results.size());

        ProductSearchDTO dto = results.get(0);

        assertEquals(1, dto.productId());
        assertEquals("Dog Food", dto.name());
        assertEquals("Premium dog food", dto.description());
        assertEquals(new BigDecimal("49.99"), dto.price());
        assertEquals("/images/dog.jpg", dto.thumbUrl());
    }

    @Test
void productSearchDTOExposesOnlyPublicFields() throws Exception {
    ProductSearchDTO dto = new ProductSearchDTO(
            1,
            "Dog Food",
            "Premium dog food",
            new BigDecimal("49.99"),
            "/images/dog.jpg"
    );

    ObjectMapper mapper = new ObjectMapper();
    JsonNode json = mapper.readTree(mapper.writeValueAsString(dto));

    Set<String> actualFields = StreamSupport
            .stream(
                    ((Iterable<String>) () -> json.fieldNames()).spliterator(),
                    false
            )
            .collect(Collectors.toSet());

    assertEquals(Set.of(
            "productId",
            "name",
            "description",
            "price",
            "thumbUrl"
    ), actualFields);
}
}
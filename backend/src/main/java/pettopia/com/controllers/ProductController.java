package pettopia.com.controllers;

import org.springframework.web.bind.annotation.*;
import pettopia.com.dtos.ProductDetailDTO;
import pettopia.com.entities.Product;
import pettopia.com.services.ProductService;
import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/search")
    public List<Product> searchProducts (@RequestParam(required = false) String category,
                                         @RequestParam(required = false) BigDecimal minPrice,
                                         @RequestParam(required = false) BigDecimal maxPrice,
                                         @RequestParam(required = false) String keyword)
    {
        return productService.searchProducts(category, minPrice, maxPrice, keyword);
    }

    @GetMapping("/{id}")
    public ProductDetailDTO getProductDetail(@PathVariable Integer id) {
        return productService.getProductDetail(id);
    }

}

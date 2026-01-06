package pettopia.com.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import pettopia.com.dtos.ProductRequestDTO;
import pettopia.com.dtos.ProductResponseDTO;
import pettopia.com.entities.Product;
import pettopia.com.services.AdminProductService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/admin/products")
public class AdminProductController {

    private final AdminProductService adminProductService;

    public AdminProductController(AdminProductService adminProductService) {
        this.adminProductService = adminProductService;
    }

    @GetMapping
    public List<ProductResponseDTO> getAllProducts() {
        return adminProductService.getAllProducts();
    }

    @PostMapping
    public ResponseEntity<ProductResponseDTO> createProduct(
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam BigDecimal price,
            @RequestParam(required = false) BigDecimal discountPrice,
            @RequestParam Integer stockQuantity,
            @RequestParam Integer categoryId,
            @RequestPart(value = "thumbFile", required = false) MultipartFile thumb,
            @RequestPart(value = "galleryFiles", required = false) MultipartFile[] images
    ) throws IOException {

        ProductRequestDTO dto = new ProductRequestDTO();
        dto.setName(name);
        dto.setDescription(description);
        dto.setPrice(price);
        dto.setDiscountPrice(discountPrice);
        dto.setStockQuantity(stockQuantity);
        dto.setCategoryId(categoryId);

        return ResponseEntity.ok(adminProductService.createProduct(dto, thumb, images));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductResponseDTO> updateProduct(
            @PathVariable Integer id,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam BigDecimal price,
            @RequestParam(required = false) BigDecimal discountPrice,
            @RequestParam Integer stockQuantity,
            @RequestParam Integer categoryId,
            @RequestPart(value = "thumbFile", required = false) MultipartFile thumb,
            @RequestPart(value = "galleryFiles", required = false) MultipartFile[] images
    ) throws IOException {

        ProductRequestDTO dto = new ProductRequestDTO();
        dto.setName(name);
        dto.setDescription(description);
        dto.setPrice(price);
        dto.setDiscountPrice(discountPrice);
        dto.setStockQuantity(stockQuantity);
        dto.setCategoryId(categoryId);

        return ResponseEntity.ok(adminProductService.updateProduct(id, dto, thumb, images));
    }

    @PatchMapping("/{id}/archive")
    public ResponseEntity<String> archiveProduct(@PathVariable Integer id) {
        return ResponseEntity.ok(adminProductService.archiveProduct(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable Integer id) {
        adminProductService.deleteProduct(id);
        return ResponseEntity.ok("Product deleted successfully");
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductResponseDTO> getProduct(@PathVariable Integer id) {
        ProductResponseDTO product = adminProductService.getProductById(id);
        return ResponseEntity.ok(product);
    }

}

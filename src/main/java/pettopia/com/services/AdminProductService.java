package pettopia.com.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pettopia.com.dtos.ProductRequestDTO;
import pettopia.com.dtos.ProductResponseDTO;
import pettopia.com.entities.Category;
import pettopia.com.entities.Product;
import pettopia.com.repositories.CategoryRepository;
import pettopia.com.repositories.ProductRepository;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
public class AdminProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ImageStorageService imageStorageService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    public AdminProductService(ProductRepository productRepository,
                               CategoryRepository categoryRepository,
                               ImageStorageService imageStorageService) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.imageStorageService = imageStorageService;
    }

    public List<ProductResponseDTO> getAllProducts() {
        List<Product> products = productRepository.findAll();
        List<ProductResponseDTO> response = new ArrayList<>();

        for (Product p : products) {
            List<String> images = new ArrayList<>();
            if (p.getImageGallery() != null && !p.getImageGallery().isEmpty()) {
                try {
                    images = Arrays.asList(objectMapper.readValue(p.getImageGallery(), String[].class));
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }
            }

            response.add(new ProductResponseDTO(
                    p.getProductId(),
                    p.getName(),
                    p.getDescription(),
                    p.getPrice(),
                    p.getDiscountPrice(),
                    p.getStockQuantity(),
                    p.getIsActive(),
                    p.getDiscontinued(),
                    p.getThumbUrl(),
                    images,
                    p.getDateAdded(),
                    p.getCategory() != null ? p.getCategory().getCategoryId() : null,
                    p.getCategory() != null ? p.getCategory().getName() : null
            ));
        }

        return response;
    }

    public ProductResponseDTO createProduct(ProductRequestDTO dto,
                                            MultipartFile thumb,
                                            MultipartFile[] images) throws IOException {
        Product product = new Product();
        product.setName(dto.getName());
        product.setDescription(dto.getDescription());
        product.setPrice(dto.getPrice());
        product.setDiscountPrice(dto.getDiscountPrice());
        product.setStockQuantity(dto.getStockQuantity());
        product.setIsActive(true);
        product.setDiscontinued(false);
        product.setArchived(false);
        product.setDateAdded(LocalDate.now());

        Optional<Category> catOpt = categoryRepository.findById(dto.getCategoryId());
        if (catOpt.isEmpty()) throw new RuntimeException("Category not found");
        product.setCategory(catOpt.get());

        if (thumb != null && !thumb.isEmpty()) {
            product.setThumbUrl(imageStorageService.saveFile(thumb));
        }

        if (images != null && images.length > 0) {
            String[] galleryPaths = imageStorageService.saveFiles(images).toArray(new String[0]);
            product.setImageGallery(objectMapper.writeValueAsString(galleryPaths));
        }

        productRepository.save(product);

        return getAllProducts().stream()
                .filter(p -> p.getProductId().equals(product.getProductId()))
                .findFirst()
                .orElseThrow();
    }

    public ProductResponseDTO updateProduct(Integer id,
                                            ProductRequestDTO dto,
                                            MultipartFile thumb,
                                            MultipartFile[] images) throws IOException {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        product.setName(dto.getName());
        product.setDescription(dto.getDescription());
        product.setPrice(dto.getPrice());
        product.setDiscountPrice(dto.getDiscountPrice());
        product.setStockQuantity(dto.getStockQuantity());

        Optional<Category> catOpt = categoryRepository.findById(dto.getCategoryId());
        if (catOpt.isEmpty()) throw new RuntimeException("Category not found");
        product.setCategory(catOpt.get());

        if (thumb != null && !thumb.isEmpty()) {
            product.setThumbUrl(imageStorageService.saveFile(thumb));
        }

        List<String> galleryPaths = new ArrayList<>();
        if (product.getImageGallery() != null && !product.getImageGallery().isEmpty()) {
            galleryPaths = new ArrayList<>(Arrays.asList(objectMapper.readValue(product.getImageGallery(), String[].class)));
        }
        if (images != null && images.length > 0) {
            List<String> newGallery = imageStorageService.saveFiles(images);
            galleryPaths.addAll(newGallery);
        }
        if (!galleryPaths.isEmpty()) {
            product.setImageGallery(objectMapper.writeValueAsString(galleryPaths));
        }

        productRepository.save(product);

        return getAllProducts().stream()
                .filter(p -> p.getProductId().equals(product.getProductId()))
                .findFirst()
                .orElseThrow();
    }

    public String archiveProduct(Integer id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        boolean nowArchived = !product.getArchived();
        product.setArchived(nowArchived);
        product.setIsActive(!nowArchived);
        product.setDiscontinued(nowArchived);
        if (nowArchived) {
            product.setDiscountPrice(null);
        }

        productRepository.save(product);

        return nowArchived ? "Product archived" : "Product restored";
    }

    public String deleteProduct(Integer id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (product.getOrderItems() != null && !product.getOrderItems().isEmpty()) {
            product.setArchived(true);
            product.setIsActive(false);
            productRepository.save(product);
            return "Product linked to orders. Archived instead of deleted.";
        } else {
            productRepository.delete(product);
            return "Product deleted successfully.";
        }
    }

    public ProductResponseDTO getProductById(Integer id) {
        Product p = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        List<String> images = new ArrayList<>();
        if (p.getImageGallery() != null && !p.getImageGallery().isEmpty()) {
            try {
                images = Arrays.asList(objectMapper.readValue(p.getImageGallery(), String[].class));
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }

        return new ProductResponseDTO(
                p.getProductId(),
                p.getName(),
                p.getDescription(),
                p.getPrice(),
                p.getDiscountPrice(),
                p.getStockQuantity(),
                p.getIsActive(),
                p.getDiscontinued(),
                p.getThumbUrl(),
                images,
                p.getDateAdded(),
                p.getCategory() != null ? p.getCategory().getCategoryId() : null,
                p.getCategory() != null ? p.getCategory().getName() : null
        );

    }

}

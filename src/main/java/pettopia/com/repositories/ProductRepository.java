package pettopia.com.repositories;

import pettopia.com.entities.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    @Query("""
        SELECT p 
        FROM Product p 
        WHERE (:keyword IS NULL OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%')))
          AND (:minPrice IS NULL OR p.price >= :minPrice)
          AND (:maxPrice IS NULL OR p.price <= :maxPrice)
          AND (:categoryName IS NULL OR p.category.name = :categoryName)
        """)
    List<Product> searchProducts(@Param("keyword") String keyword,
            @Param("minPrice") BigDecimal minPrice,
            @Param("maxPrice") BigDecimal maxPrice,
            @Param("categoryName") String categoryName);

    List<Product> findByIsActiveTrue();

}

package pettopia.com.repositories;
import pettopia.com.entities.DiscountCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface DiscountCodeRepository extends JpaRepository<DiscountCode, Integer> {

    @Query("""
    SELECT DISTINCT d 
    FROM DiscountCode d
    JOIN d.orders o 
    JOIN o.orderItems oi
    WHERE oi.product.productId = :productId 
      AND d.active = true
""")
    List<DiscountCode> findActiveByProductId(@Param("productId") Integer productId);

}

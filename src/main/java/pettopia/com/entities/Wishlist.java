package pettopia.com.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name = "wishlists", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"customer_id", "product_id"})
})
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Wishlist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer wishlistId;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @ToString.Exclude
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    @ToString.Exclude
    private Product product;

    private LocalDateTime createdAt = LocalDateTime.now();

    public Integer getWishlistId() { return wishlistId; }
    public Customer getCustomer() { return customer; }
    public Product getProduct() { return product; }
    public LocalDateTime getCreatedAt() { return createdAt; }

    public void setWishlistId(Integer wishlistId) { this.wishlistId = wishlistId; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    public void setProduct(Product product) { this.product = product; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

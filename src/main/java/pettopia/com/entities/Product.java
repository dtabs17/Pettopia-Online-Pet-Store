package pettopia.com.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "products")
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productId;

    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    private BigDecimal price;

    private LocalDate dateAdded;

    private Integer stockQuantity;

    private BigDecimal discountPrice;

    /**
     * Legacy flag used in some parts of the app. Keep it for backward compatibility.
     * New archive logic should primarily use {@link #archived}.
     */
    private Boolean isActive;

    private Boolean discontinued;

    /**
     * New: soft-archive flag. When true, product should be hidden from customer catalog
     * and prevented from being added to cart / checked out.
     */
    @Column(nullable = false)
    private Boolean archived = false;

    @Lob
    private String imageGallery;

    private String thumbUrl;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JsonManagedReference("product-reviews")
    @ToString.Exclude
    private List<Review> reviews;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonManagedReference("product-items")
    @ToString.Exclude
    private List<OrderItem> orderItems;

    @ManyToOne
    @JoinColumn(name = "categogy_id", nullable = false)
    @JsonBackReference //Prevents circular reference when serializing Category → Product
    @ToString.Exclude
    private Category category;

    /* -------------------- setters -------------------- */

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public void setDateAdded(LocalDate dateAdded) {
        this.dateAdded = dateAdded;
    }

    public void setStockQuantity(Integer stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public void setDiscontinued(Boolean discontinued) {
        this.discontinued = discontinued;
    }

    public void setArchived(Boolean archived) {
        this.archived = archived;
    }

    public void setImageGallery(String imageGallery) {
        this.imageGallery = imageGallery;
    }

    public void setThumbUrl(String thumbUrl) {
        this.thumbUrl = thumbUrl;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    /* -------------------- getters -------------------- */

    public Integer getProductId() {
        return this.productId;
    }

    public String getName() {
        return this.name;
    }

    public String getDescription() {
        return this.description;
    }

    public BigDecimal getPrice() {
        return this.price;
    }

    public Category getCategory() {
        return this.category;
    }

    public LocalDate getDateAdded() {
        return this.dateAdded;
    }

    public Integer getStockQuantity() {
        return this.stockQuantity;
    }

    public BigDecimal getDiscountPrice() {
        return this.discountPrice;
    }

    public Boolean getIsActive() {
        return this.isActive;
    }

    public Boolean getDiscontinued() {
        return this.discontinued;
    }

    public Boolean getArchived() {
        return this.archived;
    }

    public String getImageGallery() {
        return this.imageGallery;
    }

    public String getThumbUrl() {
        return this.thumbUrl;
    }

    public List<Review> getReviews() {
        return this.reviews;
    }

    public List<OrderItem> getOrderItems() {
        return this.orderItems;
    }
}

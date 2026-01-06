package pettopia.com.entities;


import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "discount_codes")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class DiscountCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer discountId;

    @Column(nullable = false, unique = true)
    private String code;

    private String description;

    /**
     * Specifies the type of discount applied.
     * <p>
     * This field is an enum with two possible values:
     * <ul>
     *   <li><b>percentage</b> – a percentage-based discount (e.g., 10% off)</li>
     *   <li><b>fixed</b> – a fixed monetary discount (e.g., €5 off)</li>
     * </ul>
     *
     * The default value is set to {@code DiscountType.percentage} to ensure
     * that newly created DiscountCode objects default to a percentage discount
     * if no type is explicitly assigned. This aligns with the database column
     * definition, which also defaults to 'percentage'.
     */
    @Enumerated(EnumType.STRING)
    @ToString.Exclude
    private DiscountType discountType = DiscountType.percentage;

    private BigDecimal discountValue;
    private LocalDate startDate;
    private LocalDate expiryDate;
    private Integer usageLimit;
    private Integer usedCount;
    private Boolean active;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "discountCode")
    @JsonIgnore
    @ToString.Exclude
    private List<Order> orders;

    public enum DiscountType { percentage, fixed }

    public Integer getDiscountId() {
        return this.discountId;
    }

    public String getCode() {
        return this.code;
    }

    public String getDescription() {
        return this.description;
    }

    public DiscountType getDiscountType() {
        return this.discountType;
    }

    public BigDecimal getDiscountValue() {
        return this.discountValue;
    }

    public LocalDate getStartDate() {
        return this.startDate;
    }

    public LocalDate getExpiryDate() {
        return this.expiryDate;
    }

    public Integer getUsageLimit() {
        return this.usageLimit;
    }

    public Integer getUsedCount() {
        return this.usedCount;
    }

    public Boolean getActive() {
        return this.active;
    }

    public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return this.updatedAt;
    }

    public List<Order> getOrders() {
        return this.orders;
    }

    public void setDiscountId(Integer discountId) {
        this.discountId = discountId;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDiscountType(DiscountType discountType) {
        this.discountType = discountType;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public void setUsageLimit(Integer usageLimit) {
        this.usageLimit = usageLimit;
    }

    public void setUsedCount(Integer usedCount) {
        this.usedCount = usedCount;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }


}

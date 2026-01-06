package pettopia.com.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "reviews")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer reviewId;

    @ManyToOne
    @JoinColumn(name = "product_id")
    @JsonBackReference("product-reviews")
    private Product product;


    @ManyToOne
    @JoinColumn(name = "customer_id")
    @JsonBackReference("customer-reviews")
    private Customer customer;



    private Integer rating;

    @Lob
    private String comment;

    private LocalDate reviewDate;
    private Boolean isFlagged;
    private String ipAddress;
    private String flagReason;

    public void setReviewId(Integer reviewId) {
        this.reviewId = reviewId;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setReviewDate(LocalDate reviewDate) {
        this.reviewDate = reviewDate;
    }

    public void setIsFlagged(Boolean isFlagged) {
        this.isFlagged = isFlagged;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public void setFlagReason(String flagReason) {
        this.flagReason = flagReason;
    }

    public String toString() {
        return "Review(reviewId=" + this.getReviewId() + ", product=" + this.getProduct() + ", customer=" + this.getCustomer() + ", rating=" + this.getRating() + ", comment=" + this.getComment() + ", reviewDate=" + this.getReviewDate() + ", isFlagged=" + this.getIsFlagged() + ", ipAddress=" + this.getIpAddress() + ", flagReason=" + this.getFlagReason() + ")";
    }

    public Integer getReviewId() {
        return this.reviewId;
    }

    public Product getProduct() {
        return this.product;
    }

    public Customer getCustomer() {
        return this.customer;
    }

    public Integer getRating() {
        return this.rating;
    }

    public String getComment() {
        return this.comment;
    }

    public LocalDate getReviewDate() {
        return this.reviewDate;
    }

    public Boolean getIsFlagged() {
        return this.isFlagged;
    }

    public String getIpAddress() {
        return this.ipAddress;
    }

    public String getFlagReason() {
        return this.flagReason;
    }
}

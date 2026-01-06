    package pettopia.com.entities;

    import com.fasterxml.jackson.annotation.JsonBackReference;
    import com.fasterxml.jackson.annotation.JsonManagedReference;
    import jakarta.persistence.*;
    import lombok.AllArgsConstructor;
    import lombok.Builder;
    import lombok.NoArgsConstructor;
    import lombok.ToString;

    import java.math.BigDecimal;
    import java.time.LocalDateTime;
    import java.util.List;

    @Entity
    @Table(name = "orders")
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    @ToString
    public class Order {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Integer orderId;

        private LocalDateTime orderDate;
        private BigDecimal total;


        private String paymentMethod;

        @ManyToOne
        @JoinColumn(name = "customer_id")
        @JsonBackReference("customer-orders")
        @ToString.Exclude
        private Customer customer;

        @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
        @JsonManagedReference("order-items")
        @ToString.Exclude
        private List<OrderItem> orderItems;

        @ManyToOne
        @JoinColumn(name = "order_status_id")
        @ToString.Exclude
        private OrderStatus orderStatus;

        @ManyToOne
        @JoinColumn(name = "discount_id")
        @ToString.Exclude
        private DiscountCode discountCode;



        public Integer getOrderId() {
            return this.orderId;
        }

        public Customer getCustomer() {
            return this.customer;
        }

        public LocalDateTime getOrderDate() {
            return this.orderDate;
        }

        public BigDecimal getTotal() {
            return this.total;
        }

        public OrderStatus getOrderStatus() {
            return this.orderStatus;
        }

        public String getPaymentMethod() {
            return this.paymentMethod;
        }

        public DiscountCode getDiscountCode() {
            return this.discountCode;
        }

        public List<OrderItem> getOrderItems() {
            return this.orderItems;
        }

        public void setOrderId(Integer orderId) {
            this.orderId = orderId;
        }

        public void setCustomer(Customer customer) {
            this.customer = customer;
        }

        public void setOrderDate(LocalDateTime orderDate) {
            this.orderDate = orderDate;
        }

        public void setTotal(BigDecimal total) {
            this.total = total;
        }

        public void setOrderStatus(OrderStatus orderStatus) {
            this.orderStatus = orderStatus;
        }

        public void setPaymentMethod(String paymentMethod) {
            this.paymentMethod = paymentMethod;
        }

        public void setDiscountCode(DiscountCode discountCode) {
            this.discountCode = discountCode;
        }

        public void setOrderItems(List<OrderItem> orderItems) {
            this.orderItems = orderItems;
        }
    }

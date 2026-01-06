package pettopia.com.entities;


import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "order_status")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class OrderStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer orderStatusId;

    @Column(nullable = false)
    private String status;

    @OneToMany(mappedBy = "orderStatus")
    @JsonIgnore
    @ToString.Exclude
    private List<Order> orders;


    public void setOrderStatusId(Integer orderStatusId) {
        this.orderStatusId = orderStatusId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public Integer getOrderStatusId() {
        return this.orderStatusId;
    }

    public String getStatus() {
        return this.status;
    }

    public List<Order> getOrders() {
        return this.orders;
    }
}

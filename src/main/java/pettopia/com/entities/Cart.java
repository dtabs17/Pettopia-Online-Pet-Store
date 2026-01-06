package pettopia.com.entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "carts")
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cartId;

    @OneToOne
    @JoinColumn(name = "customer_id")
    @ToString.Exclude
    private Customer customer;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    @JsonManagedReference
    private List<CartItem> cartItems;

    public Integer getCartId() {
        return cartId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }
}


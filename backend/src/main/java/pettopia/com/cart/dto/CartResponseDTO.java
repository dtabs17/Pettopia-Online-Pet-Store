package pettopia.com.cart.dto;

import pettopia.com.cart.Cart;


import java.util.List;

public class CartResponseDTO {
    private Cart cart;
    private List<String> removedItems;

    public CartResponseDTO() {}

    public CartResponseDTO(Cart cart, List<String> removedItems) {
        this.cart = cart;
        this.removedItems = removedItems;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public List<String> getRemovedItems() {
        return removedItems;
    }

    public void setRemovedItems(List<String> removedItems) {
        this.removedItems = removedItems;
    }
}

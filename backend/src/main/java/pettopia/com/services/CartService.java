package pettopia.com.services;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pettopia.com.dtos.CartResponseDTO;
import pettopia.com.entities.*;
import pettopia.com.repositories.*;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;

    private Customer getCustomerFromEmail(String email) {
        Optional<Customer> optionalCustomer = customerRepository.findByEmail(email);

        if (optionalCustomer.isPresent()) {
            return optionalCustomer.get();
        } else {
            throw new RuntimeException("Customer not found: " + email);
        }
    }

    private Cart getOrCreateCart(Customer customer) {
        Optional<Cart> optionalCart = cartRepository.findByCustomer(customer);

        if (optionalCart.isPresent()) {
            return optionalCart.get();
        } else {
            Cart newCart = new Cart();
            newCart.setCustomer(customer);
            newCart.setCartItems(new ArrayList<>());
            return cartRepository.save(newCart);
        }
    }

    public CartResponseDTO getCart(String email) {
        Customer customer = getCustomerFromEmail(email);
        Cart cart = getOrCreateCart(customer);

        List<String> removed = new ArrayList<>();


        Iterator<CartItem> it = cart.getCartItems().iterator();
        while (it.hasNext()) {
            CartItem item = it.next();
            Product prod = item.getProduct();
            if (prod == null) continue;
            Boolean archived = prod.getArchived();
            if (archived != null && archived) {
                removed.add(prod.getName());
                // remove from cart collection and DB
                it.remove();
                cartItemRepository.delete(item);
            }
        }

        cartRepository.save(cart);

        return new CartResponseDTO(cart, removed);
    }

    public Cart addToCart(String email, Integer productId, Integer quantity) {
        Customer customer = getCustomerFromEmail(email);
        Cart cart = getOrCreateCart(customer);

        Optional<Product> optionalProduct = productRepository.findById(productId);
        if (!optionalProduct.isPresent()) {
            throw new RuntimeException("Product not found");
        }
        Product product = optionalProduct.get();
        if (product.getArchived() != null && product.getArchived()) {
            throw new RuntimeException("Cannot add product: product is no longer available.");
        }

        if (product.getStockQuantity() < quantity) {
            throw new RuntimeException("Only " + product.getStockQuantity() + " left in stock.");
        }

        Optional<CartItem> optionalItem = cartItemRepository.findByCartAndProduct(cart, product);
        CartItem existingItem = null;

        if (optionalItem.isPresent()) {
            existingItem = optionalItem.get();
        }

        if (existingItem != null) {

            int newQuantity = existingItem.getQuantity() + quantity;

            if (newQuantity > product.getStockQuantity()) {
                throw new RuntimeException("Cannot add more than " + product.getStockQuantity());
            }

            existingItem.setQuantity(newQuantity);
            existingItem.setPrice(product.getPrice());
            cartItemRepository.save(existingItem);

        } else {

            CartItem newItem = new CartItem();
            newItem.setCart(cart);
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            newItem.setPrice(product.getPrice());

            cartItemRepository.save(newItem);
            cart.getCartItems().add(newItem);
        }

        return cartRepository.save(cart);
    }


    public Cart updateItem(String email, Integer productId, Integer quantity) {
        Customer customer = getCustomerFromEmail(email);
        Cart cart = getOrCreateCart(customer);

        Optional<Product> optionalProduct = productRepository.findById(productId);
        if (!optionalProduct.isPresent()) {
            throw new RuntimeException("Product not found");
        }
        Product product = optionalProduct.get();

        if (product.getArchived() != null && product.getArchived()) {
            throw new RuntimeException("Cannot update item: product is no longer available.");
        }

        Optional<CartItem> optionalItem = cartItemRepository.findByCartAndProduct(cart, product);
        if (!optionalItem.isPresent()) {
            throw new RuntimeException("Item not in cart");
        }
        CartItem item = optionalItem.get();

        if (quantity > product.getStockQuantity()) {
            throw new RuntimeException("Only " + product.getStockQuantity() + " left in stock.");
        }

        item.setQuantity(quantity);
        cartItemRepository.save(item);

        return cart;
    }


    public Cart removeItem(String email, Integer productId) {
        Customer customer = getCustomerFromEmail(email);
        Cart cart = getOrCreateCart(customer);

        Optional<Product> optionalProduct = productRepository.findById(productId);
        if (!optionalProduct.isPresent()) {
            throw new RuntimeException("Not found");
        }
        Product product = optionalProduct.get();

        Optional<CartItem> optionalItem = cartItemRepository.findByCartAndProduct(cart, product);
        if (!optionalItem.isPresent()) {
            throw new RuntimeException("Item not in cart");
        }
        CartItem item = optionalItem.get();

        cart.getCartItems().remove(item);
        cartItemRepository.delete(item);

        return cartRepository.save(cart);
    }

    public void clearCart(String email) {
        Customer customer = getCustomerFromEmail(email);
        Cart cart = getOrCreateCart(customer);

        cart.getCartItems().clear();

        cartRepository.save(cart);
    }
}

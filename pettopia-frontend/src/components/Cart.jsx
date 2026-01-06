import React, { useEffect, useState } from "react";
import { getCart, updateCartItem, removeCartItem, clearCart, finalizeCart } from "../services/cart";
import { getRewards } from "../services/rewards";

function Cart({ user }) {
    const [cart, setCart] = useState(null);
    const [loading, setLoading] = useState(true);
    const [availablePoints, setAvailablePoints] = useState(0);
    const [pointsToUse, setPointsToUse] = useState("");
    useEffect(() => {
        if (!user || !user.token) return;

        setLoading(true);

        Promise.all([
            getCart(user.token),
            getRewards()
        ])
            .then(([cartResponse, rewards]) => {
                setCart(cartResponse.data);
                setAvailablePoints(rewards.totalPoints || 0);
                setLoading(false);
            })
            .catch(function (error) {
                console.error("Error fetching cart or rewards:", error);
                setLoading(false);
            });
    }, [user]);


    if (!user) {
        return <div>Please log in to see your cart.</div>;
    }

    if (loading) {
        return <div>Loading cart...</div>;
    }

    if (!cart || !cart.cartItems || cart.cartItems.length === 0) {
        return <div>Your cart is empty.</div>;
    }

    function handleUpdateQuantity(productId, quantity, maxStock) {
        if (quantity > maxStock) {
            alert("Cannot exceed available stock: " + maxStock);
            return;
        }

        updateCartItem(productId, quantity, user.token)
            .then(function (response) {
                setCart(response.data);
            })
            .catch(function (error) {
                console.error("Error updating item:", error);
            });
    }

    function handleRemoveItem(productId) {
        removeCartItem(productId, user.token)
            .then(function (response) {
                setCart(response.data);
            })
            .catch(function (error) {
                console.error("Error removing item:", error);
            });
    }

    function handleClearCart() {
        clearCart(user.token)
            .then(function () {
                setCart({ cartItems: [] });
            })
            .catch(function (error) {
                console.error("Error clearing cart:", error);
            });
    }
    function handleFinalizeCart() {
        if (!cart || !cart.cartItems || cart.cartItems.length === 0) {
            alert("Your cart is empty.");
            return;
        }

        const parsedPoints = parseInt(pointsToUse, 10);
        const requestedPoints = Number.isNaN(parsedPoints) ? 0 : parsedPoints;

        if (requestedPoints < 0) {
            alert("Points must be 0 or more.");
            return;
        }

        const currentCartTotal = cart.cartItems.reduce((sum, item) => {
            return sum + item.price * item.quantity;
        }, 0);

        const maxByTotal = Math.floor(currentCartTotal);
        const usablePoints = Math.max(
            0,
            Math.min(requestedPoints, availablePoints, maxByTotal)
        );

        if (usablePoints > availablePoints) {
            alert("You can't use more points than you have.");
            return;
        }

        finalizeCart(usablePoints)
            .then(order => {
                const totalValue = order.total;
                const finalTotal =
                    typeof totalValue === "number"
                        ? totalValue.toFixed(2)
                        : totalValue;

                alert(
                    `Order finalized!\n` +
                    `Order ID: ${order.orderId}\n` +
                    `Final total: €${finalTotal}\n` +
                    `Points used: ${usablePoints}`
                );

                setCart({ cartItems: [] });
                setAvailablePoints(prev => prev - usablePoints);
                setPointsToUse("");
            })
            .catch(err => {
                console.error(err);
                alert(err.response?.data?.message || "Failed to finalize order.");
            });
    }

    let cartTotal = 0;
    if (cart && cart.cartItems && cart.cartItems.length > 0) {
        cartTotal = cart.cartItems.reduce((sum, item) => {
            return sum + item.price * item.quantity;
        }, 0);
    }

    const parsedPoints = parseInt(pointsToUse, 10);
    const requestedPoints = Number.isNaN(parsedPoints) ? 0 : parsedPoints;

    const maxByTotal = Math.floor(cartTotal);
    const usablePointsForPreview = Math.max(
        0,
        Math.min(requestedPoints, availablePoints, maxByTotal)
    );

    const finalTotalForPreview = Math.max(0, cartTotal - usablePointsForPreview);

    const pointsEarnedPreview = Math.floor(cartTotal / 50);



    return (
        <div className="container bg-dark text-light p-4 min-vh-100">
            <h2>Your Cart</h2>

            <table className="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    {cart.cartItems.map(item => (
                        <tr key={item.cartItemId}>
                            <td>{item.product.name}</td>
                            <td>€{item.price.toFixed(2)}</td>

                            <td>
                                <input
                                    type="number"
                                    min="1"
                                    max={item.product.stockQuantity}
                                    value={item.quantity}
                                    onChange={e => {
                                        const value = parseInt(e.target.value, 10);
                                        handleUpdateQuantity(item.product.productId, value, item.product.stockQuantity);
                                    }}
                                />
                            </td>

                            <td>€{(item.price * item.quantity).toFixed(2)}</td>

                            <td>
                                <button
                                    className="btn btn-danger"
                                    onClick={() => handleRemoveItem(item.product.productId)}
                                >
                                    Remove
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <div className="mt-3">
                <div className="mb-3">
                    <p>
                        <strong>Your available points:</strong> {availablePoints}{" "}
                        <span className="text-muted">(1 point = €1)</span>
                    </p>
                    <div className="d-flex gap-2 align-items-center">
                        <input
                            type="number"
                            min="0"
                            max={availablePoints}
                            className="form-control"
                            style={{ maxWidth: "200px" }}
                            placeholder="Points to use"
                            value={pointsToUse}
                            onChange={e => setPointsToUse(e.target.value)}
                        />
                    </div>
                </div>

                <div className="mt-3">
                    <p><strong>Cart subtotal:</strong> €{cartTotal.toFixed(2)}</p>
                    <p>
                        <strong>Points discount:</strong>
                        {" "}using {usablePointsForPreview} pts → -€{usablePointsForPreview.toFixed(2)}
                    </p>
                    <p>
                        <strong>Final total:</strong> €{finalTotalForPreview.toFixed(2)}
                    </p>
                    <p className="text-muted">
                        You’ll earn <strong>{pointsEarnedPreview}</strong> points from this order.
                    </p>
                </div>

                <button className="btn btn-warning me-2" onClick={handleClearCart}>
                    Clear Cart
                </button>
                <button className="btn btn-success" onClick={handleFinalizeCart}>
                    Finalize Order
                </button>
            </div>

        </div>
    );
}

export default Cart;

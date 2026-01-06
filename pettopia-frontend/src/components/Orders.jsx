import { useEffect, useState } from "react";
import { getMyOrders } from "../services/cart";

function Orders({ user }) {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const token = user?.token || localStorage.getItem("token");

        if (!token) {
            setError("You must be logged in to view orders.");
            setLoading(false);
            return;
        }

        getMyOrders(token)
            .then(data => {
                setOrders(data || []);
                setLoading(false);
            })
            .catch(err => {
                console.error(err);
                setError("Failed to fetch orders. Please try again.");
                setLoading(false);
            });
    }, [user]);

    if (loading) return <div>Loading orders...</div>;
    if (error) return <div>{error}</div>;
    if (!orders.length) return <div>No orders found.</div>;

    return (
        <div className="container bg-dark text-light p-4 min-vh-100">
            <h2>My Orders</h2>
            {orders.map(order => (
                <div key={order.orderId} className="border p-3 mb-3">
                    <p>Order ID: {order.orderId}</p>
                    <p>Date: {order.orderDate}</p>
                    <p>Total: €{order.total ?? "0.00"}</p>
                    <p>Payment: {order.paymentMethod}</p>
                    <h5>Items:</h5>
                    {order.orderItems && order.orderItems.length > 0 ? (
                        <ul>
                            {order.orderItems.map(item => (
                                <li key={item.orderItemId}>
                                    {item.product?.name ?? "Unknown Product"} - {item.quantity} x €{item.price ?? "0.00"}
                                </li>
                            ))}
                        </ul>
                    ) : (
                        <p>No items in this order.</p>
                    )}
                </div>
            ))}
        </div>
    );
}

export default Orders;

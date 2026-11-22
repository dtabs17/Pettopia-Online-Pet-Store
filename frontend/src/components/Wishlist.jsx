import { useEffect, useState } from "react";
import { getWishlist, removeFromWishlist } from "../services/wishlist";
import { Link } from "react-router-dom";

function Wishlist() {
    const [items, setItems] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        setLoading(true);
        getWishlist()
            .then(data => {
                setItems(data || []);
                setLoading(false);
            })
            .catch(e => {
                console.error(e);
                setError("Failed to load wishlist.");
                setLoading(false);
            });
    }, []);

    const handleRemove = async (productId) => {
        try {
            await removeFromWishlist(productId);
            alert("Product Removed from Wishlist!");
            setItems(prev => prev.filter(p => p.productId !== productId));
        } catch (e) {
            console.error(e);
            alert("Failed to remove from wishlist.");
        }
    };

    if (loading) return <div>Loading wishlist...</div>;
    if (error) return <div>{error}</div>;
    if (!items.length) return <div>No wishlist items yet.</div>;

    return (
        <div className="container bg-dark text-light p-4 min-vh-100">
            <h2 className="mb-4">My Wishlist</h2>

            {items.map(product => (
                <div
                    key={product.productId}
                    className="border p-3 mb-3 d-flex justify-content-between align-items-start"
                >
                    <div className="d-flex align-items-center gap-2">
                        <span style={{ fontSize: "1.4rem" }}>❤️</span>

                        <div>
                            <Link
                                to={`/product/${product.productId}`}
                                className="text-decoration-none text-light"
                            >
                                <h5 className="mb-1">{product.name}</h5>
                            </Link>
                            <p className="mb-0">€{product.price}</p>
                        </div>
                    </div>

                    <button
                        className="btn btn-sm btn-outline-danger"
                        onClick={() => handleRemove(product.productId)}
                    >
                        Remove
                    </button>
                </div>
            ))}
        </div>
    );
}

export default Wishlist;

import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getProductDetail } from "../services/product";
import { addToCart } from "../services/cart";
import { checkWishlist, addToWishlist, removeFromWishlist } from "../services/wishlist";

function ProductDetail({ user }) {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [quantity, setQuantity] = useState(1);

    const [inWishlist, setInWishlist] = useState(false);
    const [wishlistLoading, setWishlistLoading] = useState(false);

    useEffect(function () {
        async function loadProduct() {
            try {
                const data = await getProductDetail(id);
                setProduct(data);

                const isIn = await checkWishlist(data.productId);
                setInWishlist(Boolean(isIn));
            } catch (err) {
                console.error(err);
            }
        }

        loadProduct();
    }, [id]);

    function handleAddToCart() {
        if (!user || !user.token) {
            alert("You must be logged in to add items to the cart.");
            return;
        }

        if (quantity < 1) {
            alert("Quantity must be at least 1.");
            return;
        }

        addToCart(product.productId, quantity, user.token)
            .then(function () {
                alert("Item added to cart!");
            })
            .catch(function (error) {
                if (error.response && error.response.data) {
                    alert(error.response.data.message || error.response.data);
                } else {
                    alert("Failed to add item to cart.");
                }
                console.error("Error adding to cart:", error);
            });
    }

    async function toggleWishlist() {
        if (!user || !user.token) {
            alert("You must be logged in to modify wishlist.");
            return;
        }
        setWishlistLoading(true);
        try {
            if (inWishlist) {
                await removeFromWishlist(product.productId);
                alert("Product Removed from Wishlist!");
                setInWishlist(false);
            } else {
                await addToWishlist(product.productId);
                alert("Product Added to Wishlist!");
                setInWishlist(true);
            }
        } catch (e) {
            console.error(e);
            alert("Wishlist action failed.");
        } finally {
            setWishlistLoading(false);
        }
    }

    if (!product) {
        return <div>Loading...</div>;
    }

    return (
        <div className="container bg-dark text-light p-4 min-vh-100">
            <nav aria-label="breadcrumb">
                <ol className="breadcrumb bg-dark">
                    <li className="breadcrumb-item">
                        <a href="/" className="text-decoration-none">Home</a>
                    </li>
                    {product.categoryHierarchy.map(function (cat, index) {
                        return (
                            <li
                                key={index}
                                className="breadcrumb-item active text-light"
                                aria-current="page"
                            >
                                {cat}
                            </li>
                        );
                    })}
                </ol>
            </nav>

            <div className="d-flex align-items-center mb-2">
                <h2 className="mb-0 me-3">{product.name}</h2>
                <button
                    className="btn btn-outline-warning btn-sm"
                    onClick={toggleWishlist}
                    disabled={wishlistLoading}
                >
                    <span style={{ fontSize: "1.3rem" }}>
                        {inWishlist ? "❤️" : "🤍"}
                    </span>
                </button>
            </div>

            <p>
                Price: €{product.price.toFixed(2)}{" "}
                {product.discountPrice && "(Discount: €" + product.discountPrice.toFixed(2) + ")"}
            </p>
            <p>
                Availability:
                {product.stockQuantity === 0 ? (
                    <span className="text-danger"> Out of stock</span>
                ) : product.stockQuantity < 10 ? (
                    <span className="text-warning"> Low stock ({product.stockQuantity} left)</span>
                ) : (
                    <span className="text-success"> In stock</span>
                )}
            </p>

            <div className="row mb-3">
                {product.imageGallery.map(function (img, idx) {
                    return (
                        <div key={idx} className="col-md-3 mb-2">
                            <img
                                src={"http://localhost:8080" + img}
                                alt={product.name}
                                className="img-fluid img-thumbnail"
                            />
                        </div>
                    );
                })}
            </div>

            <div className="mb-3">
                <h5>Description</h5>
                <p>{product.description}</p>
                <p>Date Added: {product.dateAdded}</p>
            </div>

            {product.activeDiscounts.length > 0 && (
                <div className="mb-3">
                    <h5>Active Promotions</h5>
                    <ul>
                        {product.activeDiscounts.map(function (d, index) {
                            return (
                                <li key={index}>
                                    {d.code} - {d.type} - €{d.value}
                                </li>
                            );
                        })}
                    </ul>
                </div>
            )}

            {product.reviews.length > 0 && (
                <div className="mb-3">
                    <h5>Reviews</h5>
                    {product.reviews.map(function (r, idx) {
                        return (
                            <div key={idx} className="border p-2 mb-2 rounded">
                                <strong>{r.reviewerName}</strong> - Rating: {r.rating}/5
                                <p>{r.comment}</p>
                            </div>
                        );
                    })}
                    <p>
                        Average Rating:{" "}
                        {(
                            product.reviews.reduce(function (a, b) {
                                return a + b.rating;
                            }, 0) / product.reviews.length
                        ).toFixed(1)}
                    </p>
                </div>
            )}

            {product.stockQuantity > 0 && (
                <div className="mb-3">
                    <label htmlFor="quantity">Quantity:</label>
                    <input
                        type="number"
                        id="quantity"
                        min="1"
                        max={product.stockQuantity}
                        value={quantity}
                        onChange={function (e) {
                            let val = parseInt(e.target.value, 10);
                            if (val > product.stockQuantity) val = product.stockQuantity;
                            setQuantity(val);
                        }}
                        className="form-control w-25 d-inline-block ms-2"
                    />

                    <button className="btn btn-primary ms-2" onClick={handleAddToCart}>
                        Add to Cart
                    </button>
                </div>
            )}
        </div>
    );
}

export default ProductDetail;

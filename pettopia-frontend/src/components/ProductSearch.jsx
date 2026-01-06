import { useState, useEffect } from "react";
import { searchProducts } from "../services/product";
import { Link } from "react-router-dom";

function ProductSearch() {
    const [category, setCategory] = useState("");
    const [minPrice, setMinPrice] = useState("");
    const [maxPrice, setMaxPrice] = useState("");
    const [keyword, setKeyword] = useState("");
    const [products, setProducts] = useState([]);
    const [currentPage, setCurrentPage] = useState(1);

    const pageSize = 10;

    useEffect(() => {
        loadInitial();
    }, []);

    async function loadInitial() {
        const results = await searchProducts({});
        setProducts(results);
        setCurrentPage(1);
    }

    async function handleSearch() {
        const params = {};

        if (category.trim() !== "") params.category = category.trim();
        if (minPrice !== "") params.minPrice = parseFloat(minPrice);
        if (maxPrice !== "") params.maxPrice = parseFloat(maxPrice);
        if (keyword.trim() !== "") params.keyword = keyword.trim();

        const results = await searchProducts(params);
        setProducts(results);
        setCurrentPage(1);
    }

    const totalPages = Math.max(1, Math.ceil(products.length / pageSize));
    const startIndex = (currentPage - 1) * pageSize;
    const currentProducts = products.slice(startIndex, startIndex + pageSize);

    function goToPage(page) {
        if (page < 1 || page > totalPages) return;
        setCurrentPage(page);
    }

    return (
        <div className="container-fluid bg-dark text-light min-vh-100 p-4">
            <h2 className="mb-4">Search Products</h2>

            <div className="row g-2 mb-3">
                <div className="col-md-3">
                    <input
                        type="text"
                        placeholder="Category"
                        value={category}
                        onChange={(e) => setCategory(e.target.value)}
                        className="form-control bg-secondary text-light border-0"
                    />
                </div>
                <div className="col-md-2">
                    <input
                        type="number"
                        placeholder="Min Price"
                        value={minPrice}
                        onChange={(e) => setMinPrice(e.target.value)}
                        className="form-control bg-secondary text-light border-0"
                    />
                </div>
                <div className="col-md-2">
                    <input
                        type="number"
                        placeholder="Max Price"
                        value={maxPrice}
                        onChange={(e) => setMaxPrice(e.target.value)}
                        className="form-control bg-secondary text-light border-0"
                    />
                </div>
                <div className="col-md-2">
                    <input
                        type="text"
                        placeholder="Keyword"
                        value={keyword}
                        onChange={(e) => setKeyword(e.target.value)}
                        className="form-control bg-secondary text-light border-0"
                    />
                </div>
                <div className="col-md-2">
                    <button
                        className="btn btn-primary w-100"
                        onClick={handleSearch}
                    >
                        Search
                    </button>
                </div>
            </div>

            <div className="table-responsive">
                <table className="table table-dark table-hover mt-3">
                    <thead>
                        <tr>
                            <th>Thumbnail</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        {currentProducts.map((p) => (
                            <tr key={p.productId}>
                                <td>
                                    <Link to={`/product/${p.productId}`}>
                                        <img
                                            src={`http://localhost:8080${p.thumbUrl}`}
                                            alt={p.name}
                                            className="img-thumbnail"
                                            style={{ width: "50px", cursor: "pointer" }}
                                        />
                                    </Link>
                                </td>
                                <td>{p.name}</td>
                                <td>€{p.price}</td>
                                <td>{p.description}</td>
                            </tr>
                        ))}
                        {currentProducts.length === 0 && (
                            <tr>
                                <td colSpan="4">No products found.</td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>

            <div className="d-flex justify-content-between align-items-center mt-3">
                <div>
                    Showing {currentProducts.length} of {products.length} products
                </div>
                <div className="btn-group">
                    <button
                        className="btn btn-sm btn-secondary"
                        onClick={() => goToPage(currentPage - 1)}
                        disabled={currentPage === 1}
                    >
                        Previous
                    </button>
                    <span className="btn btn-sm btn-outline-light disabled">
                        Page {currentPage} of {totalPages}
                    </span>
                    <button
                        className="btn btn-sm btn-secondary"
                        onClick={() => goToPage(currentPage + 1)}
                        disabled={currentPage === totalPages}
                    >
                        Next
                    </button>
                </div>
            </div>
        </div>
    );
}

export default ProductSearch;

import { useEffect, useState } from "react";
import { getAllProducts, toggleProductActive } from "../../services/adminProduct";
import { Link } from "react-router-dom";

function AdminProductList() {
    const [products, setProducts] = useState([]);

    useEffect(() => {
        loadProducts();
    }, []);

    async function loadProducts() {
        try {
            const data = await getAllProducts();
            setProducts(data);
        } catch (err) {
            console.error(err);
            alert("Failed to load products.");
        }
    }

    async function handleToggleActive(product) {
        try {
            const msg = await toggleProductActive(product.productId, !product.isActive);
            alert(msg);
            await loadProducts();
        } catch (err) {
            console.error(err);
            alert("Failed to update product status.");
        }
    }

    return (
        <div className="container p-4 bg-dark text-light min-vh-100">
            <h2>Admin Product Management</h2>
            <Link to="/admin/products/new" className="btn btn-success mb-3">Add New Product</Link>
            <table className="table table-dark table-striped">
                <thead>
                    <tr>
                        <th>Thumbnail</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Category</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {products.map((p) => (
                        <tr key={p.productId}>
                            <td>
                                {p.thumbUrl && <img src={"http://localhost:8080" + p.thumbUrl} alt={p.name} width="50" />}
                            </td>
                            <td>{p.name}</td>
                            <td>€{p.price.toFixed(2)}</td>
                            <td>{p.stockQuantity}</td>
                            <td>{p.categoryName}</td>
                            <td>{p.isActive ? "Active" : "Archived"}</td>
                            <td>
                                <Link to={`/admin/products/${p.productId}/edit`} className="btn btn-primary btn-sm me-2">Edit</Link>
                                <button onClick={() => handleToggleActive(p)} className="btn btn-warning btn-sm">
                                    {p.isActive ? "Archive" : "Unarchive"}
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default AdminProductList;

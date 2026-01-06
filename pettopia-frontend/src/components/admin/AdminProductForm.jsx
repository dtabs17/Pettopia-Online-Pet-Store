import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { createProduct, updateProduct, getProduct} from "../../services/adminProduct";
import { getCategories } from "../../services/adminCategory.js";


function AdminProductForm() {
    const { id } = useParams();
    const navigate = useNavigate();

    const [categories, setCategories] = useState([]);
    const [form, setForm] = useState({
        name: "",
        description: "",
        price: "",
        discountPrice: "",
        stockQuantity: "",
        categoryId: "",
        thumbFile: null,
        galleryFiles: [],
        thumbUrl: "",
        galleryUrls: []
    });

    useEffect(() => {
        loadCategories();
        if (id) loadProduct();
    }, [id]);

    async function loadCategories() {
        try {
            const data = await getCategories();
            setCategories(data);
        } catch (err) {
            console.error(err);
        }
    }

    async function loadProduct() {
        try {
            const data = await getProduct(id);

            setForm({
                name: data.name || "",
                description: data.description || "",
                price: data.price != null ? data.price : "",
                discountPrice: data.discountPrice != null ? data.discountPrice : "",
                stockQuantity: data.stockQuantity != null ? data.stockQuantity : "",
                categoryId: data.categoryId != null ? String(data.categoryId) : "",
                thumbFile: null,
                galleryFiles: [],
                thumbUrl: data.thumbUrl || "",
                galleryUrls: data.imageGallery || []
            });
        } catch (err) {
            console.error(err);
        }
    }

    function handleChange(e) {
        const { name, value, files } = e.target;
        if (name === "thumbFile") setForm({ ...form, thumbFile: files[0] });
        else if (name === "galleryFiles") setForm({ ...form, galleryFiles: files });
        else setForm({ ...form, [name]: value });
    }

    async function handleSubmit(e) {
        e.preventDefault();
        const formData = new FormData();
        formData.append("name", form.name);
        formData.append("description", form.description);
        formData.append("price", form.price);
        formData.append("discountPrice", form.discountPrice);
        formData.append("stockQuantity", form.stockQuantity);
        formData.append("categoryId", Number(form.categoryId));

        if (form.thumbFile) formData.append("thumbFile", form.thumbFile);
        for (let i = 0; i < form.galleryFiles.length; i++) {
            formData.append("galleryFiles", form.galleryFiles[i]);
        }

        try {
            if (id) await updateProduct(id, formData);
            else await createProduct(formData);
            navigate("/admin/products");
        } catch (err) {
            console.error(err);
            alert("Failed to save product.");
        }
    }

    return (
        <div className="container p-4 bg-dark text-light min-vh-100">
            <h2>{id ? "Edit Product" : "Add New Product"}</h2>
            <form onSubmit={handleSubmit}>
                <div className="mb-3">
                    <label>Name</label>
                    <input type="text" className="form-control" name="name" value={form.name} onChange={handleChange} required />
                </div>

                <div className="mb-3">
                    <label>Description</label>
                    <textarea className="form-control" name="description" value={form.description} onChange={handleChange} required />
                </div>

                <div className="mb-3">
                    <label>Price (€)</label>
                    <input type="number" step="0.01" className="form-control" name="price" value={form.price} onChange={handleChange} required />
                </div>

                <div className="mb-3">
                    <label>Discount Price (€)</label>
                    <input type="number" step="0.01" className="form-control" name="discountPrice" value={form.discountPrice} onChange={handleChange} />
                </div>

                <div className="mb-3">
                    <label>Stock Quantity</label>
                    <input type="number" className="form-control" name="stockQuantity" value={form.stockQuantity} onChange={handleChange} required />
                </div>
                <div className="mb-3">
                    <label>Category</label>
                    <select className="form-control" name="categoryId" value={form.categoryId} onChange={handleChange} required>
                        <option value="">Select Category</option>
                        {categories.map(cat => (
                            <option key={cat.categoryId} value={String(cat.categoryId)}>
                                {cat.name}
                            </option>
                        ))}
                    </select>
                </div>

                <div className="mb-3">
                    <label>Thumbnail Image</label>
                    {form.thumbUrl && (
                        <div className="mb-2">
                            <img src={form.thumbUrl} alt="Current Thumbnail" className="img-thumbnail" style={{ maxWidth: "150px" }} />
                        </div>
                    )}
                    <input type="file" className="form-control" name="thumbFile" onChange={handleChange} />
                </div>
                <div className="mb-3">
                    <label>Gallery Images</label>
                    <div className="mb-2 d-flex flex-wrap gap-2">
                        {form.galleryUrls.map((url, idx) => (
                            <img key={idx} src={url} alt={`Gallery ${idx}`} className="img-thumbnail" style={{ maxWidth: "100px" }} />
                        ))}
                    </div>
                    <input type="file" className="form-control" name="galleryFiles" multiple onChange={handleChange} />
                </div>

                <button type="submit" className="btn btn-primary">{id ? "Update" : "Create"}</button>
            </form>
        </div>
    );
}

export default AdminProductForm;

import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { loginAdmin } from "../../services/adminAuth";

function AdminLogin({ setUser }) {
    const [form, setForm] = useState({ email: "", password: "" });
    const navigate = useNavigate();

    const handleChange = (e) => {
        setForm({ ...form, [e.target.name]: e.target.value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const res = await loginAdmin(form);

            localStorage.setItem("token", res.token);
            setUser({
                email: res.email,
                token: res.token,
                role: res.role
            });

            navigate("/admin/products");
        } catch (err) {
            console.error(err);
            alert(err.response?.data?.message || "Admin login failed");
        }
    };

    return (
        <div className="container mt-4">
            <h2>Admin Login</h2>
            <form onSubmit={handleSubmit}>
                <div className="mb-3">
                    <input
                        name="email"
                        type="email"
                        placeholder="Email"
                        className="form-control"
                        value={form.email}
                        onChange={handleChange}
                        required
                    />
                </div>
                <div className="mb-3">
                    <input
                        name="password"
                        type="password"
                        placeholder="Password"
                        className="form-control"
                        value={form.password}
                        onChange={handleChange}
                        required
                    />
                </div>
                <button type="submit" className="btn btn-primary">
                    Login
                </button>
            </form>
        </div>
    );
}

export default AdminLogin;

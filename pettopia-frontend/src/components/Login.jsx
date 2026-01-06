import { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import { loginCustomer } from "../services/customer";

function Login({ setUser }) {
    const [form, setForm] = useState({ email: "", password: "" });
    const [error, setError] = useState("");
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleChange = (e) => {
        setForm({ ...form, [e.target.name]: e.target.value });
        setError("");
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError("");
        setLoading(true);

        try {
            const res = await loginCustomer(form);
            const token = (res.token || "").trim().replace(/\s+/g, "");

            localStorage.setItem("token", token);
            const storedToken = localStorage.getItem("token");
            console.log("TOKEN START AFTER LOCALSTORAGE=[" + storedToken + "]");

            setUser({
                email: res.email,
                token: storedToken,
            });

            navigate("/");
        } catch (err) {
            console.error("Login error:", err);

            let message = "Login failed";

            if (err.response) {
                const { status, data } = err.response;
                const backendMsg = data?.message || "";

                if (status === 401) {
                    message = backendMsg || "Invalid email or password.";
                } else if (status === 423 || backendMsg.toLowerCase().includes("locked")) {

                    message = backendMsg || "Your account is locked. Try again later.";
                } else {
                    message = backendMsg || "Login failed. Please try again.";
                }
            } else {
                message = "Network error. Please try again.";
            }

            setError(message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="container mt-4">
            <h2>Login</h2>

            {error && (
                <div className="alert alert-danger" role="alert">
                    {error}
                </div>
            )}

            <form onSubmit={handleSubmit}>
                <div className="mb-3">
                    <label className="form-label">Email</label>
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
                    <label className="form-label">Password</label>
                    <input
                        name="password"
                        type="password"
                        className="form-control"
                        placeholder="Password"
                        value={form.password}
                        onChange={handleChange}
                        required
                    />
                </div>

                <button type="submit" className="btn btn-primary" disabled={loading}>
                    {loading ? "Logging in..." : "Login"}
                </button>

                <div className="mt-3">
                    <Link to="/forgot-password">Forgot your password?</Link>
                </div>
            </form>
        </div>
    );
}

export default Login;

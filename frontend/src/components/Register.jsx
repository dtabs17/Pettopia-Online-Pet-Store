import { useState } from "react";
import { useNavigate} from "react-router-dom";
import { registerCustomer } from "../services/customer";

function Register() {
    const [form, setForm] = useState(
        {
            firstName: "",
            lastName: "",
            email: "",
            password: "",
            confirmPassword: ""
        });
    const navigate = useNavigate();

    const handleChange = e => setForm({ ...form, [e.target.name]: e.target.value });

    const handleSubmit = async e => {
        e.preventDefault();

        if (form.password !== form.confirmPassword) {
            alert("Passwords do not match");
            return;
        }

        const payload = {
            firstName: form.firstName,
            lastName: form.lastName,
            email: form.email,
            password: form.password
        };

        try {
            console.log(payload);
            await registerCustomer(payload);
            navigate("/login");
        } catch (err) {
            console.log(payload);
            console.error(err);
            alert(err.response?.data.message || "Registration failed");
        }
    };

    return (
        <div className="container mt-4">
            <h2>Register</h2>
            <form onSubmit={handleSubmit}>
                <div className="mb-3">
                    <input
                        name="firstName"
                        placeholder="First Name"
                        className="form-control"
                        value={form.firstName}
                        onChange={handleChange}
                    />
                </div>
                <div className="mb-3">
                    <input
                        name="lastName"
                        placeholder="Last Name"
                        className="form-control"
                        value={form.lastName}
                        onChange={handleChange}
                    />
                </div>
                <div className="mb-3">
                    <input
                        name="email"
                        type="email"
                        placeholder="Email"
                        className="form-control"
                        value={form.email}
                        onChange={handleChange}
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
                    />
                </div>
                <div className="mb-3">
                    <input
                        name="confirmPassword"
                        type="password"
                        placeholder="Confirm Password"
                        className="form-control"
                        value={form.confirmPassword}
                        onChange={handleChange}
                    />
                </div>
                <button type="submit" className="btn btn-primary">Register</button>
            </form>
        </div>
    );
}

export default Register;

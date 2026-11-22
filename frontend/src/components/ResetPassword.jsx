import { useState } from "react";
import { useSearchParams, useNavigate } from "react-router-dom";
import { resetPassword } from "../services/auth";

function ResetPassword() {
    const [params] = useSearchParams();
    const token = params.get("token");
    const navigate = useNavigate();

    const [password, setPassword] = useState("");

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            await resetPassword(token, password);
            alert("Password reset successfully!");
            navigate("/login");
        } catch (err) {
            console.error(err);
            alert("Failed to reset password.");
        }
    };

    return (
        <div className="container mt-4">
            <h2>Reset Password</h2>

            <form onSubmit={handleSubmit}>
                <input
                    type="password"
                    className="form-control mb-3"
                    placeholder="New password"
                    onChange={(e) => setPassword(e.target.value)}
                />
                <button className="btn btn-success">Reset Password</button>
            </form>
        </div>
    );
}

export default ResetPassword;

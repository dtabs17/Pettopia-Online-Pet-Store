import { useState } from "react";
import { forgotPassword } from "../services/auth";

function ForgotPassword() {
    const [email, setEmail] = useState("");
    const [resetLink, setResetLink] = useState("");

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const data = await forgotPassword(email);
            setResetLink(data.resetUrl);
            alert(data.message);
        } catch (err) {
            console.error(err);
            alert("Failed to process request.");
        }
    };

    return (
        <div className="container mt-4">
            <h2>Forgot Password</h2>

            <form onSubmit={handleSubmit}>
                <input
                    type="email"
                    className="form-control mb-3"
                    placeholder="Enter your email"
                    onChange={(e) => setEmail(e.target.value)}
                />
                <button className="btn btn-primary">Send Reset Link</button>
            </form>

            {resetLink && (
                <div className="alert alert-info mt-3">
                    <strong>Reset Link:</strong><br />
                    <a href={resetLink}>
                        {resetLink}
                    </a>
                </div>
            )}
        </div>
    );
}

export default ForgotPassword;

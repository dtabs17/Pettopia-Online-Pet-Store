import { Link, useNavigate } from "react-router-dom";
import { logoutCustomer } from "../services/customer";

function Header({ user, setUser }) {
    const navigate = useNavigate();

    function handleLogout() {
        const confirmLogout = window.confirm("Are you sure you want to log out?");
        if (!confirmLogout) return;

        logoutCustomer();
        setUser(null);
        navigate("/");
    }


    return (
        <header className="navbar navbar-dark bg-dark px-4 py-3 mb-4 shadow-sm">

            <div className="d-flex align-items-center gap-3">
                <Link to="/" className="navbar-brand fs-3 fw-bold">
                    Pettopia
                </Link>

                {user && (
                    <span className="text-light fw-semibold">
                        Hello, {user.email}
                    </span>
                )}
            </div>

            <nav className="d-flex align-items-center gap-3">
                <Link to="/" className="btn btn-outline-light">Home</Link>

                {user ? (
                    <>
                        <Link to="/cart" className="btn btn-outline-light">Cart</Link>
                        <Link to="/orders" className="btn btn-outline-light">My Orders</Link>
                        <Link to="/wishlist" className="btn btn-outline-light">Wishlist</Link>
                        <Link to="/rewards" className="btn btn-outline-light">Rewards</Link>
                        <button className="btn btn-danger" onClick={handleLogout}>Logout</button>
                    </>
                ) : (
                    <>
                        <Link to="/register" className="btn btn-outline-light">Register</Link>
                        <Link to="/login" className="btn btn-primary">Login</Link>
                    </>
                )}
            </nav>

        </header>



    );
}

export default Header;

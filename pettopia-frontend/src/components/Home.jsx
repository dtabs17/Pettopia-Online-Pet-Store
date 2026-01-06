import { Link } from "react-router-dom";

function Home() {
    return (
        <div className="text-center mt-5">
            <h1>Welcome to Pettopia!</h1>
            <p className="lead">
                Discover the best products for your pets, from nutritious food to fun toys!
            </p>
            <Link to="/products" className="btn btn-primary btn-lg mt-3">
                Browse Products
            </Link>
        </div>
    );
}

export default Home;

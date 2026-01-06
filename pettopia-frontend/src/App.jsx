import 'bootstrap/dist/css/bootstrap.min.css';
import ProductSearch from './components/ProductSearch';
import ProductDetail from './components/ProductDetail';
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Register from "./components/Register";
import Login from "./components/Login";
import { useState } from 'react';
import Home from "./components/Home";
import Header from './components/Header';
import Cart from './components/Cart';
import AdminProductList from "./components/admin/AdminProductList";
import AdminProductForm from "./components/admin/AdminProductForm";
import AdminLogin from "./components/admin/AdminLogin";
import Orders from './components/Orders';
import Wishlist from './components/Wishlist';
import RewardsDashboard from "./components/RewardsDashboard";
import ForgotPassword from "./components/ForgotPassword";
import ResetPassword from "./components/ResetPassword";

function App() {
  const [user, setUser] = useState(null);

  return (
    <Router>
      <div className="App bg-dark text-light min-vh-100 p-4">
        <div className="container">
          <Header user={user} setUser={setUser} />
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/products" element={<ProductSearch />} />
            <Route path="/product/:id" element={<ProductDetail user={user} />} />
            <Route path="/register" element={<Register />} />
            <Route path="/login" element={<Login setUser={setUser} />} />
            <Route path="/cart" element={<Cart user={user} />} />
            <Route path="/admin/login" element={<AdminLogin setUser={setUser} />} />
            <Route path="/admin/products" element={<AdminProductList />} />
            <Route path="/admin/products/new" element={<AdminProductForm />} />
            <Route path="/admin/products/:id/edit" element={<AdminProductForm />} />
            <Route path="/orders" element={<Orders user={user} />} />
            <Route path="/wishlist" element={<Wishlist />} />
            <Route path="/rewards" element={<RewardsDashboard />} />
            <Route path="/forgot-password" element={<ForgotPassword />} />
            <Route path="/reset-password" element={<ResetPassword />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;

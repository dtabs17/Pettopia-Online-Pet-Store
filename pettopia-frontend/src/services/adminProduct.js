import axiosClient from "./axiosClient";

function getAuthHeader() {
    const token = localStorage.getItem("token");
    return token ? { Authorization: `Bearer ${token}` } : {};
}

const API_BASE_URL = "/admin/products";

export async function getAllProducts() {
    const response = await axiosClient.get(API_BASE_URL, {
        headers: getAuthHeader()
    });
    return response.data;
}

export async function getProduct(id) {
    const response = await axiosClient.get(`${API_BASE_URL}/${id}`, {
        headers: getAuthHeader()
    });
    return response.data;
}

export async function createProduct(formData) {
    const response = await axiosClient.post(API_BASE_URL, formData, {
        headers: { ...getAuthHeader() }
    });
    return response.data;
}

export async function updateProduct(id, formData) {
    const response = await axiosClient.put(`${API_BASE_URL}/${id}`, formData, {
        headers: { ...getAuthHeader() }
    });
    return response.data;
}

export async function toggleProductActive(id) {
    const response = await axiosClient.patch(`${API_BASE_URL}/${id}/archive`, null, {
        headers: getAuthHeader()
    });

    return response.data;
}

export async function getCategories() {
    const response = await axiosClient.get("/admin/categories", {
        headers: getAuthHeader()
    });
    return response.data;
}

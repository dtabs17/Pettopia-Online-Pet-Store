import axios from "axios";
import axiosClient from "./axiosClient";

const PRODUCT_API_BASE = "http://localhost:8080/api/products";

export const searchProducts = async (params) => {
    try {
        console.log("Here are the search params:", params);
        const response = await axios.get(`${PRODUCT_API_BASE}/search`, { params });
        return response.data;
    } catch (error) {
        console.error("Error fetching products:", error);
        return [];
    }
};


export async function getProductDetail(id) {
    const response = await axiosClient.get("/products/" + id);
    return response.data;
}




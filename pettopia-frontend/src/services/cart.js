import axios from "axios";
import axiosClient from "./axiosClient";

const API_BASE_URL = "http://localhost:8080/api/cart";

export function getCart(token) {
    return axios.get(API_BASE_URL, {
        headers: {
            "Authorization": "Bearer " + token
        }
    });
}



export async function addToCart(productId, quantity, token) {
    const response = await axiosClient.post(
        `/cart/add?productId=${productId}&quantity=${quantity}`,
        null,
        {
            headers: { "Authorization": "Bearer " + token }
        }
    );
    return response.data;
}


export function updateCartItem(productId, quantity, token) {
    return axios.put(API_BASE_URL + "/update", null, {
        params: {
            productId: productId,
            quantity: quantity
        },
        headers: {
            "Authorization": "Bearer " + token
        }
    });
}

export function removeCartItem(productId, token) {
    return axios.delete(API_BASE_URL + "/remove/" + productId, {
        headers: {
            "Authorization": "Bearer " + token
        }
    });
}

export function clearCart(token) {
    return axios.delete(API_BASE_URL + "/clear", {
        headers: {
            "Authorization": "Bearer " + token
        }
    });
}

export async function finalizeCart(pointsToUse) {
    const response = await axiosClient.post("/orders/finalize", {
        points: pointsToUse || 0,
    });
    return response.data;
}



export async function getMyOrders() {
    const response = await axiosClient.get("/orders/my-orders");
    console.log("➡️ getMyOrders response:", response.data);
    return response.data;
}


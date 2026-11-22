import api from "./axiosClient";

export async function registerCustomer(data) {
    const response = await api.post("/customers/register", data);
    return response.data;
}

export const loginCustomer = async (data) => {
    const response = await api.post("/customers/login", data);
    return response.data;
}

export const logoutCustomer = () => {
    localStorage.removeItem("token");
    alert("Logged out successfully");
    
};



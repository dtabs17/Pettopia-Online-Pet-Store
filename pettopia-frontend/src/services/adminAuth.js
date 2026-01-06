import axios from "axios";

const API_BASE_URL = "http://localhost:8080/api/admin";

export async function loginAdmin(credentials) {
    try {
        const response = await axios.post(`${API_BASE_URL}/login`, credentials);
        return response.data; // expects { token, email, role }
    } catch (error) {
        console.error("Admin login failed:", error.response?.data || error.message);
        throw error;
    }
}

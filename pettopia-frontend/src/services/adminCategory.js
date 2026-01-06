import axiosClient from "./axiosClient";

export async function getCategories() {
    try {
        const res = await axiosClient.get("/admin/categories");
        return res.data;
    } catch (err) {
        console.error("Failed to fetch categories:", err);
        return [];
    }
}

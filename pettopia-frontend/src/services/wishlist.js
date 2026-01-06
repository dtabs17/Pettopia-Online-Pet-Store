import axiosClient from "./axiosClient";

export async function getWishlist() {
  const resp = await axiosClient.get("/wishlist");
  return resp.data;
}

export async function checkWishlist(productId) {
  const resp = await axiosClient.get("/wishlist/check", { params: { productId }});
  return resp.data;
}

export async function addToWishlist(productId) {
  const resp = await axiosClient.post("/wishlist/add", null, { params: { productId }});
  return resp.data;
}

export async function removeFromWishlist(productId) {
  const resp = await axiosClient.delete("/wishlist/remove", { params: { productId }});
  return resp.data;
}

import api from "./axiosClient";

export const getRewards = async () => {
    const response = await api.get("/customers/rewards");
    return response.data;
};

export const redeemPoints = async (pointsToRedeem) => {
    const response = await api.post("/customers/rewards/redeem", { points: pointsToRedeem });
    return response.data;
};

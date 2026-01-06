import axiosClient from "./axiosClient";

export const changePassword = async (currentPassword, newPassword) => {
    const res = await axiosClient.post("/customers/change-password", {
        currentPassword,
        newPassword,
    });
    return res.data;
};

export async function forgotPassword(email) {
    const res = await axiosClient.post("/customers/forgot-password", { email });
    console.log("RAW forgot-password res:", res);
    console.log("Reset token from backend:", res.data.resetToken);
    return res.data;
}

export const resetPassword = async (token, newPassword) => {
    const res = await axiosClient.post("/customers/reset-password", {
        token,
        newPassword,
    });
    return res.data;
};

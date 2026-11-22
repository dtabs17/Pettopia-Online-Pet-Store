import axios from "axios";

const axiosClient = axios.create({
    baseURL: "http://localhost:8080/api"
});

axiosClient.interceptors.request.use(
  function (config) {
    let token = localStorage.getItem("token");
    console.log("➡️ INTERCEPTOR TOKEN = [" + token + "] Made it here too");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  function (error) {
    return Promise.reject(error);
  }
);



export default axiosClient;

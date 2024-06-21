import axios from "axios";

export const SERVER_URL = "http://34.203.33.28:8000";

export const myAxios = axios.create({
    baseURL: SERVER_URL
});

export const ActionTypes = {
    AUTH_USER: "auth_user",
}
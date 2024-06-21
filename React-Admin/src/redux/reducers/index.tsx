import { combineReducers } from "redux";
import authReducer from "./AuthReducer";
import productStatus from "./ProductStatus";

export default combineReducers({
    auth: authReducer,
    products: productStatus
});
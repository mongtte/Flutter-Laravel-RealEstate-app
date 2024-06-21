// third-party
import { createSlice } from "@reduxjs/toolkit";

// project imports
// import axios from 'utils/axios';
import { dispatch } from "../store.ts";
import { myAxios } from "@/redux/actions/Constants";
// types
// import { Address, DefaultRootStateProps, ProductsFilter } from 'types/e-commerce';

// ----------------------------------------------------------------------
interface ProductsType {
  title: string;
  description: string;
  imageUrl: string;
  product_id: number;
  user_id: number;
  status: boolean;
}
interface ProductStatusProps {
  products: ProductsType[];
  error: string | null;
  alert: boolean;
}

const initialState: ProductStatusProps = {
  error: null,
  products: [],
  alert: false,
};

const slice = createSlice({
  name: "product",
  initialState,
  reducers: {
    // HAS ERROR
    hasError(state, action) {
      state.error = action.payload;
    },

    // GET PRODUCTS
    getProductsSuccess(state, action) {
      state.products = action.payload;
    },
    getApprovedProductsSuccess(state, action) {
      state.products = state.products.filter(
        (item) => item.product_id !== action.payload,
      );
    },
    setAddProductAlertSuccess(state, action) {
      state.alert = action.payload;
    },
  },
});

// Reducer
export default slice.reducer;

// ----------------------------------------------------------------------

export function getProducts() {
  return async () => {
    try {
      const response = await myAxios.get("/admin/approve");
      dispatch(slice.actions.getProductsSuccess(response.data));
    } catch (error) {
      dispatch(slice.actions.hasError(error));
    }
  };
}
export function setAddProductAlert(status: boolean) {
  return async () => {
    try {
      dispatch(slice.actions.setAddProductAlertSuccess(status));
    } catch (error) {
      dispatch(slice.actions.hasError(error));
    }
  };
}
export function getApprovedProducts(product_id: number) {
  return async () => {
    try {
      dispatch(slice.actions.getApprovedProductsSuccess(product_id));
    } catch (error) {
      dispatch(slice.actions.hasError(error));
    }
  };
}
